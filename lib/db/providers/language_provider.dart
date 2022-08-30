// import 'package:hive/hive.dart';
// import 'package:collection/collection.dart';
// import 'package:starfish/db/hive_database.dart';
// import 'package:starfish/db/hive_language.dart';

// class LanguageProvider {
//   late Box<HiveLanguage> _languageBox;

//   LanguageProvider() {
//     _languageBox = Hive.box<HiveLanguage>(HiveDatabase.LANGUAGE_BOX);
//   }

//   List<HiveLanguage> getAll() {
//     return _languageBox.values.toList();
//   }

//   HiveLanguage? getById(String languageId) {
//     return _languageBox.values
//         .firstWhereOrNull((element) => element.id == languageId);
//   }
// }
