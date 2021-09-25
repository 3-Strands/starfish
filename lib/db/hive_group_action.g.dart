// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_group_action.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveGroupActionAdapter extends TypeAdapter<HiveGroupAction> {
  @override
  final int typeId = 13;

  @override
  HiveGroupAction read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveGroupAction(
      groupId: fields[0] as String?,
      actionId: fields[1] as String?,
      dueDate: fields[2] as HiveDate?,
    );
  }

  @override
  void write(BinaryWriter writer, HiveGroupAction obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.groupId)
      ..writeByte(1)
      ..write(obj.actionId)
      ..writeByte(2)
      ..write(obj.dueDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveGroupActionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
