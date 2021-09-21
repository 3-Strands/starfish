import 'package:grpc/grpc.dart';
import 'package:starfish/src/generated/starfish.pb.dart';
import 'package:starfish/utils/services/api_provider.dart';

class MaterialRepository {
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
}
