import 'dart:async';
import 'package:collection/collection.dart';

import 'package:rxdart/rxdart.dart';
import 'package:starfish/db/hive_current_user.dart';
import 'package:starfish/db/hive_group.dart';
import 'package:starfish/db/hive_group_user.dart';
import 'package:starfish/repository/current_user_repository.dart';
import 'package:starfish/repository/group_repository.dart';
import 'package:starfish/src/generated/starfish.pb.dart';

class GroupBloc extends Object {
  final GroupRepository repository = GroupRepository();
  late BehaviorSubject<List<HiveGroup>> _groups;

  GroupBloc() {
    //initializes the subject with element already
    _groups = new BehaviorSubject<List<HiveGroup>>();
  }

  // Add data to Stream
  Stream<List<HiveGroup>> get groups => _groups.stream;

  List<HiveGroup> _allGroups = [];

  fetchGroupsFromDB(String query, int groupTitleIndex) async {
    switch (groupTitleIndex) {
      case 1:
        _fetchGroupWhereRole(
            query, [GroupUser_Role.ADMIN, GroupUser_Role.TEACHER]);
        break;
      case 2:
        _fetchGroupWhereRole(query, [GroupUser_Role.LEARNER]);
        break;
      case 0:
      default:
        _fetchGroupWhereRole(query, [
          GroupUser_Role.ADMIN,
          GroupUser_Role.TEACHER,
          GroupUser_Role.LEARNER,
          GroupUser_Role.UNSPECIFIED_ROLE,
        ]);
    }
  }

  _fetchGroupWhereRole(String query, List<GroupUser_Role> havingRoles) async {
    CurrentUserRepository currentUserRepository = CurrentUserRepository();
    HiveCurrentUser currentUser = await currentUserRepository.getUserFromDB();

    List<String> matchinListIds = currentUser.groups
        .where((HiveGroupUser groupUser) =>
            havingRoles.contains(GroupUser_Role.valueOf(groupUser.role!)))
        .map((e) => e.groupId!)
        .toList();

    if (matchinListIds.isEmpty) {
      _allGroups = [];
      _groups.sink.add(_allGroups);
    } else {
      repository.fetchGroupsFromDB().then((List<HiveGroup> groups) {
        List<HiveGroup> _g = [];

        groups.forEach((element) {
          if (matchinListIds.contains(element.id) && 
              element.name!.toLowerCase().contains(query.toLowerCase())) {
            _g.add(element);
          }
        });
        _allGroups = _g;
        _groups.sink.add(_allGroups);
      });
    }
  }

  Future<int> addEditMaterial(HiveGroup group) async {
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
