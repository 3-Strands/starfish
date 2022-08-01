part of 'groups_cubit.dart';

@immutable
class GroupsState {
  GroupsState({
    required List<Group> groups,
    // required RelatedMaterials relatedMaterials,
    UserGroupRoleFilter userRoleFilter = UserGroupRoleFilter.FILTER_ALL,
    String query = "",
  })  : _groups = groups,
        // _relatedMaterials = relatedMaterials,
        _userRoleFilter = userRoleFilter,
        _query = query;

  final List<Group> _groups;
  // final RelatedMaterials _relatedMaterials;
  final UserGroupRoleFilter _userRoleFilter;
  final String _query;

  UserGroupRoleFilter get userRoleFilter => _userRoleFilter;
  String get query => _query;

  Map<UserGroupRoleFilter, List<Group>> get groupsToShow {
    var groups = _groups;

    if (_query.isNotEmpty) {
      final lowerCaseQuery = _query.toLowerCase();
      groups = groups
          .where((group) =>
              group.name.toLowerCase().contains(lowerCaseQuery) ||
              group.description.toLowerCase().contains(lowerCaseQuery))
          .toList();
    }

    final Map<UserGroupRoleFilter, List<Group>> groupsMap =
        _userRoleFilter == UserGroupRoleFilter.FILTER_ALL
            ? {
                UserGroupRoleFilter.FILTER_LEARNER: [],
                UserGroupRoleFilter.FILTER_ADMIN_CO_LEAD: []
              }
            : {_userRoleFilter: []};

    groups.forEach((group) {
      // TODO: Match to role
      groupsMap[groupsMap.keys.first]!.add(group);
    });

    return groupsMap;
  }

  GroupsState copyWith({
    List<Group>? groups,
    RelatedMaterials? relatedMaterials,
    UserGroupRoleFilter? userRoleFilter,
    String? query,
  }) =>
      GroupsState(
        groups: groups ?? this._groups,
        // relatedMaterials: relatedMaterials ?? this._relatedMaterials,
        userRoleFilter: userRoleFilter ?? this._userRoleFilter,
        query: query ?? this._query,
      );
}
