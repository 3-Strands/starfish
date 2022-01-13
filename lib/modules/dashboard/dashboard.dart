import 'package:cron/cron.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:fbroadcast/fbroadcast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
import 'package:starfish/bloc/app_bloc.dart';
import 'package:starfish/bloc/provider.dart';
import 'package:starfish/config/routes/routes.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:starfish/constants/assets_path.dart';
import 'package:starfish/constants/text_styles.dart';
import 'package:starfish/db/hive_current_user.dart';
import 'package:starfish/db/hive_database.dart';
import 'package:starfish/db/hive_language.dart';
import 'package:starfish/modules/actions_view/actions_view.dart';
import 'package:starfish/modules/groups_view/groups_view.dart';
import 'package:starfish/modules/settings_view/settings_view.dart';
import 'package:starfish/repository/group_repository.dart';
import 'package:starfish/repository/materials_repository.dart';
import 'package:starfish/repository/user_repository.dart';
import 'package:starfish/src/generated/starfish.pb.dart';
import 'package:starfish/utils/helpers/snackbar.dart';
import 'package:starfish/utils/services/field_mask.dart';
import 'package:starfish/utils/services/local_storage_service.dart';
import 'package:starfish/utils/services/sync_service.dart';
import 'package:starfish/widgets/app_logo_widget.dart';
import '../material_view/materials_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Dashboard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedIndex = 2;
  late String title;
  List<Widget> _widgetOptions = [];
  late PageController _pageController;

  late AppBloc bloc;
  late List<HiveLanguage> _languageList;
  late Box<HiveLanguage> _languageBox;
  late Box<HiveCurrentUser> _currentUserBox;
  late HiveCurrentUser _user;

  final cron = Cron();

  @override
  void initState() {
    // Sync every 15 mins
    // TODO: Check Connectivity before starting sync
    cron.schedule(Schedule.parse('*/15 * * * *'), () async {
      debugPrint('================ START SYNC =====================');
      SyncService().syncAll();
    });
    FBroadcast.instance().register(SyncService.kUpdateMaterial,
        (hiveMaterial, __) {
      debugPrint('Boradcast Receiver: kUpdateMaterial');
      MaterialRepository().createUpdateMaterial(
          material: hiveMaterial, fieldMaskPaths: kMaterialFieldMask);
    }, more: {
      SyncService.kUpdateGroup: (hiveGroup, __) {
        debugPrint('Boradcast Receiver: kUpdateGroup');
        GroupRepository().createUpdateGroup(
            group: hiveGroup, fieldMaskPaths: kGroupFieldMask);
      },
      SyncService.kUpdateUsers: (hiveUsers, __) {
        debugPrint('Boradcast Receiver: kUpdateUsers');

        (hiveUsers as List<User>).forEach(
            (user) => UserRepository().createUpdateUsers(user, kUserFieldMask));
      },
      SyncService.kUnauthenticated: (value, callback) {
        debugPrint('Boradcast Receiver: kUnauthenticated');
        handleUnauthentication();
      }
    }, context: this);

    _languageBox = Hive.box<HiveLanguage>(HiveDatabase.LANGUAGE_BOX);
    _currentUserBox = Hive.box<HiveCurrentUser>(HiveDatabase.CURRENT_USER_BOX);
    _getAllLanguages();
    _getCurrentUser();

    var materialsWidget = MaterialsScreen();
    var groupsWidget = GroupsScreen();
    var actionsWidget = ActionsScreen();

    _widgetOptions = <Widget>[materialsWidget, groupsWidget, actionsWidget];
    _pageController = PageController(initialPage: _selectedIndex);

    super.initState();
  }

  void _getAllLanguages() {
    _languageList = _languageBox.values.toList();
  }

  void _getCurrentUser() {
    _user = _currentUserBox.values.first;
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
    return Container(
      child: Stack(
        children: <Widget>[
          Scaffold(
            backgroundColor: AppColors.background,
            appBar: AppBar(
              title: Container(
                height: 64.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    AppLogo(hight: 36.h, width: 37.w),
                    Text(
                      title,
                      style: dashboardNavigationTitle,
                    ),
                    IconButton(
                      icon: SvgPicture.asset(AssetsPath.settings),
                      onPressed: () {
                        setState(
                          () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SettingsScreen(),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
              backgroundColor: (_selectedIndex == 0)
                  ? AppColors.materialSceenBG
                  : (_selectedIndex == 1)
                      ? AppColors.groupScreenBG
                      : AppColors.actionScreenBG,
              elevation: 0.0,
            ),
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
                  label: AppLocalizations.of(context)!.materialsTabItemText,
                ),
                BottomNavigationBarItem(
                  activeIcon: SvgPicture.asset(AssetsPath.groupsActiveIcon),
                  icon: SvgPicture.asset(AssetsPath.groupsIcon),
                  label: AppLocalizations.of(context)!.groupsTabItemText,
                ),
                BottomNavigationBarItem(
                  activeIcon: SvgPicture.asset(AssetsPath.actionsActiveIcon),
                  icon: SvgPicture.asset(AssetsPath.actionsIcon),
                  label: AppLocalizations.of(context)!.actionsTabItemText,
                ),
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: (_selectedIndex == 0)
                  ? AppColors.materialTabBarTextColor
                  : (_selectedIndex == 1)
                      ? AppColors.groupTabBarTextColor
                      : AppColors.actionTabBarTextColor,
              backgroundColor: AppColors.txtFieldBackground,
              unselectedItemColor: AppColors.unselectedButtonBG,
              onTap: onTabTapped,
            ),
          ),
        ],
      ),
    );
  }

  void _changeNaviagtionTitle(int index) {
    setState(() {
      _selectedIndex = index;
      switch (index) {
        case 0:
          title = AppLocalizations.of(context)!.materialsTabItemText;
          break;
        case 1:
          title = AppLocalizations.of(context)!.groupsTabItemText;
          break;
        case 2:
          title = AppLocalizations.of(context)!.actionsTabItemText;
          break;
        default:
          title = '';
      }
    });
  }

  _cleanMaterialFilterValues() {
    bloc.materialBloc.selectedLanguages.clear();
    _selectLanguage(bloc);
    bloc.materialBloc.selectedTopics.clear();
  }

  _selectLanguage(AppBloc bloc) {
    for (var languageId in _user.languageIds) {
      _languageList
          .where((item) => item.id == languageId)
          .forEach((item) => {bloc.materialBloc.selectedLanguages.add(item)});
    }
  }

  void onPageChanged(int index) {
    if (index != 0) {
      _cleanMaterialFilterValues();
    }

    FocusScope.of(context).requestFocus(new FocusNode());
    setState(() {
      this._selectedIndex = index;
    });
    _changeNaviagtionTitle(index);
  }

  void onTabTapped(int index) {
    this._pageController.animateToPage(index,
        duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    _changeNaviagtionTitle(index);
  }

  void handleUnauthentication() {
    StarfishSnackbar.showErrorMessage(
        context, AppLocalizations.of(context)!.unauthenticated);
    StarfishSharedPreference().setLoginStatus(false);
    StarfishSharedPreference().setAccessToken('');

    Navigator.of(context).pushNamedAndRemoveUntil(
        Routes.phoneAuthentication, (Route<dynamic> route) => false);
  }
}
