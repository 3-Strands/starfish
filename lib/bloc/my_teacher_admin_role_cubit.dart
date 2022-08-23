import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:starfish/repositories/data_repository.dart';
import 'package:starfish/src/grpc_extensions.dart';

part 'my_teacher_admin_role_state.dart';

class MyTeacherAdminRoleCubit extends Cubit<MyTeacherAdminRoleState> {
  MyTeacherAdminRoleCubit(DataRepository dataRepository)
      : _dataRepository = dataRepository,
        super(MyTeacherAdminRoleState(
          groupsWhereIAmAdmin: dataRepository.currentUser.adminGroups,
          groupsWhereIAmTeacher: dataRepository.currentUser.teacherGroups,
        )) {
    _subscription = _dataRepository.groups.listen((groups) {
      emit(state.copyWith(
          groupsWhereIAmAdmin: _dataRepository.currentUser.adminGroups,
          groupsWhereIAmTeacher: _dataRepository.currentUser.teacherGroups));
    });
  }

  late StreamSubscription<List<Group>> _subscription;
  final DataRepository _dataRepository;

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
