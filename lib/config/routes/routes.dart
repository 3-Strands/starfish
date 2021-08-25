import 'package:flutter/material.dart';

class Routes {
  Routes._(); //this is to prevent anyone from instantiate this object

  static const String login = '/login';

  static final routes = <String, WidgetBuilder>{
    // signin: (BuildContext context) => Login(),
  };
}
