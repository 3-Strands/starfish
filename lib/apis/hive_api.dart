import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:starfish/models/file_reference.dart';
import 'package:starfish/src/grpc_adapters.dart';
import 'package:starfish/src/grpc_extensions.dart';
import 'package:starfish/utils/services/local_storage_service.dart';
import 'package:starfish/wrappers/file_system.dart';

part 'hive_api_impl.dart';

abstract class HiveApiInterface {
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

  static init() async {
    await initHive();
    // Hive.registerAdapter(LastSyncDateTimeAdapter());
    Hive.registerAdapter(CountryAdapter());
    Hive.registerAdapter(LanguageAdapter());
    Hive.registerAdapter(UserAdapter());
    Hive.registerAdapter(GroupUserAdapter());
    Hive.registerAdapter(ActionUserAdapter());
    Hive.registerAdapter(ActionAdapter());
    Hive.registerAdapter(MaterialAdapter());
    Hive.registerAdapter(MaterialTopicAdapter());
    Hive.registerAdapter(MaterialTypeAdapter());
    Hive.registerAdapter(MaterialFeedbackAdapter());
    // Hive.registerAdapter(DateAdapter());
    // Hive.registerAdapter(EditAdapter());
    Hive.registerAdapter(GroupAdapter());
    // Hive.registerAdapter(GroupActionAdapter());
    // Hive.registerAdapter(EvaluationCategoryAdapter());
    Hive.registerAdapter(FileReferenceAdapter());
    // Hive.registerAdapter(LearnerEvaluationAdapter());
    // Hive.registerAdapter(TeacherResponseAdapter());
    // Hive.registerAdapter(GroupEvaluationAdapter());
    // Hive.registerAdapter(TransformationAdapter());
    // Hive.registerAdapter(OutputAdapter());
    // Hive.registerAdapter(OutputMarkerAdapter());
    // Hive.registerAdapter(EvaluationValueNameAdapter());

    await _openBoxes();
  }

  static _openBoxes() async {
    final encryptionKey = await StarfishSharedPreference().getEncryptionKey();

    final bytes = kIsWeb ? Uint8List(0) : null;

    await Hive.openBox<Country>(COUNTRY_BOX,
        encryptionCipher: HiveAesCipher(encryptionKey), bytes: bytes);
    await Hive.openBox<Language>(LANGUAGE_BOX,
        encryptionCipher: HiveAesCipher(encryptionKey), bytes: bytes);
    await Hive.openBox<GroupUser>(GROUP_USER_BOX,
        encryptionCipher: HiveAesCipher(encryptionKey), bytes: bytes);
    await Hive.openBox<Action>(ACTIONS_BOX,
        encryptionCipher: HiveAesCipher(encryptionKey), bytes: bytes);
    await Hive.openBox<Material>(MATERIAL_BOX,
        encryptionCipher: HiveAesCipher(encryptionKey), bytes: bytes);
    await Hive.openBox<MaterialFeedback>(MATERIAL_FEEDBACK_BOX,
        encryptionCipher: HiveAesCipher(encryptionKey), bytes: bytes);
    await Hive.openBox<MaterialTopic>(MATERIAL_TOPIC_BOX,
        encryptionCipher: HiveAesCipher(encryptionKey), bytes: bytes);
    await Hive.openBox<MaterialType>(MATERIAL_TYPE_BOX,
        encryptionCipher: HiveAesCipher(encryptionKey), bytes: bytes);
    await Hive.openBox<Group>(GROUP_BOX,
        encryptionCipher: HiveAesCipher(encryptionKey), bytes: bytes);
    await Hive.openBox<EvaluationCategory>(EVALUATION_CATEGORIES_BOX,
        encryptionCipher: HiveAesCipher(encryptionKey), bytes: bytes);
    await Hive.openBox<ActionUser>(ACTION_USER_BOX,
        encryptionCipher: HiveAesCipher(encryptionKey), bytes: bytes);
    await Hive.openBox<User>(USER_BOX,
        encryptionCipher: HiveAesCipher(encryptionKey), bytes: bytes);
    await Hive.openBox<FileReference>(FILE_BOX,
        encryptionCipher: HiveAesCipher(encryptionKey), bytes: bytes);
    await Hive.openBox<LearnerEvaluation>(LEARNER_EVALUATION_BOX,
        encryptionCipher: HiveAesCipher(encryptionKey), bytes: bytes);
    await Hive.openBox<TeacherResponse>(TEACHER_RESPONSE_BOX,
        encryptionCipher: HiveAesCipher(encryptionKey), bytes: bytes);
    await Hive.openBox<GroupEvaluation>(GROUP_EVALUATION_BOX,
        encryptionCipher: HiveAesCipher(encryptionKey), bytes: bytes);
    await Hive.openBox<Transformation>(TRANSFORMATION_BOX,
        encryptionCipher: HiveAesCipher(encryptionKey), bytes: bytes);
    await Hive.openBox<Output>(OUTPUT_BOX,
        encryptionCipher: HiveAesCipher(encryptionKey), bytes: bytes);
  }

  // Box<LastSyncDateTime> get lastSync;
  Box<Country> get country;
  Box<Language> get language;
  Box<GroupUser> get groupUser;
  Box<Action> get action;
  Box<Material> get material;
  Box<MaterialFeedback> get materialFeedback;
  Box<MaterialTopic> get materialTopic;
  Box<MaterialType> get materialType;
  Box<Group> get group;
  Box<EvaluationCategory> get evaluationCategory;
  Box<User> get user;
  Box<FileReference> get file;
  Box<ActionUser> get actionUser;
  Box<LearnerEvaluation> get learnerEvaluation;
  Box<TeacherResponse> get teacherResponse;
  Box<GroupEvaluation> get groupEvaluation;
  Box<Transformation> get transformation;
  Box<Output> get output;
}

/// Global constant to access HiveApi.
const HiveApiInterface globalHiveApi = HiveApiImpl();
