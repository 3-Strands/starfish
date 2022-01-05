import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:starfish/navigation_service.dart';

enum UserGroupRoleFilter {
  FILTER_ADMIN_CO_LEAD,
  FILTER_LEARNER,
  FILTER_ALL,
}

extension UserGroupRoleFilterExt on UserGroupRoleFilter {
  Map<UserGroupRoleFilter, String> get groupRoleFilter => {
        UserGroupRoleFilter.FILTER_ADMIN_CO_LEAD:
            AppLocalizations.of(NavigationService.navigatorKey.currentContext!)!
                .groupFilterAdminCoLead,
        UserGroupRoleFilter.FILTER_LEARNER:
            AppLocalizations.of(NavigationService.navigatorKey.currentContext!)!
                .groupFilterLearner,
        UserGroupRoleFilter.FILTER_ALL:
            AppLocalizations.of(NavigationService.navigatorKey.currentContext!)!
                .groupFilterAll,
      };

  //about property returns the custom message
  String get about => groupRoleFilter[this]!;

  String get filterLabel =>
      '${AppLocalizations.of(NavigationService.navigatorKey.currentContext!)!.groupFilterPrefix}: ${groupRoleFilter[this]!}';
}
