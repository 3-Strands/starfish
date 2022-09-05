part of 'group_evaluation_cubit.dart';

@immutable
class GroupEvaluationState {
  const GroupEvaluationState({
    required this.groupUser,
    required this.month,
    required this.evaluation,
  });

  final GroupUser groupUser;
  final Date month;
  final GroupEvaluation_Evaluation evaluation;

  GroupEvaluationState copyWith({
    GroupUser? groupUser,
    Date? month,
    GroupEvaluation_Evaluation? evaluation,
  }) =>
      GroupEvaluationState(
        groupUser: groupUser ?? this.groupUser,
        month: month ?? this.month,
        evaluation: evaluation ?? this.evaluation,
      );
}
