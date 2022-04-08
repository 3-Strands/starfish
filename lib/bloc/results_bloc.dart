import 'package:starfish/db/hive_current_user.dart';
import 'package:starfish/db/hive_date.dart';
import 'package:starfish/db/hive_evaluation_category.dart';
import 'package:starfish/db/hive_group.dart';
import 'package:starfish/db/hive_learner_evaluation.dart';
import 'package:starfish/db/providers/current_user_provider.dart';
import 'package:starfish/db/providers/evaluation_category_provider.dart';
import 'package:starfish/db/providers/group_provider.dart';
import 'package:starfish/src/generated/starfish.pb.dart';

class ResultsBloc extends Object {
  HiveGroup? hiveGroup;
  HiveDate? hiveDate;
  HiveDate? hivePreviousDate;

  ResultsBloc() {
    hiveGroup = fetchGroupsWtihLeaderRole()?.first;
    hiveDate = HiveDate.create(2022, 3,
        0); // TODO: this will be set by view, default fo current month/year

    hivePreviousDate = _calculatePreviousDate();
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

  HiveDate? _calculatePreviousDate() {
    if (hiveDate == null) {
      return null;
    }
    int currentMonth = hiveDate!.month;
    int currentYear = hiveDate!.year;

    if (currentMonth > 1) {
      return HiveDate.create(currentYear, currentMonth, 0);
    } else {
      return HiveDate.create(currentYear - 1, 12, 0);
    }
  }

  void dispose() {}
}
