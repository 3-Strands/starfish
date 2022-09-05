import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:starfish/repositories/data_repository.dart';
import 'package:starfish/src/grpc_extensions.dart';

part 'group_evaluation_state.dart';

class GroupEvaluationCubit extends Cubit<GroupEvaluationState> {
  GroupEvaluationCubit({
    required DataRepository dataRepository,
    required Date month,
    required GroupUser groupUser,
    GroupEvaluation? groupEvaluation,
  })  : _groupEvaluation = groupEvaluation,
        _dataRepository = dataRepository,
        // _id = groupEvaluation?.id ?? UuidGenerator.uuid(),
        super(GroupEvaluationState(
          groupUser: groupUser,
          month: month,
          evaluation: groupEvaluation?.evaluation ??
              GroupEvaluation_Evaluation.EVAL_UNSPECIFIED,
        )) {
    _subscription = dataRepository.groups.listen((groups) {});
  }

  late StreamSubscription<List<Group>> _subscription;

  final DataRepository _dataRepository;
  final GroupEvaluation? _groupEvaluation;
  // final String _id;

  void updateGroupEvaluation(GroupEvaluation_Evaluation evaluation) {
    emit(state.copyWith(evaluation: evaluation));
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
