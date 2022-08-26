import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starfish/repositories/authentication_repository.dart';
import 'package:starfish/src/grpc_extensions.dart';

extension CurrentUser on BuildContext {
  User get currentUser => read<AuthenticationRepository>().getCurrentUser();
}
