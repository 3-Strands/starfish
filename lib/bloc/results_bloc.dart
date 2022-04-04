import 'package:starfish/db/hive_current_user.dart';
import 'package:starfish/db/hive_group.dart';
import 'package:starfish/db/providers/current_user_provider.dart';
import 'package:starfish/db/providers/group_provider.dart';
import 'package:starfish/src/generated/starfish.pb.dart';

class ResultsBloc extends Object {
  List<HiveGroup>? fetchGroupsWtihLeaderRole() {
    final HiveCurrentUser _currentUser = CurrentUserProvider().getUserSync();
    final List<GroupUser_Role> groupUserRole = [
      GroupUser_Role.ADMIN,
      GroupUser_Role.TEACHER
    ];

    return GroupProvider().userGroupsWithRole(_currentUser.id, groupUserRole);
  }

  void dispose() {}
}
