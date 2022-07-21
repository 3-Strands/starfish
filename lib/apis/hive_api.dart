import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:starfish/db/hive_action.dart';
import 'package:starfish/db/hive_action_user.dart';
import 'package:starfish/db/hive_country.dart';
import 'package:starfish/db/hive_date.dart';
import 'package:starfish/db/hive_edit.dart';
import 'package:starfish/db/hive_evaluation_category.dart';
import 'package:starfish/db/hive_evaluation_value_name.dart';
import 'package:starfish/db/hive_file.dart';
import 'package:starfish/db/hive_group.dart';
import 'package:starfish/db/hive_group_action.dart';
import 'package:starfish/db/hive_group_evaluation.dart';
import 'package:starfish/db/hive_group_user.dart';
import 'package:starfish/db/hive_language.dart';
import 'package:starfish/db/hive_last_sync_date_time.dart';
import 'package:starfish/db/hive_learner_evaluation.dart';
import 'package:starfish/db/hive_material.dart';
import 'package:starfish/db/hive_material_feedback.dart';
import 'package:starfish/db/hive_material_topic.dart';
import 'package:starfish/db/hive_material_type.dart';
import 'package:starfish/db/hive_output.dart';
import 'package:starfish/db/hive_output_marker.dart';
import 'package:starfish/db/hive_syncable.dart';
import 'package:starfish/db/hive_teacher_response.dart';
import 'package:starfish/db/hive_transformation.dart';
import 'package:starfish/db/hive_user.dart';
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
  // HiveGroupAction // 13
  static const String EVALUATION_CATEGORIES_BOX = 'evaluationCategoryBox'; //14
  static const String ACTION_USER_BOX = 'actionUserBox'; // HiveActionUser 15
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
    Hive.registerAdapter(HiveLastSyncDateTimeAdapter());
    Hive.registerAdapter(HiveCountryAdapter());
    Hive.registerAdapter(HiveLanguageAdapter());
    Hive.registerAdapter(HiveUserAdapter());
    Hive.registerAdapter(HiveGroupUserAdapter());
    Hive.registerAdapter(HiveActionUserAdapter());
    Hive.registerAdapter(HiveActionAdapter());
    Hive.registerAdapter(HiveMaterialAdapter());
    Hive.registerAdapter(HiveMaterialTopicAdapter());
    Hive.registerAdapter(HiveMaterialTypeAdapter());
    Hive.registerAdapter(HiveMaterialFeedbackAdapter());
    Hive.registerAdapter(HiveDateAdapter());
    Hive.registerAdapter(HiveEditAdapter());
    Hive.registerAdapter(HiveGroupAdapter());
    Hive.registerAdapter(HiveGroupActionAdapter());
    Hive.registerAdapter(HiveEvaluationCategoryAdapter());
    Hive.registerAdapter(HiveFileAdapter());
    Hive.registerAdapter(HiveLearnerEvaluationAdapter());
    Hive.registerAdapter(HiveTeacherResponseAdapter());
    Hive.registerAdapter(HiveGroupEvaluationAdapter());
    Hive.registerAdapter(HiveTransformationAdapter());
    Hive.registerAdapter(HiveOutputAdapter());
    Hive.registerAdapter(HiveOutputMarkerAdapter());
    Hive.registerAdapter(HiveEvaluationValueNameAdapter());

    await _openBoxes();
  }

  static _openBoxes() async {
    final encryptionKey = await StarfishSharedPreference().getEncryptionKey();

    final bytes = kIsWeb ? Uint8List(0) : null;

    await Hive.openBox<HiveLastSyncDateTime>(LAST_SYNC_BOX,
        encryptionCipher: HiveAesCipher(encryptionKey), bytes: bytes);
    await Hive.openBox<HiveCountry>(COUNTRY_BOX,
        encryptionCipher: HiveAesCipher(encryptionKey), bytes: bytes);
    await Hive.openBox<HiveLanguage>(LANGUAGE_BOX,
        encryptionCipher: HiveAesCipher(encryptionKey), bytes: bytes);
    await Hive.openBox<HiveGroupUser>(GROUP_USER_BOX,
        encryptionCipher: HiveAesCipher(encryptionKey), bytes: bytes);
    await Hive.openBox<HiveAction>(ACTIONS_BOX,
        encryptionCipher: HiveAesCipher(encryptionKey), bytes: bytes);
    await Hive.openBox<HiveMaterial>(MATERIAL_BOX,
        encryptionCipher: HiveAesCipher(encryptionKey), bytes: bytes);
    await Hive.openBox<HiveMaterialFeedback>(MATERIAL_FEEDBACK_BOX,
        encryptionCipher: HiveAesCipher(encryptionKey), bytes: bytes);
    await Hive.openBox<HiveMaterialTopic>(MATERIAL_TOPIC_BOX,
        encryptionCipher: HiveAesCipher(encryptionKey), bytes: bytes);
    await Hive.openBox<HiveMaterialType>(MATERIAL_TYPE_BOX,
        encryptionCipher: HiveAesCipher(encryptionKey), bytes: bytes);
    await Hive.openBox<HiveGroup>(GROUP_BOX,
        encryptionCipher: HiveAesCipher(encryptionKey), bytes: bytes);
    await Hive.openBox<HiveEvaluationCategory>(EVALUATION_CATEGORIES_BOX,
        encryptionCipher: HiveAesCipher(encryptionKey), bytes: bytes);
    await Hive.openBox<HiveActionUser>(ACTION_USER_BOX,
        encryptionCipher: HiveAesCipher(encryptionKey), bytes: bytes);
    await Hive.openBox<HiveUser>(USER_BOX,
        encryptionCipher: HiveAesCipher(encryptionKey), bytes: bytes);
    await Hive.openBox<HiveFile>(FILE_BOX,
        encryptionCipher: HiveAesCipher(encryptionKey), bytes: bytes);
    await Hive.openBox<HiveLearnerEvaluation>(LEARNER_EVALUATION_BOX,
        encryptionCipher: HiveAesCipher(encryptionKey), bytes: bytes);
    await Hive.openBox<HiveTeacherResponse>(TEACHER_RESPONSE_BOX,
        encryptionCipher: HiveAesCipher(encryptionKey), bytes: bytes);
    await Hive.openBox<HiveGroupEvaluation>(GROUP_EVALUATION_BOX,
        encryptionCipher: HiveAesCipher(encryptionKey), bytes: bytes);
    await Hive.openBox<HiveTransformation>(TRANSFORMATION_BOX,
        encryptionCipher: HiveAesCipher(encryptionKey), bytes: bytes);
    await Hive.openBox<HiveOutput>(OUTPUT_BOX,
        encryptionCipher: HiveAesCipher(encryptionKey), bytes: bytes);
  }

  Box<HiveLastSyncDateTime> get lastSync;
  Box<HiveCountry> get country;
  Box<HiveLanguage> get language;
  Box<HiveGroupUser> get groupUser;
  Box<HiveAction> get action;
  Box<HiveMaterial> get material;
  Box<HiveMaterialFeedback> get materialFeedback;
  Box<HiveMaterialTopic> get materialTopic;
  Box<HiveMaterialType> get materialType;
  Box<HiveGroup> get group;
  Box<HiveEvaluationCategory> get evaluationCategory;
  Box<HiveUser> get user;
  Box<HiveFile> get file;
  Box<HiveActionUser> get actionUser;
  Box<HiveLearnerEvaluation> get learnerEvaluation;
  Box<HiveTeacherResponse> get teacherResponse;
  Box<HiveGroupEvaluation> get groupEvaluation;
  Box<HiveTransformation> get transformation;
  Box<HiveOutput> get output;
}

/// Global constant to access HiveApi.
const HiveApiInterface globalHiveApi = HiveApiImpl();
