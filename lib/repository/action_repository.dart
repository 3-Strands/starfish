import 'package:grpc/grpc_or_grpcweb.dart';
import 'package:starfish/db/hive_action.dart';
import 'package:starfish/db/hive_action_user.dart';
import 'package:starfish/db/providers/action_provider.dart';
import 'package:starfish/src/generated/starfish.pb.dart';
import 'package:starfish/utils/services/api_provider.dart';

class ActionRepository {
  final dbProvider = ActionProvider();
  final apiProvider = ApiProvider();

  Future<ResponseStream<Action>> getActions() => apiProvider.getActions();

  Future<ResponseStream<CreateUpdateActionsResponse>> createUpdateAction({
    required Action action,
    required List<String> fieldMaskPaths,
  }) =>
      apiProvider.createUpdateAction(
        action,
        fieldMaskPaths,
      );

  Future<ResponseStream<DeleteActionResponse>> deleteAction(Action action) =>
      apiProvider.deleteAction(action);

  Future<List<HiveAction>> fetchAllActionsForGroupFromDB(
          List<String> groupIds) =>
      dbProvider.getAllActionsForGroup(groupIds);

  @Deprecated("Used for Debug")
  List<HiveAction> fetchAllActions() => dbProvider.getAllActiveActions();

  List<HiveActionUser> getAllActionsUser() => dbProvider.getAllActionsUser();

  Future<List<HiveAction>> fetchAllActionsForMeFromDB(List<String> groupIds) =>
      dbProvider.getAllActionsForMe(groupIds);

  Future<void> createUpdateActionInDB(HiveAction action) =>
      dbProvider.createUpdateAction(action);

  Future<void> createUpdateActionUserInDB(HiveActionUser actionUser) =>
      dbProvider.createUpdateActionUser(actionUser);

  Future<ResponseStream<CreateUpdateActionUserResponse>>
      createUpdateActionUsers({
    required ActionUser actionUser,
    required List<String> fieldMaskPaths,
  }) =>
          apiProvider.createUpdateActionUsers(
            actionUser,
            fieldMaskPaths,
          );
}
