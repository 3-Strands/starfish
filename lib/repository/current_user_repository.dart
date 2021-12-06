import 'package:starfish/db/hive_current_user.dart';
import 'package:starfish/db/providers/current_user_provider.dart';
import 'package:starfish/src/generated/starfish.pb.dart';
import 'package:starfish/utils/services/api_provider.dart';

class CurrentUserRepository {
  final dbProvider = CurrentUserProvider();
  final apiProvider = ApiProvider();

  Future<User> getUser() => apiProvider.getCurrentUser();

  Future<User> updateCurrentUser(User user, List<String> fieldMaskPaths) =>
      apiProvider.updateCurrentUser(user, fieldMaskPaths);

  Future<HiveCurrentUser> getUserFromDB() => dbProvider.getUser();

  HiveCurrentUser getUserSyncFromDB() => dbProvider.getUserSync();
}
