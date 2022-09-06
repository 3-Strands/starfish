part of 'results_cubit.dart';

@immutable
class ResultsState {
  ResultsState({
    required List<Group> groups,
    required List<Group> groupsWithAdminRole,
    required List<Action> actions,
    required List<EvaluationCategory> evaluationCategories,
    required List<TeacherResponse> teacherResponses,
    required List<GroupEvaluation> groupEvaluations,
    required List<LearnerEvaluation> learnerEvaluations,
    required Date month,
    Group? filterGroup,
    required User currentUser,
    required RelatedTransformation relatedTransformation,
    UserGroupRoleFilter userGroupRoleFilter = UserGroupRoleFilter.FILTER_ALL,
  })  : groups = groups,
        groupsWithAdminRole = groupsWithAdminRole,
        actions = actions,
        evaluationCategories = evaluationCategories,
        teacherResponses = teacherResponses,
        groupEvaluations = groupEvaluations,
        learnerEvaluations = learnerEvaluations,
        month = month,
        filterGroup = filterGroup,
        currentUser = currentUser,
        relatedTransformation = relatedTransformation,
        _userGroupRoleFilter = userGroupRoleFilter;

  final List<Group> groups;
  final List<Group> groupsWithAdminRole;
  final List<Action> actions;
  final List<EvaluationCategory> evaluationCategories;
  final List<TeacherResponse> teacherResponses;
  final List<GroupEvaluation> groupEvaluations;
  final List<LearnerEvaluation> learnerEvaluations;
  final Date month;
  final Group? filterGroup;
  final UserGroupRoleFilter _userGroupRoleFilter;
  final User currentUser;
  final RelatedTransformation relatedTransformation;

  UserGroupRoleFilter get userGroupRoleFilter => _userGroupRoleFilter;

  GroupResultsPageView get groupWithAdminRoleResultsToShow {
    //var groups = _groups;

    final groupUsers = filterGroup?.users
            .where((groupUser) =>
                groupUser.role == GroupUser_Role.LEARNER &&
                globalHiveApi.user.containsKey(groupUser.userId))
            .map(
              (element) => GroupUserResultStatus(
                user: element.user,
                groupUser: element,
                transformation: _getTransformaiton(element),
                actionsStatus: _gerActionsStatus(element),
                teacherResponses: _getTeacherResponses(element, month),
                groupEvaluation: _getGroupEvaluation(element, month),
                learnerEvaluations:
                    _getLearnerEvaluationsByCategory(element, month),
              ),
            )
            .toList() ??
        [];

    final groupActionsSummary = {
      ActionStatus.DONE: 0,
      ActionStatus.NOT_DONE: 0,
      ActionStatus.OVERDUE: 0
    };

    final groupEvaluationSummary = {
      GroupEvaluation_Evaluation.BAD: 0,
      GroupEvaluation_Evaluation.GOOD: 0
    };

    final Map<EvaluationCategory, Map<String, int>> groupLearnerEvaluations =
        {};

    groupUsers.forEach((groupUserResultStatus) {
      // groupActionsSummary
      groupActionsSummary[ActionStatus.DONE] =
          groupUserResultStatus.actionsStatus[ActionStatus.DONE] ?? 0 + 1;
      groupActionsSummary[ActionStatus.NOT_DONE] =
          groupUserResultStatus.actionsStatus[ActionStatus.NOT_DONE] ?? 0 + 1;
      groupActionsSummary[ActionStatus.OVERDUE] =
          groupUserResultStatus.actionsStatus[ActionStatus.OVERDUE] ?? 0 + 1;

      // groupEvaluationSummary
      if (groupUserResultStatus.groupEvaluation != null) {
        if (groupUserResultStatus.groupEvaluation!.evaluation ==
            GroupEvaluation_Evaluation.BAD) {
          groupEvaluationSummary[GroupEvaluation_Evaluation.BAD] =
              groupEvaluationSummary[GroupEvaluation_Evaluation.BAD] ?? 0 + 1;
        } else if (groupUserResultStatus.groupEvaluation!.evaluation ==
            GroupEvaluation_Evaluation.GOOD) {
          groupEvaluationSummary[GroupEvaluation_Evaluation.GOOD] =
              groupEvaluationSummary[GroupEvaluation_Evaluation.GOOD] ?? 0 + 1;
        }
      }

      // groupLearnerEvaluations
      groupUserResultStatus.learnerEvaluations.forEach((key, value) {
        if (!groupLearnerEvaluations.containsKey(key)) {
          groupLearnerEvaluations[key] = value;
        } else {
          final _countByMonth = groupLearnerEvaluations[key]!;

          _countByMonth["this-month"] =
              (_countByMonth['this-month'] ?? 0) + (value['this-month'] ?? 0);
          _countByMonth["last-month"] =
              (_countByMonth['last-month'] ?? 0) + (value['last-month'] ?? 0);

          groupLearnerEvaluations[key] = _countByMonth;
        }
      });
    });

    return GroupResultsPageView(
      groupUserResultsStatusList: groupUsers,
      groupActionsSummary: groupActionsSummary,
      groupEvaluationSummary: groupEvaluationSummary,
      learnerEvaluationsSummary: groupLearnerEvaluations,
    );
  }

