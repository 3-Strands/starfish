part of 'profile_bloc.dart';

@immutable
abstract class ProfileEvent {
  const ProfileEvent();
}

class DataChanged extends ProfileEvent {
  const DataChanged({
    this.name,
    this.selectedCountries,
    this.selectedLanguages,
    this.countries,
    this.languages,
  });

  final String? name;
  final Set<String>? selectedCountries;
  final Set<String>? selectedLanguages;
  final List<Country>? countries;
  final List<Language>? languages;
}

class NameChanged extends ProfileEvent {
  const NameChanged(this.name);

  final String name;
}

class LanguageSelectionChanged extends ProfileEvent {
  const LanguageSelectionChanged(this.selectedLanguages);

  final Set<Language> selectedLanguages;
}

class CountrySelectionChanged extends ProfileEvent {
  const CountrySelectionChanged(this.selectedCountries);

  final Set<Country> selectedCountries;
}

class FinishClicked extends ProfileEvent {
  const FinishClicked();
}

class StateFoundInvalid extends ProfileEvent {
  const StateFoundInvalid();
}
