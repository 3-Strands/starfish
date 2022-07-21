part of 'hive_api.dart';

class HiveApiImpl implements HiveApiInterface {
  const HiveApiImpl();

  Box<HiveLastSyncDateTime> get lastSync => Hive.box<HiveLastSyncDateTime>(HiveApiInterface.LAST_SYNC_BOX);
  Box<HiveCountry> get country => Hive.box<HiveCountry>(HiveApiInterface.COUNTRY_BOX);
  Box<HiveLanguage> get language => Hive.box<HiveLanguage>(HiveApiInterface.LANGUAGE_BOX);
  Box<HiveGroupUser> get groupUser => Hive.box<HiveGroupUser>(HiveApiInterface.GROUP_USER_BOX);
  Box<HiveAction> get action => Hive.box<HiveAction>(HiveApiInterface.ACTIONS_BOX);
  Box<HiveMaterial> get material => Hive.box<HiveMaterial>(HiveApiInterface.MATERIAL_BOX);
  Box<HiveMaterialFeedback> get materialFeedback => Hive.box<HiveMaterialFeedback>(HiveApiInterface.MATERIAL_FEEDBACK_BOX);
  Box<HiveMaterialTopic> get materialTopic => Hive.box<HiveMaterialTopic>(HiveApiInterface.MATERIAL_TOPIC_BOX);
  Box<HiveMaterialType> get materialType => Hive.box<HiveMaterialType>(HiveApiInterface.MATERIAL_TYPE_BOX);
  Box<HiveGroup> get group => Hive.box<HiveGroup>(HiveApiInterface.GROUP_BOX);
  Box<HiveEvaluationCategory> get evaluationCategory => Hive.box<HiveEvaluationCategory>(HiveApiInterface.EVALUATION_CATEGORIES_BOX);
  Box<HiveUser> get user => Hive.box<HiveUser>(HiveApiInterface.USER_BOX);
  Box<HiveFile> get file => Hive.box<HiveFile>(HiveApiInterface.FILE_BOX);
  Box<HiveActionUser> get actionUser => Hive.box<HiveActionUser>(HiveApiInterface.ACTION_USER_BOX);
  Box<HiveLearnerEvaluation> get learnerEvaluation => Hive.box<HiveLearnerEvaluation>(HiveApiInterface.LEARNER_EVALUATION_BOX);
  Box<HiveTeacherResponse> get teacherResponse => Hive.box<HiveTeacherResponse>(HiveApiInterface.TEACHER_RESPONSE_BOX);
  Box<HiveGroupEvaluation> get groupEvaluation => Hive.box<HiveGroupEvaluation>(HiveApiInterface.GROUP_EVALUATION_BOX);
  Box<HiveTransformation> get transformation => Hive.box<HiveTransformation>(HiveApiInterface.TRANSFORMATION_BOX);
  Box<HiveOutput> get output => Hive.box<HiveOutput>(HiveApiInterface.OUTPUT_BOX);

  // Future<void> updateMaterial(HiveMaterial material) async {
  //   // TODO: files
  //   await _updateMatchingRecord(this.material, material);
  // }

  // Future<void> _updateMatchingRecord<T extends HiveSyncable>(Box<T> box, T item) async {
  //   int _currentIndex = -1;
  //   for (final entry in box.values.toList().asMap().entries) {
  //     if (item.matches(entry.value)) {
  //       _currentIndex = entry.key;
  //       break;
  //     }
  //   }

  //   if (_currentIndex > -1) {
  //     await box.putAt(_currentIndex, item);
  //   } else {
  //     await box.add(item);
  //   }
  // }
}
