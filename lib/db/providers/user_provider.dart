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

  HiveUser? getUserById(String userId) {
    return _userBox.values.firstWhereOrNull((element) => element.id == userId);
  }

  Future<void> createUpdateUser(HiveUser user) async {
    int _currentIndex = -1;
    _userBox.values.toList().asMap().forEach((key, hiveUser) {
      if (hiveUser.id == user.id) {
        _currentIndex = key;
      }
    });

    if (_currentIndex > -1) {
      return _userBox.putAt(_currentIndex, user);
    } else {
      _userBox.add(user);
    }
  }

  Future<void> deleteUserFromDB(HiveUser user) async {
    int _currentIndex = -1;
    _userBox.values.toList().asMap().forEach((key, hiveUser) {
      if (hiveUser.id == user.id) {
        _currentIndex = key;
      }
    });

    if (_currentIndex > -1) {
      return _userBox.deleteAt(_currentIndex);
    }
  }

  String getName(String userId) {
    HiveUser? _user =
        _userBox.values.firstWhereOrNull((element) => element.id == userId);
    return _user != null ? _user.name ?? userId : userId;
  }

  String getPhone(String userId) {
    HiveUser? _user =
        _userBox.values.firstWhereOrNull((element) => element.id == userId);
    return _user != null ? _user.phone ?? '' : '';
  }

  String getDiallingCode(String userId) {
    HiveUser? _user =
        _userBox.values.firstWhereOrNull((element) => element.id == userId);
    return _user != null ? _user.diallingCode ?? '' : '';
  }

  String getPhoneWithDialingCode(String userId) {
    HiveUser? _user =
        _userBox.values.firstWhereOrNull((element) => element.id == userId);
    return _user != null ? _user.phoneWithDialingCode : '';
  }
}
