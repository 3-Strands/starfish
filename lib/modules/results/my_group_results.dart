import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:starfish/bloc/app_bloc.dart';
import 'package:starfish/bloc/provider.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:starfish/constants/assets_path.dart';
import 'package:starfish/constants/text_styles.dart';
import 'package:starfish/db/hive_group.dart';
import 'package:starfish/db/hive_group_user.dart';
import 'package:starfish/modules/results/learner_list_with_summary_card.dart';
import 'package:starfish/modules/results/project_report_for_groups.dart';
import 'package:starfish/modules/results/summary_for_learners.dart';
import 'package:starfish/modules/settings_view/settings_view.dart';
import 'package:starfish/utils/helpers/alerts.dart';
import 'package:starfish/widgets/app_logo_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/src/widgets/basic.dart' as widgetsBasic;

class MyGroupResults extends StatefulWidget {
  MyGroupResults({Key? key}) : super(key: key);

  @override
  _MyGroupResultsState createState() => _MyGroupResultsState();
}

class _MyGroupResultsState extends State<MyGroupResults> {
  late AppBloc bloc;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bloc = Provider.of(context);

    return FocusDetector(
      onFocusGained: () {},
      onFocusLost: () {},
      child: Scaffold(
        backgroundColor: AppColors.resultsScreenBG,
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
        body: Scrollbar(
          thickness: 5.w,
          isAlwaysShown: false,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  height: 52.h,
                  width: 345.w,
                  margin: EdgeInsets.only(left: 15.w, right: 15.w),
                  decoration: BoxDecoration(
                    color: AppColors.txtFieldBackground,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: Center(
                    child: DropdownButtonHideUnderline(
                      child: ButtonTheme(
                        alignedDropdown: true,
                        child: DropdownButton<HiveGroup>(
                          isExpanded: true,
                          iconSize: 35,
                          style: TextStyle(
                            color: Color(0xFF434141),
                            fontSize: 19.sp,
                            fontFamily: 'OpenSans',
                          ),
                          hint: Text(
                            bloc.resultsBloc.hiveGroup?.name ?? 'Select Group',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Color(0xFF434141),
                              fontSize: 19.sp,
                              fontFamily: 'OpenSans',
                            ),
                            textAlign: TextAlign.left,
                          ),
                          onChanged: (HiveGroup? value) {
                            setState(() {
                              bloc.resultsBloc.hiveGroup = value;
                            });
                          },
                          items: bloc.resultsBloc
                              .fetchGroupsWtihLeaderRole()
                              ?.map<DropdownMenuItem<HiveGroup>>(
                                  (HiveGroup value) {
                            return DropdownMenuItem<HiveGroup>(
                              value: value,
                              child: Text(
                                value.name!,
                                style: TextStyle(
                                  color: Color(0xFF434141),
                                  fontSize: 17.sp,
                                  fontFamily: 'OpenSans',
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                SummaryForAllLearners(),
                SizedBox(
                  height: 10.h,
                ),
                ProjectReporsForGroup(),
                SizedBox(
                  height: 20.h,
                ),
                ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: bloc.resultsBloc.hiveGroup!.learners!.length,
                    itemBuilder: (BuildContext context, index) {
                      HiveGroupUser _hiveGroupUser = bloc
                          .resultsBloc.hiveGroup!.learners!
                          .elementAt(index);
                      return InkWell(
                          onTap: _onLearnerSummarySelection,
                          child: LearnerSummary(hiveGroupUser: _hiveGroupUser));
                    }),
                SizedBox(
                  height: 20.h,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onLearnerSummarySelection() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(34.r),
          topRight: Radius.circular(34.r),
        ),
      ),
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: true,
      builder: (BuildContext context) {
        return widgetsBasic.StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return Container(
              height: MediaQuery.of(context).size.height * 0.70,
              child: _buildSlidingUpPanel());
        });
      },
    );
  }

  Widget _buildSlidingUpPanel() {
    return Column(
      children: [
        Expanded(
          child: Container(
            margin: EdgeInsets.only(left: 15.0.w, top: 40.h, right: 15.0.w),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    //height: 22.h,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Expanded(
                          child: Center(
                            child: Text(
                              'Group Name',
                              //overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Color(0xFF3475F0),
                                fontFamily: 'OpenSans',
                                fontSize: 19.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  _buildActionCard(),
                  SizedBox(
                    height: 5.h,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          height: 75.0,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Color(0xFFEFEFEF),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
                left: 30.0, right: 30.0, top: 19.0, bottom: 19.0),
            child: Container(
              height: 37.5.h,
              color: Color(0xFFEFEFEF),
              child: ElevatedButton(
                onPressed: () {
                  //_closeSlidingUpPanelIfOpen();
                  Navigator.pop(context);
                },
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40.r),
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all<Color>(
                      AppColors.selectedButtonBG),
                ),
                child: Text(AppLocalizations.of(context)!.close),
              ),
            ),
          ),
        ),
      ],
    );
  }

  _buildActionCard() {
    return Card(
        //   margin: EdgeInsets.only(left: 15.w, right: 15.w),
        color: Color(0xFFEFEFEF),
        elevation: 4,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
          Radius.circular(
            10,
          ),
        )),
        child: Container(
          padding: EdgeInsets.only(left: 15.w, right: 15.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 10.h,
              ),
              Text(
                "${AppLocalizations.of(context)!.zeroOrOneActionCompleted}",
                style: TextStyle(
                  fontSize: 19.sp,
                  color: Color(0xFF4F4F4F),
                  fontWeight: FontWeight.w600,
                  fontFamily: "Open Sans",
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: 99.w,
                    decoration: BoxDecoration(
                        color: Color(0xFF6DE26B),
                        borderRadius: BorderRadius.all(Radius.circular(8.5.r))),
                    padding:
                        EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                    child: Text(
                      "${bloc.resultsBloc.hiveGroup!.actionsCompleted} ${AppLocalizations.of(context)!.done}",
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: "Rubik Medium",
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    width: 99.w,
                    decoration: BoxDecoration(
                        color: Color(0xFFFFBE4A),
                        borderRadius: BorderRadius.all(Radius.circular(8.5.r))),
                    padding:
                        EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                    child: Text(
                      "${bloc.resultsBloc.hiveGroup!.actionsNotDoneYet} ${AppLocalizations.of(context)!.pending}",
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: "Rubik Medium",
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    width: 99.w,
                    decoration: BoxDecoration(
                        color: Color(0xFFFF5E4D),
                        borderRadius: BorderRadius.all(Radius.circular(8.5.r))),
                    padding:
                        EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                    child: Text(
                      "${bloc.resultsBloc.hiveGroup!.actionsOverdue} ${AppLocalizations.of(context)!.overdue}",
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: "Rubik Medium",
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15.h,
              ),
              InkWell(onTap: () {
                
              },
                child: Text(
                  "View History",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontFamily: "Open",
                    color: Color(0xFF3475F0),
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Visibility(child: Container(child: Column(children: <Widget>[

              ],),))
            ],
          ),
        ));
  }
}
