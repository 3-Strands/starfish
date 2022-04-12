import 'package:hive/hive.dart';
import 'package:starfish/db/hive_database.dart';
import 'package:starfish/db/hive_group_evaluation.dart';

class GroupEvaluationProvider {
  late Box<HiveGroupEvaluation> _groupEvaluationBox;

  GroupEvaluationProvider() {
    _groupEvaluationBox =
        Hive.box<HiveGroupEvaluation>(HiveDatabase.GROUP_EVALUATION_BOX);
  }

  List<HiveGroupEvaluation> getGroupUserGroupEvaluation(
      String userId, String groupId) {
    return _groupEvaluationBox.values
        .where((element) =>
            element.userId! == userId && element.groupId! == groupId)
        .toList();
  }

  Future<void> createUpdateGroupEvaluation(
      HiveGroupEvaluation _groupEvaluation) async {
    int _currentIndex = -1;
    _groupEvaluationBox.values.toList().asMap().forEach((key, evaluation) {
      if (evaluation.id == _groupEvaluation.id) {
        _currentIndex = key;
      }
    });

    if (_currentIndex > -1) {
      return _groupEvaluationBox.putAt(_currentIndex, _groupEvaluation);
    } else {
      _groupEvaluationBox.add(_groupEvaluation);
    }
  }
}
