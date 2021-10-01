import 'package:starfish/src/generated/starfish.pbgrpc.dart';

enum UserGroupRoleFilter {
  FILTER_ADMIN_CO_LEAD,
  FILTER_LEARNER,
  FILTER_ALL,
}

extension UserGroupRoleFilterExt on UserGroupRoleFilter {
  static const groupRoleFilter = {
    UserGroupRoleFilter.FILTER_ADMIN_CO_LEAD:
        'Groups: Groups I teach or co-lead',
    UserGroupRoleFilter.FILTER_LEARNER: 'Groups: I\'am a learner in',
    UserGroupRoleFilter.FILTER_ALL: 'Groups: All of my groups',
  };

  //about property returns the custom message
  String get about => groupRoleFilter[this]!;
}
