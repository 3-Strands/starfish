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
  final GroupRepository repository = GroupRepository();
  late BehaviorSubject<Map<UserGroupRoleFilter, List<HiveGroup>>> _groups;

  String _query = '';
  UserGroupRoleFilter groupRoleFilter = UserGroupRoleFilter.FILTER_ALL;

  GroupBloc() {
    //initializes the subject with element already
    _groups = new BehaviorSubject<Map<UserGroupRoleFilter, List<HiveGroup>>>();
  }

  // Add data to Stream
  Stream<Map<UserGroupRoleFilter, List<HiveGroup>>> get groups =>
      _groups.stream;

  setQuery(String query) {
    _query = query;
  }

  fetchAllGroupsByRole() async {
    final Map<GroupUser_Role, List<String>> _roleGroupIdsMap = Map();
    final Map<UserGroupRoleFilter, List<HiveGroup>> _roleGroupMap = Map();

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
        _roleGroupMap[UserGroupRoleFilter.FILTER_LEARNER] =
            await _getGroupsWithIds(
                _roleGroupIdsMap[GroupUser_Role.LEARNER] ?? []);
      });
    } else if (groupRoleFilter == UserGroupRoleFilter.FILTER_ADMIN_CO_LEAD) {
      List<String> _groupIds = [];
      _groupIds.addAll(_roleGroupIdsMap[GroupUser_Role.ADMIN]!);
      _groupIds.addAll(_roleGroupIdsMap[GroupUser_Role.TEACHER]!);

      _roleGroupMap[UserGroupRoleFilter.FILTER_ADMIN_CO_LEAD] = [];

      _roleGroupIdsMap[GroupUser_Role.ADMIN]!.forEach((element) async {
        _roleGroupMap[UserGroupRoleFilter.FILTER_ADMIN_CO_LEAD]?.addAll(
            await _getGroupsWithIds(
                _roleGroupIdsMap[GroupUser_Role.ADMIN] ?? []));
      });

      _roleGroupIdsMap[GroupUser_Role.TEACHER]!.forEach((element) async {
        _roleGroupMap[UserGroupRoleFilter.FILTER_ADMIN_CO_LEAD]?.addAll(
            await _getGroupsWithIds(
                _roleGroupIdsMap[GroupUser_Role.TEACHER] ?? []));
      });
    } else {
      //if (groupRoleFilter == UserGroupRoleFilter.FILTER_ALL) {
      _roleGroupMap[UserGroupRoleFilter.FILTER_ADMIN_CO_LEAD] = [];
      _roleGroupMap[UserGroupRoleFilter.FILTER_LEARNER] = [];

      _roleGroupIdsMap[GroupUser_Role.ADMIN]!.forEach((element) async {
        _roleGroupMap[UserGroupRoleFilter.FILTER_ADMIN_CO_LEAD]?.addAll(
            await _getGroupsWithIds(
                _roleGroupIdsMap[GroupUser_Role.ADMIN] ?? []));
      });

      _roleGroupIdsMap[GroupUser_Role.TEACHER]!.forEach((element) async {
        _roleGroupMap[UserGroupRoleFilter.FILTER_LEARNER]?.addAll(
            await _getGroupsWithIds(
                _roleGroupIdsMap[GroupUser_Role.TEACHER] ?? []));
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
  }

  Future<List<HiveGroup>> _getGroupsWithIds(List<String> groupIds) async {
    List<HiveGroup> _groups = await repository.fetchGroupsFromDB();

    return _groups
        .where((HiveGroup group) =>
            groupIds.contains(group.id) &&
            group.name!.toLowerCase().contains(_query.toLowerCase()))
        .toList();
  }

  Future<int> addEditGroup(HiveGroup group) async {
    return repository.addEditGroup(group).then((value) {
      //_allGroups.add(group);
      //_groups.sink.add(_allGroups);
      return value;
    });
  }

  void dispose() {
    _groups.close();
  }
}
