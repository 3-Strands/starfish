part of 'app_bloc.dart';

@immutable
abstract class AppState {
  const AppState();
}

class AppBooting extends AppState {
  const AppBooting();
}

class AppReady extends AppState {
  const AppReady({
    required this.locale,
  });

  final String locale;
}
