import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:starfish/navigation_service.dart';

enum MaterialFilter {
  ASSIGNED_AND_COMPLETED,
  ASSIGNED_AND_INCOMPLETED,
  ASSIGNED_TO_GROUP_I_LEAD,
  NO_FILTER_APPLIED
}

extension MaterialFilterExt on MaterialFilter {
  Map<MaterialFilter, String> get values => {
        MaterialFilter.ASSIGNED_AND_COMPLETED:
            AppLocalizations.of(NavigationService.navigatorKey.currentContext!)!
                .assignedToMeDone,
        MaterialFilter.ASSIGNED_AND_INCOMPLETED:
            AppLocalizations.of(NavigationService.navigatorKey.currentContext!)!
                .assignedToMeInComplete,
        MaterialFilter.ASSIGNED_TO_GROUP_I_LEAD:
            AppLocalizations.of(NavigationService.navigatorKey.currentContext!)!
                .assignedToGroupIamLead,
        MaterialFilter.NO_FILTER_APPLIED:
            AppLocalizations.of(NavigationService.navigatorKey.currentContext!)!
                .noFilterApplied,
      };

  //about property returns the custom message
  String get about => values[this]!;
}
