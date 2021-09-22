import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
// import 'package:smart_select/smart_select.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:starfish/constants/assets_path.dart';
import 'package:starfish/constants/strings.dart';
import 'package:starfish/constants/text_styles.dart';
import 'package:starfish/db/hive_country.dart';
import 'package:starfish/db/hive_current_user.dart';
import 'package:starfish/db/hive_database.dart';
import 'package:starfish/db/hive_group_user.dart';
import 'package:starfish/db/hive_language.dart';
import 'package:starfish/repository/app_data_repository.dart';
import 'package:starfish/repository/current_user_repository.dart';
import 'package:starfish/smart_select/src/model/choice_item.dart';
import 'package:starfish/smart_select/src/model/modal_config.dart';
import 'package:starfish/smart_select/src/tile/tile.dart';
import 'package:starfish/smart_select/src/widget.dart';
import 'package:starfish/src/generated/starfish.pb.dart';
import 'package:starfish/utils/helpers/general_functions.dart';
import 'package:starfish/utils/helpers/snackbar.dart';
import 'package:starfish/utils/services/sync_service.dart';
import 'package:starfish/widgets/app_logo_widget.dart';
import 'package:starfish/widgets/seprator_line_widget.dart';
import 'package:starfish/widgets/settings_edit_button_widget.dart';
import 'package:starfish/widgets/title_label_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsScreen extends StatefulWidget {
  SettingsScreen({Key? key, this.title = ''}) : super(key: key);

  final String title;

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _countryCodeController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _nameController = TextEditingController();

  final FocusNode _countryCodeFocus = FocusNode();
  final FocusNode _phoneNumberFocus = FocusNode();
  final FocusNode _nameFocus = FocusNode();

  bool isNameEditable = false;
  bool isMobileEditable = false;

  String _userName = '';
  String _countyCode = '';
  String _mobileNumber = '';
  List<String> groups = List<String>.generate(4, (i) => "Group: $i");

  late Box<HiveCountry> _countryBox;
  late Box<HiveLanguage> _languageBox;
  late Box<HiveCurrentUser> _currentUserBox;

  late HiveCurrentUser _user;

  late List<HiveCountry> _selectedCountries = [];
  late List<HiveLanguage> _selectedLanguages = [];

  late List<HiveCountry> _countryList = [];
  late List<HiveLanguage> _languageList = [];

  @override
  void initState() {
    super.initState();
    _currentUserBox = Hive.box<HiveCurrentUser>(HiveDatabase.CURRENT_USER_BOX);
    _countryBox = Hive.box<HiveCountry>(HiveDatabase.COUNTRY_BOX);
    _languageBox = Hive.box<HiveLanguage>(HiveDatabase.LANGUAGE_BOX);

    _getCurrentUser();
    _getAllCountries();
  }

  void _getCurrentUser() {
    _user = _currentUserBox.values.first;
    setState(() {
      _nameController.text = _user.name;
      _phoneNumberController.text = _user.phone;
      // _countryCodeController.text = _user.diallingCode;

      _userName = _user.name;
      // _countyCode = _user.diallingCode;
      _mobileNumber = _user.phone;
    });
  }

  void _getAllCountries() async {
    _countryList = _countryBox.values.toList();

    for (var countryId in _user.countryIds) {
      _countryList
          .where((item) => item.id == countryId)
          .forEach((item) => {_selectedCountries.add(item)});
    }

    _getAllLanguages();
  }

  void _getAllLanguages() async {
    _languageList = _languageBox.values.toList();
    for (var languageId in _user.languageIds) {
      _languageList
          .where((item) => item.id == languageId)
          .forEach((item) => {_selectedLanguages.add(item)});
    }
  }

  void updateName() async {
    setState(() => {_userName = _nameController.text});
    _user.name = _nameController.text;
    _user.isUpdated = true;
    _currentUserBox.putAt(0, _user);
  }

  void updatePhoneNumber() async {
    setState(() => {_mobileNumber = _phoneNumberController.text});
    _user.phone = _phoneNumberController.text;
    _user.isUpdated = true;
    _currentUserBox.putAt(0, _user);
  }

  void updatelinkGroupStatus() async {
    _user.linkGroup = _user.linkGroup;
    _user.isUpdated = true;
    _currentUserBox.putAt(0, _user);
  }

  void updateCountries() async {
    GeneralFunctions().isNetworkAvailable().then((onValue) async {
      if (!onValue) {
        return StarfishSnackbar.showErrorMessage(context,
            'You can change the countries and languages only when your internet is working');
      }
    });

    var fieldMaskPaths = ['countryIds'];
    Iterable<String> _selectedCountryIds = _selectedCountries.map((e) => e.id);

    await CurrentUserRepository()
        .updateUser(_user.id, null, null, _selectedCountryIds, null, null,
            fieldMaskPaths)
        .then(
          (value) => {
            print(value),
            _user.countryIds = value.countryIds,
            _currentUserBox.putAt(0, _user),
          },
        )
        .whenComplete(() {
      // SyncService().syncLanguages();
    });
  }

  void updateLanguages() async {
    GeneralFunctions().isNetworkAvailable().then((onValue) async {
      if (!onValue) {
        return StarfishSnackbar.showErrorMessage(context,
            'You can change the countries and languages only when your internet is working');
      }
    });

    var fieldMaskPaths = ['languageIds'];
    Iterable<String> _selectedLanguageIds = _selectedLanguages.map((e) => e.id);

    await CurrentUserRepository()
        .updateUser(_user.id, null, null, null, _selectedLanguageIds, null,
            fieldMaskPaths)
        .then(
          (value) => {
            print(value),
            _user.languageIds = value.languageIds,
            _currentUserBox.putAt(0, _user),
          },
        );
  }

  @override
  Widget build(BuildContext context) {
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
                Strings.settings,
                style: dashboardNavigationTitle,
              ),
              IconButton(
                icon: SvgPicture.asset(AssetsPath.settingsActive),
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
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 52.h),
                  _getNameSection(),
                  SizedBox(height: 20.h),
                  _getPhoneNumberSection(),
                  SizedBox(height: 20.h),

                  //--> Select country section
                  Align(
                    alignment: FractionalOffset.topLeft,
                    child: TitleLabel(
                      title: Strings.myCountry,
                      align: TextAlign.left,
                    ),
                  ),
                  SizedBox(height: 10.h),

                  Container(
                    height: 80.h,
                    margin: EdgeInsets.only(left: 15.w, right: 15.w),
                    decoration: BoxDecoration(
                      color: AppColors.txtFieldBackground,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: Center(
                      child: SmartSelect<HiveCountry>.multiple(
                        title: Strings.country,
                        placeholder: Strings.selectCountry,
                        selectedValue: _selectedCountries,
                        onChange: (selected) => setState(() => {
                              _selectedCountries = selected.value,
                              updateCountries()
                            }),
                        choiceItems:
                            S2Choice.listFrom<HiveCountry, HiveCountry>(
                                source: _countryList,
                                value: (index, item) => item,
                                title: (index, item) => item.name,
                                group: (index, item) {
                                  return '';
                                }),
                        choiceGrouped: false,
                        modalFilter: true,
                        modalFilterAuto: true,
                        modalType: S2ModalType.fullPage,
                        tileBuilder: (context, state) {
                          return S2Tile.fromState(
                            state,
                            isTwoLine: true,
                          );
                        },
                      ),
                    ),
                  ),
                  //--------------------------

                  SizedBox(height: 20.h),

                  //--> Select language section
                  Align(
                    alignment: FractionalOffset.topLeft,
                    child: TitleLabel(
                      title: Strings.myLanugages,
                      align: TextAlign.left,
                    ),
                  ),
                  SizedBox(height: 10.h),

                  Container(
                    height: 80.h,
                    margin: EdgeInsets.only(left: 15.w, right: 15.w),
                    decoration: BoxDecoration(
                      color: AppColors.txtFieldBackground,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: Center(
                      child: SmartSelect<HiveLanguage>.multiple(
                        title: Strings.lanugages,
                        placeholder: Strings.selectLanugages,
                        selectedValue: _selectedLanguages,
                        onChange: (selected) {
                          setState(() => _selectedLanguages = selected.value);
                        },
                        choiceItems:
                            S2Choice.listFrom<HiveLanguage, HiveLanguage>(
                                source: _languageList,
                                value: (index, item) => item,
                                title: (index, item) => item.name,
                                group: (index, item) {
                                  return '';
                                }),
                        choiceGrouped: true,
                        modalType: S2ModalType.fullPage,
                        modalFilter: true,
                        modalFilterAuto: true,
                        tileBuilder: (context, state) {
                          return S2Tile.fromState(
                            state,
                            isTwoLine: true,
                          );
                        },
                      ),
                    ),
                  ),
                  //--------------------------

                  SizedBox(height: 39.h),

                  //--> Last successfull sync section
                  Align(
                    alignment: FractionalOffset.topLeft,
                    child: TitleLabel(
                      title: Strings.lastSuccessfullSync,
                      align: TextAlign.left,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  SepratorLine(
                    hight: 1.h,
                    edgeInsets: EdgeInsets.only(left: 15.w, right: 15.w),
                  ),
                  SizedBox(height: 20.h),

                  Container(
                    margin: EdgeInsets.only(left: 15.w, right: 15.w),
                    child: Align(
                      alignment: FractionalOffset.topLeft,
                      child: Text.rich(
                        TextSpan(
                          text: Strings.lastSuccessfullSync + ': ',
                          style: TextStyle(
                              color: AppColors.appTitle,
                              fontWeight: FontWeight.normal,
                              fontSize: 22.sp),
                          children: [
                            TextSpan(
                              text: '',
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Roboto',
                                fontSize: ScreenUtil().setSp(22),
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
                  Align(
                    alignment: FractionalOffset.topLeft,
                    child: TitleLabel(
                      title: Strings.forGroupAdmin,
                      align: TextAlign.left,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  SepratorLine(
                    hight: 1.h,
                    edgeInsets: EdgeInsets.only(left: 15.w, right: 15.w),
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
                            Strings.linkMyGroups,
                            textAlign: TextAlign.left,
                            style: titleTextStyle,
                          ),
                        ),
                        Container(
                          width: 23.w,
                          child: Center(
                            child: IconButton(
                              icon: (_user.linkGroup == true)
                                  ? Icon(Icons.check_box)
                                  : Icon(Icons.check_box_outline_blank),
                              color: AppColors.selectedButtonBG,
                              onPressed: () {
                                setState(() => {
                                      _user.linkGroup = !_user.linkGroup,
                                      updatelinkGroupStatus()
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
                      title: Strings.myGroups,
                      align: TextAlign.left,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  SepratorLine(
                    hight: 1.h,
                    edgeInsets: EdgeInsets.only(left: 15.w, right: 15.w),
                  ),

                  SizedBox(height: 20.h),

                  _myGroupsList(),
                  //--------------------------

                  //--> Copy All Codes
                  DottedBorder(
                    borderType: BorderType.RRect,
                    radius: Radius.circular(30.r),
                    color: Color(0xFF3475F0),
                    child: Container(
                      width: 345.w,
                      height: 50.h,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          Strings.copyAllCodes,
                          style: TextStyle(
                            fontFamily: 'OpenSans',
                            fontSize: 14.sp,
                            color: Color(0xFF3475F0),
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.transparent,
                          shadowColor: Colors.transparent,
                        ),
                      ),
                    ),
                  ),
                  //--------------------------

                  SizedBox(height: 10.h),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _footer(),
    );
  }

  Container _getNameSection() {
    return Container(
      height: (isNameEditable) ? 84.h : 63.h,
      margin: EdgeInsets.fromLTRB(15.w, 0.0, 15.w, 0.0),
      child: Column(
        children: [
          Container(
            height: 22.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  Strings.name,
                  textAlign: TextAlign.end,
                  style: titleTextStyle,
                ),
                EditButton(
                  onButtonClicked: (value) {
                    print('name selected value $value');
                    if (isNameEditable == true) {
                      updateName();
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _userName,
                        textAlign: TextAlign.end,
                        style: nameTextStyle,
                      ),
                    ],
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
          hintText: Strings.nameHint,
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
      margin: EdgeInsets.fromLTRB(15.w, 0.0, 15.w, 0.0),
      child: Column(
        children: [
          Container(
            height: 22.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  Strings.mobile,
                  textAlign: TextAlign.end,
                  style: titleTextStyle,
                ),
                EditButton(
                  onButtonClicked: (value) {
                    print('mobile selected value $value');
                    if (isMobileEditable == true) {
                      updatePhoneNumber();
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _countyCode + ' ' + _mobileNumber,
                        textAlign: TextAlign.end,
                        style: nameTextStyle,
                      ),
                    ],
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
        hintText: '', //Strings.countryCodeHint,
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
        hintText: Strings.phoneNumberHint,
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

  Column _myGroupsList() {
    return Column(
      children: <Widget>[
        ..._user.groups.map((item) {
          return _groupItem(item);
        }).toList(),
      ],
    );
  }

  Container _groupItem(HiveGroupUser group) {
    return Container(
      height: 90.h,
      // color: Colors.green,
      margin: EdgeInsets.only(left: 20.0, top: 10.0, right: 20.0),
      child: Column(
        children: <Widget>[
          Container(
            height: 25.h,
            child: Align(
              alignment: FractionalOffset.topLeft,
              child: Text(group.groupId, style: titleTextStyle),
            ),
          ),
          SizedBox(height: 5.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'ID: 123456\nCode: abcd',
                style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.normal,
                  fontSize: 16.sp,
                  color: AppColors.appTitle,
                ),
              ),
              Container(
                height: 36.h,
                width: 145.w,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    primary: AppColors.selectedButtonBG,
                  ),
                  child: Text(
                    Strings.copyThisInfo,
                    style: buttonTextStyle,
                  ),
                ),
              ),
            ],
          ),
        ],
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
              Strings.back,
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
}
