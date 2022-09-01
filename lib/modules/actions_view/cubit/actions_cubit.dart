import 'dart:async';
import 'dart:collection';

import 'package:bloc/bloc.dart';
import 'package:jiffy/jiffy.dart';
import 'package:meta/meta.dart';
import 'package:starfish/enums/action_filter.dart';
import 'package:starfish/enums/action_status.dart';
import 'package:starfish/repositories/data_repository.dart';
import 'package:starfish/repositories/model_wrappers/action_with_assigned_status.dart';
import 'package:starfish/src/deltas.dart';
import 'package:starfish/src/grpc_extensions.dart';

part 'actions_state.dart';

class ActionsCubit extends Cubit<ActionsState> {
  ActionsCubit(DataRepository dataRepository)
      : _dataRepository = dataRepository,
        super(ActionsState(
          actions: dataRepository.currentActions,
          relatedActions: dataRepository.getActionsRelatedToMe(),
        )) {
    _subscription = [
      dataRepository.actions.listen((actions) {
        emit(state.copyWith(
          actions: actions,
          relatedActions: dataRepository.getActionsRelatedToMe(),
        ));
      }),
      dataRepository.users.listen((users) {
        emit(state.copyWith(
          relatedActions: dataRepository.getActionsRelatedToMe(),
        ));
      }),
    ];
  }

  late List<StreamSubscription> _subscription;
  final DataRepository _dataRepository;

  void updateActionFilter(ActionFilter actionFilter) {
    emit(state.copyWith(
      actionFilter: actionFilter,
    ));
  }

  void updateQuery(String query) {
    emit(state.copyWith(
      query: query,
    ));
  }

  void deleteAction(Action action) {
    _dataRepository.addDelta(ActionDeleteDelta(action));
  }

  @override
  Future<void> close() {
    _subscription.forEach((subscription) => subscription.cancel());
    return super.close();
  }
}
