import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:rxdart/rxdart.dart';
import 'package:starfish/db/hive_action.dart';
import 'package:starfish/db/hive_action_user.dart';
import 'package:starfish/db/hive_current_user.dart';
import 'package:starfish/db/hive_group.dart';
import 'package:starfish/db/hive_material.dart';
import 'package:starfish/db/providers/group_provider.dart';
import 'package:starfish/db/providers/material_provider.dart';
import 'package:starfish/enums/action_filter.dart';
import 'package:starfish/navigation_service.dart';
import 'package:starfish/repository/action_repository.dart';
import 'package:starfish/repository/current_user_repository.dart';
import 'package:starfish/src/generated/starfish.pb.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ActionBloc extends Object {
  final ActionRepository actionRepository = ActionRepository();
  late BehaviorSubject<Map<HiveGroup, List<HiveAction>>> _actionsForMe;
  late BehaviorSubject<Map<HiveGroup, List<HiveAction>>> _actionsForGroup;
  late BehaviorSubject<List<HiveAction>> _actionsToReuse;
  late BehaviorSubject<List<HiveMaterial>> _materials;

  ActionFilter actionFilter = ActionFilter.THIS_MONTH;

  String query = '';
  String reuseActionQuery = '';
  String materialQuery = '';

  int selectedTabIndex = 0;
  HiveGroup? focusedGroup;

  ActionBloc() {
    //initializes the subject with element already
    _actionsForMe = new BehaviorSubject<Map<HiveGroup, List<HiveAction>>>();
    _actionsForGroup = new BehaviorSubject<Map<HiveGroup, List<HiveAction>>>();
    _actionsToReuse = new BehaviorSubject<List<HiveAction>>();
    _materials = new BehaviorSubject<List<HiveMaterial>>();
  }

  Stream<Map<HiveGroup, List<HiveAction>>> get actionsForMe =>
      _actionsForMe.stream;

  Stream<Map<HiveGroup, List<HiveAction>>> get actionsForGroup =>
      _actionsForGroup.stream;

  Stream<List<HiveAction>> get actions => _actionsToReuse.stream;

  Stream<List<HiveMaterial>> get materials => _materials.stream;

  Future<void> createUpdateAction(HiveAction action) async {
    return actionRepository.createUpdateActionInDB(action).then((value) {
      fetchMyActionsFromDB();
      fetchGroupActionsFromDB();
    });
  }

  fetchGroupActionsFromDB() async {
    final List<GroupUser_Role> groupUserRole = [
      GroupUser_Role.ADMIN,
      GroupUser_Role.TEACHER
    ];
    final Map<HiveGroup, List<HiveAction>> _groupActionListMap = Map();

    final CurrentUserRepository _currentUserRepository =
        CurrentUserRepository();
    HiveCurrentUser _currentUser = await _currentUserRepository.getUserFromDB();

    List<String> _groupIdsWithMatchingRole = [];
    /*_currentUser.groupsWithRole(groupUserRole).forEach((element) {
      print(
          "GROUP: ${element.group!.name} : ${element.user!.name} : ${GroupUser_Role.valueOf(element.role!)}");
      _groupIdsWithMatchingRole.add(element.groupId!);
    });*/

    GroupProvider()
        .userGroupsWithRole(_currentUser.id, groupUserRole)
        ?.forEach((element) {
      _groupIdsWithMatchingRole.add(element.id!);
    });

    actionRepository
        .fetchAllActionsForGroupFromDB(_groupIdsWithMatchingRole)
        .then((value) {
      //_allActions = value;

      value.forEach((element) {
        if (_filterAction(element) &&
            (element.name!.toLowerCase().contains(query.toLowerCase()) ||
                (element.group != null &&
                        (element.group!.name!
                            .toLowerCase()
                            .contains(query.toLowerCase())) ||
                    element.group!.containsUserName(query)))) {
          if (_groupActionListMap.containsKey(element.group)) {
            _groupActionListMap[element.group!]!.add(element);
          } else {
            _groupActionListMap[element.group!] = [element];
          }
        }
      });
    }).whenComplete(
      () => {_actionsForGroup.sink.add(_groupActionListMap)},
    );
  }

  fetchMyActionsFromDB() async {
    final List<GroupUser_Role> groupUserRole = [
      GroupUser_Role.LEARNER,
    ];
    final Map<HiveGroup, List<HiveAction>> _groupActionListMap = Map();

    final CurrentUserRepository _currentUserRepository =
        CurrentUserRepository();
    HiveCurrentUser _currentUser = await _currentUserRepository.getUserFromDB();

    List<String> _groupIdsWithMatchingRole = [];
    /*_currentUser.groupsWithRole(groupUserRole).forEach((element) {
      _groupIdsWithMatchingRole.add(element.groupId!);
    });*/
    GroupProvider()
        .userGroupsWithRole(_currentUser.id, groupUserRole)
        ?.forEach((element) {
      _groupIdsWithMatchingRole.add(element.id!);
    });

    HiveGroup _dummyGroupSelf = HiveGroup(
        id: null,
        name:
            AppLocalizations.of(NavigationService.navigatorKey.currentContext!)!
                .selfAssigned);

    // Add dummy group to put always in the first place
    _groupActionListMap[_dummyGroupSelf] = [];

    actionRepository
        .fetchAllActionsForMeFromDB(_groupIdsWithMatchingRole)
        .then((value) {
      //_allActions = value;

      value.forEach((element) {
        if (_filterAction(element) &&
            (element.name!.toLowerCase().contains(query.toLowerCase()) ||
                (element.group != null &&
                    (element.group!.name!
                            .toLowerCase()
                            .contains(query.toLowerCase()) ||
                        element.group!.containsUserName(query))))) {
          if (element.isIndividualAction) {
            if (_groupActionListMap.containsKey(_dummyGroupSelf)) {
              _groupActionListMap[_dummyGroupSelf]!.add(element);
            } else {
              _groupActionListMap[_dummyGroupSelf] = [element];
            }
          } else {
            if (_groupActionListMap.containsKey(element.group)) {
              _groupActionListMap[element.group!]!.add(element);
            } else {
              _groupActionListMap[element.group!] = [element];
            }
          }
        }
      });
    }).onError((error, stackTrace) {
      debugPrint("ERROR filtering action");
    }).whenComplete(
      () {
        if (_groupActionListMap[_dummyGroupSelf]!.isEmpty) {
          _groupActionListMap.remove(_dummyGroupSelf);
        }
        _actionsForMe.sink.add(_groupActionListMap);
      },
    );
  }

  fetchActions() async {
    _actionsToReuse.sink.add(actionRepository.dbProvider
        .getAllActiveActions()
        .where((material) => !material.isDirty)
        .where((element) => reuseActionQuery.isEmpty
            ? true
            : element.name!
                .toLowerCase()
                .contains(reuseActionQuery.toLowerCase()))
        .toList());
  }

  fetchMaterials() async {
    _materials.sink.add(MaterialProvider()
        .getMateialsSync()
        .where((materail) => !materail.isDirty)
        .where((element) => materialQuery.isEmpty
            ? true
            : element.title!
                .toLowerCase()
                .contains(materialQuery.toLowerCase()))
        .toList());
  }

  /*fetchMyActionsFromDB() async {
    return _fetchActionsFromDB([GroupUser_Role.LEARNER]);
  }

  fetchGroupActionsFromDB() async {
    return _fetchActionsFromDB([GroupUser_Role.ADMIN, GroupUser_Role.TEACHER]);
  }*/

  bool _filterAction(HiveAction hiveAction) {
    Jiffy currentDate = Jiffy();
    Jiffy actionDueDate = Jiffy({
      "year": hiveAction.dateDue!.year,
      "month": hiveAction.dateDue!.month,
      "day": currentDate.date
    });

    switch (actionFilter) {
      case ActionFilter.THIS_MONTH:
        //return currentDate.diff(actionDueDate, Units.MONTH) == 0;
        return currentDate.isSame(actionDueDate, Units.YEAR) &&
            currentDate.month == actionDueDate.month;
      case ActionFilter.NEXT_MONTH:
        //return currentDate.diff(actionDueDate, Units.MONTH) == -1;
        currentDate.add(months: 1);
        currentDate.endOf(Units.MONTH);

        return (currentDate.isSame(actionDueDate, Units.YEAR) &&
                currentDate.month == actionDueDate.month) ||
            (currentDate.isAfter(actionDueDate, Units.YEAR));
      case ActionFilter.LAST_MONTH:
        //return currentDate.diff(actionDueDate, Units.MONTH) == 1;
        currentDate.subtract(months: 1);
        currentDate.startOf(Units.MONTH);

        return (currentDate.isSame(actionDueDate, Units.YEAR) &&
                currentDate.month == actionDueDate.month) ||
            (currentDate.isBefore(actionDueDate, Units.YEAR));
      case ActionFilter.LAST_THREE_MONTH:
        //return currentDate.diff(actionDueDate, Units.MONTH) <= 2;
        Jiffy startDate = Jiffy();
        startDate.subtract(months: 2);
        startDate.startOf(Units.MONTH);

        return actionDueDate.isBetween(startDate, currentDate);
      case ActionFilter.ALL_TIME:
      default:
        return true;
    }
  }

  Future<void> createUpdateActionUser(HiveActionUser hiveActionUser) async {
    return actionRepository.createUpdateActionUserInDB(hiveActionUser);
  }
}