  GroupResultsPageView get myLifeResultsToShow {
    //var groups = _groups;
    final groupUsers = currentUser.groups
        .where((groupUser) => groupUser.role == GroupUser_Role.LEARNER)
        .map(
          (element) => GroupUserResultStatus(
            user: currentUser,
            groupUser: element,
            transformation: _getTransformaiton(element),
            actionsStatus: _gerActionsStatus(element),
            teacherResponses: _getTeacherResponses(element, month),
            groupEvaluation: _getGroupEvaluation(element, month),
            learnerEvaluations:
                _getLearnerEvaluationsByCategory(element, month),
          ),
        )
        .toList();

    return GroupResultsPageView(groupUserResultsStatusList: groupUsers);
  }

  ResultsState copyWith({
    List<Group>? groups,
    List<Group>? groupsWithAdminRole,
    List<Action>? actions,
    List<EvaluationCategory>? evaluationCategories,
    List<TeacherResponse>? teacherResponses,
    List<GroupEvaluation>? groupEvaluations,
    List<LearnerEvaluation>? learnerEvaluations,
    RelatedActions? relatedActions,
    Date? month,
    Group? filterGroup,
    UserGroupRoleFilter? userGroupRoleFilter,
    User? currentUser,
    RelatedTransformation? relatedTransformation,
  }) =>
      ResultsState(
        groups: groups ?? this.groups,
        groupsWithAdminRole: groupsWithAdminRole ?? this.groupsWithAdminRole,
        actions: actions ?? this.actions,
        evaluationCategories: evaluationCategories ?? this.evaluationCategories,
        teacherResponses: teacherResponses ?? this.teacherResponses,
        groupEvaluations: groupEvaluations ?? this.groupEvaluations,
        learnerEvaluations: learnerEvaluations ?? this.learnerEvaluations,
        month: month ?? this.month,
        filterGroup: filterGroup ?? this.filterGroup,
        userGroupRoleFilter: userGroupRoleFilter ?? this._userGroupRoleFilter,
        currentUser: currentUser ?? this.currentUser,
        relatedTransformation:
            relatedTransformation ?? this.relatedTransformation,
      );

  Transformation? _getTransformaiton(GroupUser groupUser) {
    return relatedTransformation.transformations.firstWhereOrNull(
      (transformation) =>
          transformation.groupId == groupUser.groupId &&
          transformation.userId == groupUser.userId &&
          transformation.month == month,
    );
  }

