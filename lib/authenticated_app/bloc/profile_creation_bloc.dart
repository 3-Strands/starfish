import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'profile_creation_event.dart';
part 'profile_creation_state.dart';

class ProfileCreationBloc extends Bloc<ProfileCreationEvent, ProfileCreationState> {
  ProfileCreationBloc(ProfileCreationState initialState) : super(initialState) {
    on<ProfileSetupCompleted>((event, emit) {
      emit(const ProfileReady(cameFromSetup: true));
    });
  }
}
