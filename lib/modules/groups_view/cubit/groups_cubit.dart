import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:starfish/enums/user_group_role_filter.dart';
import 'package:starfish/repositories/data_repository.dart';
import 'package:starfish/repositories/model_wrappers/group_with_actions_and_roles.dart';
import 'package:starfish/src/deltas.dart';
import 'package:starfish/src/grpc_extensions.dart';

part 'groups_state.dart';

class GroupsCubit extends Cubit<GroupsState> {
  GroupsCubit(DataRepository dataRepository)
      : _dataRepository = dataRepository,
        super(GroupsState(
          groups: dataRepository.getGroupsWithActionsAndRoles(),
          // relatedMaterials: dataRepository.getMaterialsRelatedToMe(),
        )) {
    _subscription = dataRepository.groups.listen((_) {
      emit(state.copyWith(
        groups: dataRepository.getGroupsWithActionsAndRoles(),
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
    final myId = _dataRepository.currentUser.id;
    final groupUser =
        group.users.firstWhere((groupUser) => groupUser.userId == myId);
    _dataRepository.addDelta(GroupUserDeleteDelta(groupUser));
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
