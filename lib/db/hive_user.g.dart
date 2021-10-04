// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveUserAdapter extends TypeAdapter<HiveUser> {
  @override
  final int typeId = 16;

  @override
  HiveUser read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveUser(
      id: fields[0] as String?,
      name: fields[1] as String?,
      phone: fields[2] as String?,
      linkGroups: fields[3] as bool,
      countryIds: (fields[4] as List?)?.cast<String>(),
      languageIds: (fields[5] as List?)?.cast<String>(),
      groups: (fields[6] as List?)?.cast<HiveGroupUser>(),
      actions: (fields[7] as List?)?.cast<HiveActionUser>(),
      selectedActionsTab: fields[8] as int?,
      selectedResultsTab: fields[9] as int?,
      phoneCountryId: fields[11] as String?,
      diallingCode: fields[10] as String?,
      isNew: fields[12] as bool,
      isUpdated: fields[13] as bool,
      isDeleted: fields[14] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, HiveUser obj) {
    writer
      ..writeByte(15)
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
      ..write(obj.isNew)
      ..writeByte(13)
      ..write(obj.isUpdated)
      ..writeByte(14)
      ..write(obj.isDeleted);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveUserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
