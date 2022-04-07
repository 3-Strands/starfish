import 'package:hive/hive.dart';
import 'package:collection/collection.dart';
import 'package:starfish/db/hive_database.dart';
import 'package:starfish/db/hive_group_evaluation.dart';
import 'package:starfish/db/hive_learner_evaluation.dart';
import 'package:starfish/db/hive_teacher_response.dart';
import 'package:starfish/db/hive_transformation.dart';

class ResultsProvider {
  late Box<HiveLearnerEvaluation> _learnerEvaluationBox;
  late Box<HiveGroupEvaluation> _groupEvaluationBox;
  late Box<HiveTransformation> _transfomationBox;
  late Box<HiveTeacherResponse> _teacherResponseBox;

  ResultsProvider() {
    _learnerEvaluationBox =
        Hive.box<HiveLearnerEvaluation>(HiveDatabase.LEARNER_EVALUATION_BOX);
    _groupEvaluationBox =
        Hive.box<HiveGroupEvaluation>(HiveDatabase.GROUP_EVALUATION_BOX);
    _transfomationBox =
        Hive.box<HiveTransformation>(HiveDatabase.TRANSFORMATION_BOX);
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

  Future<void> createUpdateGroupEvaluation(
      HiveGroupEvaluation groupEvaluation) async {
    int _currentIndex = -1;
    _groupEvaluationBox.values
        .toList()
        .asMap()
        .forEach((key, hiveGroupEvaluation) {
      if (hiveGroupEvaluation.id == groupEvaluation.id) {
        _currentIndex = key;
      }
    });

    if (_currentIndex > -1) {
      return _groupEvaluationBox.putAt(_currentIndex, groupEvaluation);
    } else {
      _groupEvaluationBox.add(groupEvaluation);
    }
  }

  Future<void> createUpdateTransformation(
      HiveTransformation transformation) async {
    int _currentIndex = -1;
    _transfomationBox.values
        .toList()
        .asMap()
        .forEach((key, hiveTransformation) {
      if (hiveTransformation.id == transformation.id) {
        _currentIndex = key;
      }
    });

    if (_currentIndex > -1) {
      return _transfomationBox.putAt(_currentIndex, transformation);
    } else {
      _transfomationBox.add(transformation);
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

  List<HiveLearnerEvaluation> getGroupLearnerEvaluations(String groupId) {
    return _learnerEvaluationBox.values
        .where((element) => element.groupId! == groupId)
        .toList();
  }
}
