// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_learner_evaluation.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveLearnerEvaluationAdapter extends TypeAdapter<HiveLearnerEvaluation> {
  @override
  final int typeId = 18;

  @override
  HiveLearnerEvaluation read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveLearnerEvaluation(
      id: fields[0] as String?,
      learnerId: fields[1] as String?,
      evaluatorId: fields[2] as String?,
      groupId: fields[3] as String?,
      month: fields[4] as HiveDate?,
      categoryId: fields[5] as String?,
      evaluation: fields[6] as int?,
    )
      ..isNew = fields[7] as bool
      ..isUpdated = fields[8] as bool
      ..isDirty = fields[9] as bool;
  }

  @override
  void write(BinaryWriter writer, HiveLearnerEvaluation obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.learnerId)
      ..writeByte(2)
      ..write(obj.evaluatorId)
      ..writeByte(3)
      ..write(obj.groupId)
      ..writeByte(4)
      ..write(obj.month)
      ..writeByte(5)
      ..write(obj.categoryId)
      ..writeByte(6)
      ..write(obj.evaluation)
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
      other is HiveLearnerEvaluationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
