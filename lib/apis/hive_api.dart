import 'package:hive/hive.dart';
import 'package:starfish/db/hive_action.dart';
import 'package:starfish/db/hive_action_user.dart';
import 'package:starfish/db/hive_country.dart';
import 'package:starfish/db/hive_database.dart';
import 'package:starfish/db/hive_evaluation_category.dart';
import 'package:starfish/db/hive_file.dart';
import 'package:starfish/db/hive_group.dart';
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
import 'package:starfish/db/hive_syncable.dart';
import 'package:starfish/db/hive_teacher_response.dart';
import 'package:starfish/db/hive_transformation.dart';
import 'package:starfish/db/hive_user.dart';

class HiveApi {
  HiveApi._();

  static HiveApi? _instance;

  factory HiveApi() {
    return _instance ??= HiveApi._();
  }

  Box<HiveLastSyncDateTime> lastSync = Hive.box<HiveLastSyncDateTime>(HiveDatabase.LAST_SYNC_BOX);
  Box<HiveCountry> country = Hive.box<HiveCountry>(HiveDatabase.COUNTRY_BOX);
  Box<HiveLanguage> language = Hive.box<HiveLanguage>(HiveDatabase.LANGUAGE_BOX);
  Box<HiveGroupUser> groupUser = Hive.box<HiveGroupUser>(HiveDatabase.GROUP_USER_BOX);
  Box<HiveAction> action = Hive.box<HiveAction>(HiveDatabase.ACTIONS_BOX);
  Box<HiveMaterial> material = Hive.box<HiveMaterial>(HiveDatabase.MATERIAL_BOX);
  Box<HiveMaterialFeedback> materialFeedback = Hive.box<HiveMaterialFeedback>(HiveDatabase.MATERIAL_FEEDBACK_BOX);
  Box<HiveMaterialTopic> materialTopic = Hive.box<HiveMaterialTopic>(HiveDatabase.MATERIAL_TOPIC_BOX);
  Box<HiveMaterialType> materialType = Hive.box<HiveMaterialType>(HiveDatabase.MATERIAL_TYPE_BOX);
  Box<HiveGroup> group = Hive.box<HiveGroup>(HiveDatabase.GROUP_BOX);
  Box<HiveEvaluationCategory> evaluationCategory = Hive.box<HiveEvaluationCategory>(
        HiveDatabase.EVALUATION_CATEGORIES_BOX);
  Box<HiveUser> user = Hive.box<HiveUser>(HiveDatabase.USER_BOX);
  Box<HiveFile> file = Hive.box<HiveFile>(HiveDatabase.FILE_BOX);
  Box<HiveActionUser> actionUser = Hive.box<HiveActionUser>(HiveDatabase.ACTION_USER_BOX);
  Box<HiveLearnerEvaluation> learnerEvaluation = Hive.box<HiveLearnerEvaluation>(HiveDatabase.LEARNER_EVALUATION_BOX);
  Box<HiveTeacherResponse> teacherResponse = Hive.box<HiveTeacherResponse>(HiveDatabase.TEACHER_RESPONSE_BOX);
  Box<HiveGroupEvaluation> groupEvaluation = Hive.box<HiveGroupEvaluation>(HiveDatabase.GROUP_EVALUATION_BOX);
  Box<HiveTransformation> transformation = Hive.box<HiveTransformation>(HiveDatabase.TRANSFORMATION_BOX);
  Box<HiveOutput> output = Hive.box<HiveOutput>(HiveDatabase.OUTPUT_BOX);

  Future<void> updateMaterial(HiveMaterial material) async {
    // TODO: files
    await _updateMatchingRecord(this.material, material);
  }

  Future<void> _updateMatchingRecord<T extends HiveSyncable>(Box<T> box, T item) async {
    int _currentIndex = -1;
    for (final entry in box.values.toList().asMap().entries) {
      if (item.matches(entry.value)) {
        _currentIndex = entry.key;
        break;
      }
    }

    if (_currentIndex > -1) {
      await box.putAt(_currentIndex, item);
    } else {
      await box.add(item);
    }
  }
}
