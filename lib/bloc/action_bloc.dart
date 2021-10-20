import 'package:rxdart/rxdart.dart';
import 'package:starfish/db/hive_action.dart';
import 'package:starfish/repository/action_repository.dart';

class ActionBloc extends Object {
  final ActionRepository repository = ActionRepository();
  late BehaviorSubject<List<HiveAction>> _actions;

  ActionBloc() {
    //initializes the subject with element already
    _actions = new BehaviorSubject<List<HiveAction>>();
  }

  Future<void> createUpdateAction(HiveAction action) async {
    return repository.createUpdateActionInDB(action);
  }
}
