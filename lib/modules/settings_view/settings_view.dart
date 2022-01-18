import 'dart:async';
// ignore: import_of_legacy_library_into_null_safe
import 'package:fbroadcast/fbroadcast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grpc/grpc_or_grpcweb.dart';
import 'package:hive/hive.dart';
import 'package:starfish/app.dart';
import 'package:starfish/bloc/app_bloc.dart';
import 'package:starfish/bloc/provider.dart';
import 'package:starfish/bloc/profile_bloc.dart';
import 'package:starfish/config/routes/routes.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:starfish/constants/assets_path.dart';
import 'package:starfish/constants/strings.dart';
import 'package:starfish/constants/text_styles.dart';
import 'package:starfish/db/hive_country.dart';
import 'package:starfish/db/hive_current_user.dart';
import 'package:starfish/db/hive_database.dart';
import 'package:starfish/db/hive_group.dart';
import 'package:starfish/db/hive_language.dart';
import 'package:starfish/repository/current_user_repository.dart';
import 'package:starfish/select_items/select_drop_down.dart';
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
  SettingsScreen({Key? key, this.title = ''}) : super(key: key);

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

  late Box<HiveCurrentUser> _currentUserBox;
  late Box<HiveCountry> _countryBox;
  late Box<HiveLanguage> _languageBox;
  late Box<HiveGroup> _groupBox;

  late List<HiveLanguage> _tempSelectedLanguages = [];

  String _countyCode = '';
  String _mobileNumber = '';
  String _userName = '';

  bool isMobileEditable = false;
  bool isNameEditable = false;

  late AppBloc bloc;
  bool _isLoading = false;

  late List<Map> _languages;
  late Map _language;
  late List<DropdownMenuItem<Map>> _dropdownLanguagesItem;

  List<Map<String, dynamic>> _groups = [];

  @override
  void initState() {
    super.initState();
    _currentUserBox = Hive.box<HiveCurrentUser>(HiveDatabase.CURRENT_USER_BOX);
    _countryBox = Hive.box<HiveCountry>(HiveDatabase.COUNTRY_BOX);
    _languageBox = Hive.box<HiveLanguage>(HiveDatabase.LANGUAGE_BOX);
    _groupBox = Hive.box<HiveGroup>(HiveDatabase.GROUP_BOX);

    _populateAppLanguages(Strings.appLanguageList);
    _getCurrentUser();
    _getAllCountries();
    _getAllLanguages();
    _getGroups();
    _isUserAdminAtleastInOneGroup();
  }

  _populateAppLanguages(List<Map> languages) async {
    _languages = languages;
    _dropdownLanguagesItem = _buildDropDownLanguageItems(_languages);

    await StarfishSharedPreference().getDeviceLanguage().then((value) => {
          (value == '')
              ? setState(() {
                  _language = _dropdownLanguagesItem[0].value!;
                })
              : {
                  _dropdownLanguagesItem.forEach((element) {
                    if (element.value!.values.last == value) {
                      setState(() {
                        _language = element.value!;
                      });
                    }
                  })
                }
        });
  }

  List<DropdownMenuItem<Map>> _buildDropDownLanguageItems(List listLanguage) {
    List<DropdownMenuItem<Map>> items = [];
    for (Map item in listLanguage) {
      items.add(
        DropdownMenuItem(
          child: Text(item.values.first),
          value: item,
        ),
      );
    }
    return items;
  }

  void _getCurrentUser() {
    _user = _currentUserBox.values.first;

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
          context, AppLocalizations.of(context)!.emptyFullName);
    }

    setState(() => {_userName = _nameController.text});
    _user.name = _nameController.text;
    _user.isUpdated = true;

    _currentUserBox.putAt(0, _user);
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
          context, AppLocalizations.of(context)!.dialingCodeNotExist);
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

    var fieldMaskPaths = ['diallingCode', 'phoneCountryId', 'phone'];

    HiveCurrentUser _currentUser = _currentUserBox.values.first;
    _user.phone = _phoneNumberController.text;
    _user.diallingCode = _countryCodeController.text;
    _user.phoneCountryId = _phoneCountryId;
    _user.isUpdated = true;

    await CurrentUserRepository()
        .updateCurrentUser(_currentUser.toUser(), fieldMaskPaths)
        .then(
          (value) => {
            _currentUserBox.putAt(0, _user),
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
    _currentUserBox.putAt(0, _user);
  }

  void updateCountries() async {
    setState(() {
      _isLoading = true;
    });
    var fieldMaskPaths = ['country_ids'];
    List<String> _selectedCountryIds =
        _selectedCountries.map((e) => e.id).toList();

    HiveCurrentUser _currentUser = _currentUserBox.values.first;
    _user.countryIds = _selectedCountryIds;

    await CurrentUserRepository()
        .updateCurrentUser(_currentUser.toUser(), fieldMaskPaths)
        .then((value) async => {
              await SyncService().syncLanguages(),
              setState(() => _isLoading = false),
              _user.countryIds = value.countryIds,
              _currentUserBox.putAt(0, _user),
            })
        .onError((GrpcError error, stackTrace) => {handleGrpcError(error)});
  }

  void updateLanguages(AppBloc bloc) async {
    setState(() => _isLoading = true);

    var fieldMaskPaths = ['language_ids'];
    List<String> _selectedLanguageIds =
        _selectedLanguages.map((e) => e.id).toList();

    HiveCurrentUser _currentUser = _currentUserBox.values.first;
    _user.languageIds = _selectedLanguageIds;

    await CurrentUserRepository()
        .updateCurrentUser(_currentUser.toUser(), fieldMaskPaths)
        .then(
          (value) => {
            setState(() => _isLoading = false),
            bloc.materialBloc.selectedLanguages = _selectedLanguages,
            _user.languageIds = value.languageIds,
            _currentUserBox.putAt(0, _user),
          },
        );
  }

  void handleGrpcError(GrpcError grpcError) {
    if (grpcError.code == StatusCode.unauthenticated) {
      // StatusCode 16
      // Broadcast to sync the local changes with the server
      FBroadcast.instance().broadcast(
        SyncService.kUnauthenticated,
      );
    }
  }

  Container _getNameSection() {
    return Container(
      height: (isNameEditable) ? 84.h : 63.h,
      child: Column(
        children: [
          Container(
            height: 22.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.name,
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
          SizedBox(height: 5.h),
          (isNameEditable)
              ? _getEditableNameField()
              : Container(
                  height: 36.h,
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
      height: (isMobileEditable) ? 84.h : 63.h,
      child: Column(
        children: [
          Container(
            height: 22.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.mobile,
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
          SizedBox(height: 5.h),
          (isMobileEditable)
              ? _phoneNumberContainer()
              : Container(
                  height: 36.h,
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
      height: 52.h,
      child: Row(
        children: [
          Container(
            height: 52.h,
            width: 87.w,
            child: _countryCodeField(),
          ),
          SizedBox(width: 15.w),
          Container(
            height: 52.h,
            width: 243.w,
            child: _phoneNumberField(),
          )
        ],
      ),
    );
  }

  TextFormField _countryCodeField() {
    return TextFormField(
      controller: _countryCodeController,
      focusNode: _countryCodeFocus,
      onFieldSubmitted: (term) {
        _fieldFocusChange(context, _countryCodeFocus, _phoneNumberFocus);
      },
      keyboardType: TextInputType.phone,
      style: textFormFieldText,
      decoration: InputDecoration(
        hintText: '', // AppLocalizations.of(context)!.countryCodeHint,
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
      controller: _phoneNumberController,
      focusNode: _phoneNumberFocus,
      onFieldSubmitted: (term) {
        _phoneNumberFocus.unfocus();
      },
      keyboardType: TextInputType.phone,
      style: textFormFieldText,
      decoration: InputDecoration(
        hintText: AppLocalizations.of(context)!.phoneNumberHint,
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
          context, AppLocalizations.of(context)!.updateGroupFailed);
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
              AppLocalizations.of(context)!.back,
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
                AppLocalizations.of(context)!.settings,
                style: dashboardNavigationTitle,
              ),
              IconButton(
                icon: SvgPicture.asset(AssetsPath.settings),
                onPressed: () {},
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
              thickness: 5.sp,
              isAlwaysShown: false,
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(left: 15.w, right: 15.w),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 20.h),
                      _getNameSection(),
                      SizedBox(height: 20.h),
                      _getPhoneNumberSection(),
                      SizedBox(height: 20.h),

                      //--> App language section
                      Align(
                        alignment: FractionalOffset.topLeft,
                        child: TitleLabel(
                          title: AppLocalizations.of(context)!.appLanguage,
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
                                  fontSize: 16.sp,
                                  fontFamily: 'OpenSans',
                                ),
                                onChanged: (Map? value) {
                                  setState(() {
                                    _language = value!;
                                    StarfishSharedPreference()
                                        .setDeviceLanguage(value.values.last);
                                    Starfish.of(context)!.setLocale(
                                        Locale.fromSubtags(
                                            languageCode: value.values.last));

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
                          title: AppLocalizations.of(context)!.myCountry,
                          align: TextAlign.left,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      StreamBuilder(
                        stream: profileBloc.countries,
                        builder: (BuildContext context,
                            AsyncSnapshot<List<HiveCountry>?> snapshot) {
                          if (snapshot.hasData) {
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
                          title: AppLocalizations.of(context)!.myLanugages,
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
                          title:
                              AppLocalizations.of(context)!.lastSuccessfullSync,
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
                                  "${AppLocalizations.of(context)!.lastSuccessfullSync}: ",
                              style: TextStyle(
                                color: AppColors.appTitle,
                                fontWeight: FontWeight.normal,
                                fontSize: 18.sp,
                              ),
                              children: [
                                TextSpan(
                                  text: SyncTime().lastSyncDateTimeString(),
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Roboto',
                                    fontSize: 18.sp,
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
            (_isLoading == true)
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Container()
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
            title: AppLocalizations.of(context)!.forGroupAdmin,
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
          height: 44.h,
          width: 345.w,
          child: Row(
            children: [
              Container(
                width: 300.w,
                height: 44.h,
                child: Text(
                  AppLocalizations.of(context)!.linkMyGroups,
                  textAlign: TextAlign.left,
                  style: titleTextStyle,
                ),
              ),
              Container(
                width: 23.w,
                child: Center(
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
              )
            ],
          ),
        ),
        //--------------------------

        SizedBox(height: 50.h),

        //--> My groups section
        Align(
          alignment: FractionalOffset.topLeft,
          child: TitleLabel(
            title: AppLocalizations.of(context)!.myGroups,
            align: TextAlign.left,
          ),
        ),
        SizedBox(height: 5.h),
        SepratorLine(
          hight: 1.h,
          edgeInsets: EdgeInsets.only(left: 0.w, right: 0.w),
        ),

        SizedBox(height: 20.h),

        _myGroupsList(),
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
            final FocusNode _emailFocus = FocusNode();
            _emailController.text = item['email'];

            final _confirmEmailController = TextEditingController();
            final FocusNode _confirmEmailFocus = FocusNode();
            _confirmEmailController.text = item['confirm_email'];

            return Container(
              height: (item['is_editing'] == false) ? 200.h : 240.h,
              margin: EdgeInsets.only(left: 5.0, top: 10.0, right: 5.0),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 200.w,
                        height: 25.h,
                        child: Align(
                          alignment: FractionalOffset.topLeft,
                          child: Text(getGroupName(item['id']),
                              style: titleTextStyle),
                        ),
                      ),
                      Container(
                        height: 25.h,
                        child: InkWell(
                            onTap: () {
                              setState(() {
                                _groups[index]['email'] = _emailController.text;
                              });
                              if (item['is_editing'] == false) {
                                setState(() {
                                  item['is_editing'] = !item['is_editing'];
                                });
                              } else {
                                if (_emailController.text == '') {
                                  Alerts.showMessageBox(
                                      context: context,
                                      title: AppLocalizations.of(context)!
                                          .dialogAlert,
                                      message: AppLocalizations.of(context)!
                                          .emptyEmail,
                                      positiveButtonText:
                                          AppLocalizations.of(context)!.ok,
                                      positiveActionCallback: () {});
                                } else if (!_emailController.text
                                    .isValidEmail()) {
                                  Alerts.showMessageBox(
                                      context: context,
                                      title: AppLocalizations.of(context)!
                                          .dialogAlert,
                                      message: AppLocalizations.of(context)!
                                          .alertInvalidEmaill,
                                      positiveButtonText:
                                          AppLocalizations.of(context)!.ok,
                                      positiveActionCallback: () {});
                                } else if (_emailController.text !=
                                    _confirmEmailController.text) {
                                  Alerts.showMessageBox(
                                      context: context,
                                      title: AppLocalizations.of(context)!
                                          .dialogAlert,
                                      message: AppLocalizations.of(context)!
                                          .alertEmailDoNotMatch,
                                      positiveButtonText:
                                          AppLocalizations.of(context)!.ok,
                                      positiveActionCallback: () {});
                                } else {
                                  if (item['is_editing'] == true) {
                                    _updateGroupLinkedEmaill(
                                        _groups[index]['id'],
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
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Container(
                    height: 45.h,
                    child: Align(
                      alignment: FractionalOffset.topLeft,
                      child: Text(
                          AppLocalizations.of(context)!
                              .projectAdminEmailSectionTitle,
                          style: titleTextStyle),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Container(
                    height: 52.h,
                    child: TextFormField(
                      enabled: item['is_editing'],
                      controller: _emailController,
                      focusNode: _emailFocus,
                      onFieldSubmitted: (term) {
                        _groups[index]['email'] = term;
                        _emailController.text = term;
                        _emailFocus.unfocus();
                      },
                      keyboardType: TextInputType.emailAddress,
                      style: textFormFieldText,
                      decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)!.emailHint,
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
                  SizedBox(height: 10.h),
                  Visibility(
                    visible: item['is_editing'],
                    child: Container(
                      height: 52.h,
                      child: TextFormField(
                        controller: _confirmEmailController,
                        focusNode: _confirmEmailFocus,
                        onFieldSubmitted: (term) {
                          _confirmEmailController.text = term;
                          if (_emailController.text.isValidEmail() &&
                              _emailController.text ==
                                  _confirmEmailController.text) {
                            Alerts.showMessageBox(
                                context: context,
                                title:
                                    AppLocalizations.of(context)!.dialogAlert,
                                message: AppLocalizations.of(context)!
                                    .alertSaveAdminEmail,
                                negativeButtonText:
                                    AppLocalizations.of(context)!.no,
                                positiveButtonText:
                                    AppLocalizations.of(context)!.yes,
                                negativeActionCallback: () {},
                                positiveActionCallback: () {
                                  _updateGroupLinkedEmaill(
                                      item['id'], _emailController.text);
                                });

                            _confirmEmailFocus.unfocus();
                          } else {
                            Alerts.showMessageBox(
                                context: context,
                                title:
                                    AppLocalizations.of(context)!.dialogAlert,
                                message: AppLocalizations.of(context)!
                                    .alertEmailDoNotMatch,
                                positiveButtonText:
                                    AppLocalizations.of(context)!.ok,
                                positiveActionCallback: () {});
                          }
                        },
                        keyboardType: TextInputType.emailAddress,
                        style: textFormFieldText,
                        decoration: InputDecoration(
                          hintText:
                              AppLocalizations.of(context)!.confirmEmailHint,
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
      width: 48.w,
      height: 44.h,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.edit,
            color: Colors.blue,
            size: 18.sp,
          ),
          Text(
            AppLocalizations.of(context)!.edit,
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.blue,
            ),
          )
        ],
      ),
    );
  }

  Container saveButton() {
    return Container(
      width: 53.w,
      height: 44.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        color: Colors.blue,
      ),
      child: Center(
        child: Text(
          AppLocalizations.of(context)!.save,
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
