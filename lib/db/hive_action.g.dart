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
      id: fields[0] as String?,
      type: fields[1] as int?,
      name: fields[2] as String?,
      creatorId: fields[3] as String?,
      groupId: fields[4] as String?,
      instructions: fields[5] as String?,
      materialId: fields[6] as String?,
      question: fields[7] as String?,
      dateDue: fields[8] as HiveDate?,
    )
      ..editHistory = (fields[9] as List?)?.cast<HiveEdit>()
      ..isNew = fields[10] as bool
      ..isUpdated = fields[11] as bool
      ..isDirty = fields[12] as bool;
  }

  @override
  void write(BinaryWriter writer, HiveAction obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.type)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.creatorId)
      ..writeByte(4)
      ..write(obj.groupId)
      ..writeByte(5)
      ..write(obj.instructions)
      ..writeByte(6)
      ..write(obj.materialId)
      ..writeByte(7)
      ..write(obj.question)
      ..writeByte(8)
      ..write(obj.dateDue)
      ..writeByte(9)
      ..write(obj.editHistory)
      ..writeByte(10)
      ..write(obj.isNew)
      ..writeByte(11)
      ..write(obj.isUpdated)
      ..writeByte(12)
      ..write(obj.isDirty);
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
