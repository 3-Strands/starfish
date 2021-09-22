// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_edit.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveEditAdapter extends TypeAdapter<HiveEdit> {
  @override
  final int typeId = 11;

  @override
  HiveEdit read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveEdit()
      ..username = fields[0] as String?
      ..time = fields[1] as DateTime?
      ..event = fields[2] as int?;
  }

  @override
  void write(BinaryWriter writer, HiveEdit obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.username)
      ..writeByte(1)
      ..write(obj.time)
      ..writeByte(2)
      ..write(obj.event);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveEditAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
