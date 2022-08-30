// import 'dart:async';

// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:starfish/db/hive_country.dart';
// import 'package:starfish/db/hive_database.dart';
// import 'package:starfish/db/hive_language.dart';
// import 'package:starfish/repository/current_user_repository.dart';
// import 'package:starfish/src/generated/starfish.pb.dart';

// class ProfileBloc extends Object {
//   Box<HiveCountry> _countryBox =
//       Hive.box<HiveCountry>(HiveDatabase.COUNTRY_BOX);
//   Box<HiveLanguage> _languageBox =
//       Hive.box<HiveLanguage>(HiveDatabase.LANGUAGE_BOX);

//   StreamController<List<HiveCountry>> _countryController =
//       StreamController<List<HiveCountry>>();
//   StreamController<List<HiveLanguage>> _languageController =
//       StreamController<List<HiveLanguage>>();

//   Stream<List<HiveCountry>> get countries => _countryController.stream;
//   Stream<List<HiveLanguage>> get languages => _languageController.stream;

//   /*Stream<List<HiveCountry>> get countries async* {
//     //_countryBox.watch().map((event) => _countryBox.values.toList());
//     _countryBox.watch().listen((event) {
//       print('Watch: $event');
//     });
//   }*/

//   ProfileBloc() {
//     _countryController.sink.add(_countryBox.values.toList());
//     _countryBox.watch().listen((event) {
//       print('Watch Country: ${event.runtimeType}');
//       _countryController.sink.add(_countryBox.values.toList());
//     });

//     _languageController.sink.add(_languageBox.values.toList());
//     _languageBox.watch().listen((event) {
//       print('Watch Language: ${event.runtimeType}');
//       _languageController.sink.add(_languageBox.values.toList());
//     });
//   }

//   dispose() {
//     _countryController.close();
//     _languageController.close();
//   }
// }
