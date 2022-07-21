import 'package:hive/hive.dart';
import 'package:collection/collection.dart';
import 'package:starfish/db/hive_database.dart';
import 'package:starfish/db/hive_group.dart';
import 'package:starfish/db/hive_group_user.dart';
import 'package:starfish/src/generated/starfish.pb.dart';

class GroupProvider {
  late Box<HiveGroup> _groupBox;
  late Box<HiveGroupUser> _groupUserBox;

  GroupProvider() {
    _groupBox = Hive.box<HiveGroup>(HiveDatabase.GROUP_BOX);
    _groupUserBox = Hive.box<HiveGroupUser>(HiveDatabase.GROUP_USER_BOX);
  }

  Future<List<HiveGroup>> getGroups() async {
    return _groupBox.values
        .where((element) =>
            Group_Status.valueOf(element.status ?? 0) == Group_Status.ACTIVE)
        .toList();
  }

  List<HiveGroupUser> getGroupUsersSync() {
    return _groupUserBox.values.toList();
  }

  List<HiveGroupUser> getGroupUsersByGroupIdSync(String? groupId) {
    return _groupUserBox.values
        .where((element) => element.groupId == groupId)
        .toList();
  }

  Future<void> addEditGroup(HiveGroup group) async {
    int _currentIndex = -1;
    _groupBox.values.toList().asMap().forEach((key, hiveGroup) {
      if (hiveGroup.id == group.id) {
        _currentIndex = key;
      }
    });

    if (_currentIndex > -1) {
      return _groupBox.putAt(_currentIndex, group);
    } else {
      _groupBox.add(group);
    }
  }

  Future<void> createUpdateGroupUser(HiveGroupUser groupUser) async {
    int _currentIndex = -1;
    _groupUserBox.values.toList().asMap().forEach((key, element) {
      if (element.userId == groupUser.userId &&
          element.groupId == groupUser.groupId) {
        _currentIndex = key;
      }
    });

    if (_currentIndex > -1) {
      return _groupUserBox.putAt(_currentIndex, groupUser);
    } else {
      _groupUserBox.add(groupUser);
    }
  }

  void updateGroupUserId(String? localUserId, String? remoteUserId) {
    _groupUserBox.values
        .where((element) => element.userId == localUserId)
        .forEach((_hiveGroupUser) {
      // _hiveGroupUser.userId = remoteUserId;

      _hiveGroupUser.save();
    });
  }

  void deleteGroupUser(HiveGroupUser groupUser) {
    _groupUserBox.values
        .where((element) =>
            element.userId == groupUser.userId &&
            element.groupId == groupUser.groupId)
        .forEach((element) {
      element.delete();
    });
  }

  void deleteGroupUserByUserId(String userId) {
    _groupUserBox.values
        .where((groupUser) => groupUser.userId == userId)
        .forEach((groupUser) async {
      await groupUser.delete();
    });
  }

  HiveGroup? getGroupById(String groupId) {
    return _groupBox.values
        .firstWhereOrNull((element) => element.id == groupId);
  }

  // List<HiveGroup>? userGroupsWithRole(
  //     String userId, List<GroupUser_Role> groupUserRoleList) {
  //   List<HiveGroup> _groupList = _groupBox.values
  //       .where((element) =>
  //           Group_Status.valueOf(element.status ?? 0) == Group_Status.ACTIVE)
  //       .toList();
  //   if (_groupList.length == 0) {
  //     return null;
  //   }
  //   return _groupList.where((element) {
  //     return groupUserRoleList.contains(element.getMyRole(userId));
  //   }).toList();
  // }

  Future addGroupUsers(List<HiveGroupUser> groupUsers) async {
    groupUsers.forEach((element) async {
      await createUpdateGroupUser(element);
    });
    //return _groupUserBox.addAll(groupUsers);
  }
}
