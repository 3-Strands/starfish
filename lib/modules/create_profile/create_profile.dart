import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:grpc/grpc_or_grpcweb.dart';
import 'package:smart_select/smart_select.dart';
import 'package:starfish/config/routes/routes.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:starfish/constants/strings.dart';
import 'package:starfish/repository/app_data_repository.dart';
import 'package:starfish/repository/current_user_repository.dart';
import 'package:starfish/src/generated/starfish.pb.dart';
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
  List<Country> _countriesList = [];
  List<String> _selectedCountries = [];

  List<String> _selectedLanguages = [];
  List<Language> _languagesList = [];

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    listAllCountries();
    listAllLanguages();
  }

  void getCurrentUser() async {
    await CurrentUserRepository().getUser().then((User user) {
      print("get current user");
      setState(() {
        _nameController.text = user.name;
      });
    });
  }

  void listAllCountries() async {
    await AppDataRepository()
        .listAllCountries()
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

  void listAllLanguages() async {
    setState(() {
      _isLoading = true;
    });

    await AppDataRepository()
        .listAllLanguages()
        .then((ResponseStream<Language> languages) {
      languages.listen((value) {
        print(value.name);
        setState(() {
          _languagesList.add(value);
        });
      }, onError: ((err) {
        print(err);
        setState(() {
          _isLoading = false;
        });
      }), onDone: () {
        print('done');
        setState(() {
          _isLoading = false;
        });
      });
    });
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
                  height: 70.h,
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
                      value: _selectedCountries,
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
                    height: 70.h,
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
                        value: _selectedLanguages,
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
