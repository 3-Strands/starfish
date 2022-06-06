import 'dart:async';
// ignore: import_of_legacy_library_into_null_safe
import 'package:fbroadcast/fbroadcast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grpc/grpc_or_grpcweb.dart';
import 'package:hive/hive.dart';
import 'package:starfish/app.dart';
import 'package:starfish/bloc/app_bloc.dart';
import 'package:starfish/bloc/provider.dart';
import 'package:starfish/bloc/profile_bloc.dart';
import 'package:starfish/config/routes/routes.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:starfish/constants/app_strings.dart';
import 'package:starfish/constants/assets_path.dart';
import 'package:starfish/select_items/multi_select.dart';
import 'package:starfish/utils/helpers/extensions/strings.dart';
import 'package:starfish/constants/text_styles.dart';
import 'package:starfish/db/hive_country.dart';
import 'package:starfish/db/hive_current_user.dart';
import 'package:starfish/db/hive_database.dart';
import 'package:starfish/db/hive_group.dart';
import 'package:starfish/db/hive_language.dart';
import 'package:starfish/db/providers/current_user_provider.dart';
import 'package:starfish/repository/current_user_repository.dart';
import 'package:starfish/src/generated/starfish.pb.dart';
import 'package:starfish/utils/helpers/alerts.dart';
import 'package:starfish/utils/helpers/general_functions.dart';
import 'package:starfish/utils/helpers/snackbar.dart';
import 'package:starfish/utils/services/local_storage_service.dart';
import 'package:starfish/utils/services/sync_service.dart';
import 'package:starfish/utils/sync_time.dart';
import 'package:starfish/widgets/app_logo_widget.dart';
import 'package:starfish/widgets/seprator_line_widget.dart';
import 'package:starfish/widgets/settings_edit_button_widget.dart';
import 'package:starfish/widgets/title_label_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key, this.title = ''}) : super(key: key);

  final String title;

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _countryCodeController = TextEditingController();
  final FocusNode _countryCodeFocus = FocusNode();
  final _nameController = TextEditingController();
  final FocusNode _nameFocus = FocusNode();
  final _phoneNumberController = TextEditingController();
  final FocusNode _phoneNumberFocus = FocusNode();

  late HiveCurrentUser _user;

  // late List<HiveCountry> _countryList = [];
  late List<HiveCountry> _selectedCountries = [];
  late List<HiveLanguage> _selectedLanguages = [];
  late List<HiveGroup> _groupList = [];

  late Box<HiveCountry> _countryBox;
  late Box<HiveLanguage> _languageBox;
  late Box<HiveGroup> _groupBox;

  String _countyCode = '';
  String _mobileNumber = '';
  String _userName = '';

  bool isMobileEditable = false;
  bool isNameEditable = false;

  late AppBloc bloc;

  late List<LanguageCode> _languages;
  LanguageCode? _language;
  late List<DropdownMenuItem<LanguageCode>> _dropdownLanguagesItem;
  late AppLocalizations _appLocalizations;

  List<Map<String, dynamic>> _groups = [];

  @override
  void initState() {
    super.initState();
    _countryBox = Hive.box<HiveCountry>(HiveDatabase.COUNTRY_BOX);
    _languageBox = Hive.box<HiveLanguage>(HiveDatabase.LANGUAGE_BOX);
    _groupBox = Hive.box<HiveGroup>(HiveDatabase.GROUP_BOX);

    _populateAppLanguages(AppStrings.appLanguageList);
    _getCurrentUser();
    _getAllCountries();
    _getAllLanguages();
    _getGroups();
    _isUserAdminAtleastInOneGroup();
  }

  _populateAppLanguages(List<LanguageCode> languages) async {
    _languages = languages;
    _dropdownLanguagesItem = _buildDropDownLanguageItems(_languages);

    String _deviceLanguage =
        await StarfishSharedPreference().getDeviceLanguage();
    setState(() {
      _language = _languages.firstWhere(
        (item) => item.code == _deviceLanguage,
        orElse: () => _languages.first,
      );
    });
  }

  List<DropdownMenuItem<LanguageCode>> _buildDropDownLanguageItems(List<LanguageCode> listLanguage) {
    return listLanguage.map(
      (language) => DropdownMenuItem(
        child: Text(language.name),
        value: language,
      ),
    ).toList();
  }

  void _getCurrentUser() {
    _user = CurrentUserProvider().getUserSync();

    setState(() {
      _nameController.text = _user.name;
      _phoneNumberController.text = _user.phone;
      _countryCodeController.text = _user.diallingCode;
      _userName = _user.name;
      _countyCode = _user.diallingCode;
      _mobileNumber = _user.phone;
    });
  }

  void _getAllCountries() {
    for (var countryId in _user.countryIds) {
      _countryBox.values
          .where((item) => item.id == countryId)
          .forEach((item) => {_selectedCountries.add(item)});
    }
  }

  void _getAllLanguages() {
    for (var languageId in _user.languageIds) {
      _languageBox.values
          .where((item) => item.id == languageId)
          .forEach((item) => {_selectedLanguages.add(item)});
    }
  }

  void _getGroups() {
    _groupList = _groupBox.values.toList();
  }

  void _updateName() async {
    String validationMsg =
        GeneralFunctions.validateFullName(_nameController.text);
    if (validationMsg.isNotEmpty) {
      setState(() => {_nameController.text = _user.name});
      return StarfishSnackbar.showErrorMessage(context, validationMsg);
    }

    if (_nameController.text.isEmpty) {
      setState(() => {_nameController.text = _userName});
      return StarfishSnackbar.showErrorMessage(
          context, _appLocalizations.emptyFullName);
    }

    setState(() => {_userName = _nameController.text});
    _user.name = _nameController.text;
    _user.isUpdated = true;

    CurrentUserProvider().updateUser(_user);
  }

  void _validatePhoneNumber() {
    /* validate entered dialling code in the country list if it exist or not */
    /*
    _countryBox.values.forEach((element) {
      print('element.diallingCode ==>> ${element.diallingCode}');
    });
    */

    String dialingCode = _countryCodeController.text;
    bool isDialingCodeExist = _countryBox.values
        .where((item) => item.diallingCode == dialingCode)
        .isNotEmpty;

    if (!isDialingCodeExist) {
      setState(() => {_countryCodeController.text = _countyCode});
      return StarfishSnackbar.showErrorMessage(
          context, _appLocalizations.dialingCodeNotExist);
    }
    /* ----------------------------------------------------------------- */

    String validationMsg =
        GeneralFunctions.validateMobile(_phoneNumberController.text);
    if (validationMsg.isNotEmpty) {
      setState(() => {_phoneNumberController.text = _mobileNumber});
      return StarfishSnackbar.showErrorMessage(context, validationMsg);
    }
  }

  void _updatePhoneNumber() async {
    _validatePhoneNumber();

    setState(() => {
          _mobileNumber = _phoneNumberController.text,
          _countyCode = _countryCodeController.text
        });

    var _phoneCountryId = _countryBox.values
        .where((item) => item.diallingCode == _countryCodeController.text)
        .first
        .id;

    var fieldMaskPaths = ['dialling_code', 'phone_country_id', 'phone'];

    HiveCurrentUser _currentUser = CurrentUserProvider().getUserSync();
    _user.phone = _phoneNumberController.text;
    _user.diallingCode = _countryCodeController.text;
    _user.phoneCountryId = _phoneCountryId;
    _user.isUpdated = true;

    await CurrentUserRepository()
        .updateCurrentUser(_currentUser.toUser(), fieldMaskPaths)
        .then(
          (value) => {
            CurrentUserProvider().updateUser(_user),
          },
        )
        .whenComplete(() {
      StarfishSharedPreference().setLoginStatus(false);
      Navigator.of(context).pushNamedAndRemoveUntil(
          Routes.phoneAuthentication, (Route<dynamic> route) => false);
    });
  }

  void updateLinkGroupStatus() async {
    _user.linkGroups = _user.linkGroups;
    _user.isUpdated = true;
    CurrentUserProvider().updateUser(_user);
  }

  void updateCountries() {
    var fieldMaskPaths = ['country_ids'];
    List<String> _selectedCountryIds =
        _selectedCountries.map((e) => e.id).toList();

    HiveCurrentUser _currentUser = CurrentUserProvider().getUserSync();
    _user.countryIds = _selectedCountryIds;

    EasyLoading.show();

    CurrentUserRepository()
        .updateCurrentUser(_currentUser.toUser(), fieldMaskPaths)
        .then((value) async {
      await SyncService().syncLanguages();
      _user.countryIds = value.countryIds;
      CurrentUserProvider().updateUser(_user);
    }).onError((GrpcError error, stackTrace) {
      SyncService().handleGrpcError(error, callback: () {
        updateCountries();
      });
    }).whenComplete(() {
      EasyLoading.dismiss();
    });
  }

  void updateLanguages(AppBloc bloc) {
    var fieldMaskPaths = ['language_ids'];
    List<String> _selectedLanguageIds =
        _selectedLanguages.map((e) => e.id).toList();

    _user.languageIds = _selectedLanguageIds;

    EasyLoading.show();

    CurrentUserRepository()
        .updateCurrentUser(_user.toUser(), fieldMaskPaths)
        .then(
      (value) {
        bloc.materialBloc.selectedLanguages = _selectedLanguages;
        _user.languageIds = value.languageIds;
        CurrentUserProvider().updateUser(_user);
      },
    ).onError((GrpcError error, stackTrace) {
      SyncService().handleGrpcError(error, callback: () {
        updateLanguages(bloc);
      });
    }).whenComplete(() {
      EasyLoading.dismiss();
    });
  }

  /*void handleGrpcError(GrpcError grpcError) {
    if (grpcError.code == StatusCode.unauthenticated) {
      // StatusCode 16
      // Broadcast to sync the local changes with the server
      FBroadcast.instance().broadcast(
        SyncService.kUnauthenticated,
      );
    }
  }*/

  Container _getNameSection() {
    return Container(
      //   height: (isNameEditable) ? 84.h : 63.h,
      child: Column(
        children: [
          Container(
            //      height: 22.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _appLocalizations.name,
                  textAlign: TextAlign.end,
                  style: titleTextStyle,
                ),
                EditButton(
                  onButtonClicked: (value) {
                    if (isNameEditable == true) {
                      _updateName();
                    }
                    setState(() {
                      isNameEditable = value;
                    });
                  },
                ),
              ],
            ),
          ),
          //    SizedBox(height: 5.h),
          (isNameEditable)
              ? _getEditableNameField()
              : Container(
                  //        height: 36.h,
                  child: Align(
                    alignment: FractionalOffset.topLeft,
                    child: Text(
                      _userName,
                      overflow: TextOverflow.ellipsis,
                      style: nameTextStyle,
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  Container _getEditableNameField() {
    return Container(
      //   height: 52.h,
      child: TextFormField(
        controller: _nameController,
        focusNode: _nameFocus,
        onFieldSubmitted: (term) {
          _nameFocus.unfocus();
        },
        keyboardType: TextInputType.text,
        style: textFormFieldText,
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.never,
          labelText: _appLocalizations.nameHint,
          labelStyle: formTitleHintStyle,
          alignLabelWithHint: true,
          // hintText: _appLocalizations.nameHint,
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
    );
  }

  Container _getPhoneNumberSection() {
    return Container(
      //  height: (isMobileEditable) ? 84.h : 63.h,
      child: Column(
        children: [
          Container(
            //      height: 22.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _appLocalizations.mobile,
                  textAlign: TextAlign.end,
                  style: titleTextStyle,
                ),
                EditButton(
                  onButtonClicked: (value) {
                    if (isMobileEditable == true) {
                      _updatePhoneNumber();
                    }
                    setState(
                      () {
                        isMobileEditable = value;
                      },
                    );
                  },
                ),
              ],
            ),
          ),
          //   SizedBox(height: 5.h),
          (isMobileEditable)
              ? _phoneNumberContainer()
              : Container(
                  //        height: 36.h,
                  child: Align(
                    alignment: FractionalOffset.topLeft,
                    child: Text(
                      _countyCode + ' ' + _mobileNumber,
                      overflow: TextOverflow.ellipsis,
                      style: nameTextStyle,
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  Container _phoneNumberContainer() {
    return Container(
      //   height: 52.h,
      child: Row(
        children: [
          Container(
            //        height: 52.h,
            width: 87.w,
            child: _countryCodeField(),
          ),
          SizedBox(width: 15.w),
          Container(
            ///       height: 52.h,
            width: 243.w,
            child: _phoneNumberField(),
          )
        ],
      ),
    );
  }

  TextFormField _countryCodeField() {
    return TextFormField(
      inputFormatters: [
        new FilteringTextInputFormatter.allow(RegExp("[0-9]")),
      ],
      controller: _countryCodeController,
      focusNode: _countryCodeFocus,
      onFieldSubmitted: (term) {
        _fieldFocusChange(context, _countryCodeFocus, _phoneNumberFocus);
      },
      keyboardType: TextInputType.phone,
      style: textFormFieldText,
      decoration: InputDecoration(
        hintText: '', // _appLocalizations.countryCodeHint,
        hintStyle: formTitleHintStyle,
        contentPadding: EdgeInsets.fromLTRB(15.0.w, 0.0, 5.0.w, 0.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: Colors.blue,
          ),
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
    );
  }

  TextFormField _phoneNumberField() {
    return TextFormField(
      inputFormatters: [
        new FilteringTextInputFormatter.allow(RegExp("[0-9]")),
      ],
      controller: _phoneNumberController,
      focusNode: _phoneNumberFocus,
      onFieldSubmitted: (term) {
        _phoneNumberFocus.unfocus();
      },
      keyboardType: TextInputType.phone,
      style: textFormFieldText,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.never,
        labelText: _appLocalizations.phoneNumberHint,
        labelStyle: formTitleHintStyle,
        alignLabelWithHint: true,
        // hintText: _appLocalizations.phoneNumberHint,
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
    );
  }

  String getGroupName(String groupId) {
    return _groupList.where((element) => element.id == groupId).first.name ??
        '';
  }

  String getGroupLinkedEmaill(String groupId) {
    return _groupList
            .where((element) => element.id == groupId)
            .first
            .linkEmail ??
        '';
  }

  _updateGroupLinkedEmaill(String groupId, String emailId) async {
    var group = _groupList.where((element) => element.id == groupId).first;
    group.linkEmail = emailId;
    group.isUpdated = true;

    bloc.groupBloc
        .addEditGroup(group)
        .then((value) => print('record(s) saved.'))
        .onError((error, stackTrace) {
      print('Error: ${error.toString()}.');
      StarfishSnackbar.showErrorMessage(
          context, _appLocalizations.updateGroupFailed);
    }).whenComplete(() {
      // Broadcast to sync the local changes with the server
    });
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
                        child: _backButton(),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container _backButton() {
    return Container(
      width: 319.w,
      height: 37.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(0.0),
        child: SizedBox(
          width: 319.w,
          height: 37.h,
          child: ElevatedButton(
            child: Text(
              _appLocalizations.back,
              textAlign: TextAlign.start,
              style: buttonTextStyle,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(
              primary: AppColors.unselectedButtonBG,
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(20.0),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  @override
  Widget build(BuildContext context) {
    bloc = Provider.of(context);
    _appLocalizations = AppLocalizations.of(context)!;
    ProfileBloc profileBloc = new ProfileBloc();
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        automaticallyImplyLeading: false,
        title: Container(
          height: 64.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              AppLogo(hight: 36.h, width: 37.w),
              Text(
                _appLocalizations.settings,
                style: dashboardNavigationTitle,
              ),
              Visibility(
                child: IconButton(
                  icon: SvgPicture.asset(AssetsPath.settings),
                  onPressed: () {},
                ),
                visible: false,
              ),
            ],
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Stack(
          children: [
            Scrollbar(
              thickness: 5.w,
              isAlwaysShown: false,
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(left: 15.w, right: 15.w),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 20.h),
                      _getNameSection(),
                      SizedBox(height: 5.h),
                      _getPhoneNumberSection(),
                      SizedBox(height: 5.h),

                      //--> App language section
                      Align(
                        alignment: FractionalOffset.topLeft,
                        child: TitleLabel(
                          title: _appLocalizations.appLanguage,
                          align: TextAlign.left,
                        ),
                      ),

                      SizedBox(height: 10.h),

                      Container(
                        height: 50.h,
                        decoration: BoxDecoration(
                          color: AppColors.txtFieldBackground,
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: Center(
                          child: DropdownButtonHideUnderline(
                            child: ButtonTheme(
                              alignedDropdown: true,
                              child: DropdownButton(
                                isExpanded: true,
                                iconSize: 35,
                                style: TextStyle(
                                  color: Color(0xFF434141),
                                  fontSize: 19.sp,
                                  fontFamily: 'OpenSans',
                                ),
                                onChanged: (LanguageCode? value) {
                                  setState(() {
                                    _language = value!;
                                    StarfishSharedPreference()
                                        .setDeviceLanguage(value.code);
                                    Starfish.of(context)!.setLocale(
                                        Locale.fromSubtags(
                                            languageCode: value.code));

                                    reinitLanguageFilter();
                                  });
                                },
                                value: _language,
                                items: _dropdownLanguagesItem,
                              ),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 20.h),

                      //--> Select country section
                      Align(
                        alignment: FractionalOffset.topLeft,
                        child: TitleLabel(
                          title: _appLocalizations.myCountry,
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
                            return MultiSelect<HiveCountry>(
                              navTitle: _appLocalizations.selectCountry,
                              placeholder: _appLocalizations.selectCountry,
                              items: snapshot.data!,
                              initialSelection: _selectedCountries.toSet(),
                              toDisplay: HiveCountry.toDisplay,
                              onFinished: (Set<HiveCountry> selectedItems) async {
                                bool _isNetworkAvailable =
                                    await GeneralFunctions()
                                        .isNetworkAvailable();
                                if (!_isNetworkAvailable) {
                                  StarfishSnackbar.showErrorMessage(
                                      context,
                                      _appLocalizations
                                          .internetRequiredToChangeCountriesOrLanguage);
                                  return;
                                }

                                setState(() {
                                  _selectedCountries = selectedItems.toList();
                                  updateCountries();
                                });
                              },
                            );
                          } else {
                            return Container();
                          }
                        },
                      ),
                      //--------------------------

                      SizedBox(height: 20.h),

                      //--> Select language section
                      Align(
                        alignment: FractionalOffset.topLeft,
                        child: TitleLabel(
                          title: _appLocalizations.myLanugages,
                          align: TextAlign.left,
                        ),
                      ),
                      SizedBox(height: 10.h),

                      Container(
                        child: StreamBuilder(
                          stream: profileBloc.languages,
                          builder: (BuildContext context,
                              AsyncSnapshot<List<HiveLanguage>?> snapshot) {
                            if (snapshot.hasData) {
                              snapshot.data!
                                  .sort((a, b) => a.name.compareTo(b.name));
                              return MultiSelect<HiveLanguage>(
                                navTitle: _appLocalizations.selectLanugages,
                                placeholder: _appLocalizations.selectLanugages,
                                items: snapshot.data!,
                                initialSelection: _selectedLanguages.toSet(),
                                toDisplay: HiveLanguage.toDisplay,
                                onFinished: (Set<HiveLanguage> selectedLanguages) async {
                                  bool _isNetworkAvailable =
                                      await GeneralFunctions()
                                          .isNetworkAvailable();
                                  if (!_isNetworkAvailable) {
                                    StarfishSnackbar.showErrorMessage(
                                        context,
                                        _appLocalizations
                                            .internetRequiredToChangeCountriesOrLanguage);
                                    return;
                                  }

                                  setState(() {
                                    _selectedLanguages = selectedLanguages.toList();
                                    updateLanguages(bloc);
                                  });
                                },
                              );
                            } else {
                              return Container();
                            }
                          },
                        ),
                      ),
                      //--------------------------

                      SizedBox(height: 39.h),

                      //--> Last successfull sync section
                      Align(
                        alignment: FractionalOffset.topLeft,
                        child: TitleLabel(
                          title: _appLocalizations.lastSuccessfullSync,
                          align: TextAlign.left,
                        ),
                      ),
                      SizedBox(height: 5.h),
                      SepratorLine(
                        hight: 1.h,
                        edgeInsets: EdgeInsets.only(left: 0.w, right: 0.w),
                      ),
                      SizedBox(height: 20.h),

                      Container(
                        child: Align(
                          alignment: FractionalOffset.topLeft,
                          child: Text.rich(
                            TextSpan(
                              text:
                                  "${_appLocalizations.lastSuccessfullSync}: ",
                              style: TextStyle(
                                color: AppColors.appTitle,
                                fontWeight: FontWeight.normal,
                                fontSize: 21.5.sp,
                              ),
                              children: [
                                TextSpan(
                                  text: SyncTime().lastSyncDateTimeString(),
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Roboto',
                                    fontSize: 21.5.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      //--------------------------

                      SizedBox(height: 50.h),
                      //--> Group admin section
                      _getGroupAdminsSections(),
                      //--------------------------
                      // SizedBox(height: 10.h),
                    ],
                  ),
                ),
              ),
            ),
            /*(_isLoading == true)
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Container()*/
          ],
        ),
      ),
      bottomNavigationBar: _footer(),
    );
  }

  reinitLanguageFilter() async {
    var _duration = Duration(seconds: 1);
    return Timer(_duration, _update);
  }

  void _update() {
    setState(() {
      bloc.materialBloc.selectedLanguages = _selectedLanguages;
    });
  }

  Widget _getGroupAdminsSections() {
    return (_groups.length > 0) ? _getGroupAdminsListing() : Container();
  }

  Widget _getGroupAdminsListing() {
    return Column(
      children: [
        Align(
          alignment: FractionalOffset.topLeft,
          child: TitleLabel(
            title: _appLocalizations.forGroupAdmin,
            align: TextAlign.left,
          ),
        ),
        SizedBox(height: 5.h),
        SepratorLine(
          hight: 1.h,
          edgeInsets: EdgeInsets.only(left: 0.w, right: 0.w),
        ),
        SizedBox(height: 20.h),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Text(
                  _appLocalizations.linkMyGroups,
                  textAlign: TextAlign.left,
                  style: titleTextStyle,
                ),
              ),
              Center(
                child: IconButton(
                  icon: (_user.linkGroups == true)
                      ? Icon(Icons.check_box)
                      : Icon(Icons.check_box_outline_blank),
                  color: AppColors.selectedButtonBG,
                  onPressed: () {
                    setState(() => {
                          _user.linkGroups = !_user.linkGroups,
                          updateLinkGroupStatus()
                        });
                  },
                ),
              ),
            ],
          ),
        ),
        //--------------------------

        SizedBox(height: 50.h),

        //--> My groups section
        if (_user.linkGroups)
          Align(
            alignment: FractionalOffset.topLeft,
            child: TitleLabel(
              title: _appLocalizations.myGroups,
              align: TextAlign.left,
            ),
          ),
        SizedBox(height: 5.h),
        if (_user.linkGroups)
          SepratorLine(
            hight: 1.h,
            edgeInsets: EdgeInsets.only(left: 0.w, right: 0.w),
          ),

        SizedBox(height: 20.h),

        if (_user.linkGroups) _myGroupsList(),
      ],
    );
  }

  Column _myGroupsList() {
    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: _groups.length,
          itemBuilder: (context, index) {
            final item = _groups[index];
            final _emailController = TextEditingController();
            //   final FocusNode _emailFocus = FocusNode();
            _emailController.text = item['email'];

            final _confirmEmailController = TextEditingController();
            //      final FocusNode _confirmEmailFocus = FocusNode();
            _confirmEmailController.text = item['confirm_email'];

            return Container(
              //height: (item['is_editing'] == false) ? 200.h : 240.h,
              margin: EdgeInsets.only(left: 5.0, top: 10.0, right: 5.0),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        //width: 200.w,
                        //height: 25.h,
                        child: Align(
                          alignment: FractionalOffset.topLeft,
                          child: Text(getGroupName(item['id']),
                              style: titleTextStyle),
                        ),
                      ),
                      InkWell(
                          onTap: () {
                            setState(() {
                              _groups[index]['email'] = _emailController.text;
                              _groups[index]['confirm_email'] =
                                  _confirmEmailController.text;
                            });
                            if (item['is_editing'] == false) {
                              setState(() {
                                item['is_editing'] = !item['is_editing'];
                              });
                            } else {
                              if (_emailController.text == '') {
                                Alerts.showMessageBox(
                                    context: context,
                                    title: _appLocalizations.dialogAlert,
                                    message: _appLocalizations.emptyEmail,
                                    positiveButtonText: _appLocalizations.ok,
                                    positiveActionCallback: () {});
                              } else if (!_emailController.text
                                  .isValidEmail()) {
                                Alerts.showMessageBox(
                                    context: context,
                                    title: _appLocalizations.dialogAlert,
                                    message:
                                        _appLocalizations.alertInvalidEmaill,
                                    positiveButtonText: _appLocalizations.ok,
                                    positiveActionCallback: () {});
                              } else if (_confirmEmailController.text.isEmpty) {
                                Alerts.showMessageBox(
                                    context: context,
                                    title: _appLocalizations.dialogAlert,
                                    message: _appLocalizations.emptyEmail,
                                    positiveButtonText: _appLocalizations.ok,
                                    positiveActionCallback: () {});
                              } else if (!_confirmEmailController.text
                                  .isValidEmail()) {
                                Alerts.showMessageBox(
                                    context: context,
                                    title: _appLocalizations.dialogAlert,
                                    message:
                                        _appLocalizations.alertInvalidEmaill,
                                    positiveButtonText: _appLocalizations.ok,
                                    positiveActionCallback: () {});
                              } else if (_emailController.text !=
                                  _confirmEmailController.text) {
                                Alerts.showMessageBox(
                                    context: context,
                                    title: _appLocalizations.dialogAlert,
                                    message:
                                        _appLocalizations.alertEmailDoNotMatch,
                                    positiveButtonText: _appLocalizations.ok,
                                    positiveActionCallback: () {});
                              } else {
                                if (item['is_editing'] == true) {
                                  _updateGroupLinkedEmaill(_groups[index]['id'],
                                      _groups[index]['email']);
                                }
                                setState(() {
                                  item['is_editing'] = !item['is_editing'];
                                });
                              }
                            }
                          },
                          child: (item['is_editing'] == false)
                              ? editButton()
                              : saveButton()),
                      SizedBox(width: 5),
                      if (item["is_editing"] == true)
                        InkWell(
                          child: cancelButton(),
                          onTap: () => setState(() {
                            item["is_editing"] = false;
                          }),
                        ),
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Container(
                    //height: 45.h,
                    child: Align(
                      alignment: FractionalOffset.topLeft,
                      child: Text(
                          _appLocalizations.projectAdminEmailSectionTitle,
                          style: titleTextStyle),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Container(
                    //height: 52.h,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          item['is_editing'] = true;
                        });
                      },
                      child: TextFormField(
                        enabled: item['is_editing'],
                        controller: _emailController,
                        // focusNode: _emailFocus,
                        onFieldSubmitted: (term) {
                          _groups[index]['email'] = term;
                          _emailController.text = term;
                          //  _emailFocus.unfocus();
                        },
                        keyboardType: TextInputType.emailAddress,
                        style: textFormFieldText,
                        decoration: InputDecoration(
                          labelText: _appLocalizations.emailHint,
                          labelStyle: formTitleHintStyle,
                          floatingLabelBehavior: FloatingLabelBehavior.never,

                          // hintText: _appLocalizations.emailHint,
                          contentPadding:
                              EdgeInsets.fromLTRB(15.0.w, 0.0, 5.0.w, 0.0),
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
                  ),
                  SizedBox(height: 10.h),
                  Visibility(
                    visible: item['is_editing'],
                    child: Container(
                      //height: 52.h,
                      child: TextFormField(
                        enabled: item['is_editing'],
                        controller: _confirmEmailController,
                        //   focusNode: _confirmEmailFocus,
                        onFieldSubmitted: (term) {
                          _groups[index]['confirm_email'] = term;
                          _confirmEmailController.text = term;
                          // _confirmEmailController.text = term;
                          // if (_emailController.text.isValidEmail() &&
                          //     _emailController.text ==
                          //         _confirmEmailController.text) {
                          //     Alerts.showMessageBox(
                          //         context: context,
                          //         title:
                          //             _appLocalizations.dialogAlert,
                          //         message: _appLocalizations
                          //             .alertSaveAdminEmail,
                          //         negativeButtonText:
                          //             _appLocalizations.no,
                          //         positiveButtonText:
                          //             _appLocalizations.yes,
                          //         negativeActionCallback: () {},
                          //         positiveActionCallback: () {
                          //           _updateGroupLinkedEmaill(
                          //               item['id'], _emailController.text);
                          //         });

                          //  //  _confirmEmailFocus.unfocus();
                          //   } else {
                          //     Alerts.showMessageBox(
                          //         context: context,
                          //         title:
                          //             _appLocalizations.dialogAlert,
                          //         message: _appLocalizations
                          //             .alertEmailDoNotMatch,
                          //         positiveButtonText:
                          //             _appLocalizations.ok,
                          //         positiveActionCallback: () {});
                          //   }
                        },
                        keyboardType: TextInputType.emailAddress,
                        style: textFormFieldText,
                        decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          labelText: _appLocalizations.confirmEmailHint,
                          labelStyle: formTitleHintStyle,
                          // hintText:
                          //     _appLocalizations.confirmEmailHint,
                          contentPadding:
                              EdgeInsets.fromLTRB(15.0.w, 0.0, 5.0.w, 0.0),
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
                  ),
                  SizedBox(height: 15.h),
                  SepratorLine(
                      hight: .5.h,
                      edgeInsets: EdgeInsets.only(left: 10.w, right: 10.w))
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  _isUserAdminAtleastInOneGroup() {
    _user.groups.forEach((group) {
      if (GroupUser_Role.valueOf(group.role!) == GroupUser_Role.ADMIN) {
        _groups.add({
          'id': group.groupId!,
          'email': getGroupLinkedEmaill(group.groupId!),
          'confirm_email': '',
          'is_editing': false
        });
      }
    });
  }

  Container editButton() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.edit,
            color: Colors.blue,
            size: 18.r,
          ),
          Text(
            _appLocalizations.edit,
            style: TextStyle(
              fontSize: 17.sp,
              color: Colors.blue,
            ),
          )
        ],
      ),
    );
  }

  Container saveButton() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        color: Colors.blue,
      ),
      child: Center(
        child: Text(
          _appLocalizations.save,
          style: TextStyle(
            fontSize: 17.sp,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Container cancelButton() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        color: Colors.grey,
      ),
      child: Center(
        child: Text(
          _appLocalizations.cancel,
          style: TextStyle(
            fontSize: 17.sp,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
