// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_output_marker.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveOutputMarkerAdapter extends TypeAdapter<HiveOutputMarker> {
  @override
  final int typeId = 23;

  @override
  HiveOutputMarker read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveOutputMarker(
      projectId: fields[0] as String?,
      markerId: fields[1] as String?,
      markerName: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, HiveOutputMarker obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.projectId)
      ..writeByte(1)
      ..write(obj.markerId)
      ..writeByte(2)
      ..write(obj.markerName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveOutputMarkerAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
