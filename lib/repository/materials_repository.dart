import 'package:grpc/grpc.dart';
import 'package:starfish/src/generated/starfish.pb.dart';
import 'package:starfish/utils/services/api_provider.dart';

class MaterialRepository {
  final apiProvider = ApiProvider();

  Future<ResponseStream<Material>> getMaterials() => apiProvider.getMateials();

  Future<ResponseStream<MaterialTopic>> getMaterialTopics() =>
      apiProvider.getMateialTopics();
}
