import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starfish/authenticated_app/bloc/profile_creation_bloc.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:starfish/repositories/authentication_repository.dart';
import 'package:starfish/repositories/data_repository.dart';
import 'package:starfish/select_items/multi_select.dart';
import 'package:starfish/src/grpc_extensions.dart';
import 'package:starfish/utils/currentUser.dart';
import 'package:starfish/utils/helpers/snackbar.dart';
import 'package:starfish/widgets/app_logo_widget.dart';
import 'package:starfish/constants/text_styles.dart';
import 'package:starfish/widgets/italic_title_label_widget.dart';
import 'package:starfish/widgets/loading.dart';
import 'package:starfish/widgets/title_label_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'bloc/profile_bloc.dart';

class CreateProfile extends StatelessWidget {
  const CreateProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBloc(
        dataRepository: context.read<DataRepository>(),
        authenticationRepository: context.read<AuthenticationRepository>(),
      ),
      child: const CreateProfileView(),
    );
  }
}

class CreateProfileView extends StatelessWidget {
  const CreateProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return Scaffold(
      body: BlocListener<ProfileBloc, ProfileState>(
        listenWhen: (previous, current) => current.isSubmissionCandidate,
        listener: (context, state) {
          final error = state.error;
          if (error != null) {
            StarfishSnackbar.showErrorMessage(
                context, error.toLocaleString(context));
            context.read<ProfileBloc>().add(const StateFoundInvalid());
          } else {
            context
                .read<ProfileCreationBloc>()
                .add(const ProfileSetupCompleted());
          }
        },
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
          children: <Widget>[
            SizedBox(height: 118.h),
            AppLogo(hight: 156.h, width: 163.w),
            SizedBox(height: 42.h),
            //--> Name text field section
            Align(
              alignment: FractionalOffset.topLeft,
              child: TitleLabel(
                title: appLocalizations.enterName,
                align: TextAlign.left,
              ),
            ),
            SizedBox(height: 10.h),
            Container(
              height: 52.h,
              child: TextFormField(
                initialValue: context.currentUser.name,
                keyboardType: TextInputType.text,
                style: textFormFieldText,
                onChanged: (value) {
                  context.read<ProfileBloc>().add(NameChanged(value));
                },
                decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  labelText: appLocalizations.nameHint,
                  labelStyle: formTitleHintStyle,
                  // hintText: appLocalizations.nameHint,
                  // hintStyle: formTitleHintStyle,
                  contentPadding: EdgeInsets.fromLTRB(15.0.w, 0.0, 5.0.w, 0.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                  filled: true,
                  fillColor: AppColors.txtFieldBackground,
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Align(
              alignment: FractionalOffset.topLeft,
              child: ItalicitleLabel(title: appLocalizations.enterNameDetail),
            ),
            //--------------------------
            SizedBox(height: 30.h),

            //--> Select country section
            Align(
              alignment: FractionalOffset.topLeft,
              child: TitleLabel(
                title: appLocalizations.selectCountry,
                align: TextAlign.left,
              ),
            ),
            SizedBox(height: 10.h),

            BlocBuilder<ProfileBloc, ProfileState>(
              buildWhen: (previous, current) =>
                  previous.countries != current.countries,
              builder: (context, state) {
                if (!state.hasCountries) {
                  return const Loading();
                }
                final items = [...state.countries];
                items.sort((a, b) => a.name.compareTo(b.name));

                final selectedCountries = state.selectedCountries.toSet();
                final initialSelection = selectedCountries.isEmpty
                    ? null
                    : items
                        .where(
                            (country) => selectedCountries.contains(country.id))
                        .toSet();

                return MultiSelect<Country>(
                  navTitle: appLocalizations.selectCountry,
                  placeholder: appLocalizations.selectCountry,
                  items: items,
                  initialSelection: initialSelection,
                  toDisplay: (country) => country.name,
                  onFinished: (Set<Country> selectedCountries) {
                    context
                        .read<ProfileBloc>()
                        .add(CountrySelectionChanged(selectedCountries));
                  },
                );
              },
            ),

            SizedBox(height: 10.h),
            Align(
              alignment: FractionalOffset.topLeft,
              child:
                  ItalicitleLabel(title: appLocalizations.selectCountryDetail),
            ),
            //--------------------------
            SizedBox(height: 30.h),
            //--> Select language section
            Align(
              alignment: FractionalOffset.topLeft,
              child: TitleLabel(
                title: appLocalizations.selectLanugages,
                align: TextAlign.left,
              ),
            ),
            SizedBox(height: 10.h),

            BlocBuilder<ProfileBloc, ProfileState>(
              buildWhen: (previous, current) =>
                  previous.languages != current.languages,
              builder: (context, state) {
                if (!state.hasLanguages) {
                  return const Loading();
                }
                final items = [...state.languages];
                items.sort((a, b) => a.name.compareTo(b.name));

                final selectedLanguages = state.selectedLanguages.toSet();
                final initialSelection = selectedLanguages.isEmpty
                    ? null
                    : items
                        .where(
                            (country) => selectedLanguages.contains(country.id))
                        .toSet();

                return MultiSelect<Language>(
                  navTitle: appLocalizations.selectLanugages,
                  placeholder: appLocalizations.selectLanugages,
                  items: items,
                  initialSelection: initialSelection,
                  toDisplay: (language) => language.name,
                  onFinished: (Set<Language> selectedLanguages) {
                    context
                        .read<ProfileBloc>()
                        .add(LanguageSelectionChanged(selectedLanguages));
                  },
                );
              },
            ),

            SizedBox(height: 10.h),
            Align(
              alignment: FractionalOffset.topLeft,
              child: ItalicitleLabel(
                  title: appLocalizations.selectLanugagesDetail),
            ),
            SizedBox(
              height: 65.h,
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SizedBox(
        height: 75.h,
        child: Stack(
          children: [
            Positioned(
              child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      color: AppColors.txtFieldBackground,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Align(
                          alignment: FractionalOffset.bottomCenter,
                          child: Container(
                            width: 319.w,
                            height: 37.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                              color: AppColors.selectedButtonBG,
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(0.0),
                              child: SizedBox(
                                width: 319.w,
                                height: 37.h,
                                child: BlocBuilder<ProfileBloc, ProfileState>(
                                    builder: (context, state) {
                                  return ElevatedButton(
                                    child: Text(
                                      appLocalizations.finish,
                                      textAlign: TextAlign.start,
                                      style: buttonTextStyle,
                                    ),
                                    onPressed: () {
                                      context
                                          .read<ProfileBloc>()
                                          .add(const FinishClicked());
                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary: AppColors.selectedButtonBG,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

extension ToLocaleString on ProfileError {
  String toLocaleString(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    switch (this) {
      case ProfileError.missingName:
        return appLocalizations.emptyFullName;
      case ProfileError.invalidName:
        return appLocalizations.invalidFullName;
      case ProfileError.missingCountries:
        return appLocalizations.emptySelectCountry;
      case ProfileError.missingLanguages:
        return appLocalizations.emptySelectLanguage;
    }
  }
}
