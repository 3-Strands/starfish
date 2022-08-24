import 'dart:io';

import 'package:starfish/src/generated/starfish.pb.dart';
import 'package:protobuf/protobuf.dart';

part 'fieldMasks.dart';

abstract class Storage {
  const Storage();

  String toSaveCode(String modelCode);
  String toRemoveCode();

  String toCreateCode(int typeId, String modelCode);
  String toUpdateCode(int typeId, String modelCode, String originalModelCode);
  String toDeleteCode(int typeId, String modelCode);
}

class BoxStorage extends Storage {
  const BoxStorage(this.name);

  final String name;

  @override
  String toSaveCode(String modelCode) {
    return 'globalHiveApi.$name.put($modelCode.id, $modelCode);';
  }

  @override
  String toRemoveCode() {
    return 'globalHiveApi.$name.delete(id);';
  }

  @override
  String toCreateCode(int typeId, String modelCode) {
    return '''
      globalHiveApi.$name.put($modelCode.id, $modelCode);
      ensureRevert($typeId, $modelCode.id, null);''';
  }

  @override
  String toUpdateCode(int typeId, String modelCode, String originalModelCode) {
    return '''
      globalHiveApi.$name.put($modelCode.id, $modelCode);
      ensureRevert($typeId, $originalModelCode.id, $originalModelCode);''';
  }

  @override
  String toDeleteCode(int typeId, String modelCode) {
    return '''
      globalHiveApi.$name.delete($modelCode.id);
      ensureRevert($typeId, $modelCode.id, $modelCode);''';
  }
}

class Reference {
  Reference(this.model, this.field);

  final Model model;
  final String field;
}

class ReferenceStorage extends Storage {
  const ReferenceStorage(this.references);

  final Map<String, Reference> references;

  @override
  String toSaveCode(String modelCode) {
    return references.entries.map((entry) {
      final referringField = entry.key;
      if (referringField.isEmpty) {
        return '// noop';
      }
      final refersTo = entry.value;
      final box = refersTo.model.storage as BoxStorage;
      return '''
        globalHiveApi.${box.name}.applyUpdate($modelCode.$referringField, (other) {
          other.${refersTo.field}.add($modelCode);
        });''';
    }).join('\n');
  }

  @override
  String toRemoveCode() {
    throw Exception(
        'Should not be generating remove code for object stored in reference to other objects');
    // return references.entries.map((entry) {
    //   final refersTo = entry.value;
    //   final box = refersTo.model.storage as BoxStorage;
    //   return '''
    //     globalHiveApi.${box.name}.applyGenericUpdate((model) => model.id == id, (other) => other.${refersTo.field}.removeWhere((item) => item.id == id));''';
    // }).join('\n');
  }

  @override
  String toCreateCode(int typeId, String modelCode) {
    return references.entries.map((entry) {
      final referringField = entry.key;
      final refersTo = entry.value;
      final box = refersTo.model.storage as BoxStorage;
      return '''
        globalHiveApi.${box.name}.applyEdit(${findTypeId(refersTo.model)}, $modelCode.$referringField, (other) {
          other.${refersTo.field}.add($modelCode);
        });''';
    }).join('\n');
  }

  @override
  String toUpdateCode(int typeId, String modelCode, String _) {
    bool hasWrittenId = false;
    return references.entries.map((entry) {
      final referringField = entry.key;
      final refersTo = entry.value;
      final box = refersTo.model.storage as BoxStorage;
      final code = '''
        ${hasWrittenId ? '' : 'final id = $modelCode.id;'}
        globalHiveApi.${box.name}.applyEdit(${findTypeId(refersTo.model)}, $modelCode.$referringField, (other) {
          final index = other.${refersTo.field}.indexWhere((item) => item.id == id);
          other.${refersTo.field}[index] = $modelCode;
        });''';
      hasWrittenId = true;
      return code;
    }).join('\n');
  }

