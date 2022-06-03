import 'package:hive_flutter/hive_flutter.dart';
import 'package:starfish/select_items/select_list.dart';
import 'package:starfish/src/generated/starfish.pbgrpc.dart';

part 'hive_material_type.g.dart';

@HiveType(typeId: 10)
class HiveMaterialType extends HiveObject implements Named {
  @HiveField(0)
  late String id;
  @HiveField(1)
  late String name;

  HiveMaterialType();

  HiveMaterialType.from(MaterialType material) {
    this.id = material.id;
    this.name = material.name;
  }

  @override
  String getName() => name;
}
