import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:starfish/repositories/authentication_repository.dart';
import 'package:starfish/repositories/sync_repository.dart';
import 'package:starfish/src/generated/starfish.pbgrpc.dart';
import 'package:starfish/utils/option.dart';
import 'package:starfish/utils/services/grpc_client.dart';

part 'sync_event.dart';
part 'sync_state.dart';

class SyncBloc extends Bloc<SyncEvent, SyncState> {
  SyncBloc({
    SyncRepository? syncRepository,
    required AuthenticationRepository authenticationRepository,
  }) : super(SyncState()) {
    final session = authenticationRepository.currentSession!;

    _syncRepository = syncRepository ??
        SyncRepository(
            client: makeAuthenticatedClient(session.tokens.accessToken),
            // This function will only initiate a refresh request if
            // there is not an existing request pending.
            requestRefresh: () {
              Future<StarfishClient>? pendingRefresh;
              return () {
                pendingRefresh ??=
                    authenticationRepository.refreshSession().then((session) {
                  pendingRefresh = null;
                  return makeAuthenticatedClient(session.tokens.accessToken);
                });
                return pendingRefresh!;
              };
            }());

    on<SyncInitiated>((event, emit) {
      emit(state.copyWith(isSyncing: true));
    });
    on<SyncCompleted>((event, emit) {
      emit(state.copyWith(
          isSyncing: false, lastSync: Option.some(DateTime.now())));
    });

    on<CountriesAndLanguagesRequested>((event, emit) async {
      _syncRepository.sync({
        ModelType.country,
        ModelType.language,
      });
    });
    on<SyncAllRequested>((event, emit) async {
      _syncRepository.sync(ModelType.values);
    });

    _syncRepository.isSyncing.listen((isSyncing) {
      add(isSyncing ? const SyncInitiated() : const SyncCompleted());
    });

    add(session.needsProfileCreation
        ? const CountriesAndLanguagesRequested()
        : const SyncAllRequested());
  }

  late SyncRepository _syncRepository;
}
