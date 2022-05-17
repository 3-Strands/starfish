import 'package:hive_flutter/hive_flutter.dart';
import 'package:starfish/select_items/select_drop_down.dart';
import 'package:starfish/src/generated/starfish.pbgrpc.dart';

part 'hive_material_topic.g.dart';

@HiveType(typeId: 9)
class HiveMaterialTopic extends HiveObject implements Named {
  @HiveField(0)
  late String id;
  @HiveField(1)
  late String name;

  HiveMaterialTopic();

  HiveMaterialTopic.from(MaterialTopic material) {
    this.id = material.id;
    this.name = material.name;
  }

  @override
  String getName() => name;
}
