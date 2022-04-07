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
}
