part of 'add_edit_group_cubit.dart';

enum GroupError {
  noName,
  noDescription,
}

enum ContactError {
  nameAlreadyExists,
}

@immutable
class AddEditGroupState {
  const AddEditGroupState({
    required this.languages,
    required this.evaluationCategories,
    required this.selectedLanguages,
    required this.selectedEvaluationCategories,
    required this.name,
    required this.description,
    required this.currentMembers,
    this.newMembers = const {},
    this.removedMembers = const {},
    this.roleChanges = const {},
    this.nameChanges = const {},
    this.diallingCodeChanges = const {},
    this.phoneChanges = const {},
    required this.history,
    this.error,
  });

  final List<Language> languages;
  final List<EvaluationCategory> evaluationCategories;
  final Set<String> selectedLanguages;
  final Set<String> selectedEvaluationCategories;
  final Set<GroupUser> currentMembers;
  final String name;
  final String description;
  final Set<UserWithGroupRole> newMembers;
  final Set<User> removedMembers;
  final Map<String, GroupUser_Role> roleChanges;
  final Map<String, String> nameChanges;
  final Map<String, String> diallingCodeChanges;
  final Map<String, String> phoneChanges;
  final List<Edit> history;

  final GroupError? error;

  UserWithGroupRole _toUserWithGroupRole(GroupUser groupUser) {
    final user = groupUser.user;
    return UserWithGroupRole(user, roleChanges[user] ?? groupUser.role);
  }

  List<UserWithGroupRole> get members => [
        ...currentMembers.map((groupUser) {
          final user = groupUser.user;
          return UserWithGroupRole(user, roleChanges[user] ?? groupUser.role);
        }),
        ...newMembers,
      ];

  bool _groupUserHasNumber(GroupUser groupUser) =>
      groupUser.user.hasFullPhone ||
      diallingCodeChanges.containsKey(groupUser.userId);

  List<UserWithGroupRole> get currentMembersWithNumber => currentMembers
      .where(_groupUserHasNumber)
      .map(_toUserWithGroupRole)
      .toList();

  List<UserWithGroupRole> get currentMembersWithoutNumber => currentMembers
      .where((groupUser) => !_groupUserHasNumber(groupUser))
      .map(_toUserWithGroupRole)
      .toList();

  List<UserWithGroupRole> get newMembersWithNumber =>
      newMembers.where((member) => member.user.hasFullPhone).toList();

  List<UserWithGroupRole> get newMembersWithoutNumber =>
      newMembers.where((member) => !member.user.hasFullPhone).toList();

  AddEditGroupState copyWith({
    List<Language>? languages,
    List<EvaluationCategory>? evaluationCategories,
    Set<String>? selectedLanguages,
    Set<String>? selectedEvaluationCategories,
    String? name,
    String? description,
    Set<GroupUser>? currentMembers,
    Set<UserWithGroupRole>? newMembers,
    Set<User>? removedMembers,
    Map<String, GroupUser_Role>? roleChanges,
    Map<String, String>? nameChanges,
    Map<String, String>? diallingCodeChanges,
    Map<String, String>? phoneChanges,
    List<Edit>? history,
    GroupError? error,
  }) =>
      AddEditGroupState(
        languages: languages ?? this.languages,
        evaluationCategories: evaluationCategories ?? this.evaluationCategories,
        selectedLanguages: selectedLanguages ?? this.selectedLanguages,
        selectedEvaluationCategories:
            selectedEvaluationCategories ?? this.selectedEvaluationCategories,
        name: name ?? this.name,
        description: description ?? this.description,
        currentMembers: currentMembers ?? this.currentMembers,
        newMembers: newMembers ?? this.newMembers,
        removedMembers: removedMembers ?? this.removedMembers,
        roleChanges: roleChanges ?? this.roleChanges,
        nameChanges: nameChanges ?? this.nameChanges,
        diallingCodeChanges: diallingCodeChanges ?? this.diallingCodeChanges,
        phoneChanges: phoneChanges ?? this.phoneChanges,
        history: history ?? this.history,
        // We reset this to null every time unless explicitly passed.
        error: error,
      );
}
