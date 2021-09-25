// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_evaluation_category.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveEvaluationCategoryAdapter
    extends TypeAdapter<HiveEvaluationCategory> {
  @override
  final int typeId = 14;

  @override
  HiveEvaluationCategory read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveEvaluationCategory(
      id: fields[0] as String?,
      name: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, HiveEvaluationCategory obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveEvaluationCategoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
