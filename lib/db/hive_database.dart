import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:starfish/db/hive_action.dart';
import 'package:starfish/db/hive_current_user.dart';
import 'package:starfish/db/hive_group.dart';
import 'package:starfish/db/hive_language.dart';
import 'hive_country.dart';

class HiveDatabase {
  static const String COUNTRY_BOX = 'country';
  static const String LANGUAGE_BOX = 'languageBox';
  static const String CURRENT_USER_BOX = 'currentUserBox';
  static const String GROUPS_BOX = 'groupsBox';
  static const String ACTIONS_BOX = 'actionBox';

  static const String MATERIAL_BOX = 'materialBox';

  // static final HiveDatabase _dbHelper = HiveDatabase._internal();

  // late Box<HiveMaterial> materialBox;
  late Box<HiveCountry> countryBox;

  // HiveDatabase._internal() {
  //   initHive();
  // }

  void init() async {
    if (!kIsWeb) {
      Directory directory = await getApplicationDocumentsDirectory();
      Hive.init(directory.path);
    }
    Hive.registerAdapter(HiveCountryAdapter());
    Hive.registerAdapter(HiveLanguageAdapter());
    Hive.registerAdapter(HiveCurrentUserAdapter());
    Hive.registerAdapter(HiveGroupAdapter());
    Hive.registerAdapter(HiveActionAdapter());

    openBoxes();
  }

  void openBoxes() async {
    print("open boxes");
    // materialBox = await Hive.openBox<HiveMaterial>(MATERIAL_BOX);
    //countryBox = await Hive.openBox<CountryModel>(COUNTRY_BOX);

    await Hive.openBox<HiveCountry>(COUNTRY_BOX);
    await Hive.openBox<HiveLanguage>(LANGUAGE_BOX);
    await Hive.openBox<HiveCurrentUser>(CURRENT_USER_BOX);
    await Hive.openBox<HiveGroup>(GROUPS_BOX);
    await Hive.openBox<HiveAction>(ACTIONS_BOX);
  }
}
