import 'package:hive/hive.dart';
import 'package:collection/collection.dart';
import 'package:starfish/db/hive_database.dart';
import 'package:starfish/db/hive_language.dart';

class LanguageProvider {
  late Box<HiveLanguage> _languageBox;

  LanguageProvider() {
    _languageBox = Hive.box<HiveLanguage>(HiveDatabase.LANGUAGE_BOX);
  }

  List<HiveLanguage> getAll() {
    return _languageBox.values.toList();
  }

  HiveLanguage? getById(String languageId) {
    return _languageBox.values
        .firstWhereOrNull((element) => element.id == languageId);
  }

  List<HiveLanguage> getAllByIds(List<String> languageIds,
      {required Map<String, String> languages}) {
    List<HiveLanguage> _languages = [];
    languageIds.forEach((id) {
      HiveLanguage? _language = LanguageProvider().getById(id);

      // There may be case the language is not available in the Countries followed by this user,
      // so get the name of language in `this.languages`
      if (_language == null) {
        languages.forEach((key, value) {
          if (key == id) {
            _language = HiveLanguage(id: key, name: value);
          }
        });
      }
      if (_language != null) {
        _languages.add(_language!);
      }
    });
    return _languages;
  }
}
