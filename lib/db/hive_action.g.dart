// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_action.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveActionAdapter extends TypeAdapter<HiveAction> {
  @override
  final int typeId = 4;

  @override
  HiveAction read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveAction(
      actionId: fields[0] as String,
      userId: fields[1] as String,
      status: fields[2] as String,
      teacherResponse: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, HiveAction obj) {
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
      other is HiveActionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
