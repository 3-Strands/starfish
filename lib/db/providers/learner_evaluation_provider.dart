import 'package:hive/hive.dart';
import 'package:starfish/db/hive_database.dart';
import 'package:starfish/db/hive_learner_evaluation.dart';

class LearnerEvaluationProvider {
  late Box<HiveLearnerEvaluation> _learnerEvaluationBox;

  LearnerEvaluationProvider() {
    _learnerEvaluationBox =
        Hive.box<HiveLearnerEvaluation>(HiveDatabase.LEARNER_EVALUATION_BOX);
  }

  List<HiveLearnerEvaluation> getGroupUserLearnerEvaluations(
      String userId, String groupId) {
    return _learnerEvaluationBox.values
        .where((element) =>
            element.learnerId! == userId && element.groupId! == groupId)
        .toList();
  }

  List<HiveLearnerEvaluation> getGroupLearnerEvaluations(String groupId) {
    return _learnerEvaluationBox.values
        .where((element) => element.groupId! == groupId)
        .toList();
  }
}
