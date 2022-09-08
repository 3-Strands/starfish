import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:starfish/apis/hive_api.dart';
import 'package:starfish/enums/action_status.dart';
import 'package:starfish/enums/material_filter.dart';
import 'package:starfish/repositories/data_repository.dart';
import 'package:starfish/repositories/model_wrappers/material_with_assigned_status.dart';
import 'package:starfish/src/deltas.dart';
import 'package:starfish/src/grpc_extensions.dart';

part 'materials_state.dart';

class MaterialsCubit extends Cubit<MaterialsState> {
  MaterialsCubit(DataRepository dataRepository)
      : _dataRepository = dataRepository,
        super(MaterialsState(
          selectedLanguages: dataRepository.currentUser.languageIds.toSet(),
          materials: dataRepository.currentMaterials,
          relatedMaterials: dataRepository.getMaterialsRelatedToMe(),
        )) {
    final currentUserId = dataRepository.currentUser.id;
    _subscription = [
      dataRepository.materials.listen((materials) {
        emit(state.copyWith(
          materials: materials,
          relatedMaterials: dataRepository.getMaterialsRelatedToMe(),
        ));
      }),
      globalHiveApi.user.watch(key: currentUserId).listen((_) {
        // print(
        //     'Current languages: ${globalHiveApi.user.get(currentUserId)!.languageIds}');
        emit(state.copyWith(
          selectedLanguages:
              globalHiveApi.user.get(currentUserId)!.languageIds.toSet(),
        ));
      }),
    ];
  }

  final DataRepository _dataRepository;
  late List<StreamSubscription> _subscription;

  void moreRequested() {
    emit(state.copyWith(
      pagesToShow: state.pagesToShow + 1,
    ));
  }

  void selectedLanguagesChanged(Set<Language> selectedLanguages) {
    final languageIds =
        selectedLanguages.map((language) => language.id).toSet();
    _dataRepository.addDelta(UserUpdateDelta(
      _dataRepository.currentUser,
      languageIds: languageIds.toList(),
    ));
    emit(state.copyWith(
      selectedLanguages: languageIds,
    ));
  }

  void selectedTopicsChanged(Set<MaterialTopic> selectedTopics) {
    emit(state.copyWith(
      selectedTopics: selectedTopics.map((topic) => topic.name).toSet(),
    ));
  }

  void actionsChanged(MaterialFilter actions) {
    emit(state.copyWith(
      actions: actions,
    ));
  }

  void queryChanged(String query) {
    emit(state.copyWith(
      query: query,
    ));
  }

  void materialDeleted(Material material) {
    _dataRepository.addDelta(MaterialDeleteDelta(material));
  }

  @override
  Future<void> close() {
    _subscription.forEach((s) => s.cancel());
    return super.close();
  }
}
