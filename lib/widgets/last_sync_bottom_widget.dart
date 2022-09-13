import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:starfish/apis/hive_api.dart';
import 'package:starfish/bloc/sync_bloc.dart';

class LastSyncBottomWidget extends StatelessWidget {
  const LastSyncBottomWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return Container(
      height: 40.h,
      child: Center(
        child: BlocBuilder<SyncBloc, SyncState>(builder: (context, state) {
          final lastSync = globalHiveApi.lastSync?.toDateTime(toLocal: true);
          return Text(
            // TODO: Internationalize
            state.isSyncing
                ? appLocalizations.syncing
                : lastSync == null
                    ? ''
                    : appLocalizations.lastSyncMessage(
                        DateFormat('dd-MMM-yyyy').add_Hm().format(lastSync)),
            style: TextStyle(
              color: Color(0xFF434141),
              fontSize: 17.sp,
              fontFamily: 'OpenSans',
            ),
          );
        }),
      ),
    );
  }
}
