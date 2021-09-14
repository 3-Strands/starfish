import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:grpc/grpc_or_grpcweb.dart';
import 'package:hive/hive.dart';
// import 'package:smart_select/smart_select.dart';
import 'package:starfish/config/routes/routes.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:starfish/constants/strings.dart';
import 'package:starfish/db/hive_country.dart';
import 'package:starfish/db/hive_current_user.dart';
import 'package:starfish/db/hive_database.dart';
import 'package:starfish/db/hive_language.dart';
import 'package:starfish/widgets/app_logo_widget.dart';
import 'package:starfish/constants/text_styles.dart';
import 'package:starfish/widgets/italic_title_label_widget.dart';
import 'package:starfish/widgets/title_label_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:starfish/smart_select/src/model/choice_item.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:starfish/smart_select/src/model/modal_config.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:starfish/smart_select/src/tile/tile.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:starfish/smart_select/src/widget.dart';

class CreateProfileScreen extends StatefulWidget {
  CreateProfileScreen({Key? key, this.title = ''}) : super(key: key);

  final String title;

  @override
  _CreateProfileScreenState createState() => _CreateProfileScreenState();
}

class _CreateProfileScreenState extends State<CreateProfileScreen> {
  final _nameController = TextEditingController();

  final FocusNode _nameFocus = FocusNode();

  late List<HiveCountry> _selectedCountries = [];
  late List<HiveLanguage> _selectedLanguages = [];

  bool _isLoading = false;

  late Box<HiveCountry> _countryBox;
  late Box<HiveLanguage> _languageBox;
  late Box<HiveCurrentUser> _currentUserBox;

  late List<HiveCountry> _countryList = [];
  late List<HiveLanguage> _languageList = [];
  late HiveCurrentUser _user;

  @override
  void initState() {
    super.initState();
    _countryBox = Hive.box<HiveCountry>(HiveDatabase.COUNTRY_BOX);
    _languageBox = Hive.box<HiveLanguage>(HiveDatabase.LANGUAGE_BOX);
    _currentUserBox = Hive.box<HiveCurrentUser>(HiveDatabase.CURRENT_USER_BOX);

    _getCurrentUser();
    _getAllCountries();
    _getAllLanguages();
  }

  void _getCurrentUser() {
    _user = _currentUserBox.values.first;
    setState(() {
      _nameController.text = _user.name;
    });
  }

  void _getAllCountries() {
    _countryList = _countryBox.values.toList();

    for (var countryId in _user.countryIds) {
      _countryList
          .where((item) => item.id == countryId)
          .forEach((item) => {_selectedCountries.add(item)});
    }
  }

  void _getAllLanguages() {
    print("_getAllLanguages");
    _languageList = _languageBox.values.toList();
    // print("_user.languageIds ==>>");
    // print(_user.languageIds);
    // print("===========");

    print("_languageList length ==>>");
    print(_languageList.length);
    // for (var language in _languageList) {
    //   print(language.id);
    //   print(language.name);
    // }
    // print("===========");

    // for (var languageId in _user.languageIds) {
    //   _languageList.where((item) => item.id == languageId).forEach((item) =>
    //       {print('_languageList ${item.name}'), _selectedLanguages.add(item)});
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Stack(children: [
          SingleChildScrollView(
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
                    title: Strings.enterName,
                    align: TextAlign.left,
                  ),
                ),
                SizedBox(height: 10.h),
                _getNameField(),
                SizedBox(height: 10.h),
                Align(
                  alignment: FractionalOffset.topLeft,
                  child: ItalicitleLabel(title: Strings.enterNameDetail),
                ),
                //--------------------------
                SizedBox(height: 30.h),

                //--> Select country section
                Align(
                  alignment: FractionalOffset.topLeft,
                  child: TitleLabel(
                    title: Strings.selectCountry,
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
                      onChange: (selected) =>
                          setState(() => _selectedCountries = selected.value),
                      choiceItems: S2Choice.listFrom<HiveCountry, HiveCountry>(
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

                SizedBox(height: 10.h),
                Align(
                  alignment: FractionalOffset.topLeft,
                  child: ItalicitleLabel(title: Strings.selectCountryDetail),
                ),
                //--------------------------
                SizedBox(height: 30.h),
                //--> Select language section
                Align(
                  alignment: FractionalOffset.topLeft,
                  child: TitleLabel(
                    title: Strings.selectLanugages,
                    align: TextAlign.left,
                  ),
                ),
                SizedBox(height: 10.h),
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Container(
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
                ),
                SizedBox(height: 10.h),
                Align(
                  alignment: FractionalOffset.topLeft,
                  child: ItalicitleLabel(title: Strings.selectLanugagesDetail),
                ),
              ],
            ),
          ),
          if (_isLoading == true)
            Center(
              child: CircularProgressIndicator(),
            )
        ]),
      ),
      bottomNavigationBar: _footer(),
    );
  }

  Container _getNameField() {
    return Container(
      height: 52.h,
      margin: EdgeInsets.fromLTRB(15.w, 0.0, 15.w, 0.0),
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
                  )
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
              Strings.finish,
              textAlign: TextAlign.start,
              style: buttonTextStyle,
            ),
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  Routes.dashboard, (Route<dynamic> route) => false);
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
