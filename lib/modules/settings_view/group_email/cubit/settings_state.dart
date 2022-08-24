part of 'settings_cubit.dart';

enum SettingsEmailError {
  invalidEmailFormat,
  emptyEmail,
  emailMismatch,
}

@immutable
class SettingsState {
  SettingsState({
    required this.group,
    this.email,
    this.confirmEmail,
    this.error,
  });

  final Group group;
  final String? email;
  final String? confirmEmail;

  final SettingsEmailError? error;

  SettingsState copyWith({
    Group? group,
    String? email,
    String? confirmEmail,
    SettingsEmailError? error,
  }) =>
      SettingsState(
        group: group ?? this.group,
        email: email ?? this.email,
        confirmEmail: confirmEmail ?? this.confirmEmail,
        // We reset this to null every time unless explicitly passed.
        error: error,
      );
}
