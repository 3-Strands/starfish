// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_current_user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveCurrentUserAdapter extends TypeAdapter<HiveCurrentUser> {
  @override
  final int typeId = 2;

  @override
  HiveCurrentUser read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveCurrentUser(
      id: fields[0] as String,
      name: fields[1] as String,
      phone: fields[2] as String,
      linkGroup: fields[3] as bool,
      countryIds: (fields[4] as List).cast<String>(),
      languageIds: (fields[5] as List).cast<String>(),
      groups: (fields[6] as List).cast<HiveGroup>(),
      actions: (fields[7] as List).cast<HiveAction>(),
      selectedActionsTab: fields[8] as String,
      selectedResultsTab: fields[9] as String,
      isUpdated: fields[10] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, HiveCurrentUser obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.phone)
      ..writeByte(3)
      ..write(obj.linkGroup)
      ..writeByte(4)
      ..write(obj.countryIds)
      ..writeByte(5)
      ..write(obj.languageIds)
      ..writeByte(6)
      ..write(obj.groups)
      ..writeByte(7)
      ..write(obj.actions)
      ..writeByte(8)
      ..write(obj.selectedActionsTab)
      ..writeByte(9)
      ..write(obj.selectedResultsTab)
      ..writeByte(10)
      ..write(obj.isUpdated);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveCurrentUserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
