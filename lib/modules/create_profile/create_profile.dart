import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:starfish/config/routes/routes.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:starfish/constants/strings.dart';
import 'package:starfish/db/hive_country.dart';
import 'package:starfish/db/hive_current_user.dart';
import 'package:starfish/db/hive_database.dart';
import 'package:starfish/db/hive_language.dart';
import 'package:starfish/repository/current_user_repository.dart';
import 'package:starfish/select_items/select_drop_down.dart';
import 'package:starfish/utils/services/sync_service.dart';
import 'package:starfish/widgets/app_logo_widget.dart';
import 'package:starfish/constants/text_styles.dart';
import 'package:starfish/widgets/italic_title_label_widget.dart';
import 'package:starfish/widgets/title_label_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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

    _countryBox = Hive.box<HiveCountry>(HiveDatabase.COUNTRY_BOX);
    _languageBox = Hive.box<HiveLanguage>(HiveDatabase.LANGUAGE_BOX);
    _currentUserBox = Hive.box<HiveCurrentUser>(HiveDatabase.CURRENT_USER_BOX);

    _getCurrentUser();
    _getAllCountries();
    // _getAllLanguages();
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

    _getAllLanguages();
  }

  void _getAllLanguages() {
    print("_getAllLanguages");
    _languageList = _languageBox.values.toList();
    for (var languageId in _user.languageIds) {
      _languageList
          .where((item) => item.id == languageId)
          .forEach((item) => {_selectedLanguages.add(item)});
    }
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
        .then((value) => {
              SyncService().syncLanguages(),
              setState(() => _isLoading = false),
              _user.countryIds = value.countryIds,
              _currentUserBox.putAt(0, _user),
            });
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

    _user.countryIds = _selectedCountryIds;
    _user.languageIds = _selectedLanguageIds;

    print('FINISH: $_user');
    await CurrentUserRepository()
        .updateCurrentUser(_user.toUser(), fieldMaskPaths)
        .then((value) => {
              print('=================== START ==================='),
              print(value),
              setState(() => _isLoading = false),
              _user.name = value.name,
              _user.languageIds = value.languageIds,
              _currentUserBox.putAt(0, _user),
              Navigator.of(context).pushNamedAndRemoveUntil(
                  Routes.dashboard, (Route<dynamic> route) => false)
            })
        .whenComplete(() => Navigator.of(context).pushNamedAndRemoveUntil(
            Routes.dashboard, (Route<dynamic> route) => false));
  }

  @override
  Widget build(BuildContext context) {
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
                      SelectDropDown(
                        navTitle: Strings.selectCountry,
                        placeholder: Strings.selectCountry,
                        selectedValues: _selectedCountries,
                        choice: SelectType.multiple,
                        dataSource: DataSourceType.countries,
                        onDoneClicked: <T>(countries) {
                          // print("Selected Countries ==>> $countries");
                          setState(() {
                            _selectedCountries = countries as List<HiveCountry>;
                            _updateUserCountries();
                          });
                        },
                      ),
                      SizedBox(height: 10.h),
                      Align(
                        alignment: FractionalOffset.topLeft,
                        child:
                            ItalicitleLabel(title: Strings.selectCountryDetail),
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
                      SelectDropDown(
                        navTitle: Strings.selectLanugages,
                        placeholder: Strings.selectLanugages,
                        selectedValues: _selectedLanguages,
                        choice: SelectType.multiple,
                        dataSource: DataSourceType.languages,
                        onDoneClicked: <T>(languages) {
                          // print("Selected languages ==>> $_selectedLanguages");
                          setState(() {
                            _selectedLanguages =
                                languages as List<HiveLanguage>;
                          });
                        },
                      ),
                      SizedBox(height: 10.h),
                      Align(
                        alignment: FractionalOffset.topLeft,
                        child: ItalicitleLabel(
                            title: Strings.selectLanugagesDetail),
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
              Strings.finish,
              textAlign: TextAlign.start,
              style: buttonTextStyle,
            ),
            onPressed: () {
              _updateUserProfile();
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
