import 'package:starfish/repositories/model_wrappers/action_with_assigned_status.dart';
import 'package:starfish/src/grpc_extensions.dart';

class ActionWithAssignedStatusByGroup {
  const ActionWithAssignedStatusByGroup({
    required this.actionsWithStatus,
    required this.group,
  });

  final List<ActionWithAssignedStatus> actionsWithStatus;
  final Group group;
}
