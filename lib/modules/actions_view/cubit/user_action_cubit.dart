import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:starfish/enums/action_status.dart';
import 'package:starfish/repositories/data_repository.dart';
import 'package:starfish/src/deltas.dart';
import 'package:starfish/src/grpc_extensions.dart';

part 'user_action_state.dart';

class UserActionCubit extends Cubit<UserActionState> {
  UserActionCubit({
    required DataRepository dataRepository,
    required Action action,
    required User user,
    required ActionStatus actionStatus,
    ActionUser? actionUser,
  })  : _action = action,
        _user = user,
        _actionUser = actionUser,
        _dataRepository = dataRepository,
        super(UserActionState(
          action: action,
          user: user,
          status: actionStatus == ActionStatus.DONE
              ? ActionUser_Status.COMPLETE
              : ActionUser_Status.INCOMPLETE,
          evaluation: actionUser?.evaluation ??
              ActionUser_Evaluation.UNSPECIFIED_EVALUATION,
          teacherResponse: actionUser?.teacherResponse ?? '',
          userResponse: actionUser?.userResponse ?? '',
        )) {
    _subscriptions = [];
  }

  late List<StreamSubscription> _subscriptions;
  final DataRepository _dataRepository;
  final Action _action;
  final User _user;
  final ActionUser? _actionUser;

  void submitUserActonStatus(ActionUser_Status actionUserStatus) {
    _dataRepository.addDelta(
      _actionUser == null
          ? ActionUserCreateDelta(
              userId: _user.id,
              actionId: _action.id,
              status: actionUserStatus,
            )
          : ActionUserUpdateDelta(
              _actionUser!,
              status: actionUserStatus,
            ),
    );
    emit(state.copywith(status: actionUserStatus));
  }

  // void submitUserActonEvaluation(
  //     String userId, ActionUser_Evaluation actionUserEvaluation) {
  //   _dataRepository.addDelta(
  //     _actionUser == null
  //         ? ActionUserCreateDelta(
  //             actionId: _action.id,
  //             userId: userId,
  //             evaluation: actionUserEvaluation,
  //           )
  //         : ActionUserUpdateDelta(
  //             _actionUser!,
  //             evaluation: actionUserEvaluation,
  //           ),
  //   );
  // }

  void submitUserActonResponse(String response) {
    _dataRepository.addDelta(
      _actionUser == null
          ? ActionUserCreateDelta(
              actionId: _action.id,
              userId: _user.id,
              userResponse: response,
            )
          : ActionUserUpdateDelta(
              _actionUser!,
              userResponse: response,
            ),
    );

    emit(state.copywith(userResponse: response));
  }

  void toggleUserActonEvaluation(ActionUser_Evaluation userEvaluation) {
    _dataRepository.addDelta(
      _actionUser == null
          ? ActionUserCreateDelta(
              actionId: _action.id,
              userId: _user.id,
              evaluation: userEvaluation,
            )
          : ActionUserUpdateDelta(
              _actionUser!,
              evaluation: userEvaluation,
            ),
    );

    emit(state.copywith(evaluation: userEvaluation));
  }

  @override
  Future<void> close() {
    _subscriptions.forEach((subscription) => subscription.cancel());
    return super.close();
  }
}
