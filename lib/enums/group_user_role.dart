import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:starfish/navigation_service.dart';
import 'package:starfish/src/generated/starfish.pb.dart';

extension GroupUserRoleEx on GroupUser_Role {
  Map<GroupUser_Role, String> get groupUserRoleFilter => {
        GroupUser_Role.UNSPECIFIED_ROLE:
            AppLocalizations.of(NavigationService.navigatorKey.currentContext!)!
                .unspecifiedRole,
        GroupUser_Role.ADMIN:
            AppLocalizations.of(NavigationService.navigatorKey.currentContext!)!
                .adminRole,
        GroupUser_Role.LEARNER:
            AppLocalizations.of(NavigationService.navigatorKey.currentContext!)!
                .learnerRole,
        GroupUser_Role.TEACHER:
            AppLocalizations.of(NavigationService.navigatorKey.currentContext!)!
                .teacherRole,
      };

  //about property returns the custom message
  String get about => groupUserRoleFilter[this]!;
}
