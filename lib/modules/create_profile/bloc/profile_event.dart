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
  final List<HiveCountry>? countries;
  final List<HiveLanguage>? languages;
}

class NameChanged extends ProfileEvent {
  const NameChanged(this.name);

  final String name;
}

class LanguageSelectionChanged extends ProfileEvent {
  const LanguageSelectionChanged(this.selectedLanguages);

  final Set<HiveLanguage> selectedLanguages;
}

class CountrySelectionChanged extends ProfileEvent {
  const CountrySelectionChanged(this.selectedCountries);

  final Set<HiveCountry> selectedCountries;
}

class FinishClicked extends ProfileEvent {
  const FinishClicked();
}

class StateFoundInvalid extends ProfileEvent {
  const StateFoundInvalid();
}
