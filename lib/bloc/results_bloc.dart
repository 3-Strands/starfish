import 'package:starfish/db/hive_current_user.dart';
import 'package:starfish/db/hive_date.dart';
import 'package:starfish/db/hive_evaluation_category.dart';
import 'package:starfish/db/hive_group.dart';
import 'package:starfish/db/hive_group_user.dart';
import 'package:starfish/db/hive_learner_evaluation.dart';
import 'package:starfish/db/providers/current_user_provider.dart';
import 'package:starfish/db/providers/evaluation_category_provider.dart';
import 'package:starfish/db/providers/group_provider.dart';
import 'package:starfish/src/generated/starfish.pb.dart';
import 'package:starfish/utils/date_time_utils.dart';

class ResultsBloc extends Object {
  HiveGroup? hiveGroup;
  HiveDate? hiveDate;
  HiveDate? hivePreviousDate;

  HiveGroupUser? hiveGroupUser;

  ResultsBloc() {
    hiveDate = DateTimeUtils.toHiveDate(DateTime.now());
    hivePreviousDate = hiveDate?.previousMonth;
  }

  init() {
    hiveGroup = fetchGroupsWtihLeaderRole()?.first;
    hiveGroupUser = hiveGroup?.learners?.first;
  }

  List<HiveGroup>? fetchGroupsWtihLeaderRole() {
    final HiveCurrentUser _currentUser = CurrentUserProvider().getUserSync();
    final List<GroupUser_Role> groupUserRole = [
      GroupUser_Role.ADMIN,
      GroupUser_Role.TEACHER
    ];

    return GroupProvider().userGroupsWithRole(_currentUser.id, groupUserRole);
  }

  List<HiveLearnerEvaluation>? getGroupLearnerEvaluationsForMonth(
      HiveDate _hiveDate) {
    return hiveGroup?.groupLearnerEvaluations
        .where((element) =>
            element.month!.month == _hiveDate.month &&
            element.month!.year == _hiveDate.year)
        .toList();
  }

  Map<HiveEvaluationCategory, Map<String, int>>
      getGroupLearnerEvaluationsByCategory() {
    Map<HiveEvaluationCategory, Map<String, int>> _map = Map();
    hiveGroup?.evaluationCategoryIds?.forEach((categoryId) {
      HiveEvaluationCategory? _evaluationCategory =
          EvaluationCategoryProvider().getCategoryById(categoryId);
      if (_evaluationCategory != null) {
        Map<String, int> _countByMonth = Map();
        _countByMonth["this-month"] =
            _countCategoryGroupLearnerEvaluationsForMonth(
                categoryId, hiveDate!);
        _countByMonth["last-month"] =
            _countCategoryGroupLearnerEvaluationsForMonth(
                categoryId, hivePreviousDate!);

        _map[_evaluationCategory] = _countByMonth;
      }
    });

    return _map;
  }

  int _countCategoryGroupLearnerEvaluationsForMonth(
      String categoryId, HiveDate _hiveDate) {
    int count = 0;
    getGroupLearnerEvaluationsForMonth(_hiveDate)
        ?.where((element) => element.categoryId == categoryId)
        .forEach((element) {
      count += element.evaluation!;
    });

    return count;
  }

  void dispose() {}
}
