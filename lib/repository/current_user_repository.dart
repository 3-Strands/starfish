import 'package:grpc/grpc.dart';
import 'package:starfish/src/generated/starfish.pb.dart';
import 'package:starfish/utils/services/api_provider.dart';

class CurrentUserRepository {
  final apiProvider = ApiProvider();

  Future<User> getUser() => apiProvider.getCurrentUser();

  Future<User> updateUser() => apiProvider.updateCurrentUser();

  Future<ResponseStream<Country>> listAllCountries() =>
      apiProvider.listAllCountries();

  Future<ResponseStream<Language>> listAllLanguages() =>
      apiProvider.listAllLanguages();
}
