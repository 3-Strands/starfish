import 'package:hive/hive.dart';
import 'package:collection/collection.dart';
import 'package:starfish/db/hive_database.dart';
import 'package:starfish/db/hive_material.dart';
import 'package:starfish/db/hive_material_topic.dart';

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

  Future<void> createUpdateMaterial(HiveMaterial material) async {
    int _currentIndex = -1;
    _materialBox.values.toList().asMap().forEach((key, hiveMaterial) {
      if (hiveMaterial.id == material.id) {
        _currentIndex = key;
      }
    });

    if (_currentIndex > -1) {
      return _materialBox.put(_currentIndex, material);
    } else {
      _materialBox.add(material);
    }
  }

  HiveMaterial? getMaterialById(String materialId) {
    return _materialBox.values
        .firstWhereOrNull((element) => element.id == materialId);
  }
}
