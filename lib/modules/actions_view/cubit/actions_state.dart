part of 'actions_cubit.dart';

@immutable
class ActionsState {
  ActionsState({
    required List<Action> actions,
    required RelatedActions relatedActions,
    ActionFilter actionFilter = ActionFilter.THIS_MONTH,
    String query = "",
  })  : _actions = actions,
        _relatedActions = relatedActions,
        _actionFilter = actionFilter,
        _query = query;

  static const itemsPerPage = 20;

  final List<Action> _actions;
  final RelatedActions _relatedActions;
  final ActionFilter _actionFilter;
  final String _query;

  ActionFilter get actionFilter => _actionFilter;
  String get query => _query;

  ActionsPageView getMyActionsToShow() => _getActionsToShow(
        _actions.where(
          (action) => !_actionIsAssignedToGroupWithLeaderRole(action),
        ),
      );

  ActionsPageView getGroupActionsToShow() => _getActionsToShow(
        _actions.where(
          (action) => _actionIsAssignedToGroupWithLeaderRole(action),
        ),
      );

  ActionsPageView _getActionsToShow(Iterable<Action> actions) {
    final LinkedHashMap<Group, List<ActionWithAssignedStatus>> groupActionsMap =
        LinkedHashMap();

    actions =
        actions.where((action) => _actionPassesActionFilter(action)).toList();

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
            actionUser: _relatedActions.myActionUsers[action.id],
            isAssignedToGroupWithLeaderRole:
                _actionIsAssignedToGroupWithLeaderRole(action),
            groupUserWithStatus:
                _relatedActions.actionGroupUsersWithStatus[action.id]))
        .toList();

    final Group _dummyGroup = Group(id: null, name: null);
    actionsWithStatus.forEach((actionWithStatus) {
      Group? _group = actionWithStatus.action.group;
      if (_group == null) {
        _group = _dummyGroup;
      }
      if (groupActionsMap.containsKey(_group)) {
        groupActionsMap[_group]?.add(actionWithStatus);
      } else {
        groupActionsMap[_group] = [actionWithStatus];
      }
    });
    return ActionsPageView(groupActionsMap);
  }

  ActionsState copyWith({
    List<Action>? actions,
    RelatedActions? relatedActions,
    ActionFilter? actionFilter,
    String? query,
  }) =>
      ActionsState(
        actions: actions ?? this._actions,
        relatedActions: relatedActions ?? this._relatedActions,
        actionFilter: actionFilter ?? this._actionFilter,
        query: query ?? this._query,
      );

  bool _actionPassesActionFilter(Action action) {
    if (!action.hasValidDueDate) {
      return actionFilter == ActionFilter.ALL_TIME ? true : false;
    }

    Jiffy currentDate = Jiffy();
    Jiffy actionDueDate = Jiffy({
      "year": action.dateDue.year,
      "month": action.dateDue.month,
      "day": currentDate.date
    });

    switch (actionFilter) {
      case ActionFilter.THIS_MONTH:
        return currentDate.isSame(actionDueDate, Units.YEAR) &&
            currentDate.month == actionDueDate.month;
      case ActionFilter.NEXT_MONTH:
        currentDate.add(months: 1);
        currentDate.endOf(Units.MONTH);

        return (currentDate.isSame(actionDueDate, Units.YEAR) &&
                currentDate.month == actionDueDate.month) ||
            (currentDate.isAfter(actionDueDate, Units.YEAR));
      case ActionFilter.LAST_MONTH:
        currentDate.subtract(months: 1);
        currentDate.startOf(Units.MONTH);

        return (currentDate.isSame(actionDueDate, Units.YEAR) &&
                currentDate.month == actionDueDate.month) ||
            (currentDate.isBefore(actionDueDate, Units.YEAR));
      case ActionFilter.LAST_THREE_MONTH:
        Jiffy startDate = Jiffy();
        startDate.subtract(months: 2);
        startDate.startOf(Units.MONTH);

        return actionDueDate.isBetween(startDate, currentDate);
      case ActionFilter.ALL_TIME:
      default:
        return true;
    }
  }

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
  const ActionsPageView(this.groupActionsMap);

  final Map<Group, List<ActionWithAssignedStatus>> groupActionsMap;
}
