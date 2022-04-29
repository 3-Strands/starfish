// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_output.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveOutputAdapter extends TypeAdapter<HiveOutput> {
  @override
  final int typeId = 22;

  @override
  HiveOutput read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveOutput(
      groupId: fields[0] as String?,
      month: fields[2] as HiveDate?,
      value: fields[3] as Int64?,
      isNew: fields[4] as bool,
      isUpdated: fields[5] as bool,
      isDirty: fields[6] as bool,
    )..outputMarker = fields[1] as HiveOutputMarker?;
  }

  @override
  void write(BinaryWriter writer, HiveOutput obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.groupId)
      ..writeByte(1)
      ..write(obj.outputMarker)
      ..writeByte(2)
      ..write(obj.month)
      ..writeByte(3)
      ..write(obj.value)
      ..writeByte(4)
      ..write(obj.isNew)
      ..writeByte(5)
      ..write(obj.isUpdated)
      ..writeByte(6)
      ..write(obj.isDirty);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveOutputAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
