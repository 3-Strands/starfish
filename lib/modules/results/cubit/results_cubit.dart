import 'dart:async';

import 'package:collection/collection.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:starfish/enums/user_group_role_filter.dart';
import 'package:starfish/repositories/data_repository.dart';
import 'package:starfish/src/generated/google/type/date.pb.dart';
import 'package:starfish/src/grpc_extensions.dart';

part 'results_state.dart';

class ResultsCubit extends Cubit<ResultsState> {
  ResultsCubit(DataRepository dataRepository)
      : _dataRepository = dataRepository,
        super(ResultsState(
          groups: dataRepository.currentGroups,
          currentUser: dataRepository.currentUser,
          filterGroup: dataRepository.currentGroups.first,
          relatedTransformation: dataRepository
              .getTransformationRelatedToUser(dataRepository.currentUser.id),
          month: Date(
              year: DateTime.now().year, month: DateTime.now().month, day: 0),
        )) {
    _subscription = dataRepository.groups.listen((groups) {
      emit(state.copyWith(
        groups: groups,
      ));
    });
    _transfomrmationSubscription =
        dataRepository.transformations.listen((transformations) {
      emit(state.copyWith(
        relatedTransformation: dataRepository
            .getTransformationRelatedToUser(dataRepository.currentUser.id),
      ));
    });
  }

  late StreamSubscription<List<Group>> _subscription;
  late StreamSubscription<List<Transformation>> _transfomrmationSubscription;
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
    _subscription.cancel();
    _transfomrmationSubscription.cancel();
    return super.close();
  }
}
