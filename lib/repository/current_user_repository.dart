import 'package:starfish/src/generated/starfish.pb.dart';
import 'package:starfish/utils/services/api_provider.dart';

class CurrentUserRepository {
  final apiProvider = ApiProvider();

  Future<User> getUser() => apiProvider.getCurrentUser();

  Future<User> updateUser(
          String id,
          String name,
          String phone,
          Iterable<String> countryIds,
          Iterable<String> languageIds,
          bool linkGroups) =>
      apiProvider.updateCurrentUser(
          id, name, phone, countryIds, languageIds, linkGroups);
}
