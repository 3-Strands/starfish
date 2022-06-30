import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starfish/bloc/data_bloc.dart';
import 'package:starfish/bloc/provider.dart';
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
  late DataBloc bloc;

  @override
  Widget build(BuildContext context) {
    bloc = Provider.of(context);

    return Container(
      height: 40.h,
      child: Center(
        child: StreamBuilder(
          stream: bloc.lastSyncTime,
          builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
            if (snapshot.hasData) {
              return Text(
                '${AppLocalizations.of(context)!.lastSync}: ${snapshot.data!}',
                style: TextStyle(
                  color: Color(0xFF434141),
                  fontSize: 17.sp,
                  fontFamily: 'OpenSans',
                ),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
