import 'package:grpc/grpc_or_grpcweb.dart';
import 'package:starfish/db/hive_action.dart';
import 'package:starfish/db/providers/action_provider.dart';
import 'package:starfish/src/generated/starfish.pb.dart';
import 'package:starfish/utils/services/api_provider.dart';

class ActionRepository {
  final dbProvider = ActionProvider();
  final apiProvider = ApiProvider();

  Future<ResponseStream<Action>> getActions() => apiProvider.getActions();

  Future<List<HiveAction>> fetchAllActionsFromDB() =>
      dbProvider.getAllActions();

  Future<void> createUpdateActionInDB(HiveAction action) =>
      dbProvider.createUpdateAction(action);
}
