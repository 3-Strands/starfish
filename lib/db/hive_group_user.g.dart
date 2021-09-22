// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_group_user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveGroupUserAdapter extends TypeAdapter<HiveGroupUser> {
  @override
  final int typeId = 3;

  @override
  HiveGroupUser read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveGroupUser(
      groupId: fields[0] as String?,
      userId: fields[1] as String?,
      role: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, HiveGroupUser obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.groupId)
      ..writeByte(1)
      ..write(obj.userId)
      ..writeByte(2)
      ..write(obj.role);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveGroupUserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}