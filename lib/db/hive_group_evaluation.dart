import 'package:hive/hive.dart';
import 'package:starfish/db/hive_date.dart';
import 'package:starfish/src/generated/starfish.pb.dart';

part 'hive_group_evaluation.g.dart';

@HiveType(typeId: 20)
class HiveGroupEvaluation extends HiveObject {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? userId;
  @HiveField(2)
  String? groupId;
  @HiveField(3)
  HiveDate? month;
  @HiveField(4)
  int? evaluation;
  @HiveField(5)
  bool isNew = false;
  @HiveField(6)
  bool isUpdated = false;
  @HiveField(7)
  bool isDirty = false;

  HiveGroupEvaluation({
    this.id,
    this.userId,
    this.groupId,
    this.month,
    this.evaluation,
  });

  HiveGroupEvaluation.from(GroupEvaluation groupEvaluation) {
    this.id = groupEvaluation.id;
    this.userId = groupEvaluation.userId;
    this.groupId = groupEvaluation.groupId;
    this.month = HiveDate.from(groupEvaluation.month);
    this.evaluation = groupEvaluation.evaluation.value;
  }

  GroupEvaluation toGroupEvaluation() {
    return GroupEvaluation(
      id: this.id,
      userId: this.userId,
      groupId: this.groupId,
      month: this.month?.toDate(),
      evaluation: this.evaluation != null
          ? GroupEvaluation_Evaluation.valueOf(this.evaluation!)
          : GroupEvaluation_Evaluation.EVAL_UNSPECIFIED,
    );
  }

  @override
  String toString() {
    return super.toString();
  }
}
