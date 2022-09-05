part of 'results_cubit.dart';

@immutable
class ResultsState {
  ResultsState({
    required List<Group> groups,
    required List<Group> groupsWithAdminRole,
    required List<Action> actions,
    required List<TeacherResponse> teacherResponses,
    required List<GroupEvaluation> groupEvaluations,
    required Date month,
    Group? filterGroup,
    required User currentUser,
    required RelatedTransformation relatedTransformation,
    UserGroupRoleFilter userGroupRoleFilter = UserGroupRoleFilter.FILTER_ALL,
  })  : groups = groups,
        groupsWithAdminRole = groupsWithAdminRole,
        actions = actions,
        teacherResponses = teacherResponses,
        groupEvaluations = groupEvaluations,
        month = month,
        filterGroup = filterGroup,
        currentUser = currentUser,
        relatedTransformation = relatedTransformation,
        _userGroupRoleFilter = userGroupRoleFilter;

  final List<Group> groups;
  final List<Group> groupsWithAdminRole;
  final List<Action> actions;
  final List<TeacherResponse> teacherResponses;
  final List<GroupEvaluation> groupEvaluations;
  final Date month;
  final Group? filterGroup;
  final UserGroupRoleFilter _userGroupRoleFilter;
  final User currentUser;
  final RelatedTransformation relatedTransformation;

  UserGroupRoleFilter get userGroupRoleFilter => _userGroupRoleFilter;

  GroupResultsPageView get groupWithAdminRoleResultsToShow {
    //var groups = _groups;

    final groupUsers = filterGroup?.users
            .where((groupUser) => groupUser.role == GroupUser_Role.LEARNER)
            .map(
              (element) => GroupUserResultStatus(
                user: element.user,
                groupUser: element,
                transformation: _getTransformaiton(element),
                actionsStatus: _gerActionsStatus(element),
                teacherResponses: _getTeacherResponses(element, month),
                groupEvaluation: _getGroupEvaluation(element, month),
              ),
            )
            .toList() ??
        [];

    return GroupResultsPageView(groupUsers);
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
          ),
        )
        .toList();

    return GroupResultsPageView(groupUsers);
  }

  ResultsState copyWith({
    List<Group>? groups,
    List<Group>? groupsWithAdminRole,
    List<Action>? actions,
    List<TeacherResponse>? teacherResponses,
    List<GroupEvaluation>? groupEvaluations,
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
        teacherResponses: teacherResponses ?? this.teacherResponses,
        groupEvaluations: groupEvaluations ?? this.groupEvaluations,
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
}

class GroupResultsPageView {
  const GroupResultsPageView(this.groupUserResultsStatusList);

  final List<GroupUserResultStatus> groupUserResultsStatusList;
}

class GroupUserResultStatus {
  const GroupUserResultStatus({
    required this.user,
    required this.groupUser,
    this.groupEvaluation,
    this.transformation,
    required this.teacherResponses,
    required this.actionsStatus,
  });

  final User user;
  final GroupUser groupUser;
  final GroupEvaluation? groupEvaluation;
  final Transformation? transformation;
  final List<TeacherResponse> teacherResponses;
  final Map<ActionStatus, int> actionsStatus;

  Group? get group => groupUser.group;
}
