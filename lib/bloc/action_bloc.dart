import 'package:rxdart/rxdart.dart';
import 'package:starfish/db/hive_action.dart';
import 'package:starfish/db/hive_action_user.dart';
import 'package:starfish/db/hive_current_user.dart';
import 'package:starfish/db/hive_group.dart';
import 'package:starfish/db/hive_date.dart';
import 'package:starfish/enums/action_filter.dart';
import 'package:starfish/repository/action_repository.dart';
import 'package:starfish/repository/current_user_repository.dart';
import 'package:starfish/src/generated/google/type/date.pb.dart';
import 'package:starfish/src/generated/starfish.pb.dart';

class ActionBloc extends Object {
  final ActionRepository actionRepository = ActionRepository();
  late BehaviorSubject<Map<HiveGroup, List<HiveAction>>> _actions;

  ActionFilter actionFilter = ActionFilter.THIS_MONTH;

  String query = '';

  List<HiveAction> _allActions = [];
  List<HiveAction> _filteredActionList = [];

  ActionBloc() {
    //initializes the subject with element already
    _actions = new BehaviorSubject<Map<HiveGroup, List<HiveAction>>>();
  }

  Stream<Map<HiveGroup, List<HiveAction>>> get actions => _actions.stream;

  Future<void> createUpdateAction(HiveAction action) async {
    return actionRepository.createUpdateActionInDB(action);
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
    _currentUser.groupsWithRole(groupUserRole).forEach((element) {
      _groupIdsWithMatchingRole.add(element.groupId!);
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
      () => {_actions.sink.add(_groupActionListMap)},
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
    _currentUser.groupsWithRole(groupUserRole).forEach((element) {
      _groupIdsWithMatchingRole.add(element.groupId!);
    });

    HiveGroup _dummyGroupSelf = HiveGroup(id: null, name: "Self Assigned");

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
            print("action is Individual Action");
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
    }).whenComplete(
      () => {_actions.sink.add(_groupActionListMap)},
    );
  }

  /*fetchMyActionsFromDB() async {
    return _fetchActionsFromDB([GroupUser_Role.LEARNER]);
  }

  fetchGroupActionsFromDB() async {
    return _fetchActionsFromDB([GroupUser_Role.ADMIN, GroupUser_Role.TEACHER]);
  }*/

  bool _filterAction(HiveAction hiveAction) {
    switch (actionFilter) {
      case ActionFilter.THIS_MONTH:
        return hiveAction.dateDue != null &&
            hiveAction.dateDue!.toDateTime().month == DateTime.now().month;
      case ActionFilter.NEXT_MONTH:
        return hiveAction.dateDue != null &&
            hiveAction.dateDue!.toDateTime().month == DateTime.now().month + 1;
      case ActionFilter.LAST_MONTH:
        return hiveAction.dateDue != null &&
            hiveAction.dateDue!.toDateTime().month == DateTime.now().month - 1;
      case ActionFilter.LAST_THREE_MONTH:
        return hiveAction.dateDue != null &&
            hiveAction.dateDue!.toDateTime().month == DateTime.now().month - 3;
      case ActionFilter.ALL_TIME:
      default:
        return true;
    }
  }

  Future<void> createUpdateActionUser(HiveActionUser hiveActionUser) async {
    return actionRepository.createUpdateActionUserInDB(hiveActionUser);
  }
}