  GroupEvaluation? _getGroupEvaluation(GroupUser groupUser, Date month) {
    final groupEvaluation = groupEvaluations.firstWhereOrNull(
        (groupEvaluation) =>
            groupEvaluation.groupId == groupUser.groupId &&
            groupEvaluation.userId == groupUser.userId &&
            groupEvaluation.month == month);

    return groupEvaluation;
  }

  Map<ActionStatus, int> _gerActionsStatus(GroupUser groupUser) {
    final map = {
      ActionStatus.DONE: 0,
      ActionStatus.NOT_DONE: 0,
      ActionStatus.OVERDUE: 0
    };

    groupUser.user.actions.forEach((ActionUser actionUser) {
      final action = actionUser.action;
      if (action != null &&
          (action.isIndividualAction || action.groupId == groupUser.groupId)) {
        final status = actionUser.status == ActionUser_Status.COMPLETE
            ? ActionStatus.DONE
            : action.isPastDueDate
                ? ActionStatus.OVERDUE
                : ActionStatus.NOT_DONE;

        map[status] = (map[status] ?? 0) + 1;
      }
    });

    return map;
  }

  // Returns 'List<TeacherRespnse>' for the 'User' of a 'Group'
  List<TeacherResponse> _getTeacherResponses(GroupUser groupUser, Date month) {
    return teacherResponses
        .where((teacherResponse) =>
            teacherResponse.groupId == groupUser.groupId &&
            teacherResponse.learnerId == groupUser.userId &&
            teacherResponse.month == month)
        .toList();
  }

  Map<EvaluationCategory, Map<String, int>> _getLearnerEvaluationsByCategory(
      GroupUser groupUser, Date hiveDate) {
    Map<EvaluationCategory, Map<String, int>> _map = Map();

    groupUser.group?.evaluationCategoryIds.forEach((categoryId) {
      final _evaluationCategory = evaluationCategories.firstWhereOrNull(
          (evaluationCategory) => evaluationCategory.id == categoryId);
      if (_evaluationCategory != null) {
        Map<String, int> _countByMonth = Map();
        _countByMonth["this-month"] =
            _categoryLearnerEvaluationsForMonth(categoryId, hiveDate);
        _countByMonth["last-month"] = _categoryLearnerEvaluationsForMonth(
            categoryId, hiveDate.previousMonth);

        _map[_evaluationCategory] = _countByMonth;
      }
    });

    return _map;
  }

  int _categoryLearnerEvaluationsForMonth(String categoryId, Date month) {
    LearnerEvaluation? _learnerEvaluation = learnerEvaluations
        .where((element) => element.categoryId == categoryId)
        .where((element) {
      return element.month == month;
    }).firstOrNull;

    return _learnerEvaluation == null ? 0 : _learnerEvaluation.evaluation;
  }
}

class GroupResultsPageView {
  const GroupResultsPageView({
    required this.groupUserResultsStatusList,
    this.groupActionsSummary,
    this.groupEvaluationSummary,
    this.learnerEvaluationsSummary,
  });

  final List<GroupUserResultStatus> groupUserResultsStatusList;
  final Map<EvaluationCategory, Map<String, int>>? learnerEvaluationsSummary;
  final Map<ActionStatus, int>? groupActionsSummary;
  final Map<GroupEvaluation_Evaluation, int>? groupEvaluationSummary;
}

class GroupUserResultStatus {
  const GroupUserResultStatus({
    required this.user,
    required this.groupUser,
    this.groupEvaluation,
    this.transformation,
    required this.teacherResponses,
    required this.actionsStatus,
    required this.learnerEvaluations,
  });

  final User user;
  final GroupUser groupUser;
  final GroupEvaluation? groupEvaluation;
  final Transformation? transformation;
  final List<TeacherResponse> teacherResponses;
  final Map<ActionStatus, int> actionsStatus;
  final Map<EvaluationCategory, Map<String, int>> learnerEvaluations;

  Group? get group => groupUser.group;
}