  @override
  String toDeleteCode(int typeId, String modelCode) {
    return references.entries.map((entry) {
      final referringField = entry.key;
      final refersTo = entry.value;
      final box = refersTo.model.storage as BoxStorage;
      return 'globalHiveApi.${box.name}.applyEdit(${findTypeId(refersTo.model)}, $modelCode.$referringField, (other) => other.${refersTo.field}.removeWhere((item) => item.id == $modelCode.id));';
    }).join('\n');
  }
}

class Field {
  Field({
    required this.name,
    required this.protoName,
    required this.type,
    required this.isIterable,
  });
  final String name;
  final String protoName;
  final String type;
  final bool isIterable;
}

class MessageWrapper {
  MessageWrapper(this.message);

  final GeneratedMessage message;

  String get name => message.runtimeType.toString();

  String makeAdapterCode(int typeId) {
    assert(typeId >= 0 && typeId < 256);
    final name = this.name;

    return '''
      class ${name}Adapter extends _GrpcAdapter<$name> {
        @override
        int get typeId => $typeId;

        @override
        $name create() => $name.create();
      }
    ''';
  }
}

class Model extends MessageWrapper {
  Model(
    super.message, {
    required this.storage,
    this.readonlyFields = const {},
    this.editableFields,
    this.createUpdateRequest,
    this.deleteRequest,
  });

  final Storage storage;
  final Set<String> readonlyFields;
  final List<String>? editableFields;
  final GeneratedMessage? createUpdateRequest;
  final GeneratedMessage? deleteRequest;

  static Set<String> _globalReadOnlyFields = {
    'editHistory',
    'dateCreated',
    'dateUpdated',
    'creatorId',
  };

  String makeDeltaCode(int typeId) {
    final classBuffer = StringBuffer();
    classBuffer.writeln('''
      void save${name}Locally($name model) {
        ${storage.toSaveCode('model')}
      }''');
    classBuffer.writeln();
    if (storage is BoxStorage) {
      classBuffer.writeln('''
        void remove${name}Locally(String id) {
          ${storage.toRemoveCode()}
        }''');
      classBuffer.writeln();
    }
    _generateCreateDelta(typeId, classBuffer);
    classBuffer.writeln();
    _generateUpdateDelta(typeId, classBuffer);
    classBuffer.writeln();
    _generateDeleteDelta(typeId, classBuffer);
    return classBuffer.toString();
  }

  // bool _isReadOnly(String field) =>
  //     _globalReadOnlyFields.contains(field) ||
  //     readonlyFields.contains(field) ||
  //     key.isKey(field);

  bool _isCreatable(String field) => !(_globalReadOnlyFields.contains(field) ||
      readonlyFields.contains(field));

  List<Field> get _fields {
    return message.info_.fieldInfo.values.map((field) {
      // if (field.name == 'dateDue') {
      //   // print(field.);
      // }
      final type = field.isRepeated
          ? field.makeDefault!().runtimeType.toString().substring(2)
          : field.type == PbFieldType.OS
              ? 'String'
              : field.type == PbFieldType.OB
                  ? 'bool'
                  : field.type == PbFieldType.O3
                      ? 'int'
                      : field.type == PbFieldType.O6
                          ? 'Int64'
                          : field.isGroupOrMessage
                              ? field.makeDefault!().runtimeType.toString()
                              : field.isEnum
                                  ? field.enumValues![0].runtimeType.toString()
                                  : 'dynamic';
      if (type == 'dynamic')
        print(
            'Unknown type for $name.$field (${field.type}): ${field.makeDefault?.call().runtimeType ?? '<unknown>'}');
      return Field(
        name: field.name,
        protoName: field.protoName,
        type: type,
        isIterable: field.isRepeated,
      );
    }).toList();
  }

  bool get isEditable => editableFields != null;

  List<Field> get _creatableFields =>
      _fields.where((field) => _isCreatable(field.name)).toList();

  String get createUpdateRequestName =>
      createUpdateRequest!.runtimeType.toString();

  String get deleteRequestName => deleteRequest!.runtimeType.toString();

