// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_transformation.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveTransformationAdapter extends TypeAdapter<HiveTransformation> {
  @override
  final int typeId = 21;

  @override
  HiveTransformation read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveTransformation(
      id: fields[0] as String?,
      userId: fields[1] as String?,
      groupId: fields[2] as String?,
      month: fields[3] as HiveDate?,
      impactStory: fields[4] as String?,
    )
      ..files = (fields[5] as List?)?.cast<String>()
      ..isNew = fields[6] as bool
      ..isUpdated = fields[7] as bool
      ..isDirty = fields[8] as bool;
  }

  @override
  void write(BinaryWriter writer, HiveTransformation obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.userId)
      ..writeByte(2)
      ..write(obj.groupId)
      ..writeByte(3)
      ..write(obj.month)
      ..writeByte(4)
      ..write(obj.impactStory)
      ..writeByte(5)
      ..write(obj.files)
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
      other is HiveTransformationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
