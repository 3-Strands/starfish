// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_evaluation_value_name.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveEvaluationValueNameAdapter
    extends TypeAdapter<HiveEvaluationValueName> {
  @override
  final int typeId = 24;

  @override
  HiveEvaluationValueName read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveEvaluationValueName(
      value: fields[0] as int?,
      name: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, HiveEvaluationValueName obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.value)
      ..writeByte(1)
      ..write(obj.name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveEvaluationValueNameAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
