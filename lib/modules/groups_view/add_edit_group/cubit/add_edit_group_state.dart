part of 'add_edit_group_cubit.dart';

enum GroupError {
  noName,
  noDescription,
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
    this.newUsers = const {},
    required this.history,
    this.error,
  });

  final List<Language> languages;
  final List<EvaluationCategory> evaluationCategories;
  final Set<String> selectedLanguages;
  final Set<String> selectedEvaluationCategories;
  final String name;
  final String description;
  final Set<User> newUsers;
  final List<Edit> history;

  final GroupError? error;

  AddEditGroupState copyWith({
    List<Language>? languages,
    List<EvaluationCategory>? evaluationCategories,
    Set<String>? selectedLanguages,
    Set<String>? selectedEvaluationCategories,
    String? name,
    String? description,
    Set<User>? newUsers,
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
        newUsers: newUsers ?? this.newUsers,
        history: history ?? this.history,
        // We reset this to null every time unless explicitly passed.
        error: error,
      );
}
