import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:starfish/repositories/data_repository.dart';
import 'package:starfish/src/deltas.dart';
import 'package:starfish/src/generated/file_transfer.pbgrpc.dart';
import 'package:starfish/src/grpc_extensions.dart';
import 'package:starfish/utils/helpers/uuid_generator.dart';

part 'add_edit_group_state.dart';

class AddEditGroupCubit extends Cubit<AddEditGroupState> {
  AddEditGroupCubit({
    required DataRepository dataRepository,
    Group? group,
  })  : _group = group,
        _dataRepository = dataRepository,
        super(AddEditGroupState(
          languages: dataRepository.currentLanguages,
          evaluationCategories: dataRepository.currentEvaluationCategories,
          selectedLanguages: group?.languageIds.toSet() ?? const {},
          selectedEvaluationCategories:
              group?.evaluationCategoryIds.toSet() ?? const {},
          name: group?.name ?? '',
          description: group?.description ?? '',
          history: group?.editHistory ?? const [],
        )) {
    _subscriptions = [
      dataRepository.languages
          .listen((languages) => emit(state.copyWith(languages: languages))),
      dataRepository.evaluationCategories.listen((evaluationCategories) =>
          emit(state.copyWith(evaluationCategories: evaluationCategories))),
    ];
  }

  late List<StreamSubscription> _subscriptions;
  final DataRepository _dataRepository;
  final Group? _group;

  void selectedLanguagesChanged(Set<String> ids) =>
      emit(state.copyWith(selectedLanguages: ids));

  void selectedEvaluationCategoriesChanged(Set<String> ids) =>
      emit(state.copyWith(selectedEvaluationCategories: ids));

  void nameChanged(String name) => emit(state.copyWith(name: name));

  void descriptionChanged(String description) =>
      emit(state.copyWith(description: description));

  void submitRequested() {
    GroupError? error;
    if (state.name.isEmpty) {
      error = GroupError.noName;
    } else if (state.description.isEmpty) {
      error = GroupError.noDescription;
    }

    if (error != null) {
      emit(state.copyWith(error: error));
    } else {
      final group = _group;
      final id = group?.id ?? UuidGenerator.uuid();
      _dataRepository.addDelta(
        group == null
            ? GroupCreateDelta(
                id: id,
                name: state.name,
                description: state.description,
                languageIds: state.selectedLanguages.toList(),
                evaluationCategoryIds:
                    state.selectedEvaluationCategories.toList(),
                // TODO
              )
            : GroupUpdateDelta(
                group,
                name: state.name,
                description: state.description,
                languageIds: state.selectedLanguages.toList(),
                evaluationCategoryIds:
                    state.selectedEvaluationCategories.toList(),
                // TODO
              ),
      );
    }
  }

  @override
  Future<void> close() {
    _subscriptions.forEach((subscription) => subscription.cancel());
    return super.close();
  }
}
