import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:starfish/enums/user_group_role_filter.dart';
import 'package:starfish/repositories/data_repository.dart';
import 'package:starfish/src/deltas.dart';
import 'package:starfish/src/grpc_extensions.dart';

part 'groups_state.dart';

class GroupsCubit extends Cubit<GroupsState> {
  GroupsCubit(DataRepository dataRepository)
      : _dataRepository = dataRepository,
        super(GroupsState(
          groups: dataRepository.currentGroups,
          // relatedMaterials: dataRepository.getMaterialsRelatedToMe(),
        )) {
    _subscription = dataRepository.groups.listen((groups) {
      emit(state.copyWith(
        groups: groups,
        // relatedMaterials: dataRepository.getMaterialsRelatedToMe(),
      ));
    });
  }

  final DataRepository _dataRepository;
  late StreamSubscription<List<Group>> _subscription;

  void userRoleFilterChanged(UserGroupRoleFilter userRoleFilter) {
    emit(state.copyWith(
      userRoleFilter: userRoleFilter,
    ));
  }

  void queryChanged(String query) {
    emit(state.copyWith(
      query: query,
    ));
  }

  void leaveGroupRequested(Group group) {
    // TODO: delete group_user;
    // _dataRepository.addDelta(GroupUserDeleteDelta(

    // ));
  }

  void groupDeleted(Group group) {
    _dataRepository
        .addDelta(GroupUpdateDelta(group, status: Group_Status.INACTIVE));
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
