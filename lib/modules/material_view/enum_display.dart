import 'package:flutter/widgets.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:starfish/enums/action_status.dart';
import 'package:starfish/src/generated/starfish.pb.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension VisibilityDisplay on Material_Visibility {
  String toLocaleString(BuildContext context) {
    switch (this) {
      case Material_Visibility.GROUP_VIEW:
        return AppLocalizations.of(context)!.visibilityGroupView;
      case Material_Visibility.ALL_VIEW:
        return AppLocalizations.of(context)!.visibilityAllView;
      case Material_Visibility.CREATOR_VIEW:
        return AppLocalizations.of(context)!.creatorView;
      default:
        assert(false, 'Unexpected locale string requested from $this');
        return '';
    }
  }

  static List<Material_Visibility> get displayList =>
      Material_Visibility.values.skip(2).toList();
}

extension EditabilityDisplay on Material_Editability {
  String toLocaleString(BuildContext context) {
    switch (this) {
      case Material_Editability.CREATOR_EDIT:
        return AppLocalizations.of(context)!.editabilityCreatorEdit;
      case Material_Editability.GROUP_EDIT:
        return AppLocalizations.of(context)!.editabilityGroupEdit;
      default:
        assert(false, 'Unexpected locale string requested from $this');
        return '';
    }
  }

  static List<Material_Editability> get displayList =>
      Material_Editability.values.skip(1).toList();
}

extension ActionDisplay on ActionStatus {
  Color get color {
    switch (this) {
      case ActionStatus.DONE:
        return AppColors.completeTaskBGColor;
      case ActionStatus.NOT_DONE:
        return AppColors.notCompletedTaskBGColor;
      case ActionStatus.OVERDUE:
        return AppColors.overdueTaskBGColor;
    }
  }

  String toLocaleString(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    switch (this) {
      case ActionStatus.DONE:
        return appLocalizations.assignedToMeDone;
      case ActionStatus.NOT_DONE:
        return appLocalizations.assignedToMeNotDone;
      case ActionStatus.OVERDUE:
        return appLocalizations.assignedToMeOverdue;
    }
  }
}
