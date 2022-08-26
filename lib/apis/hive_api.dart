import 'dart:async';
import 'dart:typed_data';

import 'package:meta/meta.dart';
import 'package:hive/hive.dart';
import 'package:starfish/models/file_reference.dart';
import 'package:starfish/src/generated/google/protobuf/timestamp.pb.dart';
import 'package:starfish/src/grpc_extensions.dart';

class HiveApi {
  const HiveApi();

  static const String COUNTRY_BOX = 'countryBox'; //0
  static const String LANGUAGE_BOX = 'languageBox'; //1
  static const String CURRENT_USER_BOX = 'currentUserBox'; //2
  static const String GROUP_USER_BOX = 'groupUserBox'; //3
  static const String ACTIONS_BOX = 'actionBox'; //4
  static const String MATERIAL_BOX = 'materialBox'; //5
  static const String MATERIAL_FEEDBACK_BOX = 'materialFeedbackBox'; //6
  static const String DATE = 'dateBox'; //7
  static const String LAST_SYNC_BOX = 'lastSyncBox'; //8
  static const String MATERIAL_TOPIC_BOX = 'materialTopicBox'; //9
  static const String MATERIAL_TYPE_BOX = 'materialTypeBox'; //10
  // HiveEdit 11
  static const String GROUP_BOX = 'groupBox'; //12
  // GroupAction // 13
  static const String EVALUATION_CATEGORIES_BOX = 'evaluationCategoryBox'; //14
  static const String ACTION_USER_BOX = 'actionUserBox'; // ActionUser 15
  static const String USER_BOX = 'userBox'; // 16
  static const String FILE_BOX = 'fileBox'; //17
  static const String LEARNER_EVALUATION_BOX = 'learnerEvaluationBox'; // 18
  static const String TEACHER_RESPONSE_BOX = 'teacherResponseBox'; // 19
  static const String GROUP_EVALUATION_BOX = 'groupResponseBox'; // 20
  static const String TRANSFORMATION_BOX = 'transformationBox'; // 21
  static const String OUTPUT_BOX = 'outputBox'; // 22
  // HiveOutputMarker // 23
  // HiveEvaluationValueName // 24
  static const String SYNC_BOX = 'syncBox';
  static const String BACKUP_SYNC_BOX = 'backupSyncBox';
  static const String REVERT_BOX = 'revertBox';
  static const String SYNC_TIMESTAMP_BOX = 'syncTimestampBox';

  static init({
    List<int>? encryptionKey,
    bool memoryOnly = false,
  }) async {
    final encryptionCipher =
        encryptionKey == null ? null : HiveAesCipher(encryptionKey);
    final bytes = memoryOnly ? Uint8List(0) : null;

    await Hive.openBox<Country>(COUNTRY_BOX,
        encryptionCipher: encryptionCipher, bytes: bytes);
    await Hive.openBox<Language>(LANGUAGE_BOX,
        encryptionCipher: encryptionCipher, bytes: bytes);
    await Hive.openBox<GroupUser>(GROUP_USER_BOX,
        encryptionCipher: encryptionCipher, bytes: bytes);
    await Hive.openBox<Action>(ACTIONS_BOX,
        encryptionCipher: encryptionCipher, bytes: bytes);
    await Hive.openBox<Material>(MATERIAL_BOX,
        encryptionCipher: encryptionCipher, bytes: bytes);
    await Hive.openBox<MaterialFeedback>(MATERIAL_FEEDBACK_BOX,
        encryptionCipher: encryptionCipher, bytes: bytes);
    await Hive.openBox<MaterialTopic>(MATERIAL_TOPIC_BOX,
        encryptionCipher: encryptionCipher, bytes: bytes);
    await Hive.openBox<MaterialType>(MATERIAL_TYPE_BOX,
        encryptionCipher: encryptionCipher, bytes: bytes);
    await Hive.openBox<Group>(GROUP_BOX,
        encryptionCipher: encryptionCipher, bytes: bytes);
    await Hive.openBox<EvaluationCategory>(EVALUATION_CATEGORIES_BOX,
        encryptionCipher: encryptionCipher, bytes: bytes);
    await Hive.openBox<ActionUser>(ACTION_USER_BOX,
        encryptionCipher: encryptionCipher, bytes: bytes);
    await Hive.openBox<User>(USER_BOX,
        encryptionCipher: encryptionCipher, bytes: bytes);
    await Hive.openBox<FileReference>(FILE_BOX,
        encryptionCipher: encryptionCipher, bytes: bytes);
    await Hive.openBox<LearnerEvaluation>(LEARNER_EVALUATION_BOX,
        encryptionCipher: encryptionCipher, bytes: bytes);
    await Hive.openBox<TeacherResponse>(TEACHER_RESPONSE_BOX,
        encryptionCipher: encryptionCipher, bytes: bytes);
    await Hive.openBox<GroupEvaluation>(GROUP_EVALUATION_BOX,
        encryptionCipher: encryptionCipher, bytes: bytes);
    await Hive.openBox<Transformation>(TRANSFORMATION_BOX,
        encryptionCipher: encryptionCipher, bytes: bytes);
    await Hive.openBox<Output>(OUTPUT_BOX,
        encryptionCipher: encryptionCipher, bytes: bytes);
    await Hive.openBox(SYNC_BOX,
        encryptionCipher: encryptionCipher, bytes: bytes);
    await Hive.openBox(BACKUP_SYNC_BOX,
        encryptionCipher: encryptionCipher, bytes: bytes);
    await Hive.openBox<Map<String, dynamic>>(REVERT_BOX,
        encryptionCipher: encryptionCipher, bytes: bytes);
    await Hive.openBox<Timestamp>(SYNC_TIMESTAMP_BOX,
        encryptionCipher: encryptionCipher, bytes: bytes);
  }

