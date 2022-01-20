import 'package:cron/cron.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:starfish/utils/helpers/general_functions.dart';
import 'package:starfish/utils/services/sync_service.dart';
import 'app.dart';
import 'config/app_config.dart';
import 'config/config_reader.dart';
import 'db/hive_database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (!kIsWeb) {
    Firebase.initializeApp();
  }

  await HiveDatabase().init();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) async {
    await ConfigReader.initialize();
    FlavorConfig(
      flavor: Flavor.DEV,
      values: FlavorValues(
        baseUrl: ConfigReader.getDevURL(),
        apiKey: ConfigReader.getDevAPIKey(),
      ),
    );
    return runApp(Starfish());
  });
  GeneralFunctions.configLoading();
}
