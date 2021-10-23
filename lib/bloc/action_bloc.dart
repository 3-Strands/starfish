import 'package:rxdart/rxdart.dart';
import 'package:starfish/db/hive_action.dart';
import 'package:starfish/db/hive_current_user.dart';
import 'package:starfish/repository/action_repository.dart';
import 'package:starfish/repository/current_user_repository.dart';
import 'package:starfish/src/generated/starfish.pb.dart';

class ActionBloc extends Object {
  final ActionRepository actionRepository = ActionRepository();
  late BehaviorSubject<List<HiveAction>> _actions;

  String query = '';

  List<HiveAction> _allActions = [];
  List<HiveAction> _filteredActionList = [];

  ActionBloc() {
    //initializes the subject with element already
    _actions = new BehaviorSubject<List<HiveAction>>();
  }

  Stream<List<HiveAction>> get actions => _actions.stream;

  Future<void> createUpdateAction(HiveAction action) async {
    return actionRepository.createUpdateActionInDB(action);
  }

  _fetchActionsFromDB(List<GroupUser_Role> groupUserRole) async {
    final CurrentUserRepository _currentUserRepository =
        CurrentUserRepository();
    HiveCurrentUser _currentUser = await _currentUserRepository.getUserFromDB();

    List<String> _groupIdsWithMatchingRole = [];
    _currentUser.groupsWithRole(groupUserRole).forEach((element) {
      _groupIdsWithMatchingRole.add(element.groupId!);
    });

    actionRepository
        .fetchAllActionsFromDB(_groupIdsWithMatchingRole)
        .then((value) {
      _allActions = value;
    }).whenComplete(
      () => {_actions.sink.add(_allActions)},
    );
  }

  fetchMyActionsFromDB() async {
    return _fetchActionsFromDB([GroupUser_Role.LEARNER]);
  }

  fetchGroupActionsFromDB() async {
    return _fetchActionsFromDB([GroupUser_Role.ADMIN, GroupUser_Role.TEACHER]);
  }
}
