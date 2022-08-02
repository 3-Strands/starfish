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
    MaterialError? error;
    if (state.title.isEmpty) {
      error = MaterialError.noTitle;
    } else if (state.description.isEmpty) {
      error = MaterialError.noDescription;
    } else if (!state.hasAnyFilesSelected && state.url.isEmpty) {
      error = MaterialError.noWebLinkOrFile;
    } else if (state.selectedLanguages.isEmpty) {
      error = MaterialError.noLanguage;
    }

    if (error != null) {
      emit(state.copyWith(error: error));
    } else {
      final material = _material;
      final id = material?.id ?? UuidGenerator.uuid();
      _dataRepository.addDelta(
        material == null
            ? MaterialCreateDelta(
                id: id,
                title: state.title,
                description: state.description,
                topics: state.selectedTopics.toList(),
                typeIds: state.selectedTypes.toList(),
                languageIds: state.selectedLanguages.toList(),
                url: state.url,
                editability: state.editability,
              )
            : MaterialUpdateDelta(
                material,
                title: state.title,
                description: state.description,
                topics: state.selectedTopics.toList(),
                typeIds: state.selectedTypes.toList(),
                languageIds: state.selectedLanguages.toList(),
                url: state.url,
                editability: state.editability,
              ),
      );
      state.newlySelectedFiles.forEach((file) {
        _dataRepository.addDelta(FileReferenceCreateDelta(
          entityId: id,
          entityType: EntityType.MATERIAL,
          filename: file.path.split('/').last,
          filepath: file.path,
        ));
      });
    }
  }

  @override
  Future<void> close() {
    _subscriptions.forEach((subscription) => subscription.cancel());
    return super.close();
  }
}
