// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_group.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveGroupAdapter extends TypeAdapter<HiveGroup> {
  @override
  final int typeId = 12;

  @override
  HiveGroup read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveGroup(
      id: fields[0] as String,
      name: fields[1] as String?,
      description: fields[2] as String?,
      linkEmail: fields[3] as String?,
      languageIds: (fields[4] as List?)?.cast<String>(),
      evaluationCategoryIds: (fields[6] as List?)?.cast<String>(),
      status: fields[8] as int?,
      outputMarkers: (fields[9] as List).cast<HiveOutputMarker>(),
      editHistory: (fields[10] as List?)?.cast<HiveEdit>(),
      isNew: fields[11] as bool,
      isUpdated: fields[12] as bool,
      isDirty: fields[13] as bool,
      isMe: fields[14] as bool,
    )..languages = (fields[15] as Map).cast<String, String>();
  }

  @override
  void write(BinaryWriter writer, HiveGroup obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.linkEmail)
      ..writeByte(4)
      ..write(obj.languageIds)
      ..writeByte(5)
      ..write(obj.users)
      ..writeByte(6)
      ..write(obj.evaluationCategoryIds)
      ..writeByte(8)
      ..write(obj.status)
      ..writeByte(9)
      ..write(obj.outputMarkers)
      ..writeByte(10)
      ..write(obj.editHistory)
      ..writeByte(11)
      ..write(obj.isNew)
      ..writeByte(12)
      ..write(obj.isUpdated)
      ..writeByte(13)
      ..write(obj.isDirty)
      ..writeByte(14)
      ..write(obj.isMe)
      ..writeByte(15)
      ..write(obj.languages);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveGroupAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
