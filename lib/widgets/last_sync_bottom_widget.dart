import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starfish/utils/sync_time.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LastSyncBottomWidget extends StatefulWidget {
  LastSyncBottomWidget({
    Key? key,
  }) : super(key: key);

  @override
  _LastSyncBottomWidgetState createState() => _LastSyncBottomWidgetState();
}

class _LastSyncBottomWidgetState extends State<LastSyncBottomWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.h,
      child: Center(
        child: Text(
          '${AppLocalizations.of(context)!.lastSync}: ${SyncTime().lastSyncDataTime()}',
          style: TextStyle(
            color: Color(0xFF434141),
            fontSize: 14.sp,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }
}
