import 'package:hive/hive.dart';
import 'package:starfish/src/generated/file_transfer.pbgrpc.dart';

part 'file_reference.g.dart';

@HiveType(typeId: 17)
class FileReference extends HiveObject {
  @HiveField(0)
  final String entityId;
  @HiveField(1)
  final int entityType;
  @HiveField(2)
  String? filepath; // local file path
  @HiveField(3)
  final String filename;
  @HiveField(4)
  bool isSynced;

  FileReference({
    required this.entityId,
    required this.entityType,
    this.filepath,
    required this.filename,
    this.isSynced = false,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FileReference &&
          runtimeType == other.runtimeType &&
          entityId == other.entityId &&
          filename == other.filename &&
          entityType == other.entityType;

  @override
  int get hashCode => Object.hash(entityId, entityType, filename);

  FileMetaData toFileMetaData() {
    return FileMetaData(
      entityId: entityId,
      entityType: EntityType.valueOf(entityType),
      filename: filename,
    );
  }

  bool get isLocallyAvailable => filepath != null;

  @override
  String toString() {
    return '{entityId: $entityId, entityType: $entityType, filepath: $filepath, filename: $filename, isSynced: $isSynced}';
  }

  static String keyFrom(String entityId, String filename) =>
      '$entityId:$filename';

  get key => keyFrom(entityId, filename);
}
