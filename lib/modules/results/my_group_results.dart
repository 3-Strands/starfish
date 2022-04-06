import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:intl/intl.dart';
import 'package:starfish/bloc/app_bloc.dart';
import 'package:starfish/bloc/provider.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:starfish/constants/assets_path.dart';
import 'package:starfish/constants/text_styles.dart';
import 'package:starfish/db/hive_group.dart';
import 'package:starfish/modules/settings_view/settings_view.dart';
import 'package:starfish/widgets/app_logo_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
                          // icon: Icon(Icons.arrow_drop_down),
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

                Container(
                  decoration: BoxDecoration(
                      color: Color(0xFF424242),
                      borderRadius: BorderRadius.all(Radius.circular(8.5.r))),
                  margin: EdgeInsets.only(left: 15.w, right: 15.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 10.h,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Summary for all Learners",
                          style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontFamily: "Rubik Medium",
                              fontSize: 19.sp,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Center(
                        child: Text(
                          "Actions",
                          style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontFamily: "Rubik Medium",
                              fontSize: 17.sp,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
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
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.5.r))),
                            padding: EdgeInsets.symmetric(
                                vertical: 10.h, horizontal: 10.w),
                            child: Text(
                              "${bloc.resultsBloc.hiveGroup!.actionsCompleted} Done",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "Rubik Medium",
                                  fontSize: 17.sp,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Container(
                            width: 99.w,
                            decoration: BoxDecoration(
                                color: Color(0xFFFFBE4A),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.5.r))),
                            padding: EdgeInsets.symmetric(
                                vertical: 10.h, horizontal: 10.w),
                            child: Text(
                              "${bloc.resultsBloc.hiveGroup!.actionsNotDoneYet} Pending",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "Rubik Medium",
                                  fontSize: 17.sp,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Container(
                            width: 99.w,
                            decoration: BoxDecoration(
                                color: Color(0xFFFF5E4D),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.5.r))),
                            padding: EdgeInsets.symmetric(
                                vertical: 10.h, horizontal: 10.w),
                            child: Text(
                              "${bloc.resultsBloc.hiveGroup!.actionsOverdue} Overdue",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "Rubik Medium",
                                  fontSize: 17.sp,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 10.h, horizontal: 10.w),
                        child: Divider(
                          color: Color(0xFF5D5D5D),
                          thickness: 1,
                        ),
                      ),
                      // SizedBox(
                      //   height: 10.h,
                      // ),
                      Center(
                          child: Text(
                        "Feeling about the Group",
                        style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontFamily: "Rubik Medium",
                            fontSize: 17.sp,
                            fontWeight: FontWeight.bold),
                      )),
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 99.w,
                            decoration: BoxDecoration(
                                color: Color(0xFF6DE26B),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.5.r))),
                            padding: EdgeInsets.symmetric(
                                vertical: 10.h, horizontal: 10.w),
                            child: Text(
                              "${bloc.resultsBloc.hiveGroup?.learnersEvaluationGood} Good",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "Rubik Medium",
                                  fontSize: 17.sp,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          Container(
                            width: 99.w,
                            decoration: BoxDecoration(
                                color: Color(0xFFC6C6C6),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.5.r))),
                            padding: EdgeInsets.symmetric(
                                vertical: 10.h, horizontal: 10.w),
                            child: Flexible(
                              child: Text(
                                "${bloc.resultsBloc.hiveGroup?.learnersEvaluationNotGood} Not so Good",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "Rubik Medium",
                                    fontSize: 17.sp,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 10.h, horizontal: 10.w),
                        child: Divider(
                          color: Color(0xFF5D5D5D),
                          thickness: 1,
                        ),
                      ),
                      // SizedBox(
                      //   height: 20.h,
                      // ),
                      Center(
                        child: Text(
                          "Averages",
                          style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontFamily: "Open Sans Bold",
                              fontSize: 17.sp,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          _buildCategoryStatics(
                            5,
                            Color(0xFFFFFFFF),
                          ),
                          _buildCategoryStatics(
                            4,
                            Color(0xFFFFFFFF),
                          ),
                          _buildCategoryStatics(
                            3,
                            Color(0xFFFFFFFF),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Color(0xFF424242),
                      borderRadius: BorderRadius.all(Radius.circular(8.5.r))),
                  margin: EdgeInsets.only(left: 15.w, right: 15.w),
                  padding: EdgeInsets.only(left: 15.w, right: 15.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        "Project Report for Group Name 1",
                        style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontFamily: "Rubik Medium",
                            fontSize: 19.sp,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Markers",
                            style: TextStyle(
                              fontSize: 17.sp,
                              fontFamily: "Open Sans Semibold",
                              color: Color(0xFFC6C6C6),
                            ),
                          ),
                          Text(
                            "Actuals",
                            style: TextStyle(
                              fontSize: 17.sp,
                              fontFamily: "Open Sans Semibold",
                              color: Color(0xFFC6C6C6),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      _buildMarkerStatics(53, 43),
                      Divider(
                        color: Color(0xFF5D5D5D),
                        thickness: 1,
                      ),
                      _buildMarkerStatics(53, 43),
                      Divider(
                        color: Color(0xFF5D5D5D),
                        thickness: 1,
                      ),
                      _buildMarkerStatics(126, 22),
                      Divider(
                        color: Color(0xFF5D5D5D),
                        thickness: 1,
                      ),
                      _buildMarkerStatics(143, 89),
                      Divider(
                        color: Color(0xFF5D5D5D),
                        thickness: 1,
                      ),
                      // Padding(
                      //   padding: EdgeInsets.symmetric(
                      //       vertical: 10.h, horizontal: 10.w),
                      //   child: Divider(
                      //     color: Color(0xFF5D5D5D),
                      //     thickness: 1,
                      //   ),
                      // ),
                      SizedBox(
                        height: 10.h,
                      ),

                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        color: Colors.transparent,
                        width: MediaQuery.of(context).size.width - 20,
                        //    width: 1000.w,
                        height: 50.h,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: StadiumBorder(), primary: Colors.blue),
                          onPressed: () {},
                          child: Text(
                            "Add Sign of Transformation",
                            style: TextStyle(
                                fontSize: 17.sp,
                                fontFamily: "Open Sans Regular"),
                          ),
                        ),
                      ),

                      SizedBox(
                        height: 20.h,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),

                ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 3,
                    itemBuilder: (BuildContext context, index) {
                      return Column(
                        children: [
                          SizedBox(
                            height: 10.h,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Color(0xFFEFEFEF),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.5.r))),
                            margin: EdgeInsets.only(left: 15.w, right: 15.w),
                            padding: EdgeInsets.only(left: 15.w, right: 15.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  height: 10.h,
                                ),
                                Text(
                                  "Anish",
                                  style: TextStyle(
                                      color: Color(0xFF434141),
                                      fontFamily: "OpenSans Bold",
                                      fontSize: 19.sp,
                                      fontWeight: FontWeight.bold),
                                ),

                                SizedBox(
                                  height: 10.h,
                                ),
                                IntrinsicHeight(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Center(
                                        child: Text(
                                          "Actions ",
                                          style: TextStyle(
                                              color: Color(
                                                0xFF4F4F4F,
                                              ),
                                              fontFamily: "OpenSans Semibold",
                                              fontSize: 17.sp),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          //   width: 99.w,
                                          decoration: BoxDecoration(
                                              color: Color(0xFF6DE26B),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(8.5.r))),
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10.h, horizontal: 10.w),
                                          child: Text(
                                            "4 Done",
                                            //"${group.actionsOverdue} ${AppLocalizations.of(context)!.actionsOverdue}",
                                            // Intl.plural(
                                            //     bloc.resultsBloc.hiveGroup!
                                            //         .actionsCompleted,
                                            //     zero:
                                            //         "${bloc.resultsBloc.hiveGroup!.actionsCompleted} ${AppLocalizations.of(context)!.zeroOrOneActionsOverdue}",
                                            //     one: "${bloc.resultsBloc.hiveGroup!.actionsCompleted} ${AppLocalizations.of(context)!.zeroOrOneActionsOverdue}",
                                            //     other: "${bloc.resultsBloc.hiveGroup!.actionsCompleted} ${AppLocalizations.of(context)!.moreThenOneActionsOverdue}",
                                            //     args: [
                                            //       bloc.resultsBloc.hiveGroup!
                                            //           .actionsCompleted
                                            //     ]),
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontFamily: "Rubik Medium",
                                                fontSize: 17.sp,
                                                fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          //    width: 99.w,
                                          decoration: BoxDecoration(
                                              color: Color(0xFFFFBE4A),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(8.5.r))),
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10.h, horizontal: 10.w),
                                          child: Text(
                                            "2 Pending",
                                            //"${group.actionsOverdue} ${AppLocalizations.of(context)!.actionsOverdue}",
                                            // Intl.plural(
                                            //     bloc.resultsBloc.hiveGroup!
                                            //         .actionsNotDoneYet,
                                            //     zero:
                                            //         "${bloc.resultsBloc.hiveGroup!.actionsNotDoneYet} ${AppLocalizations.of(context)!.zeroOrOneActionsOverdue}",
                                            //     one: "${bloc.resultsBloc.hiveGroup!.actionsNotDoneYet} ${AppLocalizations.of(context)!.zeroOrOneActionsOverdue}",
                                            //     other: "${bloc.resultsBloc.hiveGroup!.actionsNotDoneYet} ${AppLocalizations.of(context)!.moreThenOneActionsOverdue}",
                                            //     args: [
                                            //       bloc.resultsBloc.hiveGroup!
                                            //           .actionsNotDoneYet
                                            //     ]),
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontFamily: "Rubik Medium",
                                                fontSize: 17.sp,
                                                fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          //     width: 99.w,
                                          decoration: BoxDecoration(
                                              color: Color(0xFFFF5E4D),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(8.5.r))),
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10.h, horizontal: 10.w),
                                          child: Text(
                                            "1 Overdue",
                                            //"${group.actionsOverdue} ${AppLocalizations.of(context)!.actionsOverdue}",
                                            // Intl.plural(
                                            //     bloc.resultsBloc.hiveGroup!
                                            //         .actionsOverdue,
                                            //     zero:
                                            //         "${bloc.resultsBloc.hiveGroup!.actionsOverdue} ${AppLocalizations.of(context)!.zeroOrOneActionsOverdue}",
                                            //     one: "${bloc.resultsBloc.hiveGroup!.actionsOverdue} ${AppLocalizations.of(context)!.zeroOrOneActionsOverdue}",
                                            //     other: "${bloc.resultsBloc.hiveGroup!.actionsOverdue} ${AppLocalizations.of(context)!.moreThenOneActionsOverdue}",
                                            //     args: [
                                            //       bloc.resultsBloc.hiveGroup!
                                            //           .actionsOverdue
                                            //     ]),
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontFamily: "Rubik Medium",
                                                fontSize: 17.sp,
                                                fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                SizedBox(
                                  height: 15.h,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Transformations: ",
                                      style: TextStyle(
                                          fontSize: 17.sp,
                                          fontFamily: "Open Sans Semibold",
                                          color: Color(0xFF4F4F4F),
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Expanded(
                                      child: Container(
                                        child: Text(
                                          "First few words entered jf jkasdf ksjd",
                                          style: TextStyle(
                                            fontFamily: "Open Sans Italic",
                                            fontSize: 17.sp,
                                            fontStyle: FontStyle.italic,
                                            color: Color(0xFF4F4F4F),
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 15.h,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Feeling about the Group: ",
                                      style: TextStyle(
                                          fontSize: 17.sp,
                                          fontFamily: "Open Sans Semibold",
                                          fontStyle: FontStyle.normal,
                                          color: Color(0xFF4F4F4F),
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Expanded(
                                      child: Container(
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.thumb_up,
                                              color: Color(0xFFFFFFFF),
                                            ),
                                            SizedBox(
                                              width: 5.w,
                                            ),
                                            Text(
                                              "Good",
                                              style: TextStyle(
                                                fontFamily: "Open Sans Italic",
                                                fontSize: 17.sp,
                                                fontStyle: FontStyle.italic,
                                                color: Color(0xFF4F4F4F),
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 15.h,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Feedback: ",
                                      style: TextStyle(
                                          fontSize: 17.sp,
                                          fontFamily: "Open Sans Semibold",
                                          color: Color(0xFF4F4F4F),
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Expanded(
                                      child: Container(
                                        child: Text(
                                          "First words of feedback written in",
                                          style: TextStyle(
                                            fontFamily: "Open Sans Italic",
                                            fontSize: 17.sp,
                                            fontStyle: FontStyle.italic,
                                            color: Color(0xFF4F4F4F),
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                      ),
                                    )
                                  ],
                                ),

                                SizedBox(
                                  height: 20.h,
                                ),

                                // SizedBox(
                                //   height: 10.h,
                                // ),

                                // SizedBox(
                                //   height: 20.h,
                                // ),

                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    _buildCategoryStatics(
                                      5,
                                      Color(0xFF797979),
                                    ),
                                    _buildCategoryStatics(
                                      4,
                                      Color(0xFF797979),
                                    ),
                                    _buildCategoryStatics(
                                      3,
                                      Color(0xFF797979),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10.h),
                              ],
                            ),
                          ),
                        ],
                      );
                    }),
                // Container(
                //   child: Column(
                //     children: [
                //       Text('Summary for all Learners'),
                //       Text('Actions'),
                //       Row(
                //         children: [
                //           Container(
                //             width: 99.w,
                //             decoration: BoxDecoration(
                //                 color: Color(0xFF6DE26B),
                //                 borderRadius:
                //                     BorderRadius.all(Radius.circular(8.5.r))),
                //             padding: EdgeInsets.symmetric(
                //                 vertical: 10.h, horizontal: 10.w),
                //             child: Text(
                //               //"${group.actionsOverdue} ${AppLocalizations.of(context)!.actionsOverdue}",
                //               Intl.plural(
                //                   bloc.resultsBloc.hiveGroup!.actionsCompleted,
                //                   zero:
                //                       "${bloc.resultsBloc.hiveGroup!.actionsCompleted} ${AppLocalizations.of(context)!.zeroOrOneActionsOverdue}",
                //                   one: "${bloc.resultsBloc.hiveGroup!.actionsCompleted} ${AppLocalizations.of(context)!.zeroOrOneActionsOverdue}",
                //                   other: "${bloc.resultsBloc.hiveGroup!.actionsCompleted} ${AppLocalizations.of(context)!.moreThenOneActionsOverdue}",
                //                   args: [
                //                     bloc.resultsBloc.hiveGroup!.actionsCompleted
                //                   ]),
                //               style: TextStyle(
                //                 color: Colors.black,
                //                 fontFamily: "Rubik",
                //                 fontSize: 17.sp,
                //               ),
                //               textAlign: TextAlign.center,
                //             ),
                //           ),
                //           Container(
                //             width: 99.w,
                //             decoration: BoxDecoration(
                //                 color: Color(0xFFFFBE4A),
                //                 borderRadius:
                //                     BorderRadius.all(Radius.circular(8.5.r))),
                //             padding: EdgeInsets.symmetric(
                //                 vertical: 10.h, horizontal: 10.w),
                //             child: Text(
                //               //"${group.actionsOverdue} ${AppLocalizations.of(context)!.actionsOverdue}",
                //               Intl.plural(
                //                   bloc.resultsBloc.hiveGroup!.actionsNotDoneYet,
                //                   zero:
                //                       "${bloc.resultsBloc.hiveGroup!.actionsNotDoneYet} ${AppLocalizations.of(context)!.zeroOrOneActionsOverdue}",
                //                   one: "${bloc.resultsBloc.hiveGroup!.actionsNotDoneYet} ${AppLocalizations.of(context)!.zeroOrOneActionsOverdue}",
                //                   other: "${bloc.resultsBloc.hiveGroup!.actionsNotDoneYet} ${AppLocalizations.of(context)!.moreThenOneActionsOverdue}",
                //                   args: [
                //                     bloc.resultsBloc.hiveGroup!
                //                         .actionsNotDoneYet
                //                   ]),
                //               style: TextStyle(
                //                 color: Colors.black,
                //                 fontFamily: "Rubik",
                //                 fontSize: 17.sp,
                //               ),
                //               textAlign: TextAlign.center,
                //             ),
                //           ),
                //           Container(
                //             width: 99.w,
                //             decoration: BoxDecoration(
                //                 color: Color(0xFFFF5E4D),
                //                 borderRadius:
                //                     BorderRadius.all(Radius.circular(8.5.r))),
                //             padding: EdgeInsets.symmetric(
                //                 vertical: 10.h, horizontal: 10.w),
                //             child: Text(
                //               //"${group.actionsOverdue} ${AppLocalizations.of(context)!.actionsOverdue}",
                //               Intl.plural(
                //                   bloc.resultsBloc.hiveGroup!.actionsOverdue,
                //                   zero:
                //                       "${bloc.resultsBloc.hiveGroup!.actionsOverdue} ${AppLocalizations.of(context)!.zeroOrOneActionsOverdue}",
                //                   one: "${bloc.resultsBloc.hiveGroup!.actionsOverdue} ${AppLocalizations.of(context)!.zeroOrOneActionsOverdue}",
                //                   other: "${bloc.resultsBloc.hiveGroup!.actionsOverdue} ${AppLocalizations.of(context)!.moreThenOneActionsOverdue}",
                //                   args: [
                //                     bloc.resultsBloc.hiveGroup!.actionsOverdue
                //                   ]),
                //               style: TextStyle(
                //                 color: Colors.black,
                //                 fontFamily: "Rubik",
                //                 fontSize: 17.sp,
                //               ),
                //               textAlign: TextAlign.center,
                //             ),
                //           ),
                //         ],
                //       ),
                //     ],
                //   ),
                // ),
                // if (bloc.resultsBloc.hiveGroup?.learners != null)
                //   ListView.builder(
                //       physics: NeverScrollableScrollPhysics(),
                //       shrinkWrap: true,
                //       itemCount: bloc.resultsBloc.hiveGroup?.learners!.length,
                //       itemBuilder: (context, index) {
                //         return Container(
                //           child: Column(
                //             children: [
                //               Text(
                //                   "${bloc.resultsBloc.hiveGroup?.learners!.elementAt(index).user?.name}"),
                //               Row(
                //                 children: [],
                //               ),
                //             ],
                //           ),
                //         );
                //       })
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

  Row _buildMarkerStatics(int marker, int actuals) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Markers $marker',
          style: TextStyle(
            fontSize: 17.sp,
            fontFamily: "Open Sans Semibold",
            color: Color(0xFFC6C6C6),
          ),
        ),
        Container(
          height: 40.h,
          width: 50.w,
          color: Color(0xFFFFFFFF),
          child: Center(
            child: Text(
              "$actuals",
              style: TextStyle(
                fontSize: 17.sp,
                fontFamily: "Open Sans Bold",
                color: Color(0xFF000000),
              ),
            ),
          ),
        ),
        // Padding(
        //   padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
        //   child: Divider(
        //     color: Color(0xFF5D5D5D),
        //     thickness: 1,
        //   ),
        // ),
      ],
    );
  }

  _buildCategoryStatics(int categoryStatic, Color textColor) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              "5",
              style: TextStyle(
                  color: textColor,
                  fontFamily: "Rubik Medium",
                  fontSize: 30.sp,
                  fontWeight: FontWeight.bold),
            ),
            Icon(
              Icons.arrow_upward,
              color: Color(0xFF6DE26B),
            )
          ],
        ),
        Text(
          "Category 1",
          style: TextStyle(
            fontSize: 15.sp,
            color: textColor,
          ),
        )
      ],
    );
  }
}
