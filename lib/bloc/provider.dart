// import 'package:flutter/material.dart';
// import 'data_bloc.dart';

// class Provider extends InheritedWidget {
//   final DataBloc bloc;

//   Provider({Key? key, required Widget child})
//       : bloc = DataBloc(),
//         super(key: key, child: child);

//   @override
//   bool updateShouldNotify(_) => true;

//   static DataBloc of(BuildContext context) {
//     return context.dependOnInheritedWidgetOfExactType<Provider>()!.bloc;
//   }
// }
