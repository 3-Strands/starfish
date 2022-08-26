import 'package:starfish/enums/action_status.dart';
import 'package:starfish/src/grpc_extensions.dart';

class UserWithActionStatus {
  const UserWithActionStatus({
    required this.user,
    required this.action,
    this.actionUser,
  });

  final User user;
  final Action action;
  final ActionUser?
      actionUser; // List of all the 'ActionUser' taken by 'User' for the actions

  ActionStatus get actionStatus => actionUser == null
      ? action.isPastDueDate
          ? ActionStatus.OVERDUE
          : ActionStatus.NOT_DONE
      : actionUser?.status == ActionUser_Status.COMPLETE
          ? ActionStatus.DONE
          : action.isPastDueDate
              ? ActionStatus.OVERDUE
              : ActionStatus.NOT_DONE;

  ActionUser_Evaluation get evaluation =>
      actionUser?.evaluation ?? ActionUser_Evaluation.UNSPECIFIED_EVALUATION;
}
