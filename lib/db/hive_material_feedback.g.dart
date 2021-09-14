// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_material_feedback.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveMaterialFeedbackAdapter extends TypeAdapter<HiveMaterialFeedback> {
  @override
  final int typeId = 6;

  @override
  HiveMaterialFeedback read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveMaterialFeedback()
      ..id = fields[0] as String
      ..type = fields[1] as String
      ..reporterId = fields[2] as String
      ..report = fields[3] as String
      ..response = fields[4] as String
      ..materialId = fields[5] as String
      ..isNew = fields[14] as bool
      ..isUpdated = fields[15] as bool
      ..isDirty = fields[16] as bool;
  }

  @override
  void write(BinaryWriter writer, HiveMaterialFeedback obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.type)
      ..writeByte(2)
      ..write(obj.reporterId)
      ..writeByte(3)
      ..write(obj.report)
      ..writeByte(4)
      ..write(obj.response)
      ..writeByte(5)
      ..write(obj.materialId)
      ..writeByte(14)
      ..write(obj.isNew)
      ..writeByte(15)
      ..write(obj.isUpdated)
      ..writeByte(16)
      ..write(obj.isDirty);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveMaterialFeedbackAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
