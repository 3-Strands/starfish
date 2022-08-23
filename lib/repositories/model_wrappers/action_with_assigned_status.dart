import 'package:starfish/enums/action_status.dart';
import 'package:starfish/repositories/model_wrappers/action_group_user_with_status.dart';
import 'package:starfish/src/grpc_extensions.dart';

class ActionWithAssignedStatus {
  const ActionWithAssignedStatus(
      {required this.action,
      this.status,
      this.actionUser,
      this.isAssignedToGroupWithLeaderRole = false,
      this.groupUserWithStatus});

  final Action action;
  final ActionStatus? status;
  final ActionUser? actionUser;
  final bool isAssignedToGroupWithLeaderRole;
  final ActionGroupUserWithStatus? groupUserWithStatus;
}
