import 'package:starfish/bloc/action_bloc.dart';
import 'package:starfish/bloc/group_bloc.dart';
import 'package:starfish/bloc/material_bloc.dart';
import 'package:starfish/bloc/user_bloc.dart';

class AppBloc {
  late MaterialBloc _materialBloc;
  late GroupBloc _groupBloc;
  late ActionBloc _actionBloc;
  late UserBloc _userBloc;

  AppBloc() {
    _materialBloc = MaterialBloc();
    _groupBloc = GroupBloc();
    _actionBloc = ActionBloc();
    _userBloc = UserBloc();
  }

  MaterialBloc get materialBloc => _materialBloc;
  GroupBloc get groupBloc => _groupBloc;
  ActionBloc get actionBloc => _actionBloc;
  UserBloc get userBloc => _userBloc;
}
