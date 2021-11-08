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
      id: fields[0] as String?,
      name: fields[1] as String?,
      description: fields[2] as String?,
      languageIds: (fields[3] as List?)?.cast<String>(),
      users: (fields[4] as List?)?.cast<HiveGroupUser>(),
      evaluationCategoryIds: (fields[5] as List?)?.cast<String>(),
      actions: (fields[6] as List?)?.cast<HiveGroupAction>(),
      editHistory: (fields[7] as List?)?.cast<HiveEdit>(),
      isNew: fields[8] as bool,
      isUpdated: fields[9] as bool,
      isDirty: fields[10] as bool,
      isMe: fields[11] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, HiveGroup obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.languageIds)
      ..writeByte(4)
      ..write(obj.users)
      ..writeByte(5)
      ..write(obj.evaluationCategoryIds)
      ..writeByte(6)
      ..write(obj.actions)
      ..writeByte(7)
      ..write(obj.editHistory)
      ..writeByte(8)
      ..write(obj.isNew)
      ..writeByte(9)
      ..write(obj.isUpdated)
      ..writeByte(10)
      ..write(obj.isDirty)
      ..writeByte(11)
      ..write(obj.isMe);
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
