import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:meta/meta.dart';
import 'package:starfish/apis/hive_api.dart';
import 'package:starfish/repositories/data_repository.dart';
import 'package:starfish/src/deltas.dart';
import 'package:starfish/src/grpc_extensions.dart';

part 'results_bottomsheet_state.dart';

class ResultsBottomsheetCubit extends Cubit<ResultsBottomsheetState> {
  ResultsBottomsheetCubit({
    required this.group,
    required User initialLearner,
    required Date initialMonth,
    required DataRepository dataRepository,
    GroupEvaluation? leanerEvaluationForGroup,
  })  : _dataRepository = dataRepository,
        super(ResultsBottomsheetState(
          group: group,
          learner: initialLearner,
          month: initialMonth,
        ));

  final DataRepository _dataRepository;
  final Group group;

  void learnerChanged(User learner) {
    emit(state.copyWith(learner: learner));
  }

  void monthChanged(Date month) {
    emit(state.copyWith(month: month));
  }

  void teacherResponseChanged(String value) {
    final teacherResponse = state.teacherResponse;
    if (value.isEmpty && teacherResponse == null) {
      return;
    }
    _dataRepository.addDelta(
      teacherResponse == null
          ? TeacherResponseCreateDelta(
              groupId: state.group.id,
              learnerId: state.learner.id,
              teacherId: _dataRepository.currentUser.id,
              month: state.month,
            )
          : TeacherResponseUpdateDelta(
              teacherResponse,
              response: value,
            ),
    );
    // Since the teacher feedback is calculated lazily in the state,
    // we just update the state to force the feedback to recalculate.
    emit(state.copyWith());
  }
}
