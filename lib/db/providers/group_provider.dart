import 'package:hive/hive.dart';
import 'package:collection/collection.dart';
import 'package:starfish/db/hive_database.dart';
import 'package:starfish/db/hive_group.dart';
import 'package:starfish/db/hive_group_user.dart';
import 'package:starfish/modules/groups_view/add_edit_group_screen.dart';

class GroupProvider {
  late Box<HiveGroup> _groupBox;

  GroupProvider() {
    _groupBox = Hive.box<HiveGroup>(HiveDatabase.GROUP_BOX);
  }

  Future<List<HiveGroup>> getGroups() async {
    return _groupBox.values.toList();
  }

  Future<void> addEditGroup(HiveGroup group) async {
    int _currentIndex = -1;
    List<HiveGroupUser>? _localGroupUsers;
    _groupBox.values.toList().asMap().forEach((key, hiveGroup) {
      if (hiveGroup.id == group.id) {
        _currentIndex = key;

        _localGroupUsers = hiveGroup.users
            ?.where((element) =>
                element.isNew || element.isUpdated || element.isDirty)
            .toList();
      }
    });

    if (_currentIndex > -1) {
      if (_localGroupUsers != null && _localGroupUsers!.length > 0) {
        group.users?.addAll(_localGroupUsers!);
      }
      return _groupBox.put(_currentIndex, group);
    } else {
      _groupBox.add(group);
    }
  }

  Future<int> deleteGroupUser(HiveGroupUser groupUser) async {
    int _groupIndex = -1;
    int _groupUserIndex = -1;
    HiveGroup? _group;
    HiveGroupUser? _groupUser;

    _groupBox.values.toList().asMap().forEach((key, HiveGroup group) {
      if (group.id == groupUser.groupId) {
        _groupIndex = key;
        _group = group;
      }
    });

    if (_group == null || _groupIndex == -1 || _group?.users?.length == 0) {
      return -1;
    }
    _group?.users?.asMap().forEach((key, HiveGroupUser user) {
      if (user.groupId == groupUser.groupId) {
        _groupUserIndex = key;
        _groupUser = user;
      }
    });

    // Mark the matching GroupUser as dirty to to sync with remote
    if (_groupUser == null || _groupUserIndex == -1) {
      _groupUser!.isDirty = true;
    }
    // Also Mark the matching Group as updated to sync with remote
    _group!.isUpdated = true;

    // Update the group in local hive table
    _groupBox.putAt(_groupIndex, _group!);

    print('Groups After Delte: ');
    _groupBox.values.forEach((element) {
      print('==>> Group: $element ');
    });

    return 1;
    /*HiveGroup? _group = _groupBox.values.firstWhereOrNull((element) => element.id == groupUser.userId);
    if (_group == null) {
      return 0;
    }
    _group.users.whe
    _groupBox.deleteAt(index)*/
  }
}
