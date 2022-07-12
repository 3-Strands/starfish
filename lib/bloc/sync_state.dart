part of 'sync_bloc.dart';

@immutable
class SyncState {
  SyncState({
    this.isSyncing = false,
    this.lastSync = const Option.none(),
  });

  final bool isSyncing;
  final Option<HiveLastSyncDateTime> lastSync;

  copyWith({
    bool? isSyncing,
    Option<HiveLastSyncDateTime>? lastSync,
  }) => SyncState(
    isSyncing: isSyncing ?? this.isSyncing,
    lastSync: lastSync ?? this.lastSync,
  );
}
