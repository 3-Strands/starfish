import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:starfish/utils/helpers/general_functions.dart';
import 'app.dart';
import 'config/app_config.dart';
import 'config/config_reader.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

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
