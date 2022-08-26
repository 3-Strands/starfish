import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:starfish/repositories/authentication_repository.dart';
import 'package:starfish/repositories/data_repository.dart';
import 'package:starfish/repositories/sync_repository.dart';
import 'package:starfish/src/deltas.dart';
import 'package:starfish/src/grpc_extensions.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc({
    required DataRepository dataRepository,
    required AuthenticationRepository authenticationRepository,
    required SyncRepository syncRepository,
  }) : super(ProfileState(
          name: authenticationRepository.currentSession!.user.name,
          diallingCode:
              authenticationRepository.currentSession!.user.diallingCode,
          phone: authenticationRepository.currentSession!.user.phone,
          hasLinkGroups:
              authenticationRepository.currentSession!.user.hasLinkGroups(),
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
        diallingCode: event.diallingCode,
        phone: event.phone,
        countries: event.countries,
        languages: event.languages,
      ));
    });
    on<NameChanged>((event, emit) {
      emit(state.copyWith(
        name: event.name,
      ));
    });
    on<PhonenumberChanged>((event, emit) {
      emit(state.copyWith(
        diallingCode: event.diallingCode,
        phone: event.phone,
      ));
    });
    on<LinkGroupChanged>((event, emit) {
      emit(state.copyWith(
        hasLinkGroups: event.hasLinkGroup,
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
        // First, check to see if there are any changes that require connectivity
        final currentUser = dataRepository.currentUser;
        if (currentUser.phone != state.phone ||
            currentUser.diallingCode != state.diallingCode ||
            currentUser.countryIds
                .toSet()
                .difference(state.selectedCountries)
                .isNotEmpty ||
            currentUser.languageIds
                .toSet()
                .difference(state.selectedLanguages)
                .isNotEmpty) {
          // We need to send the request immediately
          try {
            // TODO: UpdateUserDelta
            final newCurrentUser = await syncRepository.syncImmediately();
            // authenticationRepository.updateCurrentUser(newCurrentUser);
          } catch (err) {
            // TODO: Warn user they must be online.
          }
        } else {
          dataRepository.addDelta(
            UserUpdateDelta(
              currentUser,
              name: state.name,
              // TODO: Add all fields (except phone, countries, languages).
            ),
          );
        }
        // authenticationRepository.updateUser(
        //   name: state.name,
        //   countryIds: state.selectedCountries.toList(),
        //   languageIds: state.selectedLanguages.toList(),
        // );
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
