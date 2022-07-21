import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:starfish/bloc/sync_bloc.dart';

class LastSyncBottomWidget extends StatelessWidget {
  const LastSyncBottomWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.h,
      child: Center(
        child: BlocBuilder<SyncBloc, SyncState>(
          builder: (context, state) {
            final lastSync = state.lastSync.value;
            return Text(
              // TODO: Internationalize
              state.isSyncing
                  ? 'Syncing...'
                  : '${AppLocalizations.of(context)!.lastSync}: ${lastSync == null ? 'never' : lastSync.toUtc()}',
              style: TextStyle(
                color: Color(0xFF434141),
                fontSize: 17.sp,
                fontFamily: 'OpenSans',
              ),
            );
          }
        ),
      ),
    );
  }
}
