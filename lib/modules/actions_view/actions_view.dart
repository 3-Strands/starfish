import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:starfish/config/routes/routes.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:starfish/constants/strings.dart';
import 'package:starfish/db/hive_current_user.dart';
import 'package:starfish/db/hive_database.dart';
import 'package:starfish/modules/actions_view/my_group.dart';
import 'package:starfish/modules/actions_view/me.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ActionsScreen extends StatefulWidget {
  ActionsScreen({Key? key, this.title = ''}) : super(key: key);

  final String title;

  @override
  _ActionsScreenState createState() => _ActionsScreenState();
}

class _ActionsScreenState extends State<ActionsScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late HiveCurrentUser _user;
  late Box<HiveCurrentUser> _currentUserBox;

  @override
  void initState() {
    super.initState();
    _currentUserBox = Hive.box<HiveCurrentUser>(HiveDatabase.CURRENT_USER_BOX);
    _user = _currentUserBox.values.first;
    _tabController = new TabController(
        length: _user.hasAdminOrTeacherRole ? 2 : 1,
        vsync: this,
        initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabController.length,
      child: Scaffold(
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Container(
            width: 375.w,
            height: 812.h,
            color: AppColors.actionScreenBG,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _user.hasAdminOrTeacherRole
                    ? TabBar(
                        controller: _tabController,
                        indicatorColor: Color(0xFF3475F0),
                        labelColor: Color(0xFF3475F0),
                        labelStyle: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600), //For Selected tab
                        unselectedLabelColor: Color(0xFF797979),
                        tabs: List.generate(
                          _tabController.length,
                          (index) => Tab(
                              text: index == 0
                                  ? Strings.forMeTabText
                                  : Strings.forGroupITeachTabText),
                        ),
                      )
                    : Container(),
                Expanded(
                  child: TabBarView(
                    children:
                        _tabController.length == 2 ? [Me(), MyGroup()] : [Me()],
                    controller: _tabController,
                  ),
                )
              ],
            ),

            // TitleLabel(
            //   title: '',
            //   align: TextAlign.center,
            // ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed(Routes.addActions).then(
                  (value) => FocusScope.of(context).requestFocus(
                    new FocusNode(),
                  ),
                );
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
