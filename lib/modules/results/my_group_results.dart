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
import 'package:starfish/db/hive_group_user.dart';
import 'package:starfish/enums/action_filter.dart';
import 'package:starfish/modules/settings_view/settings_view.dart';
import 'package:starfish/widgets/app_logo_widget.dart';
import 'package:starfish/widgets/searchbar_widget.dart';
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
    bloc.resultsBloc.hiveGroup =
        bloc.resultsBloc.fetchGroupsWtihLeaderRole()?.first;

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
                            bloc.resultsBloc
                                    .fetchGroupsWtihLeaderRole()
                                    ?.first
                                    .name ??
                                '',
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
                            bloc.resultsBloc.hiveGroup = value;
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
                SizedBox(height: 10.h),
                Container(
                  child: Column(
                    children: [
                      Text('Summary for all Learners'),
                      Text('Actions'),
                      Row(
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
                              //"${group.actionsOverdue} ${AppLocalizations.of(context)!.actionsOverdue}",
                              Intl.plural(
                                  bloc.resultsBloc.hiveGroup!.actionsCompleted,
                                  zero:
                                      "${bloc.resultsBloc.hiveGroup!.actionsCompleted} ${AppLocalizations.of(context)!.zeroOrOneActionsOverdue}",
                                  one: "${bloc.resultsBloc.hiveGroup!.actionsCompleted} ${AppLocalizations.of(context)!.zeroOrOneActionsOverdue}",
                                  other: "${bloc.resultsBloc.hiveGroup!.actionsCompleted} ${AppLocalizations.of(context)!.moreThenOneActionsOverdue}",
                                  args: [
                                    bloc.resultsBloc.hiveGroup!.actionsCompleted
                                  ]),
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: "Rubik",
                                fontSize: 17.sp,
                              ),
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
                              //"${group.actionsOverdue} ${AppLocalizations.of(context)!.actionsOverdue}",
                              Intl.plural(
                                  bloc.resultsBloc.hiveGroup!.actionsNotDoneYet,
                                  zero:
                                      "${bloc.resultsBloc.hiveGroup!.actionsNotDoneYet} ${AppLocalizations.of(context)!.zeroOrOneActionsOverdue}",
                                  one: "${bloc.resultsBloc.hiveGroup!.actionsNotDoneYet} ${AppLocalizations.of(context)!.zeroOrOneActionsOverdue}",
                                  other: "${bloc.resultsBloc.hiveGroup!.actionsNotDoneYet} ${AppLocalizations.of(context)!.moreThenOneActionsOverdue}",
                                  args: [
                                    bloc.resultsBloc.hiveGroup!
                                        .actionsNotDoneYet
                                  ]),
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: "Rubik",
                                fontSize: 17.sp,
                              ),
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
                              //"${group.actionsOverdue} ${AppLocalizations.of(context)!.actionsOverdue}",
                              Intl.plural(
                                  bloc.resultsBloc.hiveGroup!.actionsOverdue,
                                  zero:
                                      "${bloc.resultsBloc.hiveGroup!.actionsOverdue} ${AppLocalizations.of(context)!.zeroOrOneActionsOverdue}",
                                  one: "${bloc.resultsBloc.hiveGroup!.actionsOverdue} ${AppLocalizations.of(context)!.zeroOrOneActionsOverdue}",
                                  other: "${bloc.resultsBloc.hiveGroup!.actionsOverdue} ${AppLocalizations.of(context)!.moreThenOneActionsOverdue}",
                                  args: [
                                    bloc.resultsBloc.hiveGroup!.actionsOverdue
                                  ]),
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: "Rubik",
                                fontSize: 17.sp,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                if (bloc.resultsBloc.hiveGroup?.learners != null)
                  ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: bloc.resultsBloc.hiveGroup?.learners!.length,
                      itemBuilder: (context, index) {
                        return Container(
                          child: Column(
                            children: [
                              Text(
                                  "${bloc.resultsBloc.hiveGroup?.learners!.elementAt(index).user?.name}"),
                              Row(
                                children: [],
                              ),
                            ],
                          ),
                        );
                      })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
