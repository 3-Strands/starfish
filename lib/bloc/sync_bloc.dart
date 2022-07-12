import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:starfish/apis/hive_api.dart';
import 'package:starfish/db/hive_last_sync_date_time.dart';
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

    _syncRepository = syncRepository ?? SyncRepository(
      hiveApi: HiveApi(),
      client: makeAuthenticatedClient(session.tokens.accessToken),
      // This function will only initiate a refresh request if
      // there is not an existing request pending.
      requestRefresh: () {
        Future<StarfishClient>? pendingRefresh;
        return () {
          pendingRefresh ??= authenticationRepository.refreshSession()
            .then((session) {
              pendingRefresh = null;
              return makeAuthenticatedClient(session.tokens.accessToken);
            });
          return pendingRefresh!;
        };
      }()
    );

    on<SyncInitiated>((event, emit) {
      emit(state.copyWith(isSyncing: true));
    });
    on<SyncCompleted>((event, emit) {
      emit(state.copyWith(isSyncing: false));
    });

    on<CountriesAndLanguagesRequested>((event, emit) async {
      _syncRepository.queueSync([
        _syncRepository.countryManager,
        _syncRepository.languageManager,
      ]);
    });
    on<SyncAll>((event, emit) async {
      _syncRepository.queueSync([
        _syncRepository.countryManager,
        _syncRepository.languageManager,
        _syncRepository.materialManager,
        _syncRepository.actionManager,
      ]);
    });

    _syncRepository.isSyncing.listen((isSyncing) {
      add(isSyncing ? const SyncInitiated() : const SyncCompleted());
    });

    add(session.needsProfileCreation ? const CountriesAndLanguagesRequested() : const SyncAll());
  }

  late SyncRepository _syncRepository;
}
