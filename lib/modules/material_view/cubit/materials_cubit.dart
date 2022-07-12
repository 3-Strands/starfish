import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:starfish/db/hive_language.dart';
import 'package:starfish/db/hive_material.dart';
import 'package:starfish/db/hive_material_topic.dart';
import 'package:starfish/enums/action_status.dart';
import 'package:starfish/enums/material_filter.dart';
import 'package:starfish/repositories/data_repository.dart';

part 'materials_state.dart';

class MaterialsCubit extends Cubit<MaterialsState> {
  MaterialsCubit(DataRepository dataRepository) : _dataRepository = dataRepository,
  super(MaterialsState(
    materials: dataRepository.currentMaterials,
    relatedMaterials: dataRepository.getMaterialsRelatedToMe(),
  )) {
    _subscription = dataRepository.materials.listen((materials) {
      emit(state.copyWith(
        materials: materials,
        relatedMaterials: dataRepository.getMaterialsRelatedToMe(),
      ));
    });
  }

  final DataRepository _dataRepository;
  late StreamSubscription<List<HiveMaterial>> _subscription;

  void loadMore() {
    emit(state.copyWith(
      pagesToShow: state.pagesToShow + 1,
    ));
  }

  void updateSelectedLanguages(Set<HiveLanguage> selectedLanguages) {
    final languageIds = selectedLanguages.map((language) => language.id).toSet();
    _dataRepository.addUserLanguages(languageIds);
    emit(state.copyWith(
      selectedLanguages: languageIds,
    ));
  }

  void updateSelectedTopics(Set<HiveMaterialTopic> selectedTopics) {
    emit(state.copyWith(
      selectedTopics: selectedTopics.map((topic) => topic.name).toSet(),
    ));
  }

  void updateActions(MaterialFilter actions) {
    emit(state.copyWith(
      actions: actions,
    ));
  }

  void updateQuery(String query) {
    emit(state.copyWith(
      query: query,
    ));
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
