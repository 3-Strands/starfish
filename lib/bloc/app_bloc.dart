import 'package:starfish/bloc/material_bloc.dart';

class AppBloc {
  late MaterialBloc _materialBloc;

  AppBloc() {
    _materialBloc = MaterialBloc();
  }

  MaterialBloc get materialBloc => _materialBloc;
}
