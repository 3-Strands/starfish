import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grpc/grpc.dart';
// import 'package:smart_select/smart_select.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:starfish/constants/assets_path.dart';
import 'package:starfish/constants/strings.dart';
import 'package:starfish/constants/text_styles.dart';
import 'package:starfish/repository/app_data_repository.dart';
import 'package:starfish/repository/current_user_repository.dart';
import 'package:starfish/smart_select/src/model/choice_item.dart';
import 'package:starfish/smart_select/src/model/modal_config.dart';
import 'package:starfish/smart_select/src/tile/tile.dart';
import 'package:starfish/smart_select/src/widget.dart';
import 'package:starfish/src/generated/starfish.pb.dart';
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
  // List<String> groups = List<String>.generate(4, (i) => "Group: $i");

  List<Country> _countriesList = [];
  List<String> _selectedCountries = [];

  List<String> _selectedLanguages = [];
  List<Language> _languagesList = [];

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
    _listAllCountries();
    _listAllLanguages();
  }

  void _getCurrentUser() async {
    await CurrentUserRepository().getUser().then((User user) {
      print("get current user");
      setState(() {
        _userName = user.name;
        _nameController.text = user.name;
        _mobileNumber = user.phone;
        _phoneNumberController.text = user.phone;
      });
    });
  }

  void updateCurrentUser() async {
    // await CurrentUserRepository().updateUser().then((User user) {
    //   print("updated current user");
    //   // print(user);
    //   // print(user.name);
    // });
  }

  void _listAllCountries() async {
    await AppDataRepository()
        .getAllCountries()
        .then((ResponseStream<Country> countries) {
      countries.listen((value) {
        // print(value.name);
        // Country countryObject = value;
        setState(() {
          _countriesList.add(value);
        });
        // print(countriesList[0].name);
      }, onError: ((err) {
        print(err);
      }), onDone: () {
        print('done');
      });
    });
  }

  void _listAllLanguages() async {
    await AppDataRepository()
        .getAllLanguages()
        .then((ResponseStream<Language> languages) {
      languages.listen((value) {
        print(value.name);
        setState(() {
          _languagesList.add(value);
        });
      }, onError: ((err) {
        print(err);
      }), onDone: () {
        print('done');
      });
    });
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
                      child: SmartSelect<String>.multiple(
                        title: Strings.country,
                        placeholder: Strings.selectCountry,
                        // value: _selectedCountries,
                        onChange: (selected) =>
                            setState(() => _selectedCountries = selected.value),
                        choiceItems: S2Choice.listFrom<String, Country>(
                          source: _countriesList,
                          value: (index, item) => item.id,
                          title: (index, item) => item.name,
                          //  group: (index, item) => item['brand'],
                        ),
                        choiceGrouped: false,
                        modalFilter: true,
                        modalFilterAuto: true,
                        modalType: S2ModalType.bottomSheet,
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
                      child: SmartSelect<String>.multiple(
                        title: Strings.lanugages,
                        placeholder: Strings.selectLanugages,
                        // value: _selectedLanguages,
                        onChange: (selected) {
                          setState(() => _selectedLanguages = selected.value);
                        },
                        choiceItems: S2Choice.listFrom<String, Language>(
                            source: _languagesList,
                            value: (index, item) => item.id,
                            title: (index, item) => item.name,
                            group: (index, item) {
                              return 'Selected';
                            }),
                        choiceGrouped: true,
                        modalType: S2ModalType.bottomSheet,
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
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '', //Strings.lastSuccessfullSync + ': ',
                            style: TextStyle(
                                color: AppColors.appTitle,
                                fontWeight: FontWeight.bold,
                                fontSize: 24.0),
                          ),
                          TextSpan(
                            text: '', //"13-AUG",
                            style: TextStyle(
                                color: AppColors.appTitle,
                                fontWeight: FontWeight.normal,
                                fontSize: 24.0),
                          )
                        ],
                      ),
                    ),
                  ),

                  //--------------------------

                  SizedBox(height: 50.h),

                  //--> For group admin section
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
                              icon: const Icon(Icons.check_box),
                              color: AppColors.selectedButtonBG,
                              onPressed: () {},
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  //--------------------------

                  SizedBox(height: 50.h),

                  //--> For my groups section
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
                  //--------------------------

                  SizedBox(height: 20.h),

                  // Column(
                  //   children: <Widget>[
                  //     ...groups.map((item) {
                  //       return Text(item);
                  //     }).toList(),
                  //   ],
                  // ),
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
