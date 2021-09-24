import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:rxdart/rxdart.dart';
import 'package:starfish/db/hive_database.dart';
import 'package:starfish/db/hive_material.dart';
import 'package:starfish/db/hive_material_topic.dart';
import 'package:starfish/repository/materials_repository.dart';

class MaterialBloc extends Object {
  late BehaviorSubject<List<HiveMaterial>> _materials;

  // BehaviorSubject<List<HiveMaterialTopic>> _materialTopics =
  //     BehaviorSubject<List<HiveMaterialTopic>>();

  MaterialBloc() {
    _materials = new BehaviorSubject<
        List<HiveMaterial>>(); //initializes the subject with element already
  }

  // Add data to Stream
  Stream<List<HiveMaterial>> get materials => _materials.stream;

  List<HiveMaterial> allMaterials = [];

  // Stream<List<HiveMaterialTopic>> get materialTopics => _materialTopics.stream;

  fetchMaterialsFromDB() async {
    MaterialRepository materialRepository = MaterialRepository();

    materialRepository
        .fetchMaterialsFromDB()
        .then(
          (value) => {allMaterials = value},
        )
        .whenComplete(() => {_materials.sink.add(allMaterials)});
  }

  void addMaterial(HiveMaterial? material) {
    print('add Material');
    allMaterials.add(material!);
    _materials.sink.add(allMaterials);
  }

  void editMaterial(HiveMaterial? material) {
    print('edit Material');
    final index =
        allMaterials.indexWhere((element) => element.id == material!.id);
    allMaterials.removeAt(index);
    allMaterials.insert(index, material!);
    _materials.sink.add(allMaterials);
  }

  // void fetchMaterialTopicsFromDB() {
  //   MaterialRepository materialRepository = MaterialRepository();
  //   materialRepository
  //       .fetchMaterialTopicsFromDB()
  //       .then((value) => {_materialTopics.sink.add(value)})
  //       .whenComplete(() => {
  //             print('_materialTopics.length'),
  //             print(_materialTopics.length),
  //             // _materialTopics.forEach((element) {
  //             //   print('element ==>>');
  //             //   print(element.name);
  //             // }),
  //           });
  //   // print("topices ==>>");
  //   // print(topices);
  // }

  void dispose() {
    _materials.close();
    // _materialTopics.close();
  }
}











/*
Stream<ApiResponse<StatsVehiclesResponse>> get statsStream =>
      _subjectStatsVehicle.stream;
ApplicationBloc() {
    _applicationRepository = ApplicationRepository();
changeVehicleRequest(dynamic params) async {
    _changeVehicleAPI.sink.add(ApiResponse.loading('Please wait...'));
    try {
      var userId = await LocalStorageService().getUserId();

      Map<String, dynamic> result =
          await _applicationRepository.changeVehicleRequest(params, userId);
      print(result);
      _changeVehicleAPI.sink.add(ApiResponse.completed(result));
    } catch (e) {
      _changeVehicleAPI.sink.add(ApiResponse.error(e.toString()));
    }
  }
void dispose() {
    _applicationSubject?.close();
}
*/