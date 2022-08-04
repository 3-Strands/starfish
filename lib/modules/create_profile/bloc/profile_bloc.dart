import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:starfish/repositories/authentication_repository.dart';
import 'package:starfish/repositories/data_repository.dart';
import 'package:starfish/src/grpc_extensions.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc({
    required DataRepository dataRepository,
    required AuthenticationRepository authenticationRepository,
  }) : super(ProfileState(
          name: authenticationRepository.currentSession!.user.name,
          selectedCountries:
              authenticationRepository.currentSession!.user.countryIds.toSet(),
          selectedLanguages:
              authenticationRepository.currentSession!.user.languageIds.toSet(),
          countries: dataRepository.currentCountries,
          languages: dataRepository.currentLanguages,
        )) {
    on<DataChanged>((event, emit) {
      emit(state.copyWith(
        selectedCountries: event.selectedCountries,
        selectedLanguages: event.selectedLanguages,
        name: event.name,
        countries: event.countries,
        languages: event.languages,
      ));
    });
    on<NameChanged>((event, emit) {
      emit(state.copyWith(
        name: event.name,
      ));
    });
    on<LanguageSelectionChanged>((event, emit) {
      emit(state.copyWith(
        selectedLanguages:
            event.selectedLanguages.map((language) => language.id).toSet(),
      ));
    });
    on<CountrySelectionChanged>((event, emit) async {
      emit(state.copyWith(
        selectedCountries:
            event.selectedCountries.map((country) => country.id).toSet(),
      ));
    });
    on<FinishClicked>((event, emit) async {
      emit(state.copyWith(isSubmissionCandidate: true));
      if (state.error == null) {
        authenticationRepository.updateUser(
          name: state.name,
          countryIds: state.selectedCountries.toList(),
          languageIds: state.selectedLanguages.toList(),
        );
      }
    });
    on<StateFoundInvalid>((event, emit) {
      emit(state.copyWith(isSubmissionCandidate: false));
    });

    _subscriptions = [
      dataRepository.countries.listen((countries) {
        add(DataChanged(countries: countries));
      }),
      dataRepository.languages.listen((languages) {
        add(DataChanged(languages: languages));
      }),
    ];
  }

  late List<StreamSubscription> _subscriptions;

  @override
  Future<void> close() {
    _subscriptions.forEach((subscription) => subscription.cancel());
    return super.close();
  }
}
