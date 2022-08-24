import 'package:fixnum/fixnum.dart';
import 'package:meta/meta.dart';
import 'package:collection/collection.dart';
import 'package:hive/hive.dart';
import 'package:protobuf/protobuf.dart';
import 'package:starfish/apis/hive_api.dart';
import 'package:starfish/models/file_reference.dart';
import 'package:starfish/src/generated/file_transfer.pbgrpc.dart';
import 'package:starfish/src/grpc_extensions.dart';
import 'package:starfish/src/generated/google/type/date.pb.dart';
import 'package:starfish/utils/helpers/uuid_generator.dart';

import 'generated/google/protobuf/field_mask.pb.dart';

part 'deltas.g.dart';

Date _currentDate() {
  final date = DateTime.now();
  return Date(
    day: date.day,
    month: date.month,
    year: date.year,
  );
}

extension Edits<T extends GeneratedMessage> on Box<T> {
  // void applyGenericUpdate(
  //     bool Function(T model) isCorrect, void Function(T other) updates) {
  //   for (final key in keys) {
  //     final item = get(key)!;
  //     if (isCorrect(item)) {
  //       put(key, item.rebuild(updates));
  //       return;
  //     }
  //   }
  // }

  void applyUpdate(dynamic key, void Function(T other) updates) {
    final item = get(key);
    if (item != null) {
      put(key, item.rebuild(updates));
    }
  }

  void applyEdit(int typeId, dynamic key, void Function(T other) updates) {
    final item = get(key);
    if (item != null) {
      final itemWithChangesApplied = item.rebuild(updates);
      ensureRevert(typeId, key, item);
      put(key, itemWithChangesApplied);
    }
  }
}

void ensureRevert(int typeId, dynamic key, dynamic item) {
  final map = globalHiveApi.revert.get(typeId) ?? {};
  if (!map.containsKey(key)) {
    map[key] = item;
    globalHiveApi.revert.put(typeId, map);
  }
}

bool listsAreSame<T>(List<T> a, List<T> b) {
  if (a.length != b.length) {
    return false;
  }
  for (final item in a) {
    if (!b.contains(item)) {
      return false;
    }
  }
  return true;
}

abstract class DeltaBase {
  bool apply();
}

class FileReferenceCreateDelta extends DeltaBase {
  FileReferenceCreateDelta({
    required this.entityId,
    required this.entityType,
    required this.filename,
    required this.filepath,
  });

  final String entityId;
  final EntityType entityType;
  final String filename;
  final String filepath;

  @override
  bool apply() {
    final model = FileReference(
      entityId: entityId,
      entityType: entityType.value,
      filename: filename,
      filepath: filepath,
    );
    globalHiveApi.file.put(model.key, model);
    return true;
  }
}

int _typeIdOf(Type t) => _messageToTypeIdMap[t]!;

List<dynamic> orderRequests(Iterable<dynamic> requests) {
  return requests.toList()
    ..sort(
      (a, b) => _typeIdOf(a.runtimeType).compareTo(_typeIdOf(b.runtimeType)),
    );
}

void _revertValuesInBox<T>(Box<T> box, Map<String, dynamic>? map) {
  if (map == null) {
    return;
  }
  for (final entry in map.entries) {
    final key = entry.key;
    final T? item = entry.value;
    if (item == null) {
      box.delete(key);
    } else {
      box.put(key, item);
    }
  }
}
