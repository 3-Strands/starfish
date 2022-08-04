// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file_reference.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FileReferenceAdapter extends TypeAdapter<FileReference> {
  @override
  final int typeId = 17;

  @override
  FileReference read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FileReference(
      entityId: fields[0] as String,
      entityType: fields[1] as int,
      filepath: fields[2] as String?,
      filename: fields[3] as String,
      isSynced: fields[4] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, FileReference obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.entityId)
      ..writeByte(1)
      ..write(obj.entityType)
      ..writeByte(2)
      ..write(obj.filepath)
      ..writeByte(3)
      ..write(obj.filename)
      ..writeByte(4)
      ..write(obj.isSynced);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FileReferenceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
