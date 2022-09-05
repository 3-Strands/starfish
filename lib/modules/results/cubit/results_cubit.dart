import 'dart:async';

import 'package:collection/collection.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:starfish/apis/hive_api.dart';
import 'package:starfish/enums/action_status.dart';
import 'package:starfish/enums/user_group_role_filter.dart';
import 'package:starfish/repositories/data_repository.dart';
import 'package:starfish/src/grpc_extensions.dart';

part 'results_state.dart';

class ResultsCubit extends Cubit<ResultsState> {
  ResultsCubit(DataRepository dataRepository)
      : _dataRepository = dataRepository,
        super(ResultsState(
          groups: dataRepository.currentGroups,
          groupsWithAdminRole: dataRepository.groupsWithAdminRole,
          actions: dataRepository.currentActions,
          evaluationCategories: dataRepository.currentEvaluationCategories,
          teacherResponses: dataRepository.currentTeacherResponses,
          learnerEvaluations: dataRepository.currentLearnerEvaluations,
          groupEvaluations: dataRepository.currentGroupEvaluations,
          currentUser: dataRepository.currentUser,
          filterGroup: dataRepository.groupsWithAdminRole.length > 0
              ? dataRepository.groupsWithAdminRole.first
              : null,
          relatedTransformation: dataRepository
              .getTransformationRelatedToUser(dataRepository.currentUser.id),
          month: Date(year: DateTime.now().year, month: DateTime.now().month),
        )) {
    _subscriptions = [
      dataRepository.groups.listen((groups) {
        emit(state.copyWith(
          groups: groups,
          groupsWithAdminRole: dataRepository.groupsWithAdminRole,
        ));
      }),
      dataRepository.users.listen((users) {
        emit(state.copyWith(
          relatedTransformation: _dataRepository
              .getTransformationRelatedToUser(dataRepository.currentUser.id),
        ));
      }),
      dataRepository.actions.listen((actions) {
        emit(state.copyWith(
          actions: actions,
          relatedTransformation: _dataRepository
              .getTransformationRelatedToUser(dataRepository.currentUser.id),
        ));
      }),
      dataRepository.evaluationCategories.listen((evaluationCategories) {
        emit(state.copyWith(
          evaluationCategories: evaluationCategories,
        ));
      }),
      dataRepository.transformations.listen((transformations) {
        emit(state.copyWith(
          relatedTransformation: dataRepository
              .getTransformationRelatedToUser(dataRepository.currentUser.id),
        ));
      }),
      dataRepository.teacherResponses.listen((teacherResponses) {
        emit(state.copyWith(
          teacherResponses: dataRepository.currentTeacherResponses,
        ));
      }),
      dataRepository.groupEvaluations.listen((groupEvaluations) {
        emit(state.copyWith(
          groupEvaluations: dataRepository.currentGroupEvaluations,
        ));
      }),
      dataRepository.learnerEvaluations.listen((learnerEvaluations) {
        emit(state.copyWith(
          learnerEvaluations: dataRepository.currentLearnerEvaluations,
        ));
      }),
    ];
  }

  late List<StreamSubscription> _subscriptions;
  final DataRepository _dataRepository;

  void updateMonthFilter(Date month) {
    emit(state.copyWith(
      month: month,
    ));
  }

  void updateGroupFilter(Group group) {
    emit(state.copyWith(
      filterGroup: group,
    ));
  }

  void updateUserRole(UserGroupRoleFilter userRole) {
    emit(state.copyWith(
      userGroupRoleFilter: userRole,
    ));
  }

  void updateTransformation(String impactStory) {
    emit(state.copyWith());
  }

  @override
  Future<void> close() {
    _subscriptions.forEach((subscription) => subscription.cancel());
    return super.close();
  }
}
