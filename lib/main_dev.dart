import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:starfish/apis/local_storage_api.dart';
import 'package:starfish/repositories/session_repository.dart';
import 'package:starfish/utils/helpers/general_functions.dart';
import 'package:starfish/utils/services/grpc_client.dart';
import 'package:starfish/utils/services/sync_service.dart';
import 'app.dart';
import 'config/app_config.dart';
import 'config/config_reader.dart';
import 'db/hive_database.dart';

const String _dsn =
    'https://47b741149b0a493b9823c47085d69e1c@o1167952.ingest.sentry.io/6259436';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (!kIsWeb) {
    Firebase.initializeApp();
  }

  await HiveDatabase().init();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await ConfigReader.initialize();
  FlavorConfig(
    flavor: Flavor.DEV,
    values: FlavorValues(
      baseUrl: ConfigReader.getDevURL(),
      apiKey: ConfigReader.getDevAPIKey(),
    ),
  );
  GeneralFunctions.configLoading();
  final localStorageApi = LocalStorageApi();
  final sessionRepository = SessionRepository(
    client: makeUnauthenticatedClient(),
    localStorageApi: localStorageApi,
  );
  EasyLoading.instance
    ..loadingStyle = EasyLoadingStyle.custom
    ..userInteractions = false
    ..dismissOnTap = false
    ..backgroundColor = Colors.transparent
    ..indicatorColor = Colors.blue
    ..textColor = Colors.black45
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..boxShadow = <BoxShadow>[];

  final session = await sessionRepository.retrieveCurrentSession();
  //return runApp(Starfish());
  return SentryFlutter.init(
    (options) {
      options.dsn = _dsn;
      options.tracesSampleRate = 1.0;
      options.reportPackages = false;
      options.addInAppInclude('DEV');
      options.considerInAppFramesByDefault = false;
    },
    // Init your App.
    appRunner: () => runApp(
      DefaultAssetBundle(
        bundle: SentryAssetBundle(
          enableStructuredDataTracing: true,
        ),
        child: App(
          sessionRepository: sessionRepository,
          localStorageApi: localStorageApi,
          session: session,
        ),
      ),
    ),
  );
}
