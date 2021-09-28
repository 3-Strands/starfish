import 'package:starfish/bloc/group_bloc.dart';
import 'package:starfish/bloc/material_bloc.dart';

class AppBloc {
  late MaterialBloc _materialBloc;
  late GroupBloc _groupBloc;

  AppBloc() {
    _materialBloc = MaterialBloc();
    _groupBloc = GroupBloc();
  }

  MaterialBloc get materialBloc => _materialBloc;
  GroupBloc get groupBloc => _groupBloc;
}
