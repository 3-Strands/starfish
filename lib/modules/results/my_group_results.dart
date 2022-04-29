import 'dart:io';
import 'dart:ui';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:intl/intl.dart';
import 'package:starfish/bloc/app_bloc.dart';
import 'package:starfish/bloc/provider.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:starfish/constants/assets_path.dart';
import 'package:starfish/constants/text_styles.dart';
import 'package:starfish/db/hive_date.dart';
import 'package:starfish/db/hive_group.dart';
import 'package:starfish/db/hive_group_user.dart';
import 'package:starfish/modules/results/learner_list_with_summary_card.dart';
import 'package:starfish/modules/results/project_report_for_groups.dart';
import 'package:starfish/modules/results/result_bottomsheet.dart';
import 'package:starfish/modules/results/summary_for_learners.dart';
import 'package:starfish/modules/settings_view/settings_view.dart';
import 'package:starfish/utils/date_time_utils.dart';
import 'package:starfish/widgets/app_logo_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/src/widgets/basic.dart' as widgetsBasic;
import 'package:starfish/widgets/month_year_picker/dialogs.dart';

class MyGroupResults extends StatefulWidget {
  MyGroupResults({Key? key}) : super(key: key);

  @override
  _MyGroupResultsState createState() => _MyGroupResultsState();
}

class _MyGroupResultsState extends State<MyGroupResults> {
  late AppBloc bloc;

  bool _isEditMode = false;
  //double _value = 2.0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bloc = Provider.of(context);

    // call init only once
    if (bloc.resultsBloc.hiveGroup == null) {
      bloc.resultsBloc.init();
    }

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
        body: bloc.resultsBloc.hiveGroup != null
            ? Scrollbar(
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
                                bloc.resultsBloc.hiveGroup?.name ??
                                    '${AppLocalizations.of(context)!.selectGroup}',
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
                                debugPrint("HiveGroup: ${value!.name}");
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
                    InkWell(
                      onTap: () async {
                        DateTime? selected = await _selectMonth(bloc);

                        if (selected != null) {
                          HiveDate _hiveDate =
                              HiveDate.create(selected.year, selected.month, 0);

                          setState(() {
                            bloc.resultsBloc.hiveDate = _hiveDate;
                          });
                        }
                      },
                      child: Container(
                        alignment: Alignment.centerLeft,
                        height: 52.h,
                        width: 345.w,
                        padding: EdgeInsets.fromLTRB(15.w, 0, 15.w, 0),
                        margin: EdgeInsets.only(left: 15.w, right: 15.w),
                        decoration: BoxDecoration(
                          color: AppColors.txtFieldBackground,
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: ButtonTheme(
                          alignedDropdown: true,
                          child: Text(
                            DateTimeUtils.formatHiveDate(
                                bloc.resultsBloc.hiveDate!,
                                requiredDateFormat: "MMMM yyyy"),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Color(0xFF434141),
                              fontSize: 19.sp,
                              fontFamily: 'OpenSans',
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    SummaryForAllLearners(),
                    if (bloc.resultsBloc.shouldDisplayProjectReport())
                      SizedBox(
                        height: 20.h,
                      ),
                    if (bloc.resultsBloc.shouldDisplayProjectReport())
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
                              onTap: () =>
                                  _onLearnerSummarySelection(_hiveGroupUser),
                              child: Column(
                                children: [
                                  index != 0
                                      ? SizedBox(
                                          height: 20.h,
                                        )
                                      : SizedBox(
                                          height: 0.0,
                                        ),
                                  LearnerSummary(hiveGroupUser: _hiveGroupUser),
                                ],
                              ));
                        }),
                    SizedBox(
                      height: 20.h,
                    )
                  ],
                )),
              )
            : Container(
                height: MediaQuery.of(context).size.height - 40.h,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      '${AppLocalizations.of(context)!.joinOrCreateGroupMessage}',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontFamily: "OpenSans",
                        fontStyle: FontStyle.italic,
                        color: Color(0xFF797979),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  void _onLearnerSummarySelection(HiveGroupUser hiveGroupUser) {
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
        return ResultWidgetBottomSheet(hiveGroupUser);
      },
    );
  }

  Future<DateTime?> _selectMonth(AppBloc bloc) async {
    // reference for the MonthYearPickerLocalizations is add in app.dart
    return await showMonthYearPicker(
      context: context,
      initialDate: DateTimeUtils.toDateTime(
          DateTimeUtils.formatHiveDate(bloc.resultsBloc.hiveDate!,
              requiredDateFormat: "dd-MMM-yyyy"),
          "dd-MMM-yyyy"),
      firstDate: DateTime(2011),
      lastDate: DateTime.now(),
    );
  }
}
