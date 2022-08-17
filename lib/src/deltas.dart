import 'package:hive/hive.dart';
import 'package:protobuf/protobuf.dart';
import 'package:starfish/apis/hive_api.dart';
import 'package:starfish/models/file_reference.dart';
import 'package:starfish/src/generated/file_transfer.pbgrpc.dart';
import 'package:starfish/src/grpc_extensions.dart';
import 'package:starfish/src/generated/google/type/date.pb.dart';

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
  final map = globalHiveApi.revert.get(typeId) as Map<String, dynamic>? ?? {};
  if (!map.containsKey(key)) {
    map[key] = item;
  }
  globalHiveApi.revert.put(typeId, map);
}

const kCreatedKeys = '__created';

void ensureCreateRevert(int typeId, String key) {
  final map =
      globalHiveApi.revert.get(kCreatedKeys) as Map<int, List<String>>? ?? {};
  (map[typeId] ??= []).add(key);
  globalHiveApi.revert.put(kCreatedKeys, map);
}

void revertAll() {
  // First, pull out all the items to delete.
  final deleteMap =
      globalHiveApi.revert.get(kCreatedKeys) as Map<int, List<String>>?;
  globalHiveApi.revert.delete(kCreatedKeys);
  if (deleteMap != null) {
    for (final entry in deleteMap.entries) {
      _resolveBox(entry.key).deleteAll(entry.value);
    }
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
