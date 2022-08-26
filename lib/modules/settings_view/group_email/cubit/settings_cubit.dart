import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:starfish/repositories/data_repository.dart';
import 'package:starfish/src/deltas.dart';
import 'package:starfish/src/grpc_extensions.dart';
import 'package:starfish/utils/helpers/extensions/strings.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit({
    required DataRepository dataRepository,
    required Group group,
  })  : _dataRepository = dataRepository,
        _group = group,
        super(SettingsState(
          group: group,
          email: group.linkEmail,
        )) {
    _subscription = _dataRepository.groups.listen((groups) {
      // emit(state.copyWith(
      //     groupsWhereIAmAdmin: _dataRepository.currentUser.adminGroups,
      //     groupsWhereIAmTeacher: _dataRepository.currentUser.teacherGroups));
    });
  }

  late StreamSubscription<List<Group>> _subscription;
  final DataRepository _dataRepository;
  final Group _group;

  void emailChanged(String email) {
    emit(state.copyWith(email: email));
  }

  void confirmEmailChanged(String email) {
    emit(state.copyWith(confirmEmail: email));
  }

  // returns 'true' if update is successful, otherwise 'false'
  bool updateEmail() {
    SettingsEmailError? error;

    if (state.email == null || state.email!.isEmpty) {
      error = SettingsEmailError.emptyEmail;
    } else if (state.email != null && !state.email!.isValidEmail()) {
      error = SettingsEmailError.invalidEmailFormat;
    } else if (state.confirmEmail == null || state.confirmEmail!.isEmpty) {
      error = SettingsEmailError.emptyEmail;
    } else if (state.confirmEmail != null &&
        !state.confirmEmail!.isValidEmail()) {
      error = SettingsEmailError.invalidEmailFormat;
    } else if (state.email != state.confirmEmail) {
      error = SettingsEmailError.emailMismatch;
    }

    if (error != null) {
      emit(state.copyWith(error: error));
      return false;
    } else {
      _dataRepository.addDelta(GroupUpdateDelta(
        _group,
        linkEmail: state.email,
      ));
      return true;
    }
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
