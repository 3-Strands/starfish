// import 'package:hive/hive.dart';
// import 'package:starfish/db/hive_database.dart';
// import 'package:starfish/db/hive_learner_evaluation.dart';

// class LearnerEvaluationProvider {
//   late Box<HiveLearnerEvaluation> _learnerEvaluationBox;

//   LearnerEvaluationProvider() {
//     _learnerEvaluationBox =
//         Hive.box<HiveLearnerEvaluation>(HiveDatabase.LEARNER_EVALUATION_BOX);
//   }

//   List<HiveLearnerEvaluation> getGroupUserLearnerEvaluations(
//       String userId, String groupId) {
//     return _learnerEvaluationBox.values
//         .where((element) =>
//             element.learnerId! == userId && element.groupId! == groupId)
//         .toList();
//   }

//   List<HiveLearnerEvaluation> getGroupLearnerEvaluations(String groupId) {
//     return _learnerEvaluationBox.values
//         .where((element) => element.groupId! == groupId)
//         .toList();
//   }

//   Future<void> createUpdateLearnerEvaluation(
//       HiveLearnerEvaluation _evaluation) async {
//     int _currentIndex = -1;
//     _learnerEvaluationBox.values.toList().asMap().forEach((key, eval) {
//       if (eval.id == _evaluation.id) {
//         _currentIndex = key;
//       }
//     });

//     if (_currentIndex > -1) {
//       return _learnerEvaluationBox.putAt(_currentIndex, _evaluation);
//     } else {
//       _learnerEvaluationBox.add(_evaluation);
//     }
//   }
// }
