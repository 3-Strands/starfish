import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:meta/meta.dart';
import 'package:starfish/apis/hive_api.dart';
import 'package:starfish/repositories/data_repository.dart';
import 'package:starfish/src/deltas.dart';
import 'package:starfish/src/grpc_extensions.dart';
import 'package:starfish/utils/helpers/uuid_generator.dart';

part 'results_bottomsheet_state.dart';

class _CurrentAndPreviousResults {
  final Map<String, LearnerEvaluation> current;
  final Map<String, LearnerEvaluation> previous;

  _CurrentAndPreviousResults(this.current, this.previous);
}

_CurrentAndPreviousResults _calculateResults(
    Date month, String userId, String groupId) {
  final currentResults = <String, LearnerEvaluation>{};
  final previousResults = <String, LearnerEvaluation>{};
  final previousMonth = month.previousMonth;
  for (final learnerEvaluation in globalHiveApi.learnerEvaluation.values) {
    if (learnerEvaluation.learnerId == userId &&
        learnerEvaluation.groupId == groupId) {
      if (learnerEvaluation.month == month) {
        currentResults[learnerEvaluation.categoryId] = learnerEvaluation;
      } else if (learnerEvaluation.month == previousMonth) {
        previousResults[learnerEvaluation.categoryId] = learnerEvaluation;
      }
    }
  }
  return _CurrentAndPreviousResults(currentResults, previousResults);
}

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
          evaluations:
              _calculateResults(initialMonth, initialLearner.id, group.id),
        ));

  final DataRepository _dataRepository;
  final Group group;

  void learnerChanged(User learner) {
    emit(state.copyWith(
      learner: learner,
      evaluations: _calculateResults(state.month, learner.id, group.id),
    ));
  }

  void monthChanged(Date month) {
    emit(state.copyWith(
      month: month,
      evaluations: _calculateResults(month, state.learner.id, group.id),
    ));
  }

  void evaluationCategoryChanged(String categoryId, int value) {
    final learnerEvaluation = state.evaluations.current[categoryId];
    final id = learnerEvaluation?.id ?? UuidGenerator.uuid();
    _dataRepository.addDelta(
      learnerEvaluation == null
          ? LearnerEvaluationCreateDelta(
              id: id,
              categoryId: categoryId,
              evaluation: value,
              evaluatorId: _dataRepository.currentUser.id,
              groupId: state.group.id,
              learnerId: state.learner.id,
              month: state.month,
            )
          : LearnerEvaluationUpdateDelta(
              learnerEvaluation,
              evaluation: value,
            ),
    );
    emit(state.copyWith(
      evaluations: _CurrentAndPreviousResults(
        {
          ...state.evaluations.current,
          categoryId: globalHiveApi.learnerEvaluation.get(id)!,
        },
        state.evaluations.previous,
      ),
    ));
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
