import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:starfish/models/country_model.dart';
import 'package:starfish/utils/helpers/general_functions.dart';
// import 'package:starfish/utils/services/sync_service.dart';
import 'app.dart';
import 'config/app_config.dart';
import 'config/config_reader.dart';
import 'db/hive_database.dart';

// const String countryBoxName = 'country';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // HiveBoxes().initHive();

  HiveDatabase().init();
  // SyncService.syncAll();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) async {
    await ConfigReader.initialize();
    FlavorConfig(
      flavor: Flavor.DEV,
      values: FlavorValues(
        baseUrl: ConfigReader.getDevURL(),
      ),
    );
    return runApp(Starfish());
  });
  GeneralFunctions.configLoading();
}

// class HiveBoxes {
//   void initHive() async {
//     Directory directory = await getApplicationDocumentsDirectory();
//     Hive.init(directory.path);
//     Hive.registerAdapter(CountryModelAdapter());
//     openBoxes();
//   }

//   void openBoxes() async {
//     await Hive.openBox<CountryModel>(countryBoxName);
//   }
// }
