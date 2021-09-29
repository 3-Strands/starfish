import 'package:starfish/db/hive_current_user.dart';
import 'package:starfish/db/providers/current_user_provider.dart';
import 'package:starfish/src/generated/starfish.pb.dart';
import 'package:starfish/utils/services/api_provider.dart';

class CurrentUserRepository {
  final dbProvider = CurrentUserProvider();
  final apiProvider = ApiProvider();

  Future<User> getUser() => apiProvider.getCurrentUser();

  Future<User> updateUser(
          String id,
          String? name,
          String? phone,
          Iterable<String>? countryIds,
          Iterable<String>? languageIds,
          bool? linkGroups,
          List<String> fieldMaskPaths) =>
      apiProvider.updateCurrentUser(
          id, name, phone, countryIds, languageIds, linkGroups, fieldMaskPaths);

  Future<HiveCurrentUser> getUserFromDB() => dbProvider.getUser();
}
