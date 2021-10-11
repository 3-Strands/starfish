import 'package:grpc/grpc.dart';
import 'package:starfish/db/providers/material_provider.dart';
import 'package:starfish/db/hive_material.dart';
import 'package:starfish/db/hive_material_topic.dart';
import 'package:starfish/src/generated/starfish.pb.dart';
import 'package:starfish/utils/services/api_provider.dart';

class MaterialRepository {
  final materialProvider = MaterialProvider();
  final apiProvider = ApiProvider();

  Future<ResponseStream<Material>> getMaterials() => apiProvider.getMateials();

  Future<ResponseStream<MaterialTopic>> getMaterialTopics() =>
      apiProvider.getMateialTopics();

  Future<ResponseStream<MaterialType>> getMaterialTypes() =>
      apiProvider.getMateialTypes();

  Future<ResponseStream<CreateUpdateMaterialsResponse>> createUpdateMaterial({
    required Material material,
    required List<String> fieldMaskPaths,
  }) =>
      apiProvider.createUpdateMaterial(
        material,
        fieldMaskPaths,
      );

  Future<List<HiveMaterial>> fetchMaterialsFromDB() =>
      materialProvider.getMateials();

  Future<List<HiveMaterialTopic>> fetchMaterialTopicsFromDB() =>
      materialProvider.getMateialTypes();

  Future<void> createUpdateMaterialInDB(HiveMaterial material) =>
      materialProvider.createUpdateMaterial(material);
}
