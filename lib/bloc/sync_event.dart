part of 'sync_bloc.dart';

@immutable
abstract class SyncEvent {
  const SyncEvent();
}

class SyncInitiated extends SyncEvent {
  const SyncInitiated();
}

class SyncCompleted extends SyncEvent {
  const SyncCompleted();
}

class CountriesAndLanguagesRequested extends SyncEvent {
  const CountriesAndLanguagesRequested();
}

class SyncAll extends SyncEvent {
  const SyncAll();
}

class SyncToRemote extends SyncEvent {
  const SyncToRemote();
}

class ScheduleSyncToRemote extends SyncEvent {
  const ScheduleSyncToRemote();
}
