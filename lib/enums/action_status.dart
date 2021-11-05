import 'package:starfish/constants/strings.dart';
import 'package:starfish/src/generated/starfish.pb.dart';

enum ActionStatus {
  UNSPECIFIED_STATUS,
  DONE,
  NOT_DONE,
  OVERDUE,
}

extension ActionStatusExt on ActionStatus {
  static const selfValues = {
    ActionStatus.UNSPECIFIED_STATUS: "NA",
    ActionStatus.DONE: Strings.actionStatusDone,
    ActionStatus.NOT_DONE: Strings.actionStatusNotDone,
    ActionStatus.OVERDUE: Strings.actionStatusOverdue,
  };

  static const groupValues = {
    ActionStatus.UNSPECIFIED_STATUS: "NA",
    ActionStatus.DONE: Strings.groupActionStatusDone,
    ActionStatus.NOT_DONE: Strings.groupActionStatusNotDone,
    ActionStatus.OVERDUE: Strings.actionStatusOverdue,
  };

  //about property returns the custom message
  String get about => selfValues[this]!;

  String get aboutGroup => groupValues[this]!;
}
