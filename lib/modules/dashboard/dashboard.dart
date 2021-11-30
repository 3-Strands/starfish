import 'package:cron/cron.dart';
import 'package:fbroadcast/fbroadcast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:starfish/constants/assets_path.dart';
import 'package:starfish/constants/strings.dart';
import 'package:starfish/constants/text_styles.dart';
import 'package:starfish/modules/actions_view/actions_view.dart';
import 'package:starfish/modules/groups_view/groups_view.dart';
import 'package:starfish/modules/settings_view/settings_view.dart';
import 'package:starfish/repository/group_repository.dart';
import 'package:starfish/repository/materials_repository.dart';
import 'package:starfish/repository/user_repository.dart';
import 'package:starfish/src/generated/starfish.pb.dart';
import 'package:starfish/utils/services/field_mask.dart';
import 'package:starfish/utils/services/sync_service.dart';
import 'package:starfish/widgets/app_logo_widget.dart';
import 'package:swipedetector/swipedetector.dart';
import '../material_view/materials_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Dashboard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedIndex = 2;
  String title = Strings.actionsTabItemText;
  List<Widget> _widgetOptions = [];
  late PageController _pageController;

  final cron = Cron();

  @override
  void initState() {
    // Sync every 15 mins
    // TODO: Check Connectivity before starting sync
    cron.schedule(Schedule.parse('*/15 * * * *'), () async {
      print('================ START SYNC =====================');
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

        (hiveUsers as List<User>).forEach(
            (user) => UserRepository().createUpdateUsers(user, kUserFieldMask));
      }
    }, context: this);

    var materialsWidget = MaterialsScreen();
    var groupsWidget = GroupsScreen();
    var actionsWidget = ActionsScreen();

    _widgetOptions = <Widget>[materialsWidget, groupsWidget, actionsWidget];
    _pageController = PageController(initialPage: _selectedIndex);

    super.initState();
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
      // decoration: BoxDecoration(color: const Color(0xff000000)),
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
                                  builder: (context) => SettingsScreen()),
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
            // body: _widgetOptions[_selectedIndex],
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
                  label: Strings.materialsTabItemText,
                ),
                BottomNavigationBarItem(
                  activeIcon: SvgPicture.asset(AssetsPath.groupsActiveIcon),
                  icon: SvgPicture.asset(AssetsPath.groupsIcon),
                  label: Strings.groupsTabItemText,
                ),
                BottomNavigationBarItem(
                  activeIcon: SvgPicture.asset(AssetsPath.actionsActiveIcon),
                  icon: SvgPicture.asset(AssetsPath.actionsIcon),
                  label: Strings.actionsTabItemText,
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
          title = Strings.materialsTabItemText;
          break;
        case 1:
          title = Strings.groupsTabItemText;
          break;
        case 2:
          title = Strings.actionsTabItemText;
          break;
        default:
        // title = "Results";
      }
    });
  }

  void onPageChanged(int index) {
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
}
