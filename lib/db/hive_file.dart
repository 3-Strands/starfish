import 'package:hive/hive.dart';
import 'package:starfish/src/generated/file_transfer.pbgrpc.dart';

part 'hive_file.g.dart';

@HiveType(typeId: 17)
class HiveFile extends HiveObject {
  @HiveField(0)
  String? entityId;
  @HiveField(1)
  int? entityType;
  @HiveField(2)
  String? filepath;

  HiveFile({
    this.entityId,
    this.entityType,
    this.filepath,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveFile &&
          runtimeType == other.runtimeType &&
          entityId == other.entityId &&
          filename == other.filename &&
          entityType == other.entityType;

  @override
  int get hashCode =>
      entityId.hashCode ^ filepath.hashCode ^ entityType.hashCode;

  FileMetaData toFileMetaData() {
    return FileMetaData(
      entityId: this.entityId,
      entityType: EntityType.valueOf(this.entityType ?? 0),
      filename: filename,
    );
  }

  @override
  String toString() {
    return '{entityId: ${this.entityId}, entityType: ${this.entityType}, filepath: ${this.filepath},}';
  }
}

extension HiveFileExt on HiveFile {
  String get filename {
    return filepath!.split("/").last;
  }
}
