import 'package:flutter/material.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:starfish/modules/actions_view/my_group.dart';
import 'package:starfish/modules/actions_view/me.dart';
import 'package:starfish/src/generated/starfish.pb.dart';
import 'package:starfish/widgets/title_label_widget.dart';
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

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 2, vsync: this, initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
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
                TabBar(
                  controller: _tabController,
                  indicatorColor: Color(0xFF3475F0),
                  labelColor: Color(0xFF3475F0),
                  labelStyle: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600), //For Selected tab
                  unselectedLabelColor: Color(0xFF797979),
                  tabs: [
                    Tab(text: 'For Me'),
                    Tab(text: 'For Groups I Teach'),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [Me(), MyGroup()],
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
      ),
    );
  }
}
