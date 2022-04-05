// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_teacher_response.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveTeacherResponseAdapter extends TypeAdapter<HiveTeacherResponse> {
  @override
  final int typeId = 19;

  @override
  HiveTeacherResponse read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveTeacherResponse(
      id: fields[0] as String?,
      learnerId: fields[1] as String?,
      teacherId: fields[2] as String?,
      groupId: fields[3] as String?,
      month: fields[4] as HiveDate?,
      response: fields[5] as String?,
    )
      ..isNew = fields[6] as bool
      ..isUpdated = fields[7] as bool
      ..isDirty = fields[8] as bool;
  }

  @override
  void write(BinaryWriter writer, HiveTeacherResponse obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.learnerId)
      ..writeByte(2)
      ..write(obj.teacherId)
      ..writeByte(3)
      ..write(obj.groupId)
      ..writeByte(4)
      ..write(obj.month)
      ..writeByte(5)
      ..write(obj.response)
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
      other is HiveTeacherResponseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
