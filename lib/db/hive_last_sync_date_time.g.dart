// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_last_sync_date_time.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveLastSyncDateTimeAdapter extends TypeAdapter<HiveLastSyncDateTime> {
  @override
  final int typeId = 8;

  @override
  HiveLastSyncDateTime read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveLastSyncDateTime(
      year: fields[0] as int,
      month: fields[1] as int,
      day: fields[2] as int,
      hour: fields[3] as int,
      minute: fields[4] as int,
      second: fields[5] as int,
    );
  }

  @override
  void write(BinaryWriter writer, HiveLastSyncDateTime obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.year)
      ..writeByte(1)
      ..write(obj.month)
      ..writeByte(2)
      ..write(obj.day)
      ..writeByte(3)
      ..write(obj.hour)
      ..writeByte(4)
      ..write(obj.minute)
      ..writeByte(5)
      ..write(obj.second);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveLastSyncDateTimeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
