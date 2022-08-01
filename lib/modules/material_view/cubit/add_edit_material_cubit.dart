import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:starfish/models/file_reference.dart';
import 'package:starfish/repositories/authentication_repository.dart';
import 'package:starfish/repositories/data_repository.dart';
import 'package:starfish/src/deltas.dart';
import 'package:starfish/src/generated/file_transfer.pbgrpc.dart';
import 'package:starfish/src/grpc_extensions.dart';
import 'package:starfish/utils/helpers/uuid_generator.dart';
import 'package:starfish/wrappers/file_system.dart';

part 'add_edit_material_state.dart';

class AddEditMaterialCubit extends Cubit<AddEditMaterialState> {
  AddEditMaterialCubit({
    required AuthenticationRepository authenticationRepository,
    required DataRepository dataRepository,
    Material? material,
  })  : _material = material,
        _authenticationRepository = authenticationRepository,
        _dataRepository = dataRepository,
        super(AddEditMaterialState(
          languages: dataRepository.currentLanguages,
          types: dataRepository.currentMaterialTypes,
          topics: dataRepository.currentMaterialTopics,
          selectedLanguages: material?.languageIds.toSet() ?? const {},
          selectedTypes: material?.typeIds.toSet() ?? const {},
          selectedTopics: material?.topics.toSet() ?? const {},
          previouslySelectedFiles: material?.fileReferences ?? const [],
          newlySelectedFiles: const [],
          title: material?.title ?? '',
          description: material?.description ?? '',
          url: material?.url ?? '',
          visibility: material?.visibility ??
              Material_Visibility.UNSPECIFIED_VISIBILITY,
          editability: material?.editability ??
              Material_Editability.UNSPECIFIED_EDITABILITY,
          history: material?.editHistory ?? const [],
        )) {
    _subscriptions = [
      dataRepository.languages
          .listen((languages) => emit(state.copyWith(languages: languages))),
      dataRepository.materialTypes
          .listen((types) => emit(state.copyWith(types: types))),
      dataRepository.materialTopics
          .listen((topics) => emit(state.copyWith(topics: topics))),
    ];
  }

  late List<StreamSubscription> _subscriptions;
  final AuthenticationRepository _authenticationRepository;
  final DataRepository _dataRepository;
  final Material? _material;

  void addFile(File file) => emit(
      state.copyWith(newlySelectedFiles: [...state.newlySelectedFiles, file]));

  void selectedLanguagesChanged(Set<String> ids) =>
      emit(state.copyWith(selectedLanguages: ids));

  void selectedTypesChanged(Set<String> ids) =>
      emit(state.copyWith(selectedTypes: ids));

  void selectedTopicsChanged(Set<String> ids) =>
      emit(state.copyWith(selectedTopics: ids));

  void titleChanged(String title) => emit(state.copyWith(title: title));

  void descriptionChanged(String description) =>
      emit(state.copyWith(description: description));

  void urlChanged(String url) => emit(state.copyWith(url: url));

  void visibilityChanged(Material_Visibility? visibility) => emit(
      state.copyWith(
          visibility:
              visibility ?? Material_Visibility.UNSPECIFIED_VISIBILITY));

  void editabilityChanged(Material_Editability? editability) => emit(
      state.copyWith(
          editability:
              editability ?? Material_Editability.UNSPECIFIED_EDITABILITY));

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
