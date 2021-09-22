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
      languageIds: (fields[2] as List?)?.cast<String>(),
      users: (fields[3] as List?)?.cast<HiveGroupUser>(),
      evaluationCategoryIds: (fields[4] as List?)?.cast<String>(),
      actions: (fields[5] as List?)?.cast<HiveGroupAction>(),
      editHistory: (fields[6] as List?)?.cast<HiveEdit>(),
      isNew: fields[7] as bool,
      isUpdated: fields[8] as bool,
      isDirty: fields[9] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, HiveGroup obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.languageIds)
      ..writeByte(3)
      ..write(obj.users)
      ..writeByte(4)
      ..write(obj.evaluationCategoryIds)
      ..writeByte(5)
      ..write(obj.actions?.toList())
      ..writeByte(6)
      ..write(obj.editHistory?.toList())
      ..writeByte(7)
      ..write(obj.isNew)
      ..writeByte(8)
      ..write(obj.isUpdated)
      ..writeByte(9)
      ..write(obj.isDirty);
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
