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

class SyncAllRequested extends SyncEvent {
  const SyncAllRequested();
}
