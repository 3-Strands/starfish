import 'package:hive/hive.dart';
import 'package:starfish/db/hive_current_user.dart';
import 'package:starfish/db/hive_database.dart';

class CurrentUserProvider {
  late Box<HiveCurrentUser> _currentUserBox;

  CurrentUserProvider() {
    _currentUserBox = Hive.box<HiveCurrentUser>(HiveDatabase.CURRENT_USER_BOX);
  }

  Future<HiveCurrentUser> getUser() async {
    return _currentUserBox.values.first;
  }

  /*Future<int> updateUser(HiveCurrentUser user) async {
    return _currentUserBox.add(user);
  }*/
}
