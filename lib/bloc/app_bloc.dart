import 'package:starfish/bloc/group_bloc.dart';
import 'package:starfish/bloc/material_bloc.dart';
import 'package:starfish/bloc/user_bloc.dart';

class AppBloc {
  late MaterialBloc _materialBloc;
  late GroupBloc _groupBloc;
  late UserBloc _userBloc;

  AppBloc() {
    _materialBloc = MaterialBloc();
    _groupBloc = GroupBloc();
    _userBloc = UserBloc();
  }

  MaterialBloc get materialBloc => _materialBloc;
  GroupBloc get groupBloc => _groupBloc;
  UserBloc get userBloc => _userBloc;
}