  String _makeCreateUpdateRequestCode(String modelCode,
      [String? updateMaskCode]) {
    final name = createUpdateRequestName;
    final fieldName = createUpdateRequest!.info_.fieldInfo.values
        .firstWhere((field) => field.name != 'updateMask')
        .name;
    return '$name($fieldName: $modelCode${updateMaskCode == null ? '' : ', updateMask: $updateMaskCode'})';
  }

  String _makeDeleteRequestCode(String modelCode) {
    final name = deleteRequestName;
    final fieldName = deleteRequest!.info_.fieldInfo.values.first.name;
    return '$name($fieldName: $modelCode.id)';
  }

  void _generateCreateDelta(int typeId, StringBuffer classBuffer) {
    if (createUpdateRequest == null) {
      classBuffer.writeln('// Users cannot create the $name type');
      return;
    }

    final className = '${name}CreateDelta';

    classBuffer.writeln('class $className extends DeltaBase {');

    classBuffer.writeln('  $className({');

    final fields = _creatableFields;

    for (final field in fields) {
      classBuffer.writeln('    this.${field.name},');
    }

    classBuffer.writeln('  });');
    classBuffer.writeln();

    for (final field in fields) {
      classBuffer.writeln('  final ${field.type}? ${field.name};');
    }

    classBuffer.writeln();
    classBuffer.writeln('''
      @override
      bool apply() {
        final model = $name(
    ''');

    for (final field in fields) {
      classBuffer.writeln('${field.name}: ${field.name},');
    }

    classBuffer.writeln('''
        )..freeze();
        ${storage.toCreateCode(typeId, 'model')}
        assert(!globalHiveApi.sync.containsKey(model.id));
        globalHiveApi.sync.put(model.id, ${_makeCreateUpdateRequestCode('model')});
        return true;
      }
    ''');

    classBuffer.writeln('}');
  }

  void _generateUpdateDelta(int typeId, StringBuffer classBuffer) {
    final editableFields = this.editableFields;

    if (editableFields == null || createUpdateRequest == null) {
      classBuffer.writeln('// Users cannot update the $name type');
      return;
    }
    final className = '${name}UpdateDelta';

    classBuffer.writeln('class $className extends DeltaBase {');

    classBuffer.writeln('$className(this._model, {');

    final fields = _fields
        .where((field) => editableFields.contains(field.protoName))
        .toList();
    assert(fields.length == editableFields.length,
        'FieldMask definition not aligned with model definition for $name');

    for (final field in fields) {
      classBuffer.writeln('this.${field.name},');
    }

    classBuffer.writeln('});');
    classBuffer.writeln();

    classBuffer.writeln('final $name _model;');
    for (final field in fields) {
      classBuffer.writeln('final ${field.type}? ${field.name};');
    }

    classBuffer.writeln();
    classBuffer.writeln('''
      @override
      bool apply() {
        Set<String>? updateMask = <String>{};
        final newModel = _model.rebuild((other) {
    ''');

    for (final field in fields) {
      final comparison = field.isIterable
          ? '!listsAreSame(${field.name}!, other.${field.name})'
          : '${field.name} != other.${field.name}';
      final updateCode = field.isIterable
          ? '''other.${field.name}
            ..clear()
            ..addAll(${field.name}!);'''
          : 'other.${field.name} = ${field.name}!;';
      classBuffer.writeln('''
        if (${field.name} != null && $comparison) {
          $updateCode
          updateMask!.add('${field.protoName}');
        }
      ''');
    }

    classBuffer.writeln('''
      });

      if (updateMask.isNotEmpty) {
        ${storage.toUpdateCode(typeId, 'newModel', '_model')}
        final $createUpdateRequestName? request = globalHiveApi.sync.get(newModel.id);
        if (request != null) {
          if (!request.hasUpdateMask()) {
            // This edit follows a create. Stays as a create.
            updateMask = null;
          } else {
            // This edit follows a previous edit. Merge the edits.
            updateMask = {...updateMask, ...request.updateMask.paths};
          }
        }
        globalHiveApi.sync.put(newModel.id, ${_makeCreateUpdateRequestCode('newModel', 'updateMask == null ? null : FieldMask(paths: updateMask)')});
        return true;
      }
      return false;
    }
    ''');

    classBuffer.writeln('}');
  }

