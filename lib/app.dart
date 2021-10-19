import 'package:cron/cron.dart';
import 'package:cron/cron.dart';
import 'package:fbroadcast/fbroadcast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rxdart/rxdart.dart';
import 'package:starfish/bloc/provider.dart';
import 'package:starfish/navigation_service.dart';
import 'package:starfish/repository/group_repository.dart';
import 'package:starfish/repository/materials_repository.dart';
import 'package:starfish/repository/user_repository.dart';
import 'package:starfish/src/generated/starfish.pbgrpc.dart';
import 'package:starfish/utils/services/field_mask.dart';
import 'package:starfish/utils/services/sync_service.dart';
import 'config/routes/routes.dart';
import 'constants/app_styles.dart';
import 'modules/splash/splash.dart';

class Starfish extends StatefulWidget {
  @override
  _StarfishState createState() => _StarfishState();
}

final cron = Cron();

class _StarfishState extends State<Starfish> {
  @override
  void initState() {
    // Sync every 15 mins
    // TODO: Check Connectivity before starting sync
    cron.schedule(Schedule.parse('*/15 * * * *'), () async {
      print('================ START SYNC =====================');
      showAlert(NavigationService.navigatorKey.currentContext!);

      SyncService().syncAll();
    });

    FBroadcast.instance().register(SyncService.kUpdateMaterial,
        (hiveMaterial, __) {
      print('Boradcast Receiver: kUpdateMaterial');
      MaterialRepository().createUpdateMaterial(
          material: hiveMaterial, fieldMaskPaths: kMaterialFieldMask);
    }, more: {
      SyncService.kUpdateGroup: (hiveGroup, __) {
        print('Boradcast Receiver: kUpdateGroup');
        GroupRepository().createUpdateGroup(
            group: hiveGroup, fieldMaskPaths: kGroupFieldMask);
      },
      SyncService.kUpdateUsers: (hiveUsers, __) {
        print('Boradcast Receiver: kUpdateUsers');

        (hiveUsers as List<User>)
            .forEach((user) => UserRepository().createUsers(user));
      }
    }, context: this);
    super.initState();
  }

  void showAlert(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
              title: Text(
                "We are setting up Starfish for you!",
                style: TextStyle(color: Color(0xFF030303)),
              ),
              content: Column(
                children: [
                  Text(
                      "This may take a few minutes while we download your data from the server. Please make sure you are connected to the internet.\n"),
                  // app.SizedBox(height: 10.h),
                  SizedBox(
                      width: 20.w,
                      height: 20.h,
                      child: CircularProgressIndicator()),
                  // app.SizedBox(height: 5.h),
                  Text(
                    '\nSyncing...',
                    style: TextStyle(color: Color(0xFF030303), fontSize: 12.sp),
                  )
                ],
              ),
              actions: <Widget>[
                CupertinoDialogAction(
                  child: Text("Close"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ));
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      builder: () => Provider(
        child: MaterialApp(
            navigatorKey: NavigationService.navigatorKey, // set property
            debugShowCheckedModeBanner: false,
            title: '',
            theme: AppStyles.defaultTheme(),
            home: SplashScreen(),
            routes: Routes.routes),
      ),
    );
  }

  @override
  void dispose() {
    FBroadcast.instance().unregister(this);
    super.dispose();
  }
}
