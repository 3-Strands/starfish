import 'dart:async';

import 'package:grpc/grpc.dart';
import 'package:rxdart/subjects.dart';
import 'package:starfish/apis/hive_api.dart';
import 'package:starfish/src/deltas.dart';
import 'package:starfish/src/generated/starfish.pbgrpc.dart';

enum ModelType {
  country,
  language,
  material,
  action,
  group,
  user,
  evaluationCategory,
}

class SyncRepository {
  SyncRepository({
    required this.client,
    required this.requestRefresh,
  });
  // {
  //   _managers = {
  //     ModelType.country: SyncManager(
  //       pull: (client) => client
  //           .listAllCountries(ListAllCountriesRequest())
  //           .forEach((country) => hiveApi.country.put(country.id, country)),
  //     ),
  //     ModelType.language: SyncManager(
  //       pull: (client) => client
  //           .listLanguages(ListLanguagesRequest())
  //           .forEach((language) => hiveApi.language.put(language.id, language)),
  //     ),
  //     ModelType.material: SyncManager(
  //       pull: (client) => client
  //           .listMaterials(ListMaterialsRequest())
  //           .forEach((material) => hiveApi.material.put(material.id, material)),
  //     ),
  //     ModelType.action: SyncManager(
  //       pull: (client) => client
  //           .listActions(ListActionsRequest())
  //           .forEach((action) => hiveApi.action.put(action.id, action)),
  //     ),
  //     ModelType.group: SyncManager(
  //       pull: (client) => client
  //           .listGroups(ListGroupsRequest())
  //           .forEach((group) => hiveApi.group.put(group.id, group)),
  //     ),
  //     ModelType.user: SyncManager(
  //       pull: (client) => client
  //           .listUsers(ListUsersRequest())
  //           .forEach((user) => hiveApi.user.put(user.id, user)),
  //     ),
  //     ModelType.evaluationCategory: SyncManager(
  //       pull: (client) => client
  //           .listEvaluationCategories(ListEvaluationCategoriesRequest())
  //           .forEach((evaluationCategory) => hiveApi.evaluationCategory
  //               .put(evaluationCategory.id, evaluationCategory)),
  //     ),
  //   };

  //   // TODO: watch to push
  //   // hiveApi.material.watch().listen((_) => _checkIfTableShouldBeSynced(modelType.material));
  //   // hiveApi.action.watch().listen((_) => _checkIfTableShouldBeSynced(modelType.action));
  //   // hiveApi.group.watch().listen((_) => _checkIfTableShouldBeSynced(modelType.group));
  // }

  // late Map<ModelType, SyncManager> _managers;
  final _isSyncing = BehaviorSubject<bool>.seeded(false);
  // final _needsSync = <ModelType>{};
  // Map<ModelType, int> _skipNext = {};

  StarfishClient client;
  final Future<StarfishClient> Function() requestRefresh;

  Stream<bool> get isSyncingStream => _isSyncing.stream;
  bool get isSyncing => _isSyncing.value;

  // Future<void>? _pendingSync;
  // void _scheduleSync() {
  //   _pendingSync ??= Future.delayed(const Duration(milliseconds: 500), () {
  //     _pendingSync = null;
  //     _initializeSync();
  //   });
  // }

  // void sync(Iterable<ModelType> items) {
  //   _needsSync.addAll(items);
  //   _initializeSync();
  // }

  // void _initializeSync() async {
  //   if (_isSyncing.value) {
  //     return;
  //   }
  //   _isSyncing.add(true);
  //   // We will keep going until this is drained.
  //   while (_needsSync.isNotEmpty) {
  //     final needsSync = {..._needsSync};
  //     _needsSync.clear();
  //     await Future.wait(
  //       needsSync.map(
  //           (modelType) => _makeRequestWithRefresh(_managers[modelType]!.pull)),
  //     );
  //     // // This is to keep track of what needs to be pulled.
  //     // final needsPullFromRemote = <ModelType>{};
  //     // // We have to go in order, because some items
  //     // // need to be synced before others.
  //     // for (final modelType in ModelType.values) {
  //     //   if (_needsSync.contains(modelType)) {
  //     //     needsPullFromRemote.add(modelType);
  //     //     _needsSync.remove(modelType);
  //     //     final manager = _managers[modelType];
  //     //     if (manager is SyncManager) {
  //     //       await _makeRequestWithRefresh(manager.push);
  //     //     }
  //     //   }
  //     // }
  //     // // At this point, we've gone through in order all the items that
  //     // // were previously marked as needing a sync. It's quite possible
  //     // // some items were marked again as needing sync in that time. If
  //     // // so, then those items should *not* be pulled here, since they
  //     // // will be pulled on the next round.
  //     // needsPullFromRemote.removeAll(_needsSync);
  //     // await Future.wait(
  //     //   needsPullFromRemote.map(
  //     //       (modelType) => _makeRequestWithRefresh(_managers[modelType]!.pull)),
  //     // );
  //   }
  //   _isSyncing.add(false);
  // }

