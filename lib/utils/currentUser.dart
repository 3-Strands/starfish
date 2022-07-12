import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starfish/models/user.dart';
import 'package:starfish/repositories/authentication_repository.dart';

extension CurrentUser on BuildContext {
  AppUser get currentUser => read<AuthenticationRepository>().currentSession!.user;
}
