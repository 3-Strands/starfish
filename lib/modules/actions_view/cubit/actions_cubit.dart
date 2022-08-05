import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:starfish/enums/action_filter.dart';
import 'package:starfish/enums/action_status.dart';
import 'package:starfish/enums/user_group_role_filter.dart';
import 'package:starfish/repositories/data_repository.dart';
import 'package:starfish/repositories/model_wrappers/action_with_assigned_status.dart';
import 'package:starfish/src/grpc_extensions.dart';

part 'actions_state.dart';

class ActionsCubit extends Cubit<ActionsState> {
  ActionsCubit(DataRepository dataRepository)
      : _dataRepository = dataRepository,
        super(ActionsState(
          actions: dataRepository.currentActions,
          relatedActions: dataRepository.getActionsRelatedToMe(),
        )) {
    _subscription = dataRepository.actions.listen((actions) {
      emit(state.copyWith(
        actions: actions,
        relatedActions: dataRepository.getActionsRelatedToMe(),
      ));
    });
  }

  final DataRepository _dataRepository;
  late StreamSubscription<List<Action>> _subscription;

  void loadMore() {
    emit(state.copyWith(
      pagesToShow: state.pagesToShow + 1,
    ));
  }

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

  void updateUserRole(UserGroupRoleFilter userRole) {
    emit(state.copyWith(
      userGroupRoleFilter: userRole,
    ));
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
