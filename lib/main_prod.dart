import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:starfish/app.dart';
import 'package:starfish/config/config_reader.dart';
import 'package:starfish/utils/helpers/general_functions.dart';
import 'config/app_config.dart';
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
      flavor: Flavor.PROD,
      values: FlavorValues(
        baseUrl: ConfigReader.getProdURL(),
        apiKey: ConfigReader.getProdAPIKey(),
      ),
    );
    return runApp(Starfish());
  });
  GeneralFunctions.configLoading();
}
