import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starfish/bloc/session_bloc.dart';
import 'package:starfish/modules/actions_view/add_edit_action.dart';
import 'package:starfish/modules/authentication/phone_authentication.dart';
import 'package:starfish/modules/create_profile/create_profile.dart';
import 'package:starfish/modules/dashboard/dashboard.dart';
import 'package:starfish/modules/groups_view/add_edit_group_screen.dart';
import 'package:starfish/modules/material_view/add_edit_material_screen.dart';
import 'package:starfish/modules/settings_view/settings_view.dart';

class Routes {
  Routes._(); //this is to prevent anyone from instantiate this object

  // static const String phoneAuthentication = '/phoneAuthentication';
  static const String showProfile = '/showProfile';
  static const String dashboard = '/';
  static const String settings = '/settings';
  static const String addNewMaterial = '/addNewMaterial';
  static const String createNewGroup = '/createNewGroup';
  static const String addActions = '/addActions';
  static const String selectActions = '/selectActions';

  static Route onGenerateRoute(RouteSettings settings) {
    final page = _getPageFromRoute(settings);

    final loginGuard = BlocBuilder<SessionBloc, SessionState>(
      builder: (context, state) {
        if (state is SessionActive) {
          return page;
        }
        return const PhoneAuthentication();
      },
    );

    return MaterialPageRoute<void>(
      settings: settings,
      builder: (BuildContext context) => loginGuard,
    );
  }

  static Widget _getPageFromRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      // case phoneAuthentication: return const PhoneAuthenticationScreen();
      case showProfile: return const CreateProfileScreen();
      case dashboard: return const Dashboard();
      case settings: return const SettingsScreen();
      case addNewMaterial: return const AddEditMaterialScreen();
      case addActions: return const AddEditAction();
      case createNewGroup: return const AddEditGroupScreen();
      default: return const Center(child: Text('404: Unknown Route'));
    }
  }
}
