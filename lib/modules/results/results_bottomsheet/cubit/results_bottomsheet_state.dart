part of 'results_bottomsheet_cubit.dart';

@immutable
class ResultsBottomsheetState {
  ResultsBottomsheetState({
    required this.group,
    required this.learner,
    required this.month,
  });

  final Group group;
  final Date month;
  final User learner;

  TeacherResponse? _teacherResponse;

  TeacherResponse? get teacherResponse => _teacherResponse ??=
          globalHiveApi.teacherResponse.values.firstWhereOrNull(
        (response) =>
            response.learnerId == learner.id &&
            response.groupId == group.id &&
            response.month == month,
      );

  ResultsBottomsheetState copyWith({
    User? learner,
    Date? month,
  }) =>
      ResultsBottomsheetState(
        group: group,
        learner: learner ?? this.learner,
        month: month ?? this.month,
      );
}
