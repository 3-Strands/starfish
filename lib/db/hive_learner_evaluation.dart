import 'package:hive/hive.dart';
import 'package:starfish/db/hive_date.dart';
import 'package:starfish/db/providers/evaluation_category_provider.dart';
import 'package:starfish/src/generated/starfish.pb.dart';

part 'hive_learner_evaluation.g.dart';

@HiveType(typeId: 18)
class HiveLearnerEvaluation extends HiveObject {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? learnerId;
  @HiveField(2)
  String? evaluatorId;
  @HiveField(3)
  String? groupId;
  @HiveField(4)
  HiveDate? month;
  @HiveField(5)
  String? categoryId;
  @HiveField(6)
  int? evaluation;
  @HiveField(7)
  bool isNew = false;
  @HiveField(8)
  bool isUpdated = false;
  @HiveField(9)
  bool isDirty = false;

  HiveLearnerEvaluation({
    this.id,
    this.learnerId,
    this.evaluatorId,
    this.groupId,
    this.month,
    this.categoryId,
    this.evaluation,
  });

  HiveLearnerEvaluation.from(LearnerEvaluation learnerEvaluation) {
    this.id = learnerEvaluation.id;
    this.learnerId = learnerEvaluation.learnerId;
    this.evaluatorId = learnerEvaluation.evaluatorId;
    this.groupId = learnerEvaluation.groupId;
    this.month = HiveDate.from(learnerEvaluation.month);
    this.categoryId = learnerEvaluation.categoryId;
    this.evaluation = learnerEvaluation.evaluation;
  }

  LearnerEvaluation toLearnerEvaluation() {
    return LearnerEvaluation(
      id: this.id,
      learnerId: this.learnerId,
      evaluatorId: this.evaluatorId,
      groupId: this.groupId,
      month: this.month?.toDate(),
      categoryId: this.categoryId,
      evaluation: this.evaluation,
    );
  }

  @override
  String toString() {
    return '''{id: ${this.id}, learnerId: ${this.learnerId}, evaluatorId: ${this.evaluatorId}, 
        groupId: ${this.groupId}, month: ${this.month.toString()}, categoryId: ${this.categoryId}, 
        evaluation: ${this.evaluation} }''';
  }
}

extension HiveLearnerEvaluationExt on HiveLearnerEvaluation {
  String? get name {
    return EvaluationCategoryProvider().getCategoryById(this.categoryId!)?.name;
  }
}
