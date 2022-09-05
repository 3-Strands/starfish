import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:starfish/repositories/authentication_repository.dart';
import 'package:starfish/repositories/data_repository.dart';
import 'package:starfish/src/deltas.dart';
import 'package:starfish/src/grpc_extensions.dart';
import 'package:starfish/utils/helpers/uuid_generator.dart';

part 'add_edit_action_state.dart';

class AddEditActionCubit extends Cubit<AddEditActionState> {
  AddEditActionCubit({
    required AuthenticationRepository authenticationRepository,
    required DataRepository dataRepository,
    Action? action,
  })  : _action = action,
        _authenticationRepository = authenticationRepository,
        _dataRepository = dataRepository,
        super(AddEditActionState(
          groups: dataRepository.groupsWithAdminRole,
          materials: dataRepository.currentMaterials,
          actions: dataRepository.currentActions,
          selectedGroups: const [],
          isEditMode: action == null ? false : true,
          name: action?.name ?? '',
          type: action?.type ?? Action_Type.TEXT_INSTRUCTION,
          creatorId: action?.creatorId ?? '',
          groupId: action?.groupId ?? '',
          instructions: action?.instructions ?? '',
          materialId: action?.materialId ?? '',
          question: action?.question ?? '',
          dueDate: action?.dateDue ?? Date(),
          history: action?.editHistory ?? const [],
        )) {
    _subscriptions = [
      dataRepository.groups
          .listen((groups) => emit(state.copyWith(groups: groups))),
      dataRepository.materials
          .listen((materials) => emit(state.copyWith(materials: materials))),
    ];
  }

  late List<StreamSubscription> _subscriptions;
  final AuthenticationRepository _authenticationRepository;
  final DataRepository _dataRepository;
  final Action? _action;

  void reuseActionChanged(Action action) => emit(state.copyWith(
        reuseAction: action, // TODO: is it really needed?
        name: action.name,
        type: action.type,
        instructions: action.instructions,
        question: action.question,
        materialId: action.materialId,
      ));

  void nameChanged(String name) => emit(state.copyWith(name: name));

  void typeChanged(Action_Type? type) => emit(state.copyWith(type: type));

  void instuctionsChanged(String instructions) =>
      emit(state.copyWith(instructions: instructions));

  void questionChanged(String question) =>
      emit(state.copyWith(question: question));

  void selectedMaterialChanged(String id) =>
      emit(state.copyWith(materialId: id));

  void selectedGroupsChanged(List<Group> groups) =>
      emit(state.copyWith(selectedGroups: groups));

  void dueDateChanged(DateTime dateTime) => emit(state.copyWith(
      dueDate:
          Date(year: dateTime.year, month: dateTime.month, day: dateTime.day)));

  // void newGroupsAdded(Set<User> groups) =>
  //     emit(state.copyWith(groups: state.groups.union(groups)));

  bool submitRequested() {
    ActionError? error;
    if (state.name.isEmpty) {
      error = ActionError.noName;
    } else if (state.instructions.isEmpty) {
      error = ActionError.noInstructions;
    } else if ((state.type == Action_Type.MATERIAL_INSTRUCTION ||
            state.type == Action_Type.MATERIAL_RESPONSE) &&
        state.materialId.isEmpty) {
      error = ActionError.noMaterial;
    } else if ((state.type == Action_Type.TEXT_RESPONSE ||
            state.type == Action_Type.MATERIAL_RESPONSE) &&
        state.question.isEmpty) {
      error = ActionError.noQuestion;
    } else if (state.isEditMode == false && state.selectedGroups.isEmpty ||
        (state.isEditMode == true && state.groupId.isEmpty)) {
      error = ActionError.noGroup;
    }

    if (error != null) {
      emit(state.copyWith(error: error));
      return false;
    }

    if (_action == null) {
      for (final group in state.selectedGroups) {
        final id = UuidGenerator.uuid();
        _dataRepository.addDelta(
          ActionCreateDelta(
            id: id,
            name: state.name,
            type: state.type,
            groupId: group.hasId() ? group.id : null,
            instructions: state.instructions,
            materialId: state.materialId,
            question: state.question,
            dateDue: state.dueDate,
            // TODO
          ),
        );
      }
    } else {
      final action = _action;
      _dataRepository.addDelta(
        ActionUpdateDelta(
          action!,
          name: state.name,
          type: state.type,
          //groupId: state.groupId, //group can't be changed in 'Edit' mode
          instructions: state.instructions,
          materialId: state.materialId,
          question: state.question,
          dateDue: state.dueDate,
          // TODO
        ),
      );
    }
    return true;
  }

  @override
  Future<void> close() {
    _subscriptions.forEach((subscription) => subscription.cancel());
    return super.close();
  }
}
