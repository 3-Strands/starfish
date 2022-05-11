import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:starfish/bloc/app_bloc.dart';
import 'package:starfish/bloc/provider.dart';
import 'package:starfish/config/routes/routes.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:starfish/constants/assets_path.dart';
import 'package:starfish/constants/text_styles.dart';
import 'package:starfish/db/hive_current_user.dart';
import 'package:starfish/db/providers/current_user_provider.dart';
import 'package:starfish/modules/actions_view/me.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:starfish/modules/results/my_group_results.dart';
import 'package:starfish/modules/results/my_life_results.dart';
import 'package:starfish/modules/settings_view/settings_view.dart';
import 'package:starfish/widgets/app_logo_widget.dart';
import 'package:starfish/widgets/last_sync_bottom_widget.dart';

class ResultsScreen extends StatefulWidget {
  ResultsScreen({Key? key, this.title = ''}) : super(key: key);

  final String title;

  @override
  _ResultsScreenState createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen>
    with TickerProviderStateMixin {
  late AppBloc bloc;
  late TabController _tabController;
  late HiveCurrentUser _user;

  // For developement only
  // TODO: remove once 'For My Life' is released
  bool hideMyLife = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      if (bloc.actionBloc.selectedTabIndex == 1) {
        _tabController.index = _tabController.length > 0 ? 1 : 0;

        // set 'Month' filter to 'All Time'
        //  bloc.actionBloc.actionFilter = ActionFilter.ALL_TIME;
      }
    });
    _user = CurrentUserProvider().getUserSync();
    _tabController = new TabController(
        length: hideMyLife
            ? 1
            : _user.hasAdminOrTeacherRole
                ? 2
                : 1,
        vsync: this,
        initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    bloc = Provider.of(context);

    return DefaultTabController(
      length: _tabController.length,
      child: Scaffold(
        appBar: AppBar(
          title: Container(
            height: 64.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                AppLogo(hight: 36.h, width: 37.w),
                Text(
                  AppLocalizations.of(context)!.resultsTabItemText,
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
          backgroundColor: AppColors.resultsScreenBG,
          elevation: 0.0,
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Container(
            // width: 375.w,
            //height: 812.h,
            color: AppColors.resultsScreenBG,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                hideMyLife
                    ? Container()
                    : _user.hasAdminOrTeacherRole
                        ? TabBar(
                            controller: _tabController,
                            indicatorColor: Color(0xFF3475F0),
                            labelColor: Color(0xFF3475F0),
                            labelStyle: TextStyle(
                                fontSize: 19.sp,
                                fontWeight: FontWeight.w600), //For Selected tab
                            unselectedLabelColor: Color(0xFF797979),
                            isScrollable: true,
                            tabs: List.generate(
                              _tabController.length,
                              (index) => Tab(
                                  text: index == 0
                                      ? AppLocalizations.of(context)!
                                          .forMyLifeTabText
                                      : AppLocalizations.of(context)!
                                          .forGroupITeachTabText),
                            ),
                          )
                        : Container(),
                Expanded(
                  child: TabBarView(
                    physics: NeverScrollableScrollPhysics(),
                    children: hideMyLife
                        ? [MyGroupResults()]
                        : _tabController.length == 2
                            ? [MyLifeResults(), MyGroupResults()]
                            : [MyLifeResults()],
                    controller: _tabController,
                  ),
                ),
              ],
            ),

            // TitleLabel(
            //   title: '',
            //   align: TextAlign.center,
            // ),
          ),
        ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     Navigator.of(context).pushNamed(Routes.addActions).then(
        //           (value) => FocusScope.of(context).requestFocus(
        //             new FocusNode(),
        //           ),
        //         );
        //   },
        //   child: Icon(Icons.add),
        // ),
      ),
    );
  }
}
