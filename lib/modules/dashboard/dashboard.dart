import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:starfish/constants/app_styles.dart';
import 'package:starfish/modules/actions_view/actions_view.dart';
import 'package:starfish/modules/groups_view/groups_view.dart';
import 'package:starfish/widgets/global_app_logo.dart';
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
  String title = 'Actions';
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
              color: AppColors.BACKGROUND_COLOR.withOpacity(0.3)),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              title: Container(
                  height: 100.0.h,
                  width: 100.0.w,
                  child: Center(
                    child: Text(
                      title,
                      style: TextStyle(color: Colors.black),
                    ),
                  )
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: <Widget>[
                  //     GlobalWidgets.navigationLogo(context),
                  //     Text(
                  //       title,
                  //       style: TextStyle(color: Colors.black),
                  //     ),
                  //     IconButton(
                  //       icon: Icon(Icons.settings, color: Colors.black),
                  //       onPressed: () {
                  //         setState(
                  //           () {},
                  //         );
                  //       },
                  //     ),
                  //   ],
                  // ),
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
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.call_to_action),
                  label: 'Materials',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.book),
                  label: 'Groups',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.chat),
                  label: 'Actions',
                ),
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: AppColors.selectedButtonBG,
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
          title = "Material";
          break;
        case 1:
          title = "Groups";
          break;
        case 2:
          title = "Actions";
          break;
        default:
        // title = "Results";
      }
    });
  }
}
