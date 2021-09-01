import 'package:starfish/src/generated/starfish.pb.dart';
import 'package:starfish/utils/services/api_provider.dart';

class CurrentUserRepository {
  final apiProvider = ApiProvider();

  Future<User> getUser() => apiProvider.getCurrentUser();
}
