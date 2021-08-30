import 'package:flutter/material.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:starfish/constants/strings.dart';
import 'package:sizer/sizer.dart';
import 'package:starfish/widgets/app_logo_widget.dart';
import 'package:starfish/widgets/expanded_section_widget.dart';
import 'package:starfish/widgets/scrollbar_widget.dart';
import 'package:starfish/constants/text_styles.dart';
import 'package:starfish/widgets/select_country_dropdown_widget.dart';
import 'package:starfish/widgets/title_label_widget.dart';
import 'otp_verification.dart';

class PhoneAuthenticationScreen extends StatefulWidget {
  PhoneAuthenticationScreen({Key? key, this.title = ''}) : super(key: key);

  final String title;

  @override
  _PhoneAuthenticationScreenState createState() =>
      _PhoneAuthenticationScreenState();
}

class _PhoneAuthenticationScreenState extends State<PhoneAuthenticationScreen> {
  final _countryCodeController = TextEditingController();
  final _phoneNumberController = TextEditingController();

  final FocusNode _countryCodeFocus = FocusNode();
  final FocusNode _phoneNumberFocus = FocusNode();

  bool isStrechedDropDown = false;
  String title = 'Select Technology';
  TextEditingController _textController = TextEditingController();
  List<CountryListTileModel> checkBoxListTileModel =
      CountryListTileModel.getCountries();
  List<CountryListTileModel> newDataList =
      List.from(CountryListTileModel.getCountries());

  onItemChanged(String value) {
    setState(() {
      newDataList = checkBoxListTileModel
          .where((string) =>
              string.name.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  void itemChange(bool val, int index) {
    final findIndex = checkBoxListTileModel
        .indexWhere((element) => element.id == newDataList[index].id);

    setState(() {
      if (findIndex >= 0) {
        checkBoxListTileModel[findIndex].isCheck = val;
      }
      newDataList[index].isCheck = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Stack(
          children: <Widget>[
            Container(
              height: 100.h,
              width: 100.h,
              color: AppColors.background,
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.fromLTRB(0.0.w, 14.5.h, 0.0.w, 4.0.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      AppLogo(hight: 19.4.h, width: 43.0.w),
                      SizedBox(height: 6.1.h),
                      TitleLabel(title: Strings.phoneAuthenticationTitle),
                      // SizedBox(height: 3.7.h),
                      // _selectCountyContainer(),
                      SizedBox(height: 3.7.h),
                      CountryDropDown(
                        onCountrySelect: (CountryListTileModel country) {
                          print('selected country');
                          print(country.name);
                          _countryCodeController.text = country.code;
                        },
                      ),
                      SizedBox(height: 3.7.h),
                      _phoneNumberContainer()
                    ],
                  ),
                ),
              ),
            ),
            _footer()
          ],
        ),
      ),
    );
  }

  Column _selectCountyContainer() {
    return Column(
      children: <Widget>[
        Container(
          height: 6.4.h,
          width: 92.0.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: AppColors.txtFieldBackground,
          ),
          child: TextButton(
            style: ButtonStyle(
              alignment: Alignment.centerLeft,
            ),
            onPressed: () {
              print(newDataList);
              setState(() {
                isStrechedDropDown = !isStrechedDropDown;
              });
            },
            child: Text(
              Strings.selectCountry,
              style: TextStyle(
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.normal,
                fontSize: 16.0.sp,
                color: AppColors.txtFieldTextColor,
              ),
            ),
          ),
        ),
        SizedBox(height: 2),
        Visibility(
          visible: isStrechedDropDown,
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: Color(0xffbbbbbb)),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Column(
              children: [
                Visibility(
                  visible: isStrechedDropDown,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _textController,
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        //here your padding
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(22)),
                          borderSide: BorderSide(color: Colors.black, width: 2),
                        ),
                        hintText: "search",
                      ),
                      onChanged: onItemChanged,
                    ),
                  ),
                ),
                ExpandedSection(
                  expand: isStrechedDropDown,
                  height: 10,
                  child:
                      // Container(
                      //   child: Text('This is contianer'),
                      // ),
                      MyScrollbar(
                    builder: (context, scrollController) =>
                        new ListView.builder(
                            padding: EdgeInsets.all(0),
                            controller: scrollController,
                            shrinkWrap: true,
                            itemCount: newDataList.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.only(right: 18.0),
                                child: CheckboxListTile(
                                  value: newDataList[index].isCheck,
                                  title: Text(newDataList[index].name),
                                  onChanged: (bool? value) {
                                    itemChange(value!, index);
                                  },
                                ),
                              );
                            }),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Container _phoneNumberContainer() {
    return Container(
      height: 6.4.h,
      margin: EdgeInsets.only(left: 4.0.w),
      child: Row(
        children: [
          Container(
            height: 6.4.h,
            width: 23.2.w,
            child: _countryCodeField(),
          ),
          SizedBox(width: 4.0.w),
          Container(
            height: 6.4.h,
            width: 64.8.w,
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
      style: TextStyle(
        fontFamily: 'OpenSans',
        fontWeight: FontWeight.normal,
        fontSize: 16.0.sp,
        color: AppColors.txtFieldTextColor,
      ),
      decoration: InputDecoration(
        hintText: Strings.countryCodeHint,
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
      style: TextStyle(
        fontFamily: 'OpenSans',
        fontWeight: FontWeight.normal,
        fontSize: 16.0.sp,
        color: AppColors.txtFieldTextColor,
      ),
      decoration: InputDecoration(
        hintText: Strings.phoneNumberHint,
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

  Positioned _footer() {
    return Positioned(bottom: 0, child: _nextButton());
  }

  Container _nextButton() {
    return Container(
      color: AppColors.txtFieldBackground,
      width: 100.0.w,
      height: 9.h,
      child: Container(
        margin: EdgeInsets.all(2.25.h),
        width: 85.0.w,
        height: 4.5.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          color: AppColors.selectedButtonBG,
        ),
        child: Padding(
          padding: EdgeInsets.all(0.0),
          child: SizedBox(
            height: 4.5.h,
            width: 85.0.w,
            child: ElevatedButton(
              child: Text(
                Strings.next,
                textAlign: TextAlign.start,
                style: textButtonTextStyle,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OTPVerificationScreen(),
                  ),
                );
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
      ),
    );
  }

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
}
