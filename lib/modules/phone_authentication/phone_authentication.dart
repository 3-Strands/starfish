import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:starfish/constants/assets_path.dart';
import 'package:starfish/constants/strings.dart';
import 'package:starfish/modules/otp_verification/otp_verification.dart';
import 'package:sizer/sizer.dart';

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

  @override
  Widget build(BuildContext context) {
    _fieldFocusChange(
        BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
      currentFocus.unfocus();
      FocusScope.of(context).requestFocus(nextFocus);
    }

    Widget _countryCodeField() {
      return TextFormField(
        controller: _countryCodeController,
        focusNode: _countryCodeFocus,
        onFieldSubmitted: (term) {
          _fieldFocusChange(context, _countryCodeFocus, _phoneNumberFocus);
        },
        obscureText: false,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
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
            fillColor: Colors.grey[200]),
      );
    }

    Widget _phoneNumberField() {
      return TextFormField(
        controller: _phoneNumberController,
        focusNode: _phoneNumberFocus,
        onFieldSubmitted: (term) {
          _phoneNumberFocus.unfocus();
        },
        obscureText: false,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
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
            fillColor: Colors.grey[200]),
      );
    }

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Stack(
          children: <Widget>[
            Container(
              height: 100.h,
              width: 100.h,
              color: Colors.transparent,
              child: Center(
                child: SingleChildScrollView(
                  child: Container(
                    height: 100.h,
                    width: 100.h,
                    color: Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.all(36.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          _logo(),
                          SizedBox(height: 50.0),
                          Text(
                            Strings.phoneAuthenticationTitle,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: 'OpenSans',
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                                color: Colors.black),
                          ),
                          SizedBox(height: 30.0),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 60.0,
                              width: MediaQuery.of(context).size.width - 40.0,
                              padding: const EdgeInsets.only(
                                  left: 10.0, right: 10.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.grey[200],
                              ),
                              child: TextButton(
                                style: ButtonStyle(
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.grey),
                                ),
                                onPressed: () {},
                                child: Text(Strings.selectCountry),
                              ),
                            ),
                          ),
                          SizedBox(height: 30.0),
                          Container(
                            height: 50,
                            child: Row(
                              children: [
                                Container(
                                  height: 50,
                                  width: 100.0,
                                  child: _countryCodeField(),
                                ),
                                SizedBox(width: 10.0),
                                Container(
                                  height: 50,
                                  width:
                                      MediaQuery.of(context).size.width - 190,
                                  child: _phoneNumberField(),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                color: Colors.grey[200],
                width: MediaQuery.of(context).size.width,
                height: 9.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width - 40.0,
                      height: 40.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                        color: Colors.blue,
                      ),
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OTPVerificationScreen(),
                            ),
                          );
                        },
                        child: Text(Strings.next),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Container _logo() {
    return Container(
      height: 19.h,
      width: 43.h,
      child: SvgPicture.asset(ImagePath.logoStarfish),
    );
  }
}
