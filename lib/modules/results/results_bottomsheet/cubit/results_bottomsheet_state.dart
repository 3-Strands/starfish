part of 'results_bottomsheet_cubit.dart';

@immutable
class ResultsBottomsheetState {
  ResultsBottomsheetState({
    required this.group,
    required this.learner,
    required this.month,
    required this.evaluations,
  }) {
    teacherResponse = globalHiveApi.teacherResponse.values.firstWhereOrNull(
      (response) =>
          response.learnerId == learner.id &&
          response.groupId == group.id &&
          response.month == month,
    );
  }

  final Group group;
  final Date month;
  final User learner;
  final _CurrentAndPreviousResults evaluations;
  late final TeacherResponse? teacherResponse;

  bool isDifferentSnapshotFrom(ResultsBottomsheetState other) =>
      month != other.month || learner != other.learner;

  ResultsBottomsheetState copyWith({
    User? learner,
    Date? month,
    _CurrentAndPreviousResults? evaluations,
  }) =>
      ResultsBottomsheetState(
        group: group,
        learner: learner ?? this.learner,
        month: month ?? this.month,
        evaluations: evaluations ?? this.evaluations,
      );
}
