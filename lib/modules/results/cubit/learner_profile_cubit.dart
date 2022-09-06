import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:starfish/repositories/data_repository.dart';
import 'package:starfish/src/deltas.dart';
import 'package:starfish/src/grpc_extensions.dart';

part 'learner_profile_state.dart';

class LearnerProfileCubit extends Cubit<LearnerProfileState> {
  LearnerProfileCubit({
    required DataRepository dataRepository,
    required GroupUser groupUser,
  })  : _dataRepository = dataRepository,
        _groupUser = groupUser,
        super(LearnerProfileState(
          groupUser: groupUser,
          profile: groupUser.profile,
        )) {
    _subscription = dataRepository.groups.listen((groups) {});
  }

  late StreamSubscription<List<Group>> _subscription;

  final DataRepository _dataRepository;
  final GroupUser _groupUser;

  void updateProfile(String value) {
    emit(state.copyWith(profile: value));
  }

  void saveProfile() {
    _dataRepository.addDelta(GroupUserUpdateDelta(
      _groupUser,
      profile: state.profile,
    ));
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
