import 'package:hive/hive.dart';
import 'package:collection/collection.dart';
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
    HiveUser? _user =
        _userBox.values.firstWhereOrNull((element) => element.id == userId);
    return _user != null ? _user.name! : userId;
  }

  String getPhone(String userId) {
    HiveUser? _user =
        _userBox.values.firstWhereOrNull((element) => element.id == userId);
    return _user != null ? _user.phone! : '';
  }

  String getDiallingCode(String userId) {
    HiveUser? _user =
        _userBox.values.firstWhereOrNull((element) => element.id == userId);
    return _user != null ? _user.diallingCode! : '';
  }
}
