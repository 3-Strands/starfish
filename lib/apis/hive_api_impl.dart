part of 'hive_api.dart';

class HiveApiImpl implements HiveApiInterface {
  const HiveApiImpl();

  // Box<LastSyncDateTime> get lastSync =>
  //     Hive.box<LastSyncDateTime>(HiveApiInterface.LAST_SYNC_BOX);
  Box<Country> get country => Hive.box<Country>(HiveApiInterface.COUNTRY_BOX);
  Box<Language> get language =>
      Hive.box<Language>(HiveApiInterface.LANGUAGE_BOX);
  Box<GroupUser> get groupUser =>
      Hive.box<GroupUser>(HiveApiInterface.GROUP_USER_BOX);
  Box<Action> get action => Hive.box<Action>(HiveApiInterface.ACTIONS_BOX);
  Box<Material> get material =>
      Hive.box<Material>(HiveApiInterface.MATERIAL_BOX);
  Box<MaterialFeedback> get materialFeedback =>
      Hive.box<MaterialFeedback>(HiveApiInterface.MATERIAL_FEEDBACK_BOX);
  Box<MaterialTopic> get materialTopic =>
      Hive.box<MaterialTopic>(HiveApiInterface.MATERIAL_TOPIC_BOX);
  Box<MaterialType> get materialType =>
      Hive.box<MaterialType>(HiveApiInterface.MATERIAL_TYPE_BOX);
  Box<Group> get group => Hive.box<Group>(HiveApiInterface.GROUP_BOX);
  Box<EvaluationCategory> get evaluationCategory =>
      Hive.box<EvaluationCategory>(HiveApiInterface.EVALUATION_CATEGORIES_BOX);
  Box<User> get user => Hive.box<User>(HiveApiInterface.USER_BOX);
  Box<FileReference> get file =>
      Hive.box<FileReference>(HiveApiInterface.FILE_BOX);
  Box<ActionUser> get actionUser =>
      Hive.box<ActionUser>(HiveApiInterface.ACTION_USER_BOX);
  Box<LearnerEvaluation> get learnerEvaluation =>
      Hive.box<LearnerEvaluation>(HiveApiInterface.LEARNER_EVALUATION_BOX);
  Box<TeacherResponse> get teacherResponse =>
      Hive.box<TeacherResponse>(HiveApiInterface.TEACHER_RESPONSE_BOX);
  Box<GroupEvaluation> get groupEvaluation =>
      Hive.box<GroupEvaluation>(HiveApiInterface.GROUP_EVALUATION_BOX);
  Box<Transformation> get transformation =>
      Hive.box<Transformation>(HiveApiInterface.TRANSFORMATION_BOX);
  Box<Output> get output => Hive.box<Output>(HiveApiInterface.OUTPUT_BOX);

  // Future<void> updateMaterial(Material material) async {
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
