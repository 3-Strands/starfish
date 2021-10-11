import 'package:fbroadcast/fbroadcast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rxdart/rxdart.dart';
import 'package:starfish/bloc/provider.dart';
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

class _StarfishState extends State<Starfish> {
  @override
  void initState() {
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

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      builder: () => Provider(
        child: MaterialApp(
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