  void _generateDeleteDelta(int typeId, StringBuffer classBuffer) {
    if (deleteRequest == null) {
      classBuffer.writeln('// Users cannot delete the $name type');
      return;
    }
    final className = '${name}DeleteDelta';

    classBuffer.writeln('class $className extends DeltaBase {');

    classBuffer.writeln('$className(this._model);');

    classBuffer.writeln();

    classBuffer.writeln('final $name _model;');

    classBuffer.writeln();
    classBuffer.writeln('''
      @override
      bool apply() {
        ${storage.toDeleteCode(typeId, '_model')}
        final $createUpdateRequestName? request = globalHiveApi.sync.get(_model.id);
        if (request != null && !request.hasUpdateMask()) {
          // This delete follows a create. Reverts to nothing.
          globalHiveApi.sync.delete(_model.id);
        } else {
          globalHiveApi.sync.put(_model.id, ${_makeDeleteRequestCode('_model')});
        }
        return true;
      }
    ''');

    classBuffer.writeln('}');
  }
}

final materialModel = Model(
  Material(),
  storage: BoxStorage('material'),
  readonlyFields: {
    'languages',
    'feedbacks',
  },
  editableFields: _kMaterialFieldMask,
  createUpdateRequest: CreateUpdateMaterialsRequest(),
  deleteRequest: DeleteMaterialRequest(),
);

final actionModel = Model(
  Action(),
  storage: BoxStorage('action'),
  editableFields: _kActionFieldMask,
  createUpdateRequest: CreateUpdateActionsRequest(),
  deleteRequest: DeleteActionRequest(),
);

final groupModel = Model(
  Group(),
  storage: BoxStorage('group'),
  readonlyFields: {
    'languages',
  },
  editableFields: _kGroupFieldMask,
  createUpdateRequest: CreateUpdateGroupsRequest(),
);

final userModel = Model(
  User(),
  storage: BoxStorage('user'),
  editableFields: _kUserFieldMask,
  createUpdateRequest: CreateUpdateUserRequest(),
);

final evaluationCategoryModel = Model(
  EvaluationCategory(),
  storage: BoxStorage('evaluationCategory'),
);

