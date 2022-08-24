import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:starfish/repositories/authentication_repository.dart';
import 'package:starfish/repositories/sync_repository.dart';
import 'package:starfish/utils/option.dart';

part 'sync_event.dart';
part 'sync_state.dart';

class SyncBloc extends Bloc<SyncEvent, SyncState> {
  SyncBloc({
    required SyncRepository syncRepository,
    required AuthenticationRepository authenticationRepository,
  })  : _syncRepository = syncRepository,
        super(SyncState()) {
    final session = authenticationRepository.currentSession!;

    on<SyncInitiated>((event, emit) {
      emit(state.copyWith(isSyncing: true));
    });
    on<SyncCompleted>((event, emit) {
      emit(state.copyWith(
          isSyncing: false, lastSync: Option.some(DateTime.now())));
    });

    on<CountriesAndLanguagesRequested>((event, emit) async {
      _syncRepository.sync();
    });
    on<SyncAllRequested>((event, emit) async {
      _syncRepository.sync();
    });

    _syncRepository.isSyncingStream.listen((isSyncing) {
      add(isSyncing ? const SyncInitiated() : const SyncCompleted());
    });

    add(session.needsProfileCreation
        ? const CountriesAndLanguagesRequested()
        : const SyncAllRequested());
  }

  @override
  Future<void> close() {
    _syncRepository.close();
    return super.close();
  }

  final SyncRepository _syncRepository;
}
