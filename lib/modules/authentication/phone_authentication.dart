import 'package:flutter/material.dart';
import 'package:starfish/config/routes/routes.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:starfish/constants/strings.dart';
import 'package:sizer/sizer.dart';
import 'package:starfish/repository/current_user_repository.dart';
import 'package:starfish/src/generated/starfish.pb.dart';
import 'package:starfish/utils/services/grpc_client.dart';
import 'package:starfish/widgets/app_logo_widget.dart';
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

  void getCurrentUser() async {
    await CurrentUserRepository().getUser().then((User user) {
      print("get current user");
      // print(user);
      print(user.name);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Container(
          child: Stack(
            children: [
              Container(
                child: SingleChildScrollView(
                  reverse: true,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 17.7.h),
                      AppLogo(hight: 19.4.h, width: 43.0.w),
                      SizedBox(height: 6.1.h),
                      TitleLabel(
                        title: Strings.phoneAuthenticationTitle,
                        align: TextAlign.center,
                      ),
                      // SizedBox(height: 3.7.h),
                      // _selectCountyContainer(),
                      SizedBox(height: 3.7.h),
                      CountryDropDown(
                        onCountrySelect: (selectedCountry) {
                          if (selectedCountry.isCheck == true) {
                            setState(() {
                              _countryCodeController.text = selectedCountry.code;
                            });
                          } else {
                            setState(() {
                              _countryCodeController.text = '+1';
                            });
                          }
                        },
                      ),
                      SizedBox(height: 3.7.h),
                      _phoneNumberContainer(),
                      // Padding(
                      //   padding: EdgeInsets.only(
                      //       bottom: MediaQuery.of(context).viewInsets.bottom),
                      // ),
                    ],
                  ),
                ),
              ),
              // _footer()
            ]
          ),
        ),
      ),
      bottomNavigationBar: _footer()
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
      style: textFormFieldText,
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
      style: textFormFieldText,
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

  SizedBox _footer() {
   return SizedBox(
        height:15.h,
        child: Stack(
          children: [
            Positioned(
              child: new Align(
                alignment: FractionalOffset.bottomCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: 100.w,
                      height: 12.h,
                      color: AppColors.txtFieldBackground,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Align(
                          alignment: FractionalOffset.bottomCenter,
                          child: _nextButton(),
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

  Container _nextButton() {
    return Container(
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
              // getCurrentUser();
              Navigator.of(context).pushNamed(Routes.otpVerification);
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

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
}
