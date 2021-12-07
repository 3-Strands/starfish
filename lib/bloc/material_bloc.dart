import 'dart:async';
import 'dart:io';

import 'package:grpc/grpc_or_grpcweb.dart';
import 'package:rxdart/rxdart.dart';
import 'package:starfish/db/hive_language.dart';
import 'package:starfish/db/hive_material.dart';
import 'package:starfish/db/hive_material_topic.dart';
import 'package:starfish/repository/materials_repository.dart';
import 'package:starfish/src/generated/file_transfer.pb.dart';

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

  List<File> _selectedFiles = [];
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
      if (_ifMaterialSupportsLanguage(element, selectedLanguages) &&
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

  StreamController<FileData> _controller = StreamController<FileData>();

  Stream<FileData> get fileDataStream => _controller.stream;

  uploadMaterial(String entityId, File file) async* {
    //BehaviorSubject<FileData> _fileData = new BehaviorSubject<FileData>();

// Add data to Stream
    //Stream<FileData> fileDataStream = _controller.stream;

    //File file = _selectedFiles.first;
    //Stream<List<int>> inputStream = file.openRead();

    FileMetaData metaData = FileMetaData(
      entityId: entityId,
      filename: file.path.split("/").last,
      entityType: EntityType.MATERIAL,
    );

    FileData fileMetaData = FileData(metaData: metaData);
    //FileData fileData = FileData(chunk: chunk);

    _controller.sink.add(fileMetaData);
    //_fileData.sink.add(fileData);

    materialRepository.apiProvider
        .uploadFile(Stream.value(fileMetaData))
        .then((responseStream) {
      print("UploadStatus: =>>");
      responseStream.listen((value) {
        print("UploadStatus: $value");
      });
    });
  }

  void setSelectedFiles(List<File> selectedFiles) {
    _selectedFiles = selectedFiles;
  }

  void dispose() {
    _materials.close();
    _controller.close();
  }
}
