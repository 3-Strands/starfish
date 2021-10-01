import 'package:starfish/constants/strings.dart';
import 'package:starfish/src/generated/starfish.pbgrpc.dart';

enum UserGroupRoleFilter {
  FILTER_ADMIN_CO_LEAD,
  FILTER_LEARNER,
  FILTER_ALL,
}

extension UserGroupRoleFilterExt on UserGroupRoleFilter {
  static const groupRoleFilter = {
    UserGroupRoleFilter.FILTER_ADMIN_CO_LEAD:
        '${Strings.groupFilterAdminCoLead}',
    UserGroupRoleFilter.FILTER_LEARNER: Strings.groupFilterLearner,
    UserGroupRoleFilter.FILTER_ALL: Strings.groupFilterAll,
  };

  //about property returns the custom message
  String get about => groupRoleFilter[this]!;

  String get filterLabel =>
      '${Strings.groupFilterPrefix}: ${groupRoleFilter[this]!}';
}
