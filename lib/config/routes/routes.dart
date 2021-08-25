import 'package:flutter/material.dart';
import 'package:starfish/modules/phone_authentication/phone_authentication.dart';

class Routes {
  Routes._(); //this is to prevent anyone from instantiate this object

  static const String phoneAuthentication = '/phoneAuthentication';

  static final routes = <String, WidgetBuilder>{
    phoneAuthentication: (BuildContext context) => PhoneAuthenticationScreen(),
  };
}
