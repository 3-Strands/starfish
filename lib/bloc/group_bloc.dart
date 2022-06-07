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

  String query = '';
  UserGroupRoleFilter groupRoleFilter = UserGroupRoleFilter.FILTER_ALL;

  GroupBloc() {
    //initializes the subject with element already
    _groups = new BehaviorSubject<Map<UserGroupRoleFilter, List<HiveGroup>>>();
  }

  // Add data to Stream
  Stream<Map<UserGroupRoleFilter, List<HiveGroup>>> get groups =>
      _groups.stream;

  fetchAllGroupsByRole() async {
    final Map<UserGroupRoleFilter, List<HiveGroup>> _roleGroupMap = Map();
    _roleGroupMap[UserGroupRoleFilter.FILTER_ADMIN_CO_LEAD] = [];
    _roleGroupMap[UserGroupRoleFilter.FILTER_LEARNER] = [];

    final CurrentUserRepository currentUserRepository = CurrentUserRepository();
    HiveCurrentUser currentUser = await currentUserRepository.getUserFromDB();

    List<HiveGroup> groups = await repository.fetchGroupsFromDB();
    groups.forEach((element) {
      if (element.name!.toLowerCase().contains(query.toLowerCase()) ||
          element.description!.toLowerCase().contains(query.toLowerCase())) {
        // set Role of current User in the group
        element.userRole = element.getMyRole(currentUser.id);

        switch (element.getMyRole(currentUser.id)) {
          case GroupUser_Role.ADMIN:
            _roleGroupMap[UserGroupRoleFilter.FILTER_ADMIN_CO_LEAD]
                ?.add(element);
            break;
          case GroupUser_Role.TEACHER:
            _roleGroupMap[UserGroupRoleFilter.FILTER_ADMIN_CO_LEAD]
                ?.add(element);
            break;
          case GroupUser_Role.LEARNER:
            _roleGroupMap[UserGroupRoleFilter.FILTER_LEARNER]?.add(element);
            break;
          /*case GroupUser_Role.UNSPECIFIED_ROLE:
        default:
          _roleGroupMap[UserGroupRoleFilter.FILTER_LEARNER]?.add(element);*/
        }
      }
    });

    if (groupRoleFilter == UserGroupRoleFilter.FILTER_ALL) {
      _groups.sink.add(_roleGroupMap);
    } else {
      _groups.sink.add({groupRoleFilter: _roleGroupMap[groupRoleFilter] ?? []});
    }
  }

  Future<void> addEditGroup(HiveGroup group) async {
    return repository.addEditGroup(group).then((_) {
      //_allGroups.add(group);
      //_groups.sink.add(_allGroups);
      fetchAllGroupsByRole();
    });
  }

  leaveGroup(HiveGroup group) async {
    HiveCurrentUser _currentUser =
        await CurrentUserRepository().getUserFromDB();

    HiveGroupUser? _groupUser = group.users
        ?.firstWhereOrNull((element) => element.userId == _currentUser.id);

    if (_groupUser != null) {
      /// Mark record as dirty
      _groupUser.isDirty = true; // marked as dirty for deletion
      createUpdateGroupUser(_groupUser).then((_) => fetchAllGroupsByRole());
    }
  }

  Future<void> createUpdateGroupUser(HiveGroupUser groupUser) async {
    return repository
        .createUpdateGroupUserInDB(groupUser: groupUser)
        .then((value) => fetchAllGroupsByRole());
  }

  void dispose() {
    _groups.close();
  }

  Future addGroupUsers(List<HiveGroupUser> groupUsers) async {
    return repository.dbProvider.addGroupUsers(groupUsers);
  }
}
