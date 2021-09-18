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

  Future<ResponseStream<CreateUpdateMaterialsResponse>> createUpdateMaterial(
    String? id,
    String? creatorId,
    Material_Status? status,
    String? title,
    String? description,
    String? url,
    Material_Visibility? visibility,
    Material_Editability? editability,
    Iterable<String>? files,
    Iterable<String>? languageIds,
    Iterable<String>? typeIds,
    Iterable<String>? topics,
    List<String> fieldMaskPaths,
  ) =>
      apiProvider.createUpdateMaterial(
        id,
        creatorId,
        status,
        title,
        description,
        url,
        visibility,
        editability,
        files,
        languageIds,
        typeIds,
        topics,
        fieldMaskPaths,
      );
}
