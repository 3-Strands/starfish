import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:starfish/db/hive_edit.dart';
import 'package:starfish/db/hive_file.dart';
import 'package:starfish/db/hive_language.dart';
import 'package:starfish/db/hive_material.dart';
import 'package:starfish/db/hive_material_topic.dart';
import 'package:starfish/db/hive_material_type.dart';
import 'package:starfish/repositories/authentication_repository.dart';
import 'package:starfish/repositories/data_repository.dart';
import 'package:starfish/src/generated/starfish.pb.dart';
import 'package:starfish/utils/helpers/uuid_generator.dart';
import 'package:starfish/wrappers/file_system.dart';

part 'add_edit_material_state.dart';

class AddEditMaterialCubit extends Cubit<AddEditMaterialState> {
  AddEditMaterialCubit({
    required AuthenticationRepository authenticationRepository,
    required DataRepository dataRepository,
    HiveMaterial? material,
  })  : _material = material,
        _authenticationRepository = authenticationRepository,
        super(AddEditMaterialState(
          languages: dataRepository.currentLanguages,
          types: dataRepository.currentMaterialTypes,
          topics: dataRepository.currentMaterialTopics,
          selectedLanguages: material?.languageIds.toSet() ?? const {},
          selectedTypes: material?.typeIds.toSet() ?? const {},
          selectedTopics: material?.topicIds.toSet() ?? const {},
          previouslySelectedFiles: material?.files ?? const [],
          newlySelectedFiles: const [],
          title: material?.title ?? '',
          description: material?.description ?? '',
          url: material?.url ?? '',
          visibility: Material_Visibility.values[material?.visibility ?? 0],
          editability: Material_Editability.values[material?.editability ?? 0],
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
  final HiveMaterial? _material;

  void addFile(File file) => emit(
      state.copyWith(newlySelectedFiles: [...state.newlySelectedFiles, file]));

  void setSelectedLanguages(Set<String> ids) =>
      emit(state.copyWith(selectedLanguages: ids));

  void setSelectedTypes(Set<String> ids) =>
      emit(state.copyWith(selectedTypes: ids));

  void setSelectedTopics(Set<String> ids) =>
      emit(state.copyWith(selectedTopics: ids));

  void setTitle(String title) => emit(state.copyWith(title: title));

  void setDescription(String description) =>
      emit(state.copyWith(description: description));

  void setUrl(String url) => emit(state.copyWith(url: url));

  void setVisibility(Material_Visibility? visibility) => emit(state.copyWith(
      visibility: visibility ?? Material_Visibility.UNSPECIFIED_VISIBILITY));

  void setEditability(Material_Editability? editability) => emit(state.copyWith(
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
      _material!
        ..title = state.title
        ..description = state.description
        ..save();
      dataRepository.addDelta(MaterialMutation(
        id: _material.id,
        title: state.title,
        description: state.description,
        //...
      ));
      // TODO: Add/update material
      // TODO: Add new files
      // final material = _material;
      // if (material == null) {
      //   HiveMaterial(
      //     id: UuidGenerator.uuid(),
      //     isNew: true,
      //     creatorId: _authenticationRepository.currentSession!.user.id,
      //   );
      // } else {
      //   material
      //     ..isUpdated = true
      //     ..title = state.title
      //     ..description = state.description
      //     ..url = state.url
      //     ..fileNames
      // }
    }
  }

  @override
  Future<void> close() {
    _subscriptions.forEach((subscription) => subscription.cancel());
    return super.close();
  }
}