  // Box<LastSyncDateTime> get lastSync;
  Box<Country> get country => Hive.box<Country>(COUNTRY_BOX);
  Box<Language> get language => Hive.box<Language>(LANGUAGE_BOX);
  Box<GroupUser> get groupUser => Hive.box<GroupUser>(GROUP_USER_BOX);
  Box<Action> get action => Hive.box<Action>(ACTIONS_BOX);
  Box<Material> get material => Hive.box<Material>(MATERIAL_BOX);
  Box<MaterialFeedback> get materialFeedback =>
      Hive.box<MaterialFeedback>(MATERIAL_FEEDBACK_BOX);
  Box<MaterialTopic> get materialTopic =>
      Hive.box<MaterialTopic>(MATERIAL_TOPIC_BOX);
  Box<MaterialType> get materialType =>
      Hive.box<MaterialType>(MATERIAL_TYPE_BOX);
  Box<Group> get group => Hive.box<Group>(GROUP_BOX);
  Box<EvaluationCategory> get evaluationCategory =>
      Hive.box<EvaluationCategory>(EVALUATION_CATEGORIES_BOX);
  Box<User> get user => Hive.box<User>(USER_BOX);
  Box<FileReference> get file => Hive.box<FileReference>(FILE_BOX);
  Box<ActionUser> get actionUser => Hive.box<ActionUser>(ACTION_USER_BOX);
  Box<LearnerEvaluation> get learnerEvaluation =>
      Hive.box<LearnerEvaluation>(LEARNER_EVALUATION_BOX);
  Box<TeacherResponse> get teacherResponse =>
      Hive.box<TeacherResponse>(TEACHER_RESPONSE_BOX);
  Box<GroupEvaluation> get groupEvaluation =>
      Hive.box<GroupEvaluation>(GROUP_EVALUATION_BOX);
  Box<Transformation> get transformation =>
      Hive.box<Transformation>(TRANSFORMATION_BOX);
  Box<Output> get output => Hive.box<Output>(OUTPUT_BOX);
  @visibleForTesting
  Box<dynamic> get sync => Hive.box(SYNC_BOX);
  Box<dynamic> get _backupSync => Hive.box(BACKUP_SYNC_BOX);
  Box<Map<String, dynamic>> get revert =>
      Hive.box<Map<String, dynamic>>(REVERT_BOX);
  Box<Timestamp> get _syncTimestamp => Hive.box<Timestamp>(SYNC_TIMESTAMP_BOX);

  /// Make sure the sync box is not written to for the duration of the passed function.
  Future<void> protectSyncBox(
      FutureOr<void> Function(Iterable<dynamic>) fn) async {
    assert(!_isSyncBoxProtected,
        'Attempting to protect an already protected sync box! This is undefined behavior.');
    _isSyncBoxProtected = true;
    if (_backupSync.isNotEmpty) {
      // Somehow, things failed to get removed. Remove them now!
      clearBackupSync();
    }
    try {
      await fn(sync.values);
      // Sync succeeded!
      // First, clear the sync and revert box.
      clearSyncAndRevert();
    } catch (error) {
      // Sync failed!
      // First, write any requests saved in backup sync
      // to the sync box.
      for (final key in _backupSync.keys) {
        final request = _backupSync.get(key);
        if (request == null) {
          sync.delete(key);
        } else {
          sync.put(key, request);
        }
      }
      throw error;
    } finally {
      // No matter what, we clear the backup sync.
      clearBackupSync();
      _isSyncBoxProtected = false;
    }
  }

  Timestamp? get lastSync => _syncTimestamp.get(0);

  set lastSync(Timestamp? timestamp) => timestamp == null
      ? _syncTimestamp.delete(0)
      : _syncTimestamp.put(0, timestamp);

  dynamic getSyncRequest(dynamic key) =>
      (_isSyncBoxProtected ? _backupSync.get(key) : null) ?? sync.get(key);

  Future<void> putSyncRequest(dynamic key, dynamic request) =>
      (_isSyncBoxProtected ? _backupSync : sync).put(key, request);

  Future<void> deleteSyncRequest(dynamic key) async {
    if (_isSyncBoxProtected) {
      await _backupSync.put(key, null);
    } else {
      await sync.delete(key);
    }
  }

  void _clearBox(Box box) {
    box.deleteAll(box.keys);
  }

  void clearSyncAndRevert() {
    _clearBox(sync);
    _clearBox(revert);
  }

  void clearBackupSync() {
    _clearBox(_backupSync);
  }
}

var _isSyncBoxProtected = false;

/// Global constant to access HiveApi.
const HiveApi globalHiveApi = HiveApi();
