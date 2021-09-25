import 'package:hive/hive.dart';
import '../hive_database.dart';
import '../hive_material.dart';
import '../hive_material_topic.dart';

class MaterialProvider {
  late Box<HiveMaterial> _materialBox;
  late Box<HiveMaterialTopic> _materialTopicBox;

  MaterialProvider() {
    _materialBox = Hive.box<HiveMaterial>(HiveDatabase.MATERIAL_BOX);

    _materialTopicBox =
        Hive.box<HiveMaterialTopic>(HiveDatabase.MATERIAL_TOPIC_BOX);
  }

  Future<List<HiveMaterial>> getMateials() async {
    return _materialBox.values.toList();
  }

  Future<List<HiveMaterialTopic>> getMateialTypes() async {
    return _materialTopicBox.values.toList();
  }
}
