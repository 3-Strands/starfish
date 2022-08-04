import 'package:hive/hive.dart';
import 'package:starfish/apis/hive_api.dart';
import 'package:starfish/models/delta.dart';
import 'package:starfish/models/file_reference.dart';
import 'package:starfish/src/generated/file_transfer.pbgrpc.dart';
import 'package:starfish/src/generated/starfish.pb.dart';
import 'package:starfish/src/generated/google/type/date.pb.dart';

part 'deltas.g.dart';

Date _currentDate() {
  final date = DateTime.now();
  return Date(
    day: date.day,
    month: date.month,
    year: date.year,
  );
}

extension Edits<T> on Box<T> {
  void resave(dynamic key) {
    final item = get(key)!;
    put(key, item);
  }

  void edit(dynamic key, void Function(T) applyEdit) {
    final item = get(key)!;
    applyEdit(item);
    put(key, item);
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
