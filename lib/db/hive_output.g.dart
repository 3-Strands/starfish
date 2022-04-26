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
      projectId: fields[1] as String?,
      markerId: fields[2] as String?,
      markerName: fields[3] as String?,
      month: fields[4] as HiveDate?,
      value: fields[5] as int,
      isNew: fields[6] as bool,
      isUpdated: fields[7] as bool,
      isDirty: fields[8] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, HiveOutput obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.groupId)
      ..writeByte(1)
      ..write(obj.projectId)
      ..writeByte(2)
      ..write(obj.markerId)
      ..writeByte(3)
      ..write(obj.markerName)
      ..writeByte(4)
      ..write(obj.month)
      ..writeByte(5)
      ..write(obj.value)
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
      other is HiveOutputAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
