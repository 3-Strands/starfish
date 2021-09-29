import 'package:cron/cron.dart';
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

  await HiveDatabase().init();

  final cron = Cron();

  // Sync every 15 mins
  // TODO: Check Connectivity before starting sync
  cron.schedule(Schedule.parse('*/15 * * * *'), () async {
    print('================ START SYNC =====================');
    SyncService().syncAll();
  });

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
