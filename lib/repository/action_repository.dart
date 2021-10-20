import 'package:starfish/db/hive_action.dart';
import 'package:starfish/db/providers/action_provider.dart';

class ActionRepository {
  final dbProvider = ActionProvider();

  Future<List<HiveAction>> fetchAllActionsFromDB() =>
      dbProvider.getAllActions();

  Future<void> createUpdateActionInDB(HiveAction action) =>
      dbProvider.createUpdateAction(action);
}
