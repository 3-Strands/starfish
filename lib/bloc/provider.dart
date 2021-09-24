import 'package:flutter/material.dart';
import 'app_bloc.dart';

class Provider extends InheritedWidget {
  final AppBloc bloc;

  Provider({Key? key, required Widget child})
      : bloc = AppBloc(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(_) => true;

  static AppBloc of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Provider>()!.bloc;
  }
}
