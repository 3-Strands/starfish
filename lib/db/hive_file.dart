import 'package:hive/hive.dart';
import 'package:starfish/db/hive_keyed.dart';
import 'package:starfish/src/generated/file_transfer.pbgrpc.dart';

part 'hive_file.g.dart';

@HiveType(typeId: 17)
class HiveFile extends HiveObject implements HiveKeyed {
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

  HiveFile({
    required this.entityId,
    required this.entityType,
    this.filepath,
    required this.filename,
    this.isSynced = false,
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

  static String keyFrom(String entityId, String filename) => '$entityId:$filename';

  get key => keyFrom(entityId, filename);
}