final messages = <int, MessageWrapper>{
  0: Model(
    Country(),
    storage: BoxStorage('country'),
  ),
  1: Model(
    Language(),
    storage: BoxStorage('language'),
  ),
  // 2: legacy: CurrentUser,
  3: Model(
    GroupUser(),
    storage: ReferenceStorage({
      'groupId': Reference(groupModel, 'users'),
      'userId': Reference(userModel, 'groups'),
    }),
    editableFields: _kGroupUserFieldMask,
    createUpdateRequest: CreateUpdateGroupUsersRequest(),
    deleteRequest: DeleteGroupUserRequest(),
  ),
  4: actionModel,
  5: materialModel,
  6: Model(
    MaterialFeedback(),
    storage: ReferenceStorage({
      'materialId': Reference(materialModel, 'feedbacks'),
    }),
    createUpdateRequest: CreateMaterialFeedbacksRequest(),
  ),
  // 7: MessageWrapper(Date()),
  // 8: legacy: HiveDateTime
  9: Model(
    MaterialTopic(),
    storage: BoxStorage('materialTopic'),
  ),
  10: Model(
    MaterialType(),
    storage: BoxStorage('materialType'),
  ),
  // 11: MessageWrapper(Edit()),
  12: groupModel,
  // 13: deprecated: GroupAction,
  14: evaluationCategoryModel,
  15: Model(
    ActionUser(),
    storage: ReferenceStorage({
      'userId': Reference(userModel, 'actions'),
    }),
    editableFields: _kActionUserFieldMask,
    createUpdateRequest: CreateUpdateActionUserRequest(),
  ),
  16: userModel,
  // 17: custom: File
  18: Model(
    LearnerEvaluation(),
    storage: BoxStorage('learnerEvaluation'),
    createUpdateRequest: CreateUpdateLearnerEvaluationRequest(),
  ),
  19: Model(
    TeacherResponse(),
    storage: BoxStorage('teacherResponse'),
    createUpdateRequest: CreateUpdateTeacherResponseRequest(),
  ),
  20: Model(
    GroupEvaluation(),
    storage: BoxStorage('groupEvaluation'),
  ),
  21: Model(
    Transformation(),
    storage: BoxStorage('transformation'),
    createUpdateRequest: CreateUpdateTransformationRequest(),
  ),
  22: Model(
    Output(),
    storage: BoxStorage('output'),
    createUpdateRequest: CreateUpdateOutputRequest(),
  ),
  23: Model(
    OutputMarker(),
    storage: ReferenceStorage({
      '': Reference(groupModel, 'outputMarkers'),
    }),
  ),
  24: Model(
    EvaluationValueName(),
    storage: ReferenceStorage({
      '': Reference(evaluationCategoryModel, 'valueNames'),
    }),
  ),

  // ------------------ Request Types ------------------
  102: MessageWrapper(CreateUpdateMaterialsRequest()),
  103: MessageWrapper(CreateUpdateGroupsRequest()),
  104: MessageWrapper(CreateUpdateUserRequest()),
  105: MessageWrapper(UpdateCurrentUserRequest()),
  106: MessageWrapper(CreateUpdateActionsRequest()),
  107: MessageWrapper(CreateUpdateTransformationRequest()),
  108: MessageWrapper(CreateUpdateTeacherResponseRequest()),
  109: MessageWrapper(CreateMaterialFeedbacksRequest()),
  110: MessageWrapper(CreateUpdateActionUserRequest()),
  111: MessageWrapper(CreateUpdateGroupEvaluationRequest()),
  112: MessageWrapper(CreateUpdateGroupUsersRequest()),
  113: MessageWrapper(CreateUpdateLearnerEvaluationRequest()),
  114: MessageWrapper(CreateUpdateOutputRequest()),
  115: MessageWrapper(DeleteActionRequest()),
  116: MessageWrapper(DeleteMaterialRequest()),
  117: MessageWrapper(DeleteGroupUserRequest()),
};

int findTypeId(Model model) =>
    messages.entries.firstWhere((entry) => entry.value == model).key;

void main() {
  final deltaContents = '''
  // GENERATED CODE - DO NOT MODIFY BY HAND

  part of 'deltas.dart';

  ${messages.entries.where((entry) => entry.value is Model).map((entry) => (entry.value as Model).makeDeltaCode(entry.key)).join('\n')}

  Box _resolveBox(int typeId) {
    switch (typeId) {
      ${messages.entries.where((entry) {
            final model = entry.value;
            return model is Model && model.storage is BoxStorage;
          }).map((entry) => 'case ${entry.key}: return globalHiveApi.${((entry.value as Model).storage as BoxStorage).name};').join('\n')}
      default: throw Exception('Unknown type id \$typeId');
    }
  }

  const _messageToTypeIdMap = <Type, int>{
    ${messages.entries.where((entry) => entry.key >= 100 && entry.key < 200).map((entry) => '${entry.value.name}: ${entry.key},').join('\n')}
  };
  ''';

  File('lib/src/deltas.g.dart').writeAsString(deltaContents);

  final adapterContents = '''
  // GENERATED CODE - DO NOT MODIFY BY HAND

  part of 'grpc_adapters.dart';

  ${messages.entries.map((entry) => entry.value.makeAdapterCode(entry.key)).join('\n')}

  void registerAllAdapters() {
    ${messages.values.map((value) => 'Hive.registerAdapter(${value.name}Adapter());').join('\n')}
  }
  ''';

  File('lib/src/grpc_adapters.g.dart').writeAsString(adapterContents);
}
