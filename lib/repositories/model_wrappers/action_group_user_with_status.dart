import 'package:starfish/repositories/model_wrappers/user_with_action-status.dart';
import 'package:starfish/src/grpc_extensions.dart';

class ActionGroupUserWithStatus {
  const ActionGroupUserWithStatus({
    required this.userWithActionStatus,
    required this.group,
  });

  final Group group;
  final List<UserWithActionStatus> userWithActionStatus;
}
