import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:starfish/app.dart';
import 'package:starfish/config/config_reader.dart';
import 'package:starfish/utils/helpers/general_functions.dart';
import 'config/app_config.dart';
import 'db/hive_database.dart';

const String _dsn =
    'https://47b741149b0a493b9823c47085d69e1c@o1167952.ingest.sentry.io/6259436';

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
    //return runApp(Starfish());
    return SentryFlutter.init(
      (options) {
        options.dsn = _dsn;
        options.tracesSampleRate = 1.0;
        options.reportPackages = false;
        options.addInAppInclude('PRODUCTION');
        options.considerInAppFramesByDefault = false;
      },
      // Init your App.
      appRunner: () => runApp(
        DefaultAssetBundle(
          bundle: SentryAssetBundle(
            enableStructuredDataTracing: true,
          ),
          child: Starfish(),
        ),
      ),
    );
  });
  GeneralFunctions.configLoading();
}
