part of 'profile_creation_bloc.dart';

@immutable
abstract class ProfileCreationState {
  const ProfileCreationState();
}

class ProfileNeedsSetup extends ProfileCreationState {
  const ProfileNeedsSetup();
}

class ProfileReady extends ProfileCreationState {
  const ProfileReady({this.cameFromSetup = false});

  final bool cameFromSetup;
}
