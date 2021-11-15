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
    )
      ..userResponse = fields[4] as String?
      ..evaluation = fields[5] as int?
      ..isNew = fields[6] as bool
      ..isUpdated = fields[7] as bool
      ..isDirty = fields[8] as bool;
  }

  @override
  void write(BinaryWriter writer, HiveActionUser obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.actionId)
      ..writeByte(1)
      ..write(obj.userId)
      ..writeByte(2)
      ..write(obj.status)
      ..writeByte(3)
      ..write(obj.teacherResponse)
      ..writeByte(4)
      ..write(obj.userResponse)
      ..writeByte(5)
      ..write(obj.evaluation)
      ..writeByte(6)
      ..write(obj.isNew)
      ..writeByte(7)
      ..write(obj.isUpdated)
      ..writeByte(8)
      ..write(obj.isDirty);
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
