import 'package:rxdart/rxdart.dart';
import 'package:starfish/db/hive_current_user.dart';
import 'package:starfish/db/hive_date.dart';
import 'package:starfish/db/hive_group.dart';
import 'package:starfish/db/hive_learner_evaluation.dart';
import 'package:starfish/db/providers/current_user_provider.dart';
import 'package:starfish/db/providers/group_provider.dart';
import 'package:starfish/src/generated/starfish.pb.dart';

class ResultsBloc extends Object {
  HiveGroup? hiveGroup;
  HiveDate? hiveDate; //

  ResultsBloc() {
    hiveGroup = fetchGroupsWtihLeaderRole()?.first;
    hiveDate = HiveDate.create(2022, 3,
        0); // TODO: this will be set by view, default fo current month/year
  }

  List<HiveGroup>? fetchGroupsWtihLeaderRole() {
    final HiveCurrentUser _currentUser = CurrentUserProvider().getUserSync();
    final List<GroupUser_Role> groupUserRole = [
      GroupUser_Role.ADMIN,
      GroupUser_Role.TEACHER
    ];

    return GroupProvider().userGroupsWithRole(_currentUser.id, groupUserRole);
  }

  List<HiveLearnerEvaluation>? getGroupLearnerEvaluations() {
    return hiveGroup?.groupLearnerEvaluations
        .where((element) =>
            element.month!.month == hiveDate?.month &&
            element.month!.year == hiveDate?.year)
        .toList();
  }

  void dispose() {}
}
