import 'package:rxdart/rxdart.dart';
import 'package:starfish/db/hive_language.dart';
import 'package:starfish/db/hive_material.dart';
import 'package:starfish/db/hive_material_topic.dart';
import 'package:starfish/repository/materials_repository.dart';

class MaterialBloc extends Object {
  List<HiveLanguage> selectedLanguages = [];
  List<HiveMaterialTopic> selectedTopics = [];
  String query = '';

  late BehaviorSubject<List<HiveMaterial>> _materials;

  // BehaviorSubject<List<HiveMaterialTopic>> _materialTopics =
  //     BehaviorSubject<List<HiveMaterialTopic>>();

  MaterialBloc() {
    // _selectedLanguages = new BehaviorSubject<List<HiveLanguage>>();
    _materials = new BehaviorSubject<List<HiveMaterial>>();
  }

  // Add data to Stream
  Stream<List<HiveMaterial>> get materials => _materials.stream;

  // Add data to Stream
  // Stream<List<HiveLanguage>> get selectedLanguages => _selectedLanguages.stream;

  // List<HiveLanguage> languages = [];

  List<HiveMaterial> _allMaterials = [];
  List<HiveMaterial> _filteredMaterialsList = [];

  // Stream<List<HiveMaterialTopic>> get materialTopics => _materialTopics.stream;

  setQuery(String qury) {
    query = qury;
  }

  fetchMaterialsFromDB() async {
    MaterialRepository materialRepository = MaterialRepository();

    materialRepository
        .fetchMaterialsFromDB()
        .then(
          (value) => {_allMaterials = value},
        )
        .whenComplete(
          () => {
            _filteredMaterialsList =
                _doFilterMaterials(selectedLanguages, selectedTopics),
            _materials.sink.add(_filteredMaterialsList)
          },
        );
  }

  List<HiveMaterial> _doFilterMaterials(List<HiveLanguage>? _selectedLanguages,
      List<HiveMaterialTopic>? _selectedTopics) {
    List<HiveMaterial> _overAllFilterMaterials = [];
    List<HiveMaterial> _filterMaterialsByLanguage = [];

    // ignore: unnecessary_null_comparison
    if (_selectedLanguages != null && _selectedLanguages.length > 0) {
      print('_selectedLanguages.length > 0');

      _filterMaterialsByLanguage =
          _materialFilterByLanguages(_selectedLanguages);

      // ignore: unnecessary_null_comparison
      if (_selectedTopics != null && _selectedTopics.length > 0) {
        if (_filterMaterialsByLanguage.length > 0) {
          _overAllFilterMaterials = _materialFilterByTopics(
              _filterMaterialsByLanguage, _selectedTopics);
        } else {
          _overAllFilterMaterials =
              _materialFilterByTopics(_allMaterials, _selectedTopics);
        }
      } else {
        _overAllFilterMaterials = _filterMaterialsByLanguage;
      }
    } else {
      // ignore: unnecessary_null_comparison
      if (_selectedTopics != null && _selectedTopics.length > 0) {
        _overAllFilterMaterials =
            _materialFilterByTopics(_allMaterials, _selectedTopics);
      }
    }

    return _overAllFilterMaterials;
  }

  List<HiveMaterial> _materialFilterByLanguages(
      List<HiveLanguage>? _selectedLanguages) {
    List<HiveMaterial>? _filterMaterialsByLanguage = [];

    _selectedLanguages!.forEach((element) {
      var filteredMaterials = _allMaterials
          .where((material) => (material.languageIds!.contains(element.id)))
          .toList();
          print('selected language ids: ${element.id}');
           _allMaterials.forEach((element) {
          print('material language ids: ${element.id}');
           });


      if (_filterMaterialsByLanguage!.length == 0 && filteredMaterials.length != 0) {
        _filterMaterialsByLanguage = filteredMaterials;
      } else {
        filteredMaterials.forEach((filterMaterial) {
          List<HiveMaterial> result = _filterMaterialsByLanguage!
              .where((output) => output.id == filterMaterial.id)
              .toList();

          if (result.length == 0) {
            _filterMaterialsByLanguage!.add(filterMaterial);
          }
        });
      }
    });

    return _filterMaterialsByLanguage!;
  }

  List<HiveMaterial> _materialFilterByTopics(
      List<HiveMaterial> materials, List<HiveMaterialTopic>? _selectedTopics) {
    List<HiveMaterial> _listToShow = [];

    _selectedTopics!.forEach((element) {
      var filteredMaterials = materials
          .where((material) => (material.topics!.contains(element.name)))
          .toList();

      if (_listToShow.length == 0) {
        _listToShow = filteredMaterials;
      } else {
        filteredMaterials.forEach((filterMaterial) {
          List<HiveMaterial> result = _listToShow
              .where((output) => output.id == filterMaterial.id)
              .toList();
          if (result.length == 0) {
            // If item is already not added then add that item in the material list
            _listToShow.add(filterMaterial);
          }
        });
      }
      print(filteredMaterials.length);
    });

    return _listToShow;
  }

  void addMaterial(HiveMaterial? material) {
    print('add Material');
    fetchMaterialsFromDB();
    // _filteredMaterialsList.add(material!);
    // _materials.sink.add(_filteredMaterialsList);
  }

  void editMaterial(HiveMaterial? material) {
    print('edit Material');
    final index = _filteredMaterialsList
        .indexWhere((element) => element.id == material!.id);

    _filteredMaterialsList.removeAt(index);
    _filteredMaterialsList.insert(index, material!);
    _materials.sink.add(_filteredMaterialsList);
  }

  void dispose() {
    _materials.close();
  }
}
