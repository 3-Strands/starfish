import 'dart:async';

import 'package:grpc/grpc.dart';
import 'package:rxdart/subjects.dart';
import 'package:starfish/apis/hive_api.dart';
import 'package:starfish/src/deltas.dart';
import 'package:starfish/src/generated/starfish.pbgrpc.dart';

// enum ModelType {
//   country,
//   language,
//   material,
//   action,
//   group,
//   user,
//   evaluationCategory,
// }

class _Scheduler {
  _Scheduler(this.sync);

  final Future<void> Function() sync;

  final _isSyncing = BehaviorSubject<bool>.seeded(false);
  Completer<void>? _completer;
  Timer? _timer;

  Stream<bool> get isSyncingStream => _isSyncing.stream;
  bool get isSyncing => _isSyncing.value;

  void _run() {
    _isSyncing.add(true);
    sync()
        .then(_completer!.complete)
        .onError(_completer!.completeError)
        .whenComplete(() {
      _isSyncing.add(false);
      _completer = null;
    });
  }

  Future<void> schedule({bool immediately = false}) {
    if (isSyncing) {
      // nothing to do
      return _completer!.future;
    }
    _completer ??= Completer();
    _timer?.cancel();
    if (immediately) {
      _timer = null;
      _run();
    } else {
      _timer = Timer(const Duration(milliseconds: 200), _run);
    }

    return _completer!.future;
  }

  void close() async {
    _timer?.cancel();
    try {
      if (isSyncing) {
        await _completer!.future;
      }
    } finally {
      _isSyncing.close();
    }
  }
}

class SyncRepository {
  SyncRepository({
    required this.client,
    required this.requestRefresh,
  }) {
    _scheduler = _Scheduler(_doSync);
  }

  late _Scheduler _scheduler;

  StarfishClient client;
  final Future<StarfishClient> Function() requestRefresh;

  Stream<bool> get isSyncingStream => _scheduler.isSyncingStream;
  bool get isSyncing => _scheduler.isSyncing;

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
    _scheduler.close();
  }

  Future<void> syncImmediately() => _scheduler.schedule(immediately: true);

  Future<void> sync() => _scheduler.schedule();

  Future<void> _doSync() async {
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
