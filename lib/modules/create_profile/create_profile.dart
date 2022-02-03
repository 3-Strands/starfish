import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:starfish/bloc/profile_bloc.dart';
import 'package:starfish/config/routes/routes.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:starfish/db/hive_country.dart';
import 'package:starfish/db/hive_current_user.dart';
import 'package:starfish/db/hive_database.dart';
import 'package:starfish/db/hive_language.dart';
import 'package:starfish/repository/current_user_repository.dart';
import 'package:starfish/select_items/select_drop_down.dart';
import 'package:starfish/utils/helpers/general_functions.dart';
import 'package:starfish/utils/helpers/snackbar.dart';
import 'package:starfish/utils/services/sync_service.dart';
import 'package:starfish/widgets/app_logo_widget.dart';
import 'package:starfish/constants/text_styles.dart';
import 'package:starfish/widgets/italic_title_label_widget.dart';
import 'package:starfish/widgets/title_label_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CreateProfileScreen extends StatefulWidget {
  CreateProfileScreen({Key? key, this.title = ''}) : super(key: key);

  final String title;

  @override
  _CreateProfileScreenState createState() => _CreateProfileScreenState();
}

class _CreateProfileScreenState extends State<CreateProfileScreen> {
  final _nameController = TextEditingController();

  final FocusNode _nameFocus = FocusNode();

  bool _isLoading = false;

  late Box<HiveCurrentUser> _currentUserBox;

  late HiveCurrentUser _user;

  late List<HiveCountry> _selectedCountries = [];
  late List<HiveLanguage> _selectedLanguages = [];

  @override
  void initState() {
    super.initState();

    _currentUserBox = Hive.box<HiveCurrentUser>(HiveDatabase.CURRENT_USER_BOX);

    _getCurrentUser();
  }

  void _getCurrentUser() {
    _user = _currentUserBox.values.first;
    setState(() {
      _nameController.text = _user.name;
    });
  }

  _updateUserCountries() async {
    setState(() {
      _isLoading = true;
    });

    List<String> _selectedCountryIds =
        _selectedCountries.map((e) => e.id).toList();
    List<String> _selectedLanguageIds =
        _selectedLanguages.map((e) => e.id).toList();

    var fieldMaskPaths = ['country_ids'];

    _user.countryIds = _selectedCountryIds;
    _user.languageIds = _selectedLanguageIds;

    await CurrentUserRepository()
        .updateCurrentUser(_user.toUser(), fieldMaskPaths)
        .then((value) async => {
              await SyncService().syncLanguages(),
              setState(() => _isLoading = false),
              _user.countryIds = value.countryIds,
              _currentUserBox.putAt(0, _user),
            });
  }

  _validateInfo() {
    String validationMsg =
        GeneralFunctions.validateFullName(_nameController.text);
    if (validationMsg.isNotEmpty) {
      return StarfishSnackbar.showErrorMessage(context, validationMsg);
    } else if (_selectedCountries.length == 0) {
      StarfishSnackbar.showErrorMessage(
          context, AppLocalizations.of(context)!.emptySelectCountry);
    } else if (_selectedLanguages.length == 0) {
      StarfishSnackbar.showErrorMessage(
          context, AppLocalizations.of(context)!.emptySelectLanguage);
    } else {
      _updateUserProfile();
    }
  }

