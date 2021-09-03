import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:starfish/app.dart';
import 'package:starfish/config/config_reader.dart';
import 'package:starfish/utils/helpers/general_functions.dart';
import 'config/app_config.dart';

void main() async {
  
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) async {
    await ConfigReader.initialize();
    FlavorConfig(
      flavor: Flavor.PROD,
      values: FlavorValues(
        baseUrl: ConfigReader.getProdURL(),
      ),
    );
    return runApp(Starfish());
  });
  GeneralFunctions.configLoading();
}