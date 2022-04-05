import 'package:hive/hive.dart';
import 'package:starfish/db/hive_database.dart';
import 'package:starfish/db/hive_learner_evaluation.dart';
import 'package:starfish/db/hive_teacher_response.dart';

class ResultsProvider {
  late Box<HiveLearnerEvaluation> _learnerEvaluationBox;
  late Box<HiveTeacherResponse> _teacherResponseBox;

  ResultsProvider() {
    _learnerEvaluationBox =
        Hive.box<HiveLearnerEvaluation>(HiveDatabase.LEARNER_EVALUATION_BOX);
    _teacherResponseBox =
        Hive.box<HiveTeacherResponse>(HiveDatabase.TEACHER_RESPONSE_BOX);
  }

  Future<void> createUpdateLearnerEvaluation(
      HiveLearnerEvaluation learnerEvaluation) async {
    int _currentIndex = -1;
    _learnerEvaluationBox.values
        .toList()
        .asMap()
        .forEach((key, hiveLearnerEvaluation) {
      if (hiveLearnerEvaluation.id == learnerEvaluation.id) {
        _currentIndex = key;
      }
    });

    if (_currentIndex > -1) {
      return _learnerEvaluationBox.putAt(_currentIndex, learnerEvaluation);
    } else {
      _learnerEvaluationBox.add(learnerEvaluation);
    }
  }

  Future<void> createUpdateTeacherResponse(
      HiveTeacherResponse teacherResponse) async {
    int _currentIndex = -1;
    _teacherResponseBox.values
        .toList()
        .asMap()
        .forEach((key, hiveTeacherREsponse) {
      if (hiveTeacherREsponse.id == teacherResponse.id) {
        _currentIndex = key;
      }
    });

    if (_currentIndex > -1) {
      return _teacherResponseBox.putAt(_currentIndex, teacherResponse);
    } else {
      _teacherResponseBox.add(teacherResponse);
    }
  }
}
