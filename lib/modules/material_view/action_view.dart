import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:starfish/enums/action_status.dart';

extension ActionView on ActionStatus {
  Color get color {
    switch (this) {
      case ActionStatus.DONE: return AppColors.completeTaskBGColor;
      case ActionStatus.NOT_DONE: return AppColors.notCompletedTaskBGColor;
      case ActionStatus.OVERDUE: return AppColors.overdueTaskBGColor;
    }
  }

  String localeLabel(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    switch (this) {
      case ActionStatus.DONE: return appLocalizations.assignedToMeDone;
      case ActionStatus.NOT_DONE: return appLocalizations.assignedToMeNotDone;
      case ActionStatus.OVERDUE: return appLocalizations.assignedToMeOverdue;
    }
  }
}