part of 'app_bloc.dart';

@immutable
abstract class AppEvent {
  const AppEvent();
}

class AppInitialized extends AppEvent {
  const AppInitialized({
    required this.initialLocale,
  });

  final String initialLocale;
}

class LocaleChanged extends AppEvent {
  const LocaleChanged(this.locale);

  final String locale;
}
