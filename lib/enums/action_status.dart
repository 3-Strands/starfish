import 'package:starfish/constants/strings.dart';

enum ActionStatus {
  DONE,
  NOT_DONE,
  OVERDUE,
}

extension ActionStatusExt on ActionStatus {
  static const values = {
    ActionStatus.DONE: Strings.actionStatusDone,
    ActionStatus.NOT_DONE: Strings.actionStatusNotDone,
    ActionStatus.OVERDUE: Strings.actionStatusOverdue,
  };

  //about property returns the custom message
  String get about => values[this]!;
}
