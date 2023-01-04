import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starfish/authenticated_app/bloc/profile_creation_bloc.dart';
import 'package:starfish/bloc/sync_bloc.dart';
import 'package:starfish/modules/create_profile/create_profile.dart';
import 'package:starfish/modules/dashboard/dashboard.dart';
import 'package:starfish/repositories/authentication_repository.dart';
import 'package:starfish/repositories/data_repository.dart';
import 'package:starfish/repositories/sync_repository.dart';

import '../models/session.dart';

class AuthenticatedApp extends StatelessWidget {
  const AuthenticatedApp({
    Key? key,
    required this.session,
  }) : super(key: key);

  final Session session;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => DataRepository(
            getCurrentUser:
                context.read<AuthenticationRepository>().getCurrentUser,
          ),
        ),
        RepositoryProvider(
          create: (context) => SyncRepository(
            makeAuthenticatedRequest: context
                .read<AuthenticationRepository>()
                .makeAuthenticatedRequest,
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            lazy: false,
            create: (context) {
              return SyncBloc(
                authenticationRepository:
                    context.read<AuthenticationRepository>(),
                syncRepository: context.read<SyncRepository>(),
              );
            },
          ),
          BlocProvider(
            create: (context) {
              final needsProfileCreation = context
                  .read<AuthenticationRepository>()
                  .currentSession!
                  .needsProfileCreation;
              return ProfileCreationBloc(
                needsProfileCreation
                    ? const ProfileNeedsSetup()
                    : const ProfileReady(),
              );
            },
          ),
        ],
        child: const AuthenticatedAppView(),
      ),
    );
  }
}

class AuthenticatedAppView extends StatelessWidget {
  const AuthenticatedAppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCreationBloc, ProfileCreationState>(
        listener: (context, state) {
      if (state is ProfileReady && state.cameFromSetup) {
        final appLocalizations = AppLocalizations.of(context)!;
        final dialog = CupertinoAlertDialog(
          title: Text(
            appLocalizations.syncAlertTitleText,
            style: TextStyle(color: Color(0xFF030303)),
          ),
          content: Column(
            children: [
              Text(appLocalizations.syncAlertContentText),
              SizedBox(
                width: 20.w,
                height: 20.h,
                child: CircularProgressIndicator(),
              ),
              Text(
                appLocalizations.syncText,
                style: TextStyle(color: Color(0xFF030303), fontSize: 12.sp),
              ),
            ],
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text(appLocalizations.close),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
        showDialog(
          context: context,
          builder: (context) => dialog,
        );
      }
    }, builder: (context, state) {
      if (state is ProfileNeedsSetup) {
        return const CreateProfile();
      }
      return Navigator(
        onGenerateRoute: (settings) {
          return MaterialPageRoute<void>(
            settings: settings,
            builder: (BuildContext context) => const Dashboard(),
          );
        },
      );
    });
  }
}
