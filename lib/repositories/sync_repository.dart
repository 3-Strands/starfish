import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:rxdart/rxdart.dart';
import 'package:starfish/apis/hive_api.dart';
import 'package:starfish/models/file_reference.dart';
import 'package:starfish/repositories/authentication_repository.dart';
import 'package:starfish/src/deltas.dart';
import 'package:starfish/src/generated/google/protobuf/timestamp.pb.dart';
import 'package:starfish/src/generated/starfish.pbgrpc.dart';
import 'package:starfish/wrappers/file_system.dart';

class SyncRepository {
  SyncRepository({
    required this.makeAuthenticatedRequest,
  }) {
    _scheduler = _Scheduler(_doSync);
    _subscriptions = [
      globalHiveApi.sync
          .watch()
          .debounceTime(const Duration(milliseconds: 200))
          .listen(
        (_) {
          if (globalHiveApi.sync.isNotEmpty) {
            sync();
          }
        },
      ),
      Connectivity().onConnectivityChanged.listen((status) {
        if (status == ConnectivityResult.bluetooth) {
          // Don't care about bluetooth connections...
          return;
        }
        isConnected = status != ConnectivityResult.none;
      }),
    ];
  }

  bool _isConnected = true;
  late _Scheduler _scheduler;
  late List<StreamSubscription> _subscriptions;

  bool get isConnected => _isConnected;
  set isConnected(bool value) {
    if (value != _isConnected) {
      _isConnected = value;
      // If we have gained connectivity, check to see if (a) we have
      // things to sync, or (b) it's been more than 15 minutes.
      if (value && (globalHiveApi.sync.isNotEmpty || _lastSyncWasOld())) {
        sync();
      }
    }
  }

  bool _lastSyncWasOld() =>
      (globalHiveApi.lastSync?.seconds.toInt() ?? 0) <
      Timestamp.fromDateTime(DateTime.now()).seconds.toInt() -
          _secondsIn15Minutes;

  static const _secondsIn15Minutes = 60 * 15;

  final MakeAuthenticatedRequest makeAuthenticatedRequest;

  Stream<bool> get isSyncingStream => _scheduler.isSyncingStream;
  bool get isSyncing => _scheduler.isSyncing;

  void close() {
    _scheduler.close();
    _subscriptions.forEach((s) => s.cancel());
  }

  Future<void> syncImmediately() => _scheduler.schedule(immediately: true);

  Future<void> sync() => _scheduler.schedule();

  Future<void> _doSync() async {
    await globalHiveApi.protectSyncBox(
      (requests) =>
          makeAuthenticatedRequest((client, fileTransferClient) async {
        final fileRequests = List<FileReference>.from(
            requests.where((request) => request is FileReference));
        if (fileRequests.isNotEmpty) {
          // Upload the files
          await uploadFiles(fileRequests, fileTransferClient);
          // Delete the requests
          globalHiveApi.sync
              .deleteAll(fileRequests.map((fileRequest) => fileRequest.key));
          // Filter the remaining requests and proceed
          requests = requests.where((request) => !(request is FileReference));
        }
        final controller = StreamController<SyncRequest>();
        final responseStream = client.sync(controller.stream);
        controller.add(SyncRequest(
          metaData: SyncRequestMetaData(
            getNewRecords: true,
            updatedSince: globalHiveApi.lastSync,
          ),
        ));
        for (final request in orderRequests(requests)) {
          final syncRequest = SyncRequest.create();
          if (request is CreateMaterialFeedbacksRequest)
            syncRequest.createMaterialFeedback = request;
          else if (request is CreateUpdateActionsRequest)
            syncRequest.createUpdateAction = request;
          else if (request is CreateUpdateActionUserRequest)
            syncRequest.createUpdateActionUser = request;
          else if (request is CreateUpdateGroupsRequest)
            syncRequest.createUpdateGroup = request;
          else if (request is CreateUpdateGroupEvaluationRequest)
            syncRequest.createUpdateGroupEvaluation = request;
          else if (request is CreateUpdateGroupUsersRequest)
            syncRequest.createUpdateGroupUser = request;
          else if (request is CreateUpdateLearnerEvaluationRequest)
            syncRequest.createUpdateLearnerEvaluation = request;
          else if (request is CreateUpdateMaterialsRequest)
            syncRequest.createUpdateMaterial = request;
          else if (request is CreateUpdateOutputRequest)
            syncRequest.createUpdateOutput = request;
          else if (request is CreateUpdateTeacherResponseRequest)
            syncRequest.createUpdateTeacherResponse = request;
          else if (request is CreateUpdateTransformationRequest)
            syncRequest.createUpdateTransformation = request;
          else if (request is CreateUpdateUserRequest)
            syncRequest.createUpdateUser = request;
          else if (request is DeleteActionRequest)
            syncRequest.deleteAction = request;
          // TODO
          // else if (request is DeleteGroupUserRequest)
          //   syncRequest.deleteGroupUser = request;
          else if (request is DeleteMaterialRequest)
            syncRequest.deleteMaterial = request;
          else if (request is UpdateCurrentUserRequest)
            syncRequest.updateCurrentUser = request;
          print('Adding $syncRequest');
          controller.add(syncRequest);
        }
        controller.close();
        final items = await responseStream.toList();
        revertAll();
        for (final item in items) {
          item.freeze();
          if (item.hasMetaData())
            globalHiveApi.lastSync = item.metaData.requestTime;
          if (item.hasAction())
            globalHiveApi.action.put(item.action.id, item.action);
          if (item.hasCountry())
            globalHiveApi.country.put(item.country.id, item.country);
          if (item.hasEvaluationCategory())
            globalHiveApi.evaluationCategory
                .put(item.evaluationCategory.id, item.evaluationCategory);
          if (item.hasGroup())
            globalHiveApi.group.put(item.group.id, item.group);
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
      }),
    );
    // TODO: check for any more deltas to apply.
  }
}

class _Scheduler {
  _Scheduler(this.sync);

  final Future<void> Function() sync;
  Timer? _nextSyncTimer;

  final _isSyncing = BehaviorSubject<bool>.seeded(false);
  Completer<void>? _completer;
  Timer? _timer;

  Stream<bool> get isSyncingStream => _isSyncing.stream;
  bool get isSyncing => _isSyncing.value;

  void _run() {
    _isSyncing.value = true;
    _nextSyncTimer?.cancel();
    sync()
        .then(_completer!.complete)
        .onError(_completer!.completeError)
        .whenComplete(() {
      _isSyncing.value = false;
      _completer = null;
      // Schedule the next
      _nextSyncTimer = Timer(const Duration(minutes: 15), schedule);
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
    _nextSyncTimer?.cancel();
    try {
      if (isSyncing) {
        await _completer!.future;
      }
    } finally {
      _isSyncing.close();
    }
  }
}