  Future<T> _makeRequestWithRefresh<T>(
      Future<T> Function(StarfishClient client) makeRequest) async {
    try {
      return await makeRequest(client);
    } on GrpcError catch (error) {
      if (error.code == StatusCode.unauthenticated) {
        client = await requestRefresh();
        return await makeRequest(client);
      } else {
        throw error;
      }
    }
  }

  void close() {
    _isSyncing.close();
  }

  void initSync() async {
    await _makeRequestWithRefresh((client) async {
      final controller = StreamController<SyncRequest>();
      final responseStream = client.sync(controller.stream);
      // TODO: Add requests.
      controller.close();
      final items = await responseStream.toList();
      for (final item in items) {
        if (item.hasAction())
          globalHiveApi.action.put(item.action.id, item.action);
        if (item.hasCountry())
          globalHiveApi.country.put(item.country.id, item.country);
        if (item.hasEvaluationCategory())
          globalHiveApi.evaluationCategory
              .put(item.evaluationCategory.id, item.evaluationCategory);
        if (item.hasGroup()) globalHiveApi.group.put(item.group.id, item.group);
        if (item.hasGroupEvaluation())
          globalHiveApi.groupEvaluation
              .put(item.groupEvaluation.id, item.groupEvaluation);
        if (item.hasLanguage())
          globalHiveApi.language.put(item.language.id, item.language);
        if (item.hasLearnerEvaluation())
          globalHiveApi.learnerEvaluation
              .put(item.learnerEvaluation.id, item.learnerEvaluation);
        if (item.hasMaterial())
          globalHiveApi.material.put(item.material.id, item.material);
        if (item.hasMaterialTopic())
          globalHiveApi.materialTopic
              .put(item.materialTopic.id, item.materialTopic);
        if (item.hasMaterialType())
          globalHiveApi.materialType
              .put(item.materialType.id, item.materialType);
        if (item.hasOutput())
          globalHiveApi.output.put(item.output.id, item.output);
        if (item.hasTeacherResponse())
          globalHiveApi.teacherResponse
              .put(item.teacherResponse.id, item.teacherResponse);
        if (item.hasTransformation())
          globalHiveApi.transformation
              .put(item.transformation.id, item.transformation);
        if (item.hasUser()) globalHiveApi.user.put(item.user.id, item.user);
        if (item.hasDeletedRecord()) {
          final deletedRecord = item.deletedRecord;
          final id = deletedRecord.id;
          switch (deletedRecord.resourceType) {
            case ResourceType.ACTION_RESOURCE:
              removeActionLocally(id);
              break;
            case ResourceType.COUNTRY_RESOURCE:
              removeCountryLocally(id);
              break;
            case ResourceType.EVALUATION_CATEGORY_RESOURCE:
              removeEvaluationCategoryLocally(id);
              break;
            case ResourceType.GROUP_EVALUATION_RESOURCE:
              removeGroupEvaluationLocally(id);
              break;
            case ResourceType.GROUP_RESOURCE:
              removeGroupLocally(id);
              break;
            case ResourceType.LANGUAGE_RESOURCE:
              removeLanguageLocally(id);
              break;
            case ResourceType.LEARNER_EVALUATION_RESOURCE:
              removeLearnerEvaluationLocally(id);
              break;
            case ResourceType.MATERIAL_RESOURCE:
              removeMaterialLocally(id);
              break;
            case ResourceType.MATERIAL_TOPIC_RESOURCE:
              removeMaterialTopicLocally(id);
              break;
            case ResourceType.MATERIAL_TYPE_RESOURCE:
              removeMaterialTypeLocally(id);
              break;
            case ResourceType.OUTPUT_RESOURCE:
              removeOutputLocally(id);
              break;
            case ResourceType.TEACHER_RESPONSE_RESOURCE:
              removeTeacherResponseLocally(id);
              break;
            case ResourceType.TRANSFORMATION_RESOURCE:
              removeTransformationLocally(id);
              break;
            case ResourceType.USER_RESOURCE:
              removeUserLocally(id);
              break;

            // Since these are stored in their parent models,
            // which will show as edited, we don't need to
            // take any action.
            case ResourceType.ACTION_USER_RESOURCE:
            case ResourceType.EVALUATION_VALUE_NAME_RESOURCE:
            case ResourceType.GROUP_USER_RESOURCE:
            case ResourceType.MATERIAL_FEEDBACK_RESOURCE:
            case ResourceType.OUTPUT_MARKER_RESOURCE:
              // noop
              break;
            default:
              assert(
                false,
                'Unknown ResourceType ${deletedRecord.resourceType}',
              );
          }
        }
      }
    });
  }
}

// class SyncManager {
//   const SyncManager({
//     required this.pull,
//   });

//   final Future<void> Function(StarfishClient client) pull;
// }
