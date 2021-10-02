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
      linkGroups: fields[3] as bool,
      countryIds: (fields[4] as List).cast<String>(),
      languageIds: (fields[5] as List).cast<String>(),
      groups: (fields[6] as List).cast<HiveGroupUser>(),
      actions: (fields[7] as List).cast<HiveActionUser>(),
      selectedActionsTab: fields[8] as int,
      selectedResultsTab: fields[9] as int,
      phoneCountryId: fields[11] as String,
      diallingCode: fields[10] as String,
      isUpdated: fields[12] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, HiveCurrentUser obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.phone)
      ..writeByte(3)
      ..write(obj.linkGroups)
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
      ..write(obj.diallingCode)
      ..writeByte(11)
      ..write(obj.phoneCountryId)
      ..writeByte(12)
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
