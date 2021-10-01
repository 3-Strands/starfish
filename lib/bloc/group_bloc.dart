import 'dart:async';
import 'package:collection/collection.dart';

import 'package:rxdart/rxdart.dart';
import 'package:starfish/db/hive_current_user.dart';
import 'package:starfish/db/hive_group.dart';
import 'package:starfish/db/hive_group_user.dart';
import 'package:starfish/enums/user_group_role_filter.dart';
import 'package:starfish/repository/current_user_repository.dart';
import 'package:starfish/repository/group_repository.dart';
import 'package:starfish/src/generated/starfish.pb.dart';

class GroupBloc extends Object {
  UserGroupRoleFilter groupRoleFilter = UserGroupRoleFilter.FILTER_ALL;

  final GroupRepository repository = GroupRepository();
  late BehaviorSubject<Map<GroupUser_Role, List<HiveGroup>>> _groups;

  String _query = '';

  GroupBloc() {
    //initializes the subject with element already
    _groups = new BehaviorSubject<Map<GroupUser_Role, List<HiveGroup>>>();
  }

  // Add data to Stream
  Stream<Map<GroupUser_Role, List<HiveGroup>>> get groups => _groups.stream;

  List<HiveGroup> _allGroups = [];

  /*fetchGroupsFromDB(String query, int groupTitleIndex) async {
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
  }*/

  fetchGroupsFromDB(String query, String filter) {}

  fetchAllGroupsByRole(
      String query, UserGroupRoleFilter groupRoleFilter) async {
    final Map<GroupUser_Role, List<String>> _roleGroupIdsMap = Map();
    final Map<GroupUser_Role, List<HiveGroup>> _roleGroupMap = Map();

    _roleGroupIdsMap[GroupUser_Role.ADMIN] =
        await _fetchGroupIdsWithRole(GroupUser_Role.ADMIN) ?? [];
    _roleGroupIdsMap[GroupUser_Role.TEACHER] =
        await _fetchGroupIdsWithRole(GroupUser_Role.TEACHER) ?? [];
    _roleGroupIdsMap[GroupUser_Role.LEARNER] =
        await _fetchGroupIdsWithRole(GroupUser_Role.LEARNER) ?? [];
    _roleGroupIdsMap[GroupUser_Role.UNSPECIFIED_ROLE] =
        await _fetchGroupIdsWithRole(GroupUser_Role.UNSPECIFIED_ROLE) ?? [];

    if (groupRoleFilter == UserGroupRoleFilter.FILTER_LEARNER) {
      _roleGroupIdsMap[GroupUser_Role.LEARNER]?.forEach((element) async {
        _roleGroupMap[GroupUser_Role.LEARNER] = await _getGroupsWithIds(
            _roleGroupIdsMap[GroupUser_Role.LEARNER] ?? []);
      });
    } else if (groupRoleFilter == UserGroupRoleFilter.FILTER_ADMIN_CO_LEAD) {
      List<String> _groupIds = [];
      _groupIds.addAll(_roleGroupIdsMap[GroupUser_Role.ADMIN]!);
      _groupIds.addAll(_roleGroupIdsMap[GroupUser_Role.TEACHER]!);

      _roleGroupMap[GroupUser_Role.ADMIN] = [];

      _roleGroupIdsMap[GroupUser_Role.ADMIN]!.forEach((element) async {
        _roleGroupMap[GroupUser_Role.ADMIN]?.addAll(await _getGroupsWithIds(
            _roleGroupIdsMap[GroupUser_Role.ADMIN] ?? []));
      });

      _roleGroupIdsMap[GroupUser_Role.TEACHER]!.forEach((element) async {
        _roleGroupMap[GroupUser_Role.ADMIN]?.addAll(await _getGroupsWithIds(
            _roleGroupIdsMap[GroupUser_Role.TEACHER] ?? []));
      });
    } else {
      //if (groupRoleFilter == UserGroupRoleFilter.FILTER_ALL) {
      _roleGroupIdsMap
          .forEach((GroupUser_Role key, List<String> groupIds) async {
        _roleGroupMap[key] = await _getGroupsWithIds(groupIds);
      });
    }
    _groups.sink.add(_roleGroupMap);
  }

  Future<List<String>?> _fetchGroupIdsWithRole(
      GroupUser_Role groupUserRole) async {
    CurrentUserRepository currentUserRepository = CurrentUserRepository();
    HiveCurrentUser currentUser = await currentUserRepository.getUserFromDB();
    return currentUser.groups
        .where((HiveGroupUser groupUser) =>
            GroupUser_Role.valueOf(groupUser.role!) == groupUserRole)
        .map((e) => e.groupId!)
        .toList();

    /*currentUserRepository.getUserFromDB().then((HiveCurrentUser currentUser) {
      List<String> ids = currentUser.groups
          .where((HiveGroupUser groupUser) =>
              GroupUser_Role.valueOf(groupUser.role!) == groupUserRole)
          .map((e) => e.groupId!)
          .toList();
      print('IDS[$groupUserRole]: $ids');
      return ids;
    }).onError((error, stackTrace) {
      return [];
    });*/
  }

  Future<List<HiveGroup>> _getGroupsWithIds(List<String> groupIds) async {
    List<HiveGroup> _groups = await repository.fetchGroupsFromDB();

    return _groups
        .where((HiveGroup group) => groupIds.contains(group.id))
        .toList();
  }

/*
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
*/
  Future<int> addEditMaterial(HiveGroup group) async {
    return repository.addEditGroup(group).then((value) {
      _allGroups.add(group);
      //_groups.sink.add(_allGroups);
      return value;
    });
  }

  void dispose() {
    _groups.close();
  }
}
