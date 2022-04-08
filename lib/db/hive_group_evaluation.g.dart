// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_group_evaluation.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveGroupEvaluationAdapter extends TypeAdapter<HiveGroupEvaluation> {
  @override
  final int typeId = 20;

  @override
  HiveGroupEvaluation read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveGroupEvaluation(
      id: fields[0] as String?,
      userId: fields[1] as String?,
      groupId: fields[2] as String?,
      month: fields[3] as HiveDate?,
      evaluation: fields[4] as int?,
    )
      ..isNew = fields[5] as bool
      ..isUpdated = fields[6] as bool
      ..isDirty = fields[7] as bool;
  }

  @override
  void write(BinaryWriter writer, HiveGroupEvaluation obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.userId)
      ..writeByte(2)
      ..write(obj.groupId)
      ..writeByte(3)
      ..write(obj.month)
      ..writeByte(4)
      ..write(obj.evaluation)
      ..writeByte(5)
      ..write(obj.isNew)
      ..writeByte(6)
      ..write(obj.isUpdated)
      ..writeByte(7)
      ..write(obj.isDirty);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveGroupEvaluationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
