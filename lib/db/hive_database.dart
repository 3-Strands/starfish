import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:starfish/db/hive_action.dart';
import 'package:starfish/db/hive_current_user.dart';
import 'package:starfish/db/hive_date.dart';
import 'package:starfish/db/hive_group.dart';
import 'package:starfish/db/hive_language.dart';
import 'package:starfish/db/hive_last_sync_date_time.dart';
import 'package:starfish/db/hive_material.dart';
import 'package:starfish/db/hive_material_feedback.dart';
import 'package:starfish/db/hive_material_topic.dart';
import 'hive_country.dart';

class HiveDatabase {
  static const String COUNTRY_BOX = 'countryBox'; //0
  static const String LANGUAGE_BOX = 'languageBox'; //1
  static const String CURRENT_USER_BOX = 'currentUserBox'; //2
  static const String GROUPS_BOX = 'groupsBox'; //3
  static const String ACTIONS_BOX = 'actionBox'; //4
  static const String MATERIAL_BOX = 'materialBox'; //5
  static const String MATERIAL_FEEDBACK_BOX = 'materialTopicBox'; //6
  static const String DATE = 'dateBox'; //7
  static const String LAST_SYNC_BOX = 'lastSyncBox'; //8
  static const String MATERIAL_TOPIC_BOX = 'materialTopicBox'; //9

  // static final HiveDatabase _dbHelper = HiveDatabase._internal();

  // late Box<HiveMaterial> materialBox;
  // late Box<HiveCountry> countryBox;

  // HiveDatabase._internal() {
  //   initHive();
  // }

  void init() async {
    if (!kIsWeb) {
      Directory directory = await getApplicationDocumentsDirectory();
      Hive.init(directory.path);
    }
    Hive.registerAdapter(HiveLastSyncDateTimeAdapter());
    Hive.registerAdapter(HiveCountryAdapter());
    Hive.registerAdapter(HiveLanguageAdapter());
    Hive.registerAdapter(HiveCurrentUserAdapter());
    Hive.registerAdapter(HiveGroupAdapter());
    Hive.registerAdapter(HiveActionAdapter());
    Hive.registerAdapter(HiveMaterialAdapter());
    Hive.registerAdapter(HiveMaterialTopicAdapter());
    Hive.registerAdapter(HiveMaterialFeedbackAdapter());
    Hive.registerAdapter(HiveDateAdapter());

    openBoxes();
  }

  void openBoxes() async {
    print("open boxes");
    // materialBox = await Hive.openBox<HiveMaterial>(MATERIAL_BOX);
    // countryBox = await Hive.openBox<CountryModel>(COUNTRY_BOX);

    await Hive.openBox<HiveLastSyncDateTime>(LAST_SYNC_BOX);
    await Hive.openBox<HiveCountry>(COUNTRY_BOX);
    await Hive.openBox<HiveLanguage>(LANGUAGE_BOX);
    await Hive.openBox<HiveCurrentUser>(CURRENT_USER_BOX);
    await Hive.openBox<HiveGroup>(GROUPS_BOX);
    await Hive.openBox<HiveAction>(ACTIONS_BOX);
    await Hive.openBox<HiveMaterial>(MATERIAL_BOX);
    await Hive.openBox<HiveMaterialTopic>(MATERIAL_TOPIC_BOX);
  }
}
