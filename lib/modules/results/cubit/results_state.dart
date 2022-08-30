part of 'results_cubit.dart';

@immutable
class ResultsState {
  ResultsState({
    required List<Group> groups,
    required Date month,
    required Group? filterGroup,
    required User currentUser,
    required RelatedTransformation relatedTransformation,
    UserGroupRoleFilter userGroupRoleFilter = UserGroupRoleFilter.FILTER_ALL,
  })  : groups = groups,
        month = month,
        filterGroup = filterGroup,
        currentUser = currentUser,
        relatedTransformation = relatedTransformation,
        _userGroupRoleFilter = userGroupRoleFilter;

  static const itemsPerPage = 20;

  final List<Group> groups;
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
                groupUser.role == GroupUser_Role.ADMIN ||
                groupUser.role == GroupUser_Role.TEACHER)
            .map(
              (element) => GroupUserResultStatus(
                  user: element.user,
                  groupUser: element,
                  transformation: _getTransformaiton(element)),
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
              transformation: _getTransformaiton(element)),
        )
        .toList();

    return GroupResultsPageView(groupUsers);
  }

  ResultsState copyWith({
    List<Group>? groups,
    RelatedActions? relatedActions,
    Date? month,
    Group? filterGroup,
    UserGroupRoleFilter? userGroupRoleFilter,
    User? currentUser,
    RelatedTransformation? relatedTransformation,
  }) =>
      ResultsState(
        groups: groups ?? this.groups,
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

  GroupEvaluation? _getGroupEvaluation(GroupUser groupUser) {}
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
    this.teacherResponses,
  });

  final User user;
  final GroupUser groupUser;
  final GroupEvaluation? groupEvaluation;
  final Transformation? transformation;
  final List<TeacherResponse>? teacherResponses;

  Group? get group => groupUser.group;
}
