part of 'actions_cubit.dart';

@immutable
class ActionsState {
  ActionsState({
    required List<Action> actions,
    required RelatedActions relatedActions,
    int pagesToShow = 1,
    ActionFilter actionFilter = ActionFilter.THIS_MONTH,
    UserGroupRoleFilter userGroupRoleFilter = UserGroupRoleFilter.FILTER_ALL,
    String query = "",
  })  : _actions = actions,
        _relatedActions = relatedActions,
        _pagesToShow = pagesToShow,
        _actionFilter = actionFilter,
        _userGroupRoleFilter = userGroupRoleFilter,
        _query = query;

  static const itemsPerPage = 20;

  final List<Action> _actions;
  final RelatedActions _relatedActions;
  final int _pagesToShow;
  final ActionFilter _actionFilter;
  final String _query;
  final UserGroupRoleFilter _userGroupRoleFilter;

  int get pagesToShow => _pagesToShow;
  ActionFilter get actionFilter => _actionFilter;
  String get query => _query;
  UserGroupRoleFilter get userGroupRoleFilter => _userGroupRoleFilter;

  ActionsPageView get actionsToShow {
    var actions = _actions;

    if (_userGroupRoleFilter == UserGroupRoleFilter.FILTER_ADMIN_CO_LEAD) {
      actions = actions
          .where((action) => _actionIsAssignedToGroupWithLeaderRole(action))
          .toList();
    } else {
      actions = actions
          .where((action) => !_actionIsAssignedToGroupWithLeaderRole(action))
          .toList();
    }

    if (_query.isNotEmpty) {
      final lowerCaseQuery = _query.toLowerCase();
      actions = actions
          .where((action) =>
              action.name.toLowerCase().contains(lowerCaseQuery) ||
              (action.group?.name.toLowerCase().contains(lowerCaseQuery) ??
                  false)) // TODO:  filter on group member name also
          .toList();
    }

    var actionsWithStatus = actions
        .map((action) => ActionWithAssignedStatus(
            action: action,
            status: _assignedActionStatus(action),
            isAssignedToGroupWithLeaderRole:
                _actionIsAssignedToGroupWithLeaderRole(action)))
        .toList();

    print("actionsWithStatus.length: ${actionsWithStatus.length}");

    // final numberToTake = _pagesToShow * itemsPerPage;
    // if (numberToTake < actionsWithStatus.length) {
    //   return ActionsPageView(
    //       actionsWithStatus.take(numberToTake).toList(), true);
    // }

    //return ActionsPageView(actionsWithStatus, false);
    return ActionsPageView(actionsWithStatus, false);
  }

  ActionsState copyWith({
    List<Action>? actions,
    RelatedActions? relatedActions,
    int? pagesToShow,
    ActionFilter? actionFilter,
    String? query,
    UserGroupRoleFilter? userGroupRoleFilter,
  }) =>
      ActionsState(
        actions: actions ?? this._actions,
        relatedActions: relatedActions ?? this._relatedActions,
        pagesToShow: pagesToShow ?? this._pagesToShow,
        actionFilter: actionFilter ?? this._actionFilter,
        query: query ?? this._query,
        userGroupRoleFilter: userGroupRoleFilter ?? this._userGroupRoleFilter,
      );

  // bool _actionPassesActionFilter(ActionsWithAssignedGroupAndStatus action) {
  //   if (!action.action.hasValidDueDate && action.action.dateDue == null) {
  //     return actionFilter == ActionFilter.ALL_TIME ? true : false;
  //   }

  //   Jiffy currentDate = Jiffy();
  //   Jiffy actionDueDate = Jiffy({
  //     "year": action.action.dateDue!.year,
  //     "month": action.action.dateDue!.month,
  //     "day": currentDate.date
  //   });

  //   switch (actionFilter) {
  //     case ActionFilter.THIS_MONTH:
  //       return currentDate.isSame(actionDueDate, Units.YEAR) &&
  //           currentDate.month == actionDueDate.month;
  //     case ActionFilter.NEXT_MONTH:
  //       currentDate.add(months: 1);
  //       currentDate.endOf(Units.MONTH);

  //       return (currentDate.isSame(actionDueDate, Units.YEAR) &&
  //               currentDate.month == actionDueDate.month) ||
  //           (currentDate.isAfter(actionDueDate, Units.YEAR));
  //     case ActionFilter.LAST_MONTH:
  //       currentDate.subtract(months: 1);
  //       currentDate.startOf(Units.MONTH);

  //       return (currentDate.isSame(actionDueDate, Units.YEAR) &&
  //               currentDate.month == actionDueDate.month) ||
  //           (currentDate.isBefore(actionDueDate, Units.YEAR));
  //     case ActionFilter.LAST_THREE_MONTH:
  //       Jiffy startDate = Jiffy();
  //       startDate.subtract(months: 2);
  //       startDate.startOf(Units.MONTH);

  //       return actionDueDate.isBetween(startDate, currentDate);
  //     case ActionFilter.ALL_TIME:
  //     default:
  //       return true;
  //   }
  // }

  ActionStatus? _assignedActionStatus(Action action) {
    return _relatedActions.actionsAssignedToMe[action.id];
  }

  bool _actionIsAssignedToGroupWithLeaderRole(Action action) {
    return _relatedActions.actionsAssignedToGroupWithLeaderRole
        .contains(action.id);
  }

  // bool _actionIsAssignedToGroupRole(ActionsWithAssignedGroupAndStatus action) {
  //   if (userGroupRoleFilter == UserGroupRoleFilter.FILTER_LEARNER) {
  //     return !action.isAssignedToGroupWithLeaderRole;
  //   } else {
  //     return action.isAssignedToGroupWithLeaderRole;
  //   }
  // }

  // int memberCountByActionStatus(HiveAction action, ActionStatus actionStatus) {
  //   int i = 0;
  //   action.actionStatus;
  //   return i;
  // }
}

class ActionsPageView {
  const ActionsPageView(this.actions, this.hasMore);

  final List<ActionWithAssignedStatus> actions;
  final bool hasMore;
}
