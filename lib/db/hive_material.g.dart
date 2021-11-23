// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_material.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveMaterialAdapter extends TypeAdapter<HiveMaterial> {
  @override
  final int typeId = 5;

  @override
  HiveMaterial read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveMaterial(
      id: fields[0] as String?,
      creatorId: fields[1] as String?,
      title: fields[5] as String?,
      description: fields[6] as String?,
      url: fields[8] as String?,
      languageIds: (fields[10] as List?)?.cast<String>(),
      typeIds: (fields[11] as List?)?.cast<String>(),
      topics: (fields[12] as List?)?.cast<String>(),
      status: fields[2] as int?,
      visibility: fields[3] as int?,
      editability: fields[4] as int?,
      editHistory: (fields[19] as List?)?.cast<HiveEdit>(),
      isNew: fields[16] as bool,
      isUpdated: fields[17] as bool,
      isDirty: fields[18] as bool,
    )
      ..targetAudience = fields[7] as String?
      ..files = (fields[9] as List?)?.cast<String>()
      ..feedbacks = (fields[13] as List?)?.cast<HiveMaterialFeedback>()
      ..dateCreated = fields[14] as HiveDate?
      ..dateUpdated = fields[15] as HiveDate?;
  }

  @override
  void write(BinaryWriter writer, HiveMaterial obj) {
    writer
      ..writeByte(20)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.creatorId)
      ..writeByte(2)
      ..write(obj.status)
      ..writeByte(3)
      ..write(obj.visibility)
      ..writeByte(4)
      ..write(obj.editability)
      ..writeByte(5)
      ..write(obj.title)
      ..writeByte(6)
      ..write(obj.description)
      ..writeByte(7)
      ..write(obj.targetAudience)
      ..writeByte(8)
      ..write(obj.url)
      ..writeByte(9)
      ..write(obj.files)
      ..writeByte(10)
      ..write(obj.languageIds)
      ..writeByte(11)
      ..write(obj.typeIds)
      ..writeByte(12)
      ..write(obj.topics)
      ..writeByte(13)
      ..write(obj.feedbacks)
      ..writeByte(14)
      ..write(obj.dateCreated)
      ..writeByte(15)
      ..write(obj.dateUpdated)
      ..writeByte(16)
      ..write(obj.isNew)
      ..writeByte(17)
      ..write(obj.isUpdated)
      ..writeByte(18)
      ..write(obj.isDirty)
      ..writeByte(19)
      ..write(obj.editHistory);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveMaterialAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
