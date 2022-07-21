import 'package:hive/hive.dart';
import 'package:collection/collection.dart';
import 'package:starfish/db/hive_database.dart';
import 'package:starfish/db/hive_file.dart';
import 'package:starfish/db/hive_material.dart';
import 'package:starfish/db/hive_material_topic.dart';

class MaterialProvider {
  late Box<HiveMaterial> _materialBox;
  late Box<HiveMaterialTopic> _materialTopicBox;
  late Box<HiveFile> _fileBox;

  MaterialProvider() {
    _materialBox = Hive.box<HiveMaterial>(HiveDatabase.MATERIAL_BOX);

    _materialTopicBox =
        Hive.box<HiveMaterialTopic>(HiveDatabase.MATERIAL_TOPIC_BOX);

    _fileBox = Hive.box<HiveFile>(HiveDatabase.FILE_BOX);
  }

  Future<List<HiveMaterial>> getMateials() async {
    return _materialBox.values.toList();
  }

  List<HiveMaterial> getMateialsSync() {
    return _materialBox.values.toList();
  }

  Future<List<HiveMaterialTopic>> getMateialTypes() async {
    return _materialTopicBox.values.toList();
  }

  Future<void> createUpdateMaterial(HiveMaterial material,
      {List<HiveFile>? files}) async {
    if (files != null && files.length > 0) {
      createUpdateMaterialFile(files);
    }
    int _currentIndex = -1;
    _materialBox.values.toList().asMap().forEach((key, hiveMaterial) {
      if (hiveMaterial.id == material.id) {
        _currentIndex = key;
      }
    });

    if (_currentIndex > -1) {
      return _materialBox.putAt(_currentIndex, material);
    } else {
      _materialBox.add(material);
    }
  }

  Future<void> deleteMaterial({required String id}) async {
    HiveMaterial? _hiveMaterial =
        _materialBox.values.firstWhereOrNull((element) => element.id == id);

    if (_hiveMaterial != null) {
      _hiveMaterial.delete();
    }
  }

  HiveMaterial? getMaterialById(String materialId) {
    return _materialBox.values
        .firstWhereOrNull((element) => element.id == materialId);
  }

  createUpdateMaterialFile(List<HiveFile> files) {
    files.forEach((file) {
      int _currentIndex = -1;
      _fileBox.values.toList().asMap().forEach((key, hiveFile) {
        if (hiveFile == file) {
          _currentIndex = key;
        }
      });

      if (_currentIndex > -1) {
        _fileBox.putAt(_currentIndex, file);
      } else {
        _fileBox.add(file);
      }
    });
  }

  List<HiveFile> getFiles() {
    return _fileBox.values.toList();
  }
}
