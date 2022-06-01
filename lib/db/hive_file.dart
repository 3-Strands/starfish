import 'package:hive/hive.dart';
import 'package:starfish/src/generated/file_transfer.pbgrpc.dart';
import 'package:starfish/wrappers/platform.dart';

part 'hive_file.g.dart';

@HiveType(typeId: 17)
class HiveFile extends HiveObject {
  @HiveField(0)
  String? entityId;
  @HiveField(1)
  int? entityType;
  @HiveField(2)
  String? filepath; // local file path
  @HiveField(3)
  String filename;
  @HiveField(4)
  String? md5Checksum;
  @HiveField(5)
  bool isSynced;
  @HiveField(6)
  List<int>? content;

  HiveFile({
    this.entityId,
    this.entityType,
    this.filepath,
    required this.filename,
    this.md5Checksum,
    this.isSynced = false,
    this.content,
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

  bool get isLocallyAvailable => Platform.isWeb ? content != null : filepath != null;

  @override
  String toString() {
    return '{entityId: ${this.entityId}, entityType: ${this.entityType}, filepath: ${this.filepath}, filename: ${this.filename}, md5Checksum: ${this.md5Checksum}, isSynced: ${this.isSynced}}';
  }
}

/*extension HiveFileExt on HiveFile {
  String get filename {
    return filepath!.split("/").last;
  }
}*/
