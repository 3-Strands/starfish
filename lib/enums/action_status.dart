import 'package:starfish/src/generated/starfish.pb.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:starfish/navigation_service.dart';

enum ActionStatus {
  UNSPECIFIED_STATUS,
  DONE,
  NOT_DONE,
  OVERDUE,
}

extension ActionStatusExt on ActionStatus {
  Map<ActionStatus, String> get selfValues => {
        ActionStatus.UNSPECIFIED_STATUS:
            AppLocalizations.of(NavigationService.navigatorKey.currentContext!)!
                .na,
        ActionStatus.DONE:
            AppLocalizations.of(NavigationService.navigatorKey.currentContext!)!
                .actionStatusDone,
        ActionStatus.NOT_DONE:
            AppLocalizations.of(NavigationService.navigatorKey.currentContext!)!
                .actionStatusNotDone,
        ActionStatus.OVERDUE:
            AppLocalizations.of(NavigationService.navigatorKey.currentContext!)!
                .actionStatusOverdue,
      };

  // static const selfValues = {
  //   ActionStatus.UNSPECIFIED_STATUS: "NA",
  //   ActionStatus.DONE: Strings.actionStatusDone,
  //   ActionStatus.NOT_DONE: Strings.actionStatusNotDone,
  //   ActionStatus.OVERDUE: Strings.actionStatusOverdue,
  // };

  Map<ActionStatus, String> get groupValues => {
        ActionStatus.UNSPECIFIED_STATUS:
            AppLocalizations.of(NavigationService.navigatorKey.currentContext!)!
                .na,
        ActionStatus.DONE:
            AppLocalizations.of(NavigationService.navigatorKey.currentContext!)!
                .groupActionStatusDone,
        ActionStatus.NOT_DONE:
            AppLocalizations.of(NavigationService.navigatorKey.currentContext!)!
                .groupActionStatusNotDone,
        ActionStatus.OVERDUE:
            AppLocalizations.of(NavigationService.navigatorKey.currentContext!)!
                .actionStatusOverdue,
      };

  // static const groupValues = {
  //   ActionStatus.UNSPECIFIED_STATUS: "NA",
  //   ActionStatus.DONE: Strings.groupActionStatusDone,
  //   ActionStatus.NOT_DONE: Strings.groupActionStatusNotDone,
  //   ActionStatus.OVERDUE: Strings.actionStatusOverdue,
  // };

  //about property returns the custom message
  String get about => selfValues[this]!;

  String get aboutGroup => groupValues[this]!;

  ActionUser_Status toActionUserStatus() {
    switch (this) {
      case ActionStatus.DONE:
        return ActionUser_Status.COMPLETE;
      case ActionStatus.NOT_DONE:
      case ActionStatus.OVERDUE:
        return ActionUser_Status.INCOMPLETE;
      case ActionStatus.UNSPECIFIED_STATUS:
      default:
        return ActionUser_Status.UNSPECIFIED_STATUS;
    }
  }
}
