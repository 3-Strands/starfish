import 'package:flutter/material.dart';
import 'package:starfish/modules/actions_view/add_edit_action.dart';
import 'package:starfish/modules/authentication/otp_verification.dart';
import 'package:starfish/modules/authentication/phone_authentication.dart';
import 'package:starfish/modules/create_profile/create_profile.dart';
import 'package:starfish/modules/dashboard/dashboard.dart';
import 'package:starfish/modules/groups_view/add_edit_group_screen.dart';
import 'package:starfish/modules/material_view/add_edit_material_screen.dart';
import 'package:starfish/modules/settings_view/settings_view.dart';
import 'package:starfish/modules/actions_view/select_action.dart';

class Routes {
  Routes._(); //this is to prevent anyone from instantiate this object

  static const String phoneAuthentication = '/phoneAuthentication';
  static const String otpVerification = '/otpVerification';
  static const String showProfile = '/showProfile';
  static const String dashboard = '/dashboard';
  static const String settings = '/settings';
  static const String addNewMaterial = '/addNewMaterial';
  static const String createNewGroup = '/createNewGroup';
  static const String addActions = '/addActions';
  static const String selectActions = '/selectActions';

  static final routes = <String, WidgetBuilder>{
    phoneAuthentication: (BuildContext context) => PhoneAuthenticationScreen(),
    otpVerification: (BuildContext context) => OTPVerificationScreen(),
    showProfile: (BuildContext context) => CreateProfileScreen(),
    dashboard: (BuildContext context) => Dashboard(),
    settings: (BuildContext context) => SettingsScreen(),
    addNewMaterial: (BuildContext context) => AddEditMaterialScreen(),
    addActions: (BuildContext context) => AddEditAction(),
    selectActions: (BuildContext context) => SelectActions(),
    createNewGroup: (BuildContext context) => AddEditGroupScreen(),
  };
}
