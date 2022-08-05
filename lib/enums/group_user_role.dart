import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:starfish/navigation_service.dart';
import 'package:starfish/src/generated/starfish.pb.dart';

extension GroupUserRoleEx on GroupUser_Role {
  String get about {
    switch (this) {
      case GroupUser_Role.UNSPECIFIED_ROLE:
        return AppLocalizations.of(
                NavigationService.navigatorKey.currentContext!)!
            .unspecifiedRole;
      case GroupUser_Role.ADMIN:
        return AppLocalizations.of(
                NavigationService.navigatorKey.currentContext!)!
            .adminRole;
      case GroupUser_Role.LEARNER:
        return AppLocalizations.of(
                NavigationService.navigatorKey.currentContext!)!
            .learnerRole;
      case GroupUser_Role.TEACHER:
        return AppLocalizations.of(
                NavigationService.navigatorKey.currentContext!)!
            .teacherRole;
      default:
        throw Error();
    }
  }
}
