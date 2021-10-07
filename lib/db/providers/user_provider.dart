import 'package:hive/hive.dart';
import 'package:starfish/db/hive_database.dart';
import 'package:starfish/db/hive_user.dart';

class UserProvider {
  late Box<HiveUser> _userBox;

  UserProvider() {
    _userBox = Hive.box<HiveUser>(HiveDatabase.USER_BOX);
  }

  Future<List<HiveUser>> getUsers() async {
    return _userBox.values.toList();
  }

  String getName(String userId) {
    return _userBox.values.firstWhere((element) => element.id == userId).name!;
  }

  String getPhone(String userId) {
    return _userBox.values.firstWhere((element) => element.id == userId).phone!;
  }

  String getDiallingCode(String userId) {
    return _userBox.values
        .firstWhere((element) => element.id == userId)
        .diallingCode!;
  }
}
