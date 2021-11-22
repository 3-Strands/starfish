import 'package:rxdart/rxdart.dart';
import 'package:starfish/db/hive_language.dart';
import 'package:starfish/db/hive_material.dart';
import 'package:starfish/db/hive_material_topic.dart';
import 'package:starfish/repository/materials_repository.dart';

class MaterialBloc extends Object {
  MaterialRepository materialRepository = MaterialRepository();
  List<HiveLanguage> selectedLanguages = [];
  List<HiveMaterialTopic> selectedTopics = [];
  String query = '';

  late BehaviorSubject<List<HiveMaterial>> _materials;

  MaterialBloc() {
    _materials = new BehaviorSubject<List<HiveMaterial>>();
  }

  // Add data to Stream
  Stream<List<HiveMaterial>> get materials => _materials.stream;

  List<HiveMaterial> _allMaterials = [];
  List<HiveMaterial> _filteredMaterialsList = [];

  setQuery(String qury) {
    query = qury;
  }

  fetchMaterialsFromDB() async {
    materialRepository
        .fetchMaterialsFromDB()
        .then(
          (value) => {_allMaterials = value},
        )
        .whenComplete(
          () => {
            _filteredMaterialsList = _filterMaterials(),
            _materials.sink.add(_filteredMaterialsList)
          },
        );
  }

  bool _ifMaterialSupportsLanguage(
      HiveMaterial _material, List<HiveLanguage> _selectedLanguages) {
    if (_selectedLanguages.length == 0) {
      return true;
    }
    if (_material.languageIds == null || _material.languageIds!.length == 0) {
      return false;
    }

    Set<String> _selectdLanguageSet =
        _selectedLanguages.map((e) => e.id).toList().toSet();

    Set<String> _materialLanguageSet = _material.languageIds!.toSet();

    return _materialLanguageSet.intersection(_selectdLanguageSet).length > 0;
  }

  bool _ifMaterialSupportsTopic(
      HiveMaterial _material, List<HiveMaterialTopic> _selectedTopics) {
    if (_selectedTopics.length == 0) {
      return true;
    }
    if (_material.topics == null || _material.topics!.length == 0) {
      return false;
    }

    Set<String> _selectdTopicsSet =
        _selectedTopics.map((e) => e.name).toList().toSet();

    Set<String> _materialTopicsSet = _material.topics!.toSet();

    return _materialTopicsSet.intersection(_selectdTopicsSet).length > 0;
  }

  List<HiveMaterial> _filterMaterials() {
    List<HiveMaterial> _results = [];
    _allMaterials.forEach((element) {
      if (/*_ifMaterialSupportsLanguage(element, selectedLanguages)*/ true &&
          _ifMaterialSupportsTopic(element, selectedTopics)) {
        _results.add(element);
      }
    });
    return _results;
  }

  Future<void> createUpdateMaterial(HiveMaterial material) async {
    return materialRepository.createUpdateMaterialInDB(material).then((_) {
      fetchMaterialsFromDB();
    });
  }

  void dispose() {
    _materials.close();
  }
}
