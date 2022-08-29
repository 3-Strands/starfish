import 'package:starfish/enums/action_status.dart';
import 'package:starfish/repositories/model_wrappers/user_with_action_status.dart';
import 'package:starfish/src/grpc_extensions.dart';

class ActionGroupUserWithStatus {
  const ActionGroupUserWithStatus({
    required this.userWithActionStatus,
    required this.group,
  });

  final Group group;
  final List<UserWithActionStatus> userWithActionStatus;

  int get totalLearners => userWithActionStatus.length;

  int get actionsDone => userWithActionStatus
      .where((element) => element.actionStatus == ActionStatus.DONE)
      .length;

  int get actionsNotDone => userWithActionStatus
      .where((element) => element.actionStatus == ActionStatus.NOT_DONE)
      .length;

  int get actionsOverdue => userWithActionStatus
      .where((element) => element.actionStatus == ActionStatus.OVERDUE)
      .length;

  int get goodEvaluations => userWithActionStatus
      .where((element) => element.evaluation == ActionUser_Evaluation.GOOD)
      .length;

  int get badEvaluations => userWithActionStatus
      .where((element) => element.evaluation == ActionUser_Evaluation.BAD)
      .length;
}
