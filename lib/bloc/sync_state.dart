part of 'sync_bloc.dart';

@immutable
class SyncState {
  SyncState({
    this.isSyncing = false,
  });

  final bool isSyncing;

  copyWith({
    bool? isSyncing,
  }) =>
      SyncState(
        isSyncing: isSyncing ?? this.isSyncing,
      );
}
