part of 'profile_bloc.dart';

enum ProfileError {
  missingName,
  invalidName,
  missingCountries,
  missingLanguages,
}

@immutable
class ProfileState {
  static RegExp _nameValidator = RegExp(r"^[\p{L} ,.'-]*$", caseSensitive: false, unicode: true, dotAll: true);

  ProfileState({
    this.name = '',
    required this.countries,
    required this.languages,
    this.selectedCountries = const {},
    this.selectedLanguages = const {},
    this.isSubmissionCandidate = false,
  });

  final String name;
  final Set<String> selectedCountries;
  final Set<String> selectedLanguages;
  final List<HiveCountry> countries;
  final List<HiveLanguage> languages;
  final bool isSubmissionCandidate;

  ProfileError? get error => name.isEmpty ? ProfileError.missingName
      : !_nameValidator.hasMatch(name) ? ProfileError.invalidName
      : selectedCountries.isEmpty ? ProfileError.missingCountries
      : selectedCountries.isEmpty ? ProfileError.missingLanguages
      : null;

  bool get hasCountries => countries.isNotEmpty;
  bool get hasLanguages => languages.isNotEmpty;

  ProfileState copyWith({
    String? name,
    Set<String>? selectedCountries,
    Set<String>? selectedLanguages,
    List<HiveCountry>? countries,
    List<HiveLanguage>? languages,
    bool? isSubmissionCandidate,
  }) => ProfileState(
    name: name ?? this.name,
    selectedCountries: selectedCountries ?? this.selectedCountries,
    selectedLanguages: selectedLanguages ?? this.selectedLanguages,
    countries: countries ?? this.countries,
    languages: languages ?? this.languages,
    isSubmissionCandidate: isSubmissionCandidate ?? this.isSubmissionCandidate,
  );
}
