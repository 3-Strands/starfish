import 'package:hive/hive.dart';
import 'package:collection/collection.dart';
import 'package:starfish/db/hive_current_user.dart';
import 'package:starfish/db/hive_database.dart';
import 'package:starfish/db/hive_user.dart';

class CurrentUserProvider {
  late Box<HiveCurrentUser> _currentUserBox;

  CurrentUserProvider() {
    _currentUserBox = Hive.box<HiveCurrentUser>(HiveDatabase.CURRENT_USER_BOX);
  }

  Future<HiveCurrentUser> getUser() async {
    return _currentUserBox.values.first;
  }

  @Deprecated("Use 'getCurrentUserSync' instead")
  HiveCurrentUser getUserSync() {
    return _currentUserBox.values.first;
  }

  HiveCurrentUser? getCurrentUserSync() {
    return _currentUserBox.values.firstOrNull;
  }

  bool hasCurrentUser() {
    return _currentUserBox.values.firstOrNull != null;
  }

  /*Future<int> updateUser(HiveCurrentUser user) async {
    return _currentUserBox.add(user);
  }*/

  @Deprecated("Use 'createUpdate' instead")
  void updateUser(HiveCurrentUser _hiveCurrentUser) {
    _currentUserBox.putAt(0, _hiveCurrentUser);
  }

  Future<void> createUpdate(HiveCurrentUser _hiveCurrentUser) {
    return _currentUserBox.isEmpty
        ? _currentUserBox.add(_hiveCurrentUser)
        : _currentUserBox.putAt(0, _hiveCurrentUser);
  }
}

extension CurrentUserProviderExt on CurrentUserProvider {
  HiveUser get user {
    return HiveUser.fromCurrentUser(_currentUserBox.values.first);
  }
}
