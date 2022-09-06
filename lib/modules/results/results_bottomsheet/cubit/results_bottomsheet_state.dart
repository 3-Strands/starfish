part of 'results_bottomsheet_cubit.dart';

@immutable
class ResultsBottomsheetState {
  ResultsBottomsheetState({
    required this.group,
    required this.learner,
    required this.month,
    required this.evaluations,
    required this.teacherResponse,
  });

  final Group group;
  final Date month;
  final User learner;
  final _CurrentAndPreviousResults evaluations;
  final TeacherResponse? teacherResponse;

  bool isDifferentSnapshotFrom(ResultsBottomsheetState other) =>
      month != other.month || learner != other.learner;

  ResultsBottomsheetState copyWith({
    User? learner,
    Date? month,
    _CurrentAndPreviousResults? evaluations,
    Option<TeacherResponse>? teacherResponse,
  }) =>
      ResultsBottomsheetState(
        group: group,
        learner: learner ?? this.learner,
        month: month ?? this.month,
        evaluations: evaluations ?? this.evaluations,
        teacherResponse: teacherResponse == null ? this.teacherResponse : teacherResponse.value,
      );
}
