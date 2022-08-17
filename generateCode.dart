import 'dart:io';

import 'package:starfish/src/generated/starfish.pb.dart';
import 'package:protobuf/protobuf.dart';

part 'fieldMasks.dart';

abstract class Storage {
  const Storage();

  String toCreateCode(int typeId, String modelCode);
  String toUpdateCode(int typeId, String modelCode, String originalModelCode);
  String toDeleteCode(int typeId, String modelCode);
}

class BoxStorage extends Storage {
  const BoxStorage(this.name);

  final String name;

  @override
  String toCreateCode(int typeId, String modelCode) {
    return '''
      globalHiveApi.$name.put($modelCode.id, $modelCode);
      ensureCreateRevert($typeId, $modelCode.id);''';
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

enum ReferenceType {
  fullModel,
  modelKey,
}

class Reference {
  Reference(this.model, this.field, this.type);

  final Model model;
  final String field;
  final ReferenceType type;
}

class ReferenceStorage extends Storage {
  const ReferenceStorage(this.references);

  final Map<String, Reference> references;

  @override
  String toCreateCode(int typeId, String modelCode) {
    return references.entries.map((entry) {
      final referringField = entry.key;
      final refersTo = entry.value;
      switch (refersTo.type) {
        case ReferenceType.fullModel:
          final box = refersTo.model.storage as BoxStorage;
          return '''
            globalHiveApi.${box.name}.applyEdit(${findTypeId(refersTo.model)}, $modelCode.$referringField, (other) {
              other.${refersTo.field}.add($modelCode);
            });''';
        case ReferenceType.modelKey:
          return '';
      }
    }).join('\n');
  }

  @override
  String toUpdateCode(int typeId, String modelCode, String _) {
    bool hasWrittenId = false;
    return references.entries.map((entry) {
      final referringField = entry.key;
      final refersTo = entry.value;
      switch (refersTo.type) {
        case ReferenceType.fullModel:
          final box = refersTo.model.storage as BoxStorage;
          final code = '''
            ${hasWrittenId ? '' : 'final id = $modelCode.id;'}
            globalHiveApi.${box.name}.applyEdit(${findTypeId(refersTo.model)}, $modelCode.$referringField, (other) {
              final index = other.${refersTo.field}.indexWhere((item) => item.id == id);
              other.${refersTo.field}[index] = $modelCode;
            });''';
          hasWrittenId = true;
          return code;
        case ReferenceType.modelKey:
          return '';
      }
    }).join('\n');
  }

  @override
  String toDeleteCode(int typeId, String modelCode) {
    return references.entries.map((entry) {
      final referringField = entry.key;
      final refersTo = entry.value;
      switch (refersTo.type) {
        case ReferenceType.fullModel:
          final box = refersTo.model.storage as BoxStorage;
          return 'globalHiveApi.${box.name}.applyEdit(${findTypeId(refersTo.model)}, $modelCode.$referringField, (other) => other.${refersTo.field}.removeWhere((item) => item.id == $modelCode.id));';
        case ReferenceType.modelKey:
          return '';
      }
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
                  : field.isGroupOrMessage
                      ? field.makeDefault!().runtimeType.toString()
                      : field.isEnum
                          ? field.enumValues![0].runtimeType.toString()
                          : 'dynamic';
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
      classBuffer.writeln('// $name is not creatable');
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
        );
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
      classBuffer.writeln('// $name is not updatable');
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
      classBuffer.writeln('// $name is not deletable');
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

final messages = <int, MessageWrapper>{
  0: Model(
    Country(),
    storage: BoxStorage('country'),
  ),
  1: Model(
    Language(),
    storage: BoxStorage('language'),
  ),
  3: Model(
    GroupUser(),
    storage: ReferenceStorage({
      'groupId': Reference(groupModel, 'users', ReferenceType.fullModel),
      'userId': Reference(userModel, 'groups', ReferenceType.fullModel),
    }),
    editableFields: _kGroupUserFieldMask,
    createUpdateRequest: CreateUpdateGroupUsersRequest(),
    deleteRequest: GroupUser(),
  ),
  4: actionModel,
  5: materialModel,
  6: Model(
    MaterialFeedback(),
    storage: ReferenceStorage({
      'materialId':
          Reference(materialModel, 'feedbacks', ReferenceType.fullModel),
    }),
    createUpdateRequest: CreateMaterialFeedbacksRequest(),
  ),
  9: Model(
    MaterialTopic(),
    storage: BoxStorage('materialTopic'),
  ),
  10: Model(
    MaterialType(),
    storage: BoxStorage('materialType'),
  ),
  12: groupModel,
  15: Model(
    ActionUser(),
    storage: ReferenceStorage({
      'userId': Reference(userModel, 'actions', ReferenceType.fullModel),
    }),
    editableFields: _kActionUserFieldMask,
    createUpdateRequest: CreateUpdateActionUserRequest(),
  ),
  16: userModel,

  // ------------------ Request Types ------------------
  102: MessageWrapper(CreateMaterialFeedbacksRequest()),
  103: MessageWrapper(CreateUpdateActionsRequest()),
  104: MessageWrapper(CreateUpdateActionUserRequest()),
  105: MessageWrapper(CreateUpdateGroupEvaluationRequest()),
  106: MessageWrapper(CreateUpdateGroupsRequest()),
  107: MessageWrapper(CreateUpdateGroupUsersRequest()),
  108: MessageWrapper(CreateUpdateLearnerEvaluationRequest()),
  109: MessageWrapper(CreateUpdateMaterialsRequest()),
  110: MessageWrapper(CreateUpdateOutputRequest()),
  111: MessageWrapper(CreateUpdateTeacherResponseRequest()),
  112: MessageWrapper(CreateUpdateTransformationRequest()),
  113: MessageWrapper(CreateUpdateUserRequest()),
  114: MessageWrapper(DeleteActionRequest()),
  // 115: MessageWrapper(DeleteGroupUserRequest()),
  116: MessageWrapper(DeleteMaterialRequest()),
  117: MessageWrapper(UpdateCurrentUserRequest()),
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