  _updateUserProfile() async {
    setState(() {
      _isLoading = true;
    });

    List<String> _selectedCountryIds =
        _selectedCountries.map((e) => e.id).toList();
    List<String> _selectedLanguageIds =
        _selectedLanguages.map((e) => e.id).toList();

    var fieldMaskPaths = ['name', 'country_ids', 'language_ids'];

    if (_nameController.text.isNotEmpty) {
      _user.name = _nameController.text;
    }
    _user.countryIds = _selectedCountryIds;
    _user.languageIds = _selectedLanguageIds;

    await CurrentUserRepository()
        .updateCurrentUser(_user.toUser(), fieldMaskPaths)
        .then((value) => {
              setState(() => _isLoading = false),
              _user.name = value.name,
              _user.languageIds = value.languageIds,
              _currentUserBox.putAt(0, _user),
              // Navigator.of(context).pushNamedAndRemoveUntil(
              //     Routes.dashboard, (Route<dynamic> route) => false)
            })
        .whenComplete(() => {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  Routes.dashboard, (Route<dynamic> route) => false)
            });
  }

  @override
  Widget build(BuildContext context) {
    ProfileBloc profileBloc = new ProfileBloc();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Container(
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 118.h),
                      AppLogo(hight: 156.h, width: 163.w),
                      SizedBox(height: 42.h),
                      //--> Name text field section
                      Align(
                        alignment: FractionalOffset.topLeft,
                        child: TitleLabel(
                          title: AppLocalizations.of(context)!.enterName,
                          align: TextAlign.left,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      _getNameField(),
                      SizedBox(height: 10.h),
                      Align(
                        alignment: FractionalOffset.topLeft,
                        child: ItalicitleLabel(
                            title:
                                AppLocalizations.of(context)!.enterNameDetail),
                      ),
                      //--------------------------
                      SizedBox(height: 30.h),

                      //--> Select country section
                      Align(
                        alignment: FractionalOffset.topLeft,
                        child: TitleLabel(
                          title: AppLocalizations.of(context)!.selectCountry,
                          align: TextAlign.left,
                        ),
                      ),
                      SizedBox(height: 10.h),

                      StreamBuilder(
                          stream: profileBloc.countries,
                          builder: (BuildContext context,
                              AsyncSnapshot<List<HiveCountry>?> snapshot) {
                            if (snapshot.hasData) {
                              snapshot.data!
                                  .sort((a, b) => a.name.compareTo(b.name));
                              return SelectDropDown(
                                navTitle:
                                    AppLocalizations.of(context)!.selectCountry,
                                placeholder:
                                    AppLocalizations.of(context)!.selectCountry,
                                selectedValues: _selectedCountries,
                                dataSource: snapshot.data,
                                type: SelectType.multiple,
                                dataSourceType: DataSourceType.countries,
                                onDoneClicked: <T>(countries) {
                                  setState(() {
                                    _selectedCountries = List<HiveCountry>.from(
                                        countries as List<dynamic>);
                                    _updateUserCountries();
                                  });
                                },
                              );
                            } else {
                              return Container();
                            }
                          }),

                      SizedBox(height: 10.h),
                      Align(
                        alignment: FractionalOffset.topLeft,
                        child: ItalicitleLabel(
                            title: AppLocalizations.of(context)!
                                .selectCountryDetail),
                      ),
                      //--------------------------
                      SizedBox(height: 30.h),
                      //--> Select language section
                      Align(
                        alignment: FractionalOffset.topLeft,
                        child: TitleLabel(
                          title: AppLocalizations.of(context)!.selectLanugages,
                          align: TextAlign.left,
                        ),
                      ),
                      SizedBox(height: 10.h),

                      StreamBuilder(
                          stream: profileBloc.languages,
                          builder: (BuildContext context,
                              AsyncSnapshot<List<HiveLanguage>?> snapshot) {
                            if (snapshot.hasData) {
                              snapshot.data!
                                  .sort((a, b) => a.name.compareTo(b.name));
                              return SelectDropDown(
                                navTitle: AppLocalizations.of(context)!
                                    .selectLanugages,
                                placeholder: AppLocalizations.of(context)!
                                    .selectLanugages,
                                selectedValues: _selectedLanguages,
                                dataSource: snapshot.data,
                                type: SelectType.multiple,
                                dataSourceType: DataSourceType.languages,
                                onDoneClicked: <T>(languages) {
                                  setState(() {
                                    _selectedLanguages =
                                        List<HiveLanguage>.from(
                                            languages as List<dynamic>);
                                  });
                                },
                              );
                            } else {
                              return Container();
                            }
                          }),

                      SizedBox(height: 10.h),
                      Align(
                        alignment: FractionalOffset.topLeft,
                        child: ItalicitleLabel(
                            title: AppLocalizations.of(context)!
                                .selectLanugagesDetail),
                      ),
                    ],
                  ),
                ),
              ),
              (_isLoading == true)
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Container()
            ],
          ),
        ),
      ),
      bottomNavigationBar: _footer(),
    );
  }

  Container _getNameField() {
    return Container(
      height: 52.h,
      child: TextFormField(
        controller: _nameController,
        focusNode: _nameFocus,
        onFieldSubmitted: (term) {
          _nameFocus.unfocus();
        },
        keyboardType: TextInputType.text,
        style: textFormFieldText,
        decoration: InputDecoration(
          hintText: AppLocalizations.of(context)!.nameHint,
          hintStyle: formTitleHintStyle,
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
    );
  }

  SizedBox _footer() {
    return SizedBox(
      height: 75.h,
      child: Stack(
        children: [
          Positioned(
            child: new Align(
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
                        child: _finishButton(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container _finishButton() {
    return Container(
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
          child: ElevatedButton(
            child: Text(
              AppLocalizations.of(context)!.finish,
              textAlign: TextAlign.start,
              style: buttonTextStyle,
            ),
            onPressed: () {
              _validateInfo();
            },
            style: ElevatedButton.styleFrom(
              primary: AppColors.selectedButtonBG,
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(20.0),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
