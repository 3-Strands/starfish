part of 'add_edit_action_cubit.dart';

enum ActionError {
  noName,
  noInstructions,
  noMaterial,
  noQuestion,
  noGroup,
}

@immutable
class AddEditActionState {
  const AddEditActionState({
    required this.groups,
    required this.materials,
    required this.actions,
    required this.selectedGroups,
    required this.name,
    required this.type,
    required this.creatorId,
    required this.groupId,
    required this.instructions,
    required this.materialId,
    required this.question,
    required this.dueDate,
    required this.history,
    this.reuseAction,
    this.error,
  });

  final List<Group> groups;
  final List<Material> materials;
  final List<Action> actions;
  final List<Group> selectedGroups;
  final String name;
  final Action_Type type;
  final String creatorId;
  final String groupId;
  final String instructions;
  final String materialId;
  final String question;
  final Date dueDate;
  final Action? reuseAction;
  final List<Edit> history;

  final ActionError? error;

  AddEditActionState copyWith({
    List<Group>? groups,
    List<Material>? materials,
    List<Action>? actions,
    List<Group>? selectedGroups,
    String? name,
    Action_Type? type,
    String? creatorId,
    String? groupId,
    String? instructions,
    String? materialId,
    String? question,
    Date? dueDate,
    List<Edit>? history,
    Action? reuseAction,
    ActionError? error,
  }) =>
      AddEditActionState(
        groups: groups ?? this.groups,
        materials: materials ?? this.materials,
        actions: actions ?? this.actions,
        selectedGroups: selectedGroups ?? this.selectedGroups,
        name: name ?? this.name,
        type: type ?? this.type,
        creatorId: creatorId ?? this.creatorId,
        groupId: groupId ?? this.groupId,
        instructions: instructions ?? this.instructions,
        materialId: materialId ?? this.materialId,
        question: question ?? this.question,
        dueDate: dueDate ?? this.dueDate,
        history: history ?? this.history,
        reuseAction: reuseAction ?? this.reuseAction,
        // We reset this to null every time unless explicitly passed.
        error: error,
      );
}
