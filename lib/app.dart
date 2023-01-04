import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starfish/apis/local_storage_api.dart';
import 'package:starfish/authenticated_app/authenticated_app.dart';
import 'package:starfish/bloc/app_bloc.dart';
import 'package:starfish/bloc/session_bloc.dart';
import 'package:starfish/cubit/error_cubit.dart';
import 'package:starfish/modules/authentication/authentication.dart';
import 'package:starfish/modules/authentication/reauthenticate.dart';
import 'package:starfish/navigation_service.dart';
import 'package:starfish/repositories/authentication_repository.dart';
import 'package:starfish/repositories/error_repository.dart';
import 'package:starfish/utils/helpers/alerts.dart';
import 'package:starfish/utils/helpers/snackbar.dart';
import 'package:starfish/widgets/constrain_center.dart';
import 'package:starfish/wrappers/platform.dart';
import 'package:starfish/wrappers/window.dart';
// import 'config/routes/routes.dart';
import 'constants/app_styles.dart';
import 'l10n/l10n.dart';
import 'modules/splash/splash.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
    required this.authenticationRepository,
    required this.localStorageApi,
  }) : super(key: key);

  final AuthenticationRepository authenticationRepository;
  final LocalStorageApi localStorageApi;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(
          value: authenticationRepository,
        ),
        RepositoryProvider(
          create: (_) => ErrorRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (_) => AppBloc(
                    localStorageApi: localStorageApi,
                    authenticationRepository: authenticationRepository,
                  )),
          BlocProvider(
              create: (_) => SessionBloc(
                    authenticationRepository: authenticationRepository,
                  )),
          BlocProvider(
              create: (context) => ErrorCubit(
                    context.read<ErrorRepository>(),
                  )),
        ],
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppState>(
      listenWhen: (previous, current) => previous is AppBooting,
      listener: (context, state) => removeSplashScreen(),
      builder: (context, state) {
        if (state is AppReady) {
          return MaterialApp(
            locale: Locale(state.locale),
            scrollBehavior: const _StarfishScrollBehavior(),
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: L10n.all,
            navigatorKey: NavigationService.navigatorKey, // set property
            debugShowCheckedModeBanner: false,
            title: '',
            theme: AppStyles.defaultTheme(),
            // home: SplashScreen(),
            // initialRoute: _initialRoute,
            // routes: Routes.routes,
            onGenerateRoute: (settings) {
              final loginGuard = BlocListener<ErrorCubit, UserFacingError?>(
                listener: (context, error) {
                  if (error != null) {
                    final appLocalizations = AppLocalizations.of(context)!;
                    String message;
                    switch (error.type) {
                      case ErrorType.groupMustHaveAdmin:
                        message =
                            appLocalizations.alertGroupCanNotBeWithoutAdmin;
                        break;
                    }
                    if (error.severity == Severity.low) {
                      StarfishSnackbar.showErrorMessage(context, message);
                    } else {
                      Alerts.showMessageBox(
                        context: context,
                        title: appLocalizations.dialogAlert,
                        message: message,
                        callback: () {},
                      );
                    }
                  }
                },
                child: BlocConsumer<SessionBloc, SessionState>(
                  listener: (context, state) {
                    if (state is SessionActive &&
                        state.pendingReauthenticate != null) {
                      final completer = state.pendingReauthenticate!;
                      Reauthenticate.init(context)
                          .then(completer.complete)
                          .onError(completer.completeError);
                    }
                  },
                  builder: (context, state) {
                    if (state is SessionActive) {
                      return AuthenticatedApp(session: state.session);
                    }
                    return const Authentication();
                  },
                ),
              );

              return MaterialPageRoute<void>(
                settings: settings,
                builder: (BuildContext context) => loginGuard,
              );
            },
            // onGenerateInitialRoutes: _initialRoute == null ? null : (String route) =>
            //   [Routes.onGenerateRoute(RouteSettings(name: route))],
            builder: EasyLoading.init(
              builder: (context, widget) {
                Widget wrapper = MediaQuery(
                  //Setting font does not change with system font size
                  data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                  child: widget!,
                );
                if (Platform.isWeb) {
                  wrapper = ConstrainCenter(child: wrapper);
                }
                return ScreenUtilInit(
                  designSize: MediaQuery.of(context).size,
                  builder: (context, child) => child!,
                  child: wrapper,
                );
              },
            ),
          );
        }
        return MaterialApp(
          onGenerateRoute: (_) => MaterialPageRoute(
            builder: (_) =>
                Platform.isWeb ? const SizedBox.shrink() : const SplashScreen(),
          ),
        );
      },
    );
  }
}

class _StarfishScrollBehavior extends MaterialScrollBehavior {
  const _StarfishScrollBehavior();

  @override
  Widget buildScrollbar(
      BuildContext context, Widget child, ScrollableDetails details) {
    switch (axisDirectionToAxis(details.direction)) {
      case Axis.horizontal:
        return child;
      case Axis.vertical:
        // Always show a scrollbar on all platforms
        return Scrollbar(
          controller: details.controller,
          thickness: 5,
          child: child,
        );
    }
  }
}
