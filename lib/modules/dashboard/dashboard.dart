import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:starfish/constants/app_styles.dart';
import 'package:starfish/constants/assets_path.dart';
import 'package:starfish/constants/strings.dart';
import 'package:starfish/constants/text_styles.dart';
import 'package:starfish/modules/actions_view/actions_view.dart';
import 'package:starfish/modules/groups_view/groups_view.dart';
import 'package:starfish/modules/settings_view/settings_view.dart';
import 'package:starfish/widgets/app_logo_widget.dart';
import '../material_view/materials_view.dart';
import 'package:sizer/sizer.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppStyles.defaultTheme(),
      home: _DashboardView(),
      // onGenerateRoute: App().getAppRoutes().getRoutes,
    );
  }
}

class _DashboardView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DashboardState();
}

class _DashboardState extends State<_DashboardView> {
  int _selectedIndex = 2;
  String title = Strings.actionsTabItemText;
  List<Widget> _widgetOptions = [];

  @override
  void initState() {
    var materialsWidget = MaterialsScreen();
    var groupsWidget = GroupsScreen();
    var actionsWidget = ActionsScreen();

    _widgetOptions = <Widget>[materialsWidget, groupsWidget, actionsWidget];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: const Color(0xff000000)),
      child: Stack(
        children: <Widget>[
          Container(
            height: 100.0,
            width: 100.0,
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              title: Container(
                height: 100.0.h,
                width: 100.0.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    AppLogo(hight: 4.4.h, width: 9.6.w),
                    Text(
                      title,
                      style: dashboardNavigationTitle,
                    ),
                    IconButton(
                      icon: SvgPicture.asset(AssetsPath.settingsActive),
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
            body: _widgetOptions[_selectedIndex],
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
              onTap: _onItemTapped,
            ),
          ),
        ],
      ),
    );
  }

  void _onItemTapped(int index) {
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
}
