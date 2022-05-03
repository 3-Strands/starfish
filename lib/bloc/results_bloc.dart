import 'package:starfish/db/hive_action.dart';
import 'package:starfish/db/hive_action_user.dart';
import 'package:starfish/db/hive_current_user.dart';
import 'package:starfish/db/hive_date.dart';
import 'package:starfish/db/hive_evaluation_category.dart';
import 'package:starfish/db/hive_group.dart';
import 'package:starfish/db/hive_group_evaluation.dart';
import 'package:starfish/db/hive_group_user.dart';
import 'package:starfish/db/hive_learner_evaluation.dart';
import 'package:starfish/db/hive_output.dart';
import 'package:starfish/db/hive_output_marker.dart';
import 'package:starfish/db/providers/action_provider.dart';
import 'package:starfish/db/providers/current_user_provider.dart';
import 'package:starfish/db/providers/evaluation_category_provider.dart';
import 'package:starfish/db/providers/group_evaluation_provider.dart';
import 'package:starfish/db/providers/group_provider.dart';
import 'package:starfish/db/providers/learner_evaluation_provider.dart';
import 'package:starfish/db/providers/output_provider.dart';
import 'package:starfish/enums/action_status.dart';
import 'package:starfish/enums/action_user_status.dart';
import 'package:starfish/src/generated/starfish.pb.dart';
import 'package:starfish/utils/date_time_utils.dart';

class ResultsBloc extends Object {
  HiveGroup? hiveGroup;
  HiveDate? hiveDate;
  HiveDate? hivePreviousDate;

  HiveGroupUser? hiveGroupUser;

  ResultsBloc() {
    hiveDate = DateTimeUtils.toHiveDate(DateTime.now()).toMonth;
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

  /*Map<HiveOutputMarker, int> fetchGroupOutputsForMonth() {
    Map<HiveOutputMarker, int> _map = Map();
    hiveGroup?.outputMarkers?.forEach((HiveOutputMarker element) {
      HiveOutput? _output = OutputProvider()
          .getGroupOutputForMonth(hiveGroup!.id!, element, hiveDate!);
      int _markerValue = _output != null ? _output.value!.toInt() : 0;
      _map[element] = _markerValue;
    });

    return _map;
  }*/

  bool shouldDisplayProjectReport() {
    return CurrentUserProvider().getUserSync().linkGroups &&
        (hiveGroup?.outputMarkers != null &&
            hiveGroup!.outputMarkers!.length > 0);
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

  // TODO: may be we nned to change this and user value notifier/Stream to notify the UI for changes
  GroupEvaluation_Evaluation getGroupEvaluation() {
    HiveGroupEvaluation? _hiveGroupEvaluation =
        hiveGroupUser!.getGroupEvaluationForMonth(hiveDate!);

    if (_hiveGroupEvaluation == null) {
      return GroupEvaluation_Evaluation.EVAL_UNSPECIFIED;
    }

    return GroupEvaluation_Evaluation.valueOf(
        _hiveGroupEvaluation.evaluation!)!;
  }

  int getLearnersEvaluationCountByType(GroupEvaluation_Evaluation evaluation) {
    if (hiveGroup == null || hiveDate == null) {
      return 0;
    }
    return GroupEvaluationProvider()
        .getGroupEvaluations(hiveGroup!.id!)
        .where((element) =>
            element.month == hiveDate &&
            GroupEvaluation_Evaluation.valueOf(element.evaluation!) ==
                evaluation)
        .length;
  }

  List<HiveDate> getListOfAvailableHistoryMonths() {
    if (hiveGroup == null) {
      return [];
    }
    List<HiveDate> _listMonth = [];
    LearnerEvaluationProvider()
        .getGroupLearnerEvaluations(hiveGroup!.id!)
        .forEach((element) {
      if (!_listMonth.contains(element.month!.toMonth)) {
        _listMonth.add(element.month!.toMonth);
      }
    });
    return _listMonth.toSet().toList();
  }

  Map<String, int> actionUserStatusForSelectedMonth(HiveDate _hiveDate) {
    Map<String, int> _map = Map();
    _map['done'] = 0;
    _map['not_done'] = 0;
    _map['overdue'] = 0;

    if (this.hiveGroupUser == null) {
      return _map;
    }
    List<HiveAction>? _actions =
        ActionProvider().getGroupActions(this.hiveGroupUser!.groupId!);
    if (_actions == null) {
      return _map;
    }
    int _countDone = 0;
    int _countNotDone = 0;
    int _countOverdue = 0;
    _actions
        .where((element) => element.isDueInMonth(_hiveDate))
        .forEach((HiveAction hiveAction) {
      HiveActionUser? _hiveActionUser = ActionProvider()
          .getActionUser(this.hiveGroupUser!.userId!, hiveAction.id!);

      if (_hiveActionUser != null) {
        switch (
            ActionUser_Status.valueOf(_hiveActionUser.status!)!.convertTo()) {
          case ActionStatus.DONE:
            _countDone++;
            break;

          case ActionStatus.NOT_DONE:
            _countNotDone++;
            break;
          case ActionStatus.OVERDUE:
            _countOverdue++;
            break;
        }
      }
    });
    _map['done'] = _countDone;
    _map['not_done'] = _countNotDone;
    _map['overdue'] = _countOverdue;

    return _map;
  }

  void dispose() {}
}
