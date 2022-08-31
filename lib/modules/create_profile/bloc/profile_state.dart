part of 'profile_bloc.dart';

enum ProfileError {
  missingName,
  invalidName,
  missingCountries,
  missingLanguages,
}

@immutable
class ProfileState {
  static RegExp _nameValidator = RegExp(r"^[\p{L} ,.'-]*$",
      caseSensitive: false, unicode: true, dotAll: true);

  ProfileState({
    this.name = '',
    required this.countries,
    required this.languages,
    this.selectedCountries = const {},
    this.selectedLanguages = const {},
    this.diallingCode = '',
    this.phone = '',
    this.isSubmissionCandidate = false,
    this.hasLinkGroups = false,
  });

  final String name;
  final Set<String> selectedCountries;
  final Set<String> selectedLanguages;
  final String diallingCode;
  final String phone;
  final List<Country> countries;
  final List<Language> languages;
  final bool isSubmissionCandidate;
  final bool hasLinkGroups;

  ProfileError? get error => name.isEmpty
      ? ProfileError.missingName
      : !_nameValidator.hasMatch(name)
          ? ProfileError.invalidName
          : selectedCountries.isEmpty
              ? ProfileError.missingCountries
              : selectedCountries.isEmpty
                  ? ProfileError.missingLanguages
                  : null;

  bool get hasCountries => countries.isNotEmpty;
  bool get hasLanguages => languages.isNotEmpty;

  ProfileState copyWith({
    String? name,
    String? diallingCode,
    String? phone,
    Set<String>? selectedCountries,
    Set<String>? selectedLanguages,
    List<Country>? countries,
    List<Language>? languages,
    bool? isSubmissionCandidate,
    bool? hasLinkGroups,
  }) =>
      ProfileState(
        name: name ?? this.name,
        diallingCode: diallingCode ?? this.diallingCode,
        phone: phone ?? this.phone,
        selectedCountries: selectedCountries ?? this.selectedCountries,
        selectedLanguages: selectedLanguages ?? this.selectedLanguages,
        countries: countries ?? this.countries,
        languages: languages ?? this.languages,
        isSubmissionCandidate:
            isSubmissionCandidate ?? this.isSubmissionCandidate,
        hasLinkGroups: hasLinkGroups ?? this.hasLinkGroups,
      );
}