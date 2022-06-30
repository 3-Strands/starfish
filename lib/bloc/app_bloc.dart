import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:starfish/apis/local_storage_api.dart';
import 'package:starfish/wrappers/platform.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({
    required this.localStorageApi,
  }) : super(const AppBooting()) {
    on<AppInitialized>((event, emit) {
      emit(AppReady(locale: event.initialLocale));
    });
    on<LocaleChanged>((event, emit) {
      localStorageApi.setDeviceLanguage(event.locale);
      emit(AppReady(locale: event.locale));
    });
    _load();
  }

  final LocalStorageApi localStorageApi;

  Future<void> _load() async {
    final savedLocale = await localStorageApi.getDeviceLanguage();
    final deviceLanguage = Platform.localeName.substring(0, 2);
    final locale = (savedLocale == '')
      ? (
        deviceLanguage == 'hi'
          ? deviceLanguage
          : 'en'
      )
      : savedLocale;

    add(AppInitialized(initialLocale: locale));
  }
}
