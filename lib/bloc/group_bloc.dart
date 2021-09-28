import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:starfish/db/hive_group.dart';
import 'package:starfish/repository/group_repository.dart';
import 'package:starfish/src/generated/starfish.pb.dart';

class GroupBloc extends Object {
  late BehaviorSubject<List<HiveGroup>> _groups;

  GroupBloc() {
    //initializes the subject with element already
    _groups = new BehaviorSubject<List<HiveGroup>>();
  }

  // Add data to Stream
  Stream<List<HiveGroup>> get groups => _groups.stream;

  List<HiveGroup> _allGroups = [];

  fetchGroupsFromDB() async {
    GroupRepository repository = GroupRepository();

    repository.fetchGroupsFromDB().then(
      (value) {
        print('Group Count: ${value.length}');
        _allGroups = value;

        //var map1 = Map.fromIterable(value, key: (e) => e.id, value: (e) => e);

        _groups.sink.add(_allGroups);
      },
    ).whenComplete(() => {});
  }

  fetchGroupsWhereUserHavingRole(
      String userId, List<GroupUser_Role> userRoles) {
    _allGroups.where((HiveGroup group) => group.users!.contains(
        (GroupUser groupUser) => {
              groupUser.userId == userId && userRoles.contains(groupUser.role)
            }));
  }

  Future<int> addEditMaterial(HiveGroup group) async {
    GroupRepository repository = GroupRepository();
    return repository.addEditGroup(group).then((value) {
      _allGroups.add(group);
      _groups.sink.add(_allGroups);
      return value;
    });
  }

  void dispose() {
    _groups.close();
  }
}
