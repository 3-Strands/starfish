// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_action_user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveActionUserAdapter extends TypeAdapter<HiveActionUser> {
  @override
  final int typeId = 15;

  @override
  HiveActionUser read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveActionUser(
      actionId: fields[0] as String?,
      userId: fields[1] as String?,
      status: fields[2] as int?,
      teacherResponse: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, HiveActionUser obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.actionId)
      ..writeByte(1)
      ..write(obj.userId)
      ..writeByte(2)
      ..write(obj.status)
      ..writeByte(3)
      ..write(obj.teacherResponse);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveActionUserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
