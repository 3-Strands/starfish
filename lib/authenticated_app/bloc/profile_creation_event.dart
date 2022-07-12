part of 'profile_creation_bloc.dart';

@immutable
abstract class ProfileCreationEvent {
  const ProfileCreationEvent();
}

class ProfileSetupCompleted extends ProfileCreationEvent {
  const ProfileSetupCompleted();
}
