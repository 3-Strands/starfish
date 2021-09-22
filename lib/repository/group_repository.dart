import 'package:grpc/grpc.dart';
import 'package:starfish/src/generated/starfish.pb.dart';
import 'package:starfish/utils/services/api_provider.dart';

class GroupRepository {
  final apiProvider = ApiProvider();

  Future<ResponseStream<Group>> getGroups() => apiProvider.getGroups();
}
