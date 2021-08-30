import 'package:flutter/material.dart';
import 'package:starfish/modules/authentication/otp_verification.dart';
import 'package:starfish/modules/authentication/phone_authentication.dart';
import 'package:starfish/modules/create_profile/create_profile.dart';
import 'package:starfish/modules/dashboard/dashboard.dart';

class Routes {
  Routes._(); //this is to prevent anyone from instantiate this object

  static const String phoneAuthentication = '/phoneAuthentication';
  static const String otpVerification = '/otpVerification';
  static const String showProfile = '/showProfile';
  static const String dashboard = '/dashboard';

  static final routes = <String, WidgetBuilder>{
    phoneAuthentication: (BuildContext context) => PhoneAuthenticationScreen(),
    otpVerification: (BuildContext context) => OTPVerificationScreen(),
    showProfile: (BuildContext context) => CreateProfileScreen(),
    dashboard: (BuildContext context) => Dashboard(),
  };
}
