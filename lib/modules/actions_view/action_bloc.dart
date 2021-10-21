import 'package:rxdart/rxdart.dart';
import 'package:starfish/db/hive_action.dart';
import 'package:starfish/repository/action_repository.dart';

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

  fetchActionsFromDB() async {
    actionRepository
        .fetchAllActionsFromDB()
        .then(
          (value) => {_allActions = value},
        )
        .whenComplete(
          () => {
            // print('  $_allActions'),
            _actions.sink.add(_allActions)
          },
        );
  }
}
