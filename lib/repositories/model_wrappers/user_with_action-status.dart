import 'package:starfish/enums/action_status.dart';
import 'package:starfish/src/grpc_extensions.dart';

class UserWithActionStatus {
  const UserWithActionStatus({
    required this.user,
    required this.actionStatus,
    this.actionUser,
  });

  final User user;
  final ActionUser? actionUser;
  final ActionStatus actionStatus;
}
