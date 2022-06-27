import 'package:cron/cron.dart';
import 'package:collection/collection.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:fbroadcast/fbroadcast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:starfish/bloc/app_bloc.dart';
import 'package:starfish/bloc/provider.dart';
import 'package:starfish/config/routes/routes.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:starfish/constants/assets_path.dart';
import 'package:starfish/db/hive_current_user.dart';
import 'package:starfish/db/hive_group.dart';
import 'package:starfish/db/hive_language.dart';
import 'package:starfish/db/providers/current_user_provider.dart';
import 'package:starfish/db/providers/language_provider.dart';
import 'package:starfish/modules/actions_view/actions_view.dart';
import 'package:starfish/modules/groups_view/groups_view.dart';
import 'package:starfish/modules/results/results_views.dart';
import 'package:starfish/utils/helpers/snackbar.dart';
import 'package:starfish/utils/services/field_mask.dart';
import 'package:starfish/utils/services/local_storage_service.dart';
import 'package:starfish/utils/services/sync_service.dart';
import 'package:starfish/wrappers/platform.dart';
import '../material_view/materials_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedIndex = 3;
  late String title;
  List<Widget> _widgetOptions = [];
  late PageController _pageController;

  late AppBloc bloc;
  HiveCurrentUser? _user;
  late AppLocalizations _appLocalizations;

  final cron = Cron();

  @override
  void initState() {
    if (!Platform.isWeb) {
      // Sync every 15 mins
      cron.schedule(Schedule.parse('*/15 * * * *'), () async {
        debugPrint('================ START SYNC =====================');
        SyncService().syncAll();
      });
    }
    FBroadcast.instance().register(SyncService.kUpdateMaterial,
        (hiveMaterial, __) {
      debugPrint('Boradcast Receiver: kUpdateMaterial');
      SyncService().syncLocalMaterialsToRemote();
      SyncService().syncLocalFiles();
    }, more: {
      SyncService.kUpdateTeacherResponse: (hiveTeacherResponse, __) {
        debugPrint('Boradcast Receiver: kUpdateTeacherResponse');
        SyncService().syncLocalTeacherResponsesToRemote();
      },
      SyncService.kUpdateTransformation: (hiveTransformation, __) {
        debugPrint('Boradcast Receiver: kUpdateTransformation');
        SyncService().syncLocalTransformationsToRemote();
        SyncService().syncLocalFiles();
      },
      SyncService.kUpdateLearnerEvaluation: (hiveLearnerEvaluation, __) {
        debugPrint('Boradcast Receiver: kUpdateLearnerEvaluation');
        SyncService().syncLocalLearnerEvaluationsToRemote();
      },
      SyncService.kDeleteMaterial: (hiveMaterial, __) {
        debugPrint('Boradcast Receiver: kDeleteMaterial');
        SyncService().syncLocalDeletedMaterialsToRemote();
      },
      SyncService.kUpdateGroup: (hiveGroup, __) {
        SyncService().syncLocalUsersAndGroups();
      },
      SyncService.kUpdateUsers: (hiveUsers, __) {
        debugPrint('Boradcast Receiver: kUpdateUsers');
        SyncService().syncLocalUsersAndGroups();
      },
      SyncService.kUpdateCurrentUser: (hiveCurrentUser, __) {
        debugPrint('Boradcast Receiver: kUpdateCurrentUser');
        SyncService().syncLocalCurrentUser(kCurrentUserFieldMask);
      },
      SyncService.kUnauthenticated: (value, callback) {
        debugPrint('Boradcast Receiver: kUnauthenticated');
        handleUnauthentication();
      },
      "switchToActionTab": (value, callback) {
        debugPrint('Boradcast Receiver: switchToActionTab');
        onTabTapped(2);
        bloc.actionBloc.selectedTabIndex = 1;
        bloc.actionBloc.focusedGroup = value as HiveGroup;
      }
    }, context: this);

    _user = CurrentUserProvider().getCurrentUserSync();
    SyncService().syncAll().whenComplete(() {
      if (_user == null) {
        _getCurrentUser();
      }
    });

    var materialsWidget = MaterialsScreen();
    var groupsWidget = GroupsScreen();
    var actionsWidget = ActionsScreen();
    var resultsWidget = ResultsScreen();

    _widgetOptions = <Widget>[
      materialsWidget,
      groupsWidget,
      actionsWidget,
      resultsWidget,
    ];
    _pageController = PageController(initialPage: _selectedIndex);

    super.initState();
  }

  void _getCurrentUser() {
    setState(() {
      _user = CurrentUserProvider().getCurrentUserSync();
    });
  }

  @override
  void didChangeDependencies() {
    bloc = Provider.of(context);
    title = AppLocalizations.of(context)!.actionsTabItemText;

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _pageController.dispose();
    FBroadcast.instance().unregister(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_user == null) {
      return const SizedBox();
    }
    // StarfishSharedPreference()
    //     .getAccessToken()
    //     .then((value) => debugPrint("AccessToken: $value"));
    _appLocalizations = AppLocalizations.of(context)!;
    return Container(
      child: Stack(
        children: <Widget>[
          Scaffold(
            backgroundColor: AppColors.background,
            body: PageView(
              children: _widgetOptions,
              onPageChanged: onPageChanged,
              controller: _pageController,
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  activeIcon: SvgPicture.asset(AssetsPath.metericalsActiveIcon),
                  icon: SvgPicture.asset(AssetsPath.metericalsIcon),
                  label: _appLocalizations.materialsTabItemText,
                ),
                BottomNavigationBarItem(
                  activeIcon: SvgPicture.asset(AssetsPath.groupsActiveIcon),
                  icon: SvgPicture.asset(AssetsPath.groupsIcon),
                  label: _appLocalizations.groupsTabItemText,
                ),
                BottomNavigationBarItem(
                  activeIcon: SvgPicture.asset(AssetsPath.actionsActiveIcon),
                  icon: SvgPicture.asset(AssetsPath.actionsIcon),
                  label: _appLocalizations.actionsTabItemText,
                ),
                BottomNavigationBarItem(
                  activeIcon: SvgPicture.asset(AssetsPath.resultsActiveIcon),
                  icon: SvgPicture.asset(AssetsPath.resultsIcon),
                  label: _appLocalizations.resultsTabItemText,
                ),
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: _selectedTabColor(_selectedIndex),
              backgroundColor: AppColors.txtFieldBackground,
              unselectedItemColor: AppColors.unselectedButtonBG,
              unselectedFontSize: 14.sp,
              selectedFontSize: 14.sp,
              onTap: onTabTapped,
            ),
          ),
        ],
      ),
    );
  }

  _cleanMaterialFilterValues() {
    bloc.materialBloc.selectedLanguages.clear();
    _selectLanguage(bloc);
    bloc.materialBloc.selectedTopics.clear();
  }

  _selectLanguage(AppBloc bloc) {
    _user?.languageIds.forEach((languageId) {
      HiveLanguage? _langugage = LanguageProvider()
          .getAll()
          .firstWhereOrNull((element) => element.id == languageId);
      if (_langugage != null) {
        bloc.materialBloc.selectedLanguages.add(_langugage);
      }
    });
  }

  void onPageChanged(int index) {
    _getCurrentUser();

    if (index != 0) {
      _cleanMaterialFilterValues();
    } else {
      _selectLanguage(bloc);
    }

    FocusScope.of(context).requestFocus(new FocusNode());
    setState(() {
      this._selectedIndex = index;
    });
  }

  void onTabTapped(int index) {
    this._pageController.animateToPage(index,
        duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  void handleUnauthentication() {
    StarfishSnackbar.showErrorMessage(
        context, _appLocalizations.unauthenticated);
    StarfishSharedPreference().setLoginStatus(false);
    StarfishSharedPreference().setAccessToken('');

    Navigator.of(context).pushNamedAndRemoveUntil(
        Routes.phoneAuthentication, (Route<dynamic> route) => false);
  }

  Color _selectedTabColor(int _selectedIndex) {
    switch (_selectedIndex) {
      case 3:
        return AppColors.resultsTabBarTextColor;
      case 2:
        return AppColors.actionTabBarTextColor;
      case 1:
        return AppColors.groupTabBarTextColor;
      case 0:
      default:
        return AppColors.materialTabBarTextColor;
    }
  }
}
