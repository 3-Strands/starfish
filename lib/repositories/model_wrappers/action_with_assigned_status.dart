import 'package:starfish/enums/action_status.dart';
import 'package:starfish/src/grpc_extensions.dart';

class ActionWithAssignedStatus {
  const ActionWithAssignedStatus({
    required this.action,
    this.status,
    this.isAssignedToGroupWithLeaderRole = false,
  });

  final Action action;
  final ActionStatus? status;
  final bool isAssignedToGroupWithLeaderRole;
}
