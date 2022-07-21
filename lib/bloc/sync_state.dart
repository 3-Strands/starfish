part of 'sync_bloc.dart';

@immutable
class SyncState {
  SyncState({
    this.isSyncing = false,
    this.lastSync = const Option.none(),
  });

  final bool isSyncing;
  final Option<DateTime> lastSync;

  copyWith({
    bool? isSyncing,
    Option<DateTime>? lastSync,
  }) => SyncState(
    isSyncing: isSyncing ?? this.isSyncing,
    lastSync: lastSync ?? this.lastSync,
  );
}
