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
import 'package:starfish/db/hive_evaluation_category.dart';
import 'package:starfish/db/hive_group.dart';
import 'package:starfish/db/hive_group_evaluation.dart';
import 'package:starfish/db/hive_group_user.dart';
import 'package:starfish/db/hive_learner_evaluation.dart';
import 'package:starfish/db/hive_teacher_response.dart';
import 'package:starfish/db/hive_transformation.dart';
import 'package:starfish/db/providers/current_user_provider.dart';
import 'package:starfish/db/providers/group_evaluation_provider.dart';
import 'package:starfish/db/providers/learner_evaluation_provider.dart';
import 'package:starfish/db/providers/teacher_response_provider.dart';
import 'package:starfish/db/providers/transformation_provider.dart';
import 'package:starfish/modules/image_cropper/image_cropper_view.dart';
import 'package:starfish/modules/results/learner_list_with_summary_card.dart';
import 'package:starfish/modules/results/project_report_for_groups.dart';
import 'package:starfish/utils/helpers/snackbar.dart';
import 'package:starfish/widgets/focusable_text_field.dart';
import 'package:starfish/widgets/shapes/slider_thumb.dart';
import 'package:starfish/modules/results/summary_for_learners.dart';
import 'package:starfish/modules/settings_view/settings_view.dart';
import 'package:starfish/src/generated/starfish.pb.dart';
import 'package:starfish/utils/date_time_utils.dart';
import 'package:starfish/utils/helpers/uuid_generator.dart';
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

  TextEditingController _teacherFeedbackController = TextEditingController();
  TextEditingController _transformationController = TextEditingController();
  List<File> _selectedFiles = [];
 

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bloc = Provider.of(context);
    bloc.resultsBloc.init();

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
                      child: InkWell(
                        onTap: () async {
                          DateTime? selected = await _selectMonth(bloc);

                          if (selected != null) {
                            HiveDate _hiveDate = HiveDate();

                            _hiveDate.year = selected.year;
                            _hiveDate.month = selected.month;
                            _hiveDate.day = 1;

                            setState(() {
                              bloc.resultsBloc.hiveDate = _hiveDate;
                            });
                          }
                        },
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
                    SizedBox(
                      height: 20.h,
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
                              onTap: () =>
                                  _onLearnerSummarySelection(_hiveGroupUser),
                              child: LearnerSummary(
                                  hiveGroupUser: _hiveGroupUser));
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
        return _buildSlidingUpPanel(hiveGroupUser);
      },
    );
  }

  Widget _buildSlidingUpPanel(HiveGroupUser hiveGroupUser) {
    return widgetsBasic.StatefulBuilder(
        builder: (BuildContext context, StateSetter setModalState) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.80,
        child: Column(
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
                                  '${hiveGroupUser.group!.name}',
                                  //overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
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
                      SizedBox(height: 20.h),
                      Container(
                        alignment: Alignment.centerLeft,

                        height: 52.h,
                        width: 345.w,
                        padding: EdgeInsets.only(left: 15.w, right: 15.w),
                        //   margin: EdgeInsets.only(left: 15.w, right: 15.w),
                        decoration: BoxDecoration(
                          color: AppColors.txtFieldBackground,
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: InkWell(
                          onTap: () async {
                            final selected = await _selectMonth(bloc);
                            if (selected != null) {
                              HiveDate _hiveDate = HiveDate();

                              _hiveDate.year = selected.year;
                              _hiveDate.month = selected.month;
                              _hiveDate.day = 1;

                              setModalState(() {
                                bloc.resultsBloc.hiveDate = _hiveDate;
                              });

                              // update parent view also
                              setState(() {
                                bloc.resultsBloc.hiveDate = _hiveDate;
                              });

                              _updateLearnerSummary();
                            }
                          },
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
                      Center(
                        child: Container(
                          decoration: BoxDecoration(
                              color: Color(0xFFEFEFEF),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.5.r))),
                          child: DropdownButtonHideUnderline(
                            child: ButtonTheme(
                              alignedDropdown: true,
                              child: DropdownButton<HiveGroupUser>(
                                isExpanded: true,
                                iconSize: 35,
                                style: TextStyle(
                                  color: Color(0xFFEFEFEF),
                                  fontSize: 19.sp,
                                  fontFamily: 'OpenSans',
                                ),
                                hint: Text(
                                  "${AppLocalizations.of(context)!.learner}: ${bloc.resultsBloc.hiveGroupUser?.name}",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Color(0xFF434141),
                                    fontSize: 19.sp,
                                    fontFamily: 'OpenSans',
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                                onChanged: (HiveGroupUser? value) {
                                  setModalState(() {
                                    bloc.resultsBloc.hiveGroupUser = value;
                                  });

                                  /*setState(() {
                                    bloc.resultsBloc.hiveGroupUser = value;
                                  });*/

                                  _updateLearnerSummary();
                                },
                                items: bloc.resultsBloc.hiveGroup!.learners
                                    ?.map<DropdownMenuItem<HiveGroupUser>>(
                                        (HiveGroupUser value) {
                                  return DropdownMenuItem<HiveGroupUser>(
                                    value: value,
                                    child: Text(
                                      value.name,
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
                      /*SizedBox(
                        height: 20.h,
                      ),
                      Row(
                        children: [
                          Text(
                            '${AppLocalizations.of(context)!.feelingAboutTheGroup}:',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 19.sp,
                              fontFamily: "OpenSans",
                              color: Color(0xFF4F4F4F),
                            ),
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          _buildGroupEvaluationWidget(),
                        ],
                      ),*/
                      SizedBox(
                        height: 30.h,
                      ),
                      _buildActionCard(),
                      SizedBox(
                        height: 5.h,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      _buildTrasnformatonsCard(),
                      SizedBox(
                        height: 10.h,
                      ),
                      _buildTeacherFeedBackCard(),
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
                      _selectedFiles.clear();
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
                          AppColors.unselectedButtonBG),
                    ),
                    child: Text(AppLocalizations.of(context)!.close),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildTeacherFeedBackCard() {
    bool isViewCategoryEvalutionHistory = false;
    return Card(
      color: Color(0xFFEFEFEF),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(
            10,
          ),
        ),
      ),
      child: Container(
        padding: EdgeInsets.only(left: 15.w, right: 15.w),
        child: Column(
          children: [
            SizedBox(
              height: 10.h,
            ),
            Text(
              '${AppLocalizations.of(context)!.teacherFeedbackForLearner}',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 17.sp,
                fontFamily: "OpenSans",
                color: Color(0xFF4F4F4F),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 5.h,
            ),
            Text(
              '${AppLocalizations.of(context)!.helpTextForTeacherFeedback}',
              style: TextStyle(
                // fontWeight: FontWeight.w600,
                fontStyle: FontStyle.italic,
                fontSize: 14.sp,
                fontFamily: "OpenSans",
                color: Color(0xFF797979),
              ),
            ),
            SizedBox(height: 10.h),
            Container(
              decoration: BoxDecoration(
                color: Color(0xFFFFFFFF),
                border: Border.all(
                  color: Color(0xFF979797),
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: FocusableTextField(
                controller: _teacherFeedbackController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: "",
                  hintStyle: TextStyle(
                    fontFamily: "OpenSans",
                    fontSize: 16.sp,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                maxLines: 3,
                textInputAction: TextInputAction.done,
                onFocusChange: (isFocused) {
                  debugPrint("Has focus: $isFocused");
                  if (isFocused) {
                    return;
                  }
                  if (_teacherFeedbackController.text.length > 0) {
                    _saveTeacherFeedback();
                  }
                },
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            if (bloc.resultsBloc.hiveGroup?.groupEvaluationCategories != null)
              ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: bloc
                      .resultsBloc.hiveGroup?.groupEvaluationCategories?.length,
                  itemBuilder: (context, index) {
                    HiveEvaluationCategory _category = bloc
                        .resultsBloc.hiveGroup!.groupEvaluationCategories!
                        .elementAt(index);
                    return _buildCategorySlider(_category);
                  }),
            SizedBox(
              height: 20.h,
            ),
            StatefulBuilder(
              builder: (BuildContext context, StateSetter setModalState) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Visibility(
                      visible: isViewCategoryEvalutionHistory,
                      child: Text(
                        '${AppLocalizations.of(context)!.currentEvaluation}',
                        style: TextStyle(
                          fontFeatures: [FontFeature.subscripts()],
                          color: Color(0xFF434141),
                          fontFamily: "OpenSans",
                          fontSize: 19.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Visibility(
                        visible: isViewCategoryEvalutionHistory,
                        child: SizedBox(
                          height: 10.h,
                        )),
                    Visibility(
                      visible: isViewCategoryEvalutionHistory,
                      child: _buildCurrentEvaluationWidget(
                        bloc.resultsBloc.hiveGroupUser!
                            .getLearnerEvaluationsByCategoryForMoth(
                                bloc.resultsBloc.hiveDate!),
                      ),
                    ),
                    Visibility(
                      visible: isViewCategoryEvalutionHistory,
                      child: SizedBox(
                        height: 20.h,
                      ),
                    ),
                    Visibility(
                      visible: isViewCategoryEvalutionHistory,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '${AppLocalizations.of(context)!.history}',
                          style: TextStyle(
                            fontFeatures: [FontFeature.subscripts()],
                            color: Color(0xFF434141),
                            fontFamily: "OpenSans",
                            fontSize: 19.sp,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Visibility(
                        visible: isViewCategoryEvalutionHistory,
                        child: _buildCategoryHistoryWidget()),
                    SizedBox(
                      height: 10.h,
                    ),
                    InkWell(
                      onTap: () {
                        setModalState(() {
                          isViewCategoryEvalutionHistory =
                              !isViewCategoryEvalutionHistory;
                        });
                      },
                      child: Center(
                        child: Text(
                          isViewCategoryEvalutionHistory
                              ? '${AppLocalizations.of(context)!.hideHistory}'
                              : '${AppLocalizations.of(context)!.viewHistory}',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontFamily: "Open",
                            color: Color(0xFF3475F0),
                          ),
                        ),
                      ),
                    )
                  ],
                );
              },
            ),
            SizedBox(
              height: 20.h,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryHistoryWidget() {
    List<HiveDate> _historyAvailableMonths =
        bloc.resultsBloc.getListOfAvailableHistoryMonths();
    _historyAvailableMonths.sort((a, b) => b.compareTo(a));
    if (_historyAvailableMonths.contains(bloc.resultsBloc.hiveDate!)) {
      _historyAvailableMonths.remove(bloc.resultsBloc.hiveDate!);
    }

    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: _historyAvailableMonths.length,
        itemBuilder: (BuildContext context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 10.h,
              ),
              Text(
                DateTimeUtils.formatHiveDate(
                    _historyAvailableMonths.elementAt(index),
                    requiredDateFormat: "MMM yyyy"), //"JUL 2021",
                style: TextStyle(
                  fontFamily: "OpenSans",
                  fontSize: 19.sp,
                  color: Color(0xFF434141),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              _buildMonthlyEvaluationWidget(
                bloc.resultsBloc.hiveGroupUser!
                    .getLearnerEvaluationsByCategoryForMoth(
                        _historyAvailableMonths.elementAt(index)),
              )

              // Row(
              //   children: <Widget>[
              //     Text(
              //       "Category1:",
              //       style: TextStyle(
              //         fontFamily: "OpenSans",
              //         fontSize: 14.sp,
              //         color: Color(0xFF434141),
              //       ),
              //     ),
              //     SizedBox(
              //       width: 5.h,
              //     ),
              //     Text(
              //       "5",
              //       style: TextStyle(
              //         fontFamily: "OpenSans",
              //         fontSize: 14.sp,
              //         color: Color(0xFF434141),
              //       ),
              //     ),
              //   ],
              // ),
              // SizedBox(
              //   height: 5.h,
              // ),
              // Row(
              //   children: <Widget>[
              //     Text(
              //       "Category3: ",
              //       style: TextStyle(
              //         fontFamily: "OpenSans",
              //         fontSize: 14.sp,
              //         color: Color(0xFF434141),
              //       ),
              //     ),
              //     SizedBox(
              //       width: 5.h,
              //     ),
              //     Text(
              //       "5",
              //       style: TextStyle(
              //         fontFamily: "OpenSans",
              //         fontSize: 14.sp,
              //         color: Color(0xFF434141),
              //       ),
              //     ),
              //   ],
              // ),
              // SizedBox(
              //   height: 10.h,
              // ),
              // Row(
              //   children: <Widget>[
              //     Text(
              //       "Category2: ",
              //       style: TextStyle(
              //         fontFamily: "OpenSans",
              //         fontSize: 14.sp,
              //         color: Color(0xFF434141),
              //       ),
              //     ),
              //     SizedBox(
              //       width: 5.h,
              //     ),
              //     Text(
              //       "5",
              //       style: TextStyle(
              //         fontFamily: "OpenSans",
              //         fontSize: 14.sp,
              //         color: Color(0xFF434141),
              //       ),
              //     ),
              //   ],
              // )
            ],
          );
        });
  }

  Widget _buildCurrentEvaluation(
      int count, String categoryName, int changeInCount, Color textColor) {
    return Expanded(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text("$count",
                      style: TextStyle(
                        fontFeatures: [FontFeature.subscripts()],
                        color: Color(0xFF434141),
                        fontFamily: "OpenSans",
                        fontSize: 30.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                    child: Text(
                      "$changeInCount",
                      style: TextStyle(
                          fontFeatures: [FontFeature.superscripts()],
                          color: Colors.red),
                    ),
                  )
                ],
              ),
            ),
            Text(
              "$categoryName",
              style: TextStyle(
                fontSize: 17.sp,
                fontFamily: "OpenSans",
                color: Color(0x99434141),
              ),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildMonthWiseEvaluation(
      int count, String categoryName, int changeInCount, Color textColor) {
    return Expanded(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("$count",
                style: TextStyle(
                  fontFeatures: [FontFeature.subscripts()],
                  color: Color(0xFF434141),
                  fontFamily: "OpenSans",
                  fontSize: 30.sp,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center),
            Text(
              "$categoryName",
              style: TextStyle(
                fontSize: 17.sp,
                fontFamily: "OpenSans",
                color: Color(0x99434141),
              ),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildMonthlyEvaluationWidget(
      Map<HiveEvaluationCategory, Map<String, int>> _learnersEvaluations) {
    List<Widget> _currentEvaluationWidget = [];
    _learnersEvaluations.forEach(
        (HiveEvaluationCategory category, Map<String, int> countByMonth) {
      _currentEvaluationWidget.add(_buildMonthWiseEvaluation(
          countByMonth["this-month"] ?? 0,
          category.name!,
          ((countByMonth["this-month"] ?? 0) -
              (countByMonth["last-month"] ?? 0)),
          Color(0xFFFFFFFF)));
    });
    return Row(
      children: _currentEvaluationWidget,
    );
  }

  Widget _buildCurrentEvaluationWidget(
      Map<HiveEvaluationCategory, Map<String, int>> _learnersEvaluations) {
    List<Widget> _currentEvaluationWidget = [];
    _learnersEvaluations.forEach(
        (HiveEvaluationCategory category, Map<String, int> countByMonth) {
      _currentEvaluationWidget.add(_buildCurrentEvaluation(
          countByMonth["this-month"] ?? 0,
          category.name!,
          ((countByMonth["this-month"] ?? 0) -
              (countByMonth["last-month"] ?? 0)),
          Color(0xFFFFFFFF)));
    });
    return Row(
      children: _currentEvaluationWidget,
    );
  }

  Widget _buildCategorySlider(HiveEvaluationCategory _evaluationCategory) {
    HiveLearnerEvaluation? _evaluation = bloc.resultsBloc.hiveGroupUser
        ?.getLearnerEvaluation(bloc.resultsBloc.hiveDate!,
            _evaluationCategory.id!, CurrentUserProvider().getUserSync().id);

    double _value =
        _evaluation != null ? _evaluation.evaluation!.toDouble() : 3.0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _evaluationCategory.name!,
          style: TextStyle(
            fontFamily: "OpenSans",
            fontSize: 19.sp,
            fontWeight: FontWeight.bold,
            color: Color(0xFF434141),
          ),
          textAlign: TextAlign.left,
        ),
        SizedBox(
          height: 10.h,
        ),
        StatefulBuilder(builder: (context, setState) {
          return Container(
            child: SliderTheme(
              data: SliderTheme.of(context).copyWith(
                thumbShape: SliderThumb(),
                valueIndicatorColor: Colors.transparent,
                valueIndicatorTextStyle: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                showValueIndicator: ShowValueIndicator.never,
              ),
              child: Slider(
                activeColor: Color(0xFFFCDFBA),
                inactiveColor: Color(0xFFFCDFBA),
                thumbColor: Color(0xFFE5625C),
                max: 5.0,
                min: 1.0,
                divisions: 4,
                value: _value,
                label: sliderLabel(_value.toInt()),
                onChanged: (double value) {
                  debugPrint("Slider Value: $value");
                  setState(() {
                    _value = value;
                  });

                  _saveLearnerEvaluation(
                      _evaluationCategory.id!, value.toInt());
                },
              ),
            ),
          );
        }),
        // SizedBox(
        //   height: 5.h,
        // ),
        // Text(
        //   "This is dynamic text which explains the meaning of each ",
        //   style: TextStyle(
        //     fontStyle: FontStyle.italic,
        //     fontFamily: "OpenSans",
        //     fontSize: 14.sp,
        //     color: Color(0xFF797979),
        //   ),
        // ),
        SizedBox(
          height: 5.h,
        ),
      ],
    );
  }

  Widget _buildTrasnformatonsCard() {
    return Card(
      color: Color(0xFFEFEFEF),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(
            10,
          ),
        ),
      ),
      child: Container(
        padding: EdgeInsets.only(left: 15.w, right: 15.w),
        child: Column(
          children: [
            SizedBox(
              height: 10.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  AssetsPath.resultsActiveIcon,
                  color: Colors.green,
                ),
                SizedBox(
                  width: 5.w,
                ),
                Text(
                  '${AppLocalizations.of(context)!.transformations}',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 19.sp,
                    fontFamily: "OpenSans",
                    color: Color(0xFF4F4F4F),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Container(
              decoration: BoxDecoration(
                color: Color(0xFFFFFFFF),
                border: Border.all(
                  color: Color(0xFF979797),
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: FocusableTextField(
                controller: _transformationController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText:
                      '${AppLocalizations.of(context)!.hintTextTransformationsTextField}',
                  hintStyle: TextStyle(
                    fontFamily: "OpenSans",
                    fontSize: 16.sp,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                maxLines: 3,
                textInputAction: TextInputAction.done,
                onFocusChange: (isFocused) {
                  debugPrint("Has focus: $isFocused");
                  if (isFocused) {
                    return;
                  }
                  if (_transformationController.text.length > 0) {
                    _saveTransformation();
                  }
                },
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            //  if (_isEditMode) _previewFiles(widget.material!),
            // SizedBox(height: 10.h),

            // _previewSelectedFiles(),

            // Add Materials
            // // Selected files (Not uploaded)
            StatefulBuilder(builder: (context, setModal) {
              return Column(
                children: [
                  _previewSelectedFiles(),
                  SizedBox(height: 10.h),

            DottedBorder(
              borderType: BorderType.RRect,
              radius: Radius.circular(30.r),
              color: Color(0xFF3475F0),
              child: Container(
                width: double.infinity,
                height: 50.h,
                child:  ElevatedButton(
                      onPressed: () async {
                        if ((!_isEditMode && _selectedFiles.length >= 5)) {
                          StarfishSnackbar.showErrorMessage(context,
                              AppLocalizations.of(context)!.maxFilesSelected);
                        } else {
                          FilePickerResult? result = await FilePicker.platform
                              .pickFiles(
                                allowMultiple: false
                                  type: FileType.custom,
                                   allowedExtensions: ['jpg', 'png','jpeg'],
                                );
                
                          if (result != null) {
                            // if single selected file is IMAGE, open image in Cropper
                            if (result.count == 1 &&
                                ['jpg', 'jpeg', 'png'].contains(result.paths.first
                                    ?.split("/")
                                    .last
                                    .split(".")
                                    .last)) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ImageCropperScreen(
                                    sourceImage: File(result.paths.first!),
                                    onDone: (File? _newFile) {
                                      if (_newFile == null) {
                                        return;
                                      }
                                     
                                      setModal(() {
                                        _selectedFiles.add(_newFile);
                                        print('pathhhhhhh${_selectedFiles[0].path}');
                                      });
                                    },
                                  ),
                                ),
                              ).then((value) => {
                                    // Handle cropped image here
                                  });
                            } else {
                              setModal(() {
                                _selectedFiles.addAll(result.paths
                                    .map((path) => File(path!))
                                    .toList());
                              });
                            }
                          } else {
                            // User canceled the picker
                          }
                        }
                      },
                      child: Text(
                        '${AppLocalizations.of(context)!.addPhotos}',
                        style: TextStyle(
                          fontFamily: 'OpenSans',
                          fontSize: 17.sp,
                          color: Color(0xFF3475F0),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.transparent,
                        shadowColor: Colors.transparent,
                      ),
                    )
                  
              ),
            ),
                ],
              );
            }),

            SizedBox(
              height: 20.h,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionCard() {
    bool isViewHistory = false;
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
              "${AppLocalizations.of(context)!.resultMoreThenOneActionCompleted}",
              style: TextStyle(
                fontSize: 19.sp,
                color: Color(0xFF4F4F4F),
                fontWeight: FontWeight.w600,
                fontFamily: "OpenSans",
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
                    Intl.plural(
                      bloc.resultsBloc.hiveGroup!.actionsCompleted,
                      zero:
                          "${bloc.resultsBloc.hiveGroup!.actionsCompleted} ${AppLocalizations.of(context)!.resultZeroOrOneActionCompleted}",
                      one:
                          "${bloc.resultsBloc.hiveGroup!.actionsCompleted} ${AppLocalizations.of(context)!.resultZeroOrOneActionCompleted}",
                      other:
                          "${bloc.resultsBloc.hiveGroup!.actionsCompleted} ${AppLocalizations.of(context)!.resultMoreThenOneActionCompleted}",
                      args: [bloc.resultsBloc.hiveGroup!.actionsCompleted],
                    ),
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Rubik",
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
                    Intl.plural(
                      bloc.resultsBloc.hiveGroup!.actionsNotDoneYet,
                      zero:
                          "${bloc.resultsBloc.hiveGroup!.actionsNotDoneYet} ${AppLocalizations.of(context)!.resultZeroOrOneActionsIncompleted}",
                      one:
                          "${bloc.resultsBloc.hiveGroup!.actionsNotDoneYet} ${AppLocalizations.of(context)!.resultZeroOrOneActionsIncompleted}",
                      other:
                          "${bloc.resultsBloc.hiveGroup!.actionsNotDoneYet} ${AppLocalizations.of(context)!.resultMoreThenOneActionsIncompleted}",
                      args: [bloc.resultsBloc.hiveGroup!.actionsNotDoneYet],
                    ),
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Rubik",
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
                    Intl.plural(
                      bloc.resultsBloc.hiveGroup!.actionsOverdue,
                      zero:
                          "${bloc.resultsBloc.hiveGroup!.actionsOverdue} ${AppLocalizations.of(context)!.resultZeroOrOneActionsOverdue}",
                      one:
                          "${bloc.resultsBloc.hiveGroup!.actionsOverdue} ${AppLocalizations.of(context)!.resultZeroOrOneActionsOverdue}",
                      other:
                          "${bloc.resultsBloc.hiveGroup!.actionsOverdue} ${AppLocalizations.of(context)!.resultMoreThenOneActionsOverdue}",
                      args: [bloc.resultsBloc.hiveGroup!.actionsOverdue],
                    ),
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Rubik",
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            StatefulBuilder(
              builder: (BuildContext context, StateSetter setModalState) {
                return Column(
                  children: [
                    Visibility(
                      visible: isViewHistory,
                      child: SizedBox(
                        height: 15.h,
                      ),
                    ),
                    Visibility(
                      visible: isViewHistory,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '${AppLocalizations.of(context)!.history}',
                          style: TextStyle(
                            fontFeatures: [FontFeature.subscripts()],
                            color: Color(0xFF434141),
                            fontFamily: "OpenSans",
                            fontSize: 19.sp,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Visibility(
                        visible: isViewHistory,
                        child: _buildActionHistoryWidget()),
                    SizedBox(
                      height: 10.h,
                    ),
                    InkWell(
                      onTap: () {
                        setModalState(() {
                          isViewHistory = !isViewHistory;
                        });
                      },
                      child: Text(
                        isViewHistory
                            ? '${AppLocalizations.of(context)!.hideHistory}'
                            : '${AppLocalizations.of(context)!.viewHistory}',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontFamily: "Open",
                          color: Color(0xFF3475F0),
                        ),
                      ),
                    )
                  ],
                );
              },
            ),
            SizedBox(
              height: 10.h,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionHistoryWidget() {
    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: 4,
        itemBuilder: (BuildContext context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 10.h,
              ),
              Text(
                "JUL 2021",
                style: TextStyle(
                  fontFamily: "OpenSans",
                  fontSize: 19.sp,
                  color: Color(0xFF434141),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: Container(
                      width: 99.w,
                      decoration: BoxDecoration(
                          color: Color(0xFF6DE26B),
                          borderRadius:
                              BorderRadius.all(Radius.circular(8.5.r))),
                      padding: EdgeInsets.symmetric(
                          vertical: 10.h, horizontal: 10.w),
                      child: Text(
                        Intl.plural(
                          bloc.resultsBloc.hiveGroup!.actionsCompleted,
                          zero:
                              "${bloc.resultsBloc.hiveGroup!.actionsCompleted} ${AppLocalizations.of(context)!.resultZeroOrOneActionCompleted}",
                          one:
                              "${bloc.resultsBloc.hiveGroup!.actionsCompleted} ${AppLocalizations.of(context)!.resultZeroOrOneActionCompleted}",
                          other:
                              "${bloc.resultsBloc.hiveGroup!.actionsCompleted} ${AppLocalizations.of(context)!.resultMoreThenOneActionCompleted}",
                          args: [bloc.resultsBloc.hiveGroup!.actionsCompleted],
                        ),
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Rubik",
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15.w,
                  ),
                  Expanded(
                    child: Container(
                      width: 99.w,
                      decoration: BoxDecoration(
                          color: Color(0xFFFFBE4A),
                          borderRadius:
                              BorderRadius.all(Radius.circular(8.5.r))),
                      padding: EdgeInsets.symmetric(
                          vertical: 10.h, horizontal: 10.w),
                      child: Text(
                        Intl.plural(
                          bloc.resultsBloc.hiveGroup!.actionsNotDoneYet,
                          zero:
                              "${bloc.resultsBloc.hiveGroup!.actionsNotDoneYet} ${AppLocalizations.of(context)!.resultZeroOrOneActionsIncompleted}",
                          one:
                              "${bloc.resultsBloc.hiveGroup!.actionsNotDoneYet} ${AppLocalizations.of(context)!.resultZeroOrOneActionsIncompleted}",
                          other:
                              "${bloc.resultsBloc.hiveGroup!.actionsNotDoneYet} ${AppLocalizations.of(context)!.resultMoreThenOneActionsIncompleted}",
                          args: [bloc.resultsBloc.hiveGroup!.actionsNotDoneYet],
                        ),
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Rubik",
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
            ],
          );
        });
  }

  Widget _buildGroupEvaluationWidget() {
    if (bloc.resultsBloc.getGroupEvaluation() ==
        GroupEvaluation_Evaluation.GOOD) {
      return Row(children: [
        Icon(
          Icons.thumb_up,
          color: Color(0xFF707070),
        ),
        SizedBox(
          width: 5.w,
        ),
        Text(
          '${AppLocalizations.of(context)!.goodText}',
          style: TextStyle(
            //    fontWeight: FontWeight.w600,
            fontSize: 16.sp,
            fontFamily: "Rubik",
            color: Color(0xFF707070),
          ),
        ),
      ]);
    } else if (bloc.resultsBloc.getGroupEvaluation() ==
        GroupEvaluation_Evaluation.BAD) {
      return Row(children: [
        Icon(
          Icons.thumb_down,
          color: Color(0xFF707070),
        ),
        SizedBox(
          width: 5.w,
        ),
        Text(
          '${AppLocalizations.of(context)!.notSoGoodText}',
          style: TextStyle(
            //    fontWeight: FontWeight.w600,
            fontSize: 16.sp,
            fontFamily: "Rubik",
            color: Color(0xFF707070),
          ),
        ),
      ]);
    } else {
      //if (bloc.resultsBloc.getGroupEvaluation() == GroupEvaluation_Evaluation.EVAL_UNSPECIFIED) {
      return Container();
    }
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

  String sliderLabel(int value) {
    switch (value) {
      case 1:
        return "${AppLocalizations.of(context)!.poorText}";
      case 2:
        return "${AppLocalizations.of(context)!.notSoGoodText}";
      case 3:
        return "${AppLocalizations.of(context)!.acceptableText}";
      case 4:
        return "${AppLocalizations.of(context)!.goodText}";
      case 5:
        return "${AppLocalizations.of(context)!.greatText}";
      default:
        return "";
    }
  }

  void _updateLearnerSummary() {
    _teacherFeedbackController.text = bloc.resultsBloc.hiveGroupUser
            ?.getTeacherResponseForMonth(bloc.resultsBloc.hiveDate!)
            ?.response ??
        '';

    _transformationController.text = bloc.resultsBloc.hiveGroupUser
            ?.getTransformationForMonth(bloc.resultsBloc.hiveDate!)
            ?.impactStory ??
        '';
  }

  void _saveGroupEvaluation(GroupEvaluation_Evaluation evaluation) {
    HiveGroupEvaluation _hiveGroupEvaluation;

    if (_isEditMode) {
      // TODO:

      _hiveGroupEvaluation = HiveGroupEvaluation();
    } else {
      _hiveGroupEvaluation = HiveGroupEvaluation();
      _hiveGroupEvaluation.userId = bloc.resultsBloc.hiveGroupUser?.userId;
      _hiveGroupEvaluation.groupId = bloc.resultsBloc.hiveGroupUser?.groupId;
      _hiveGroupEvaluation.month = bloc.resultsBloc.hiveDate;
    }
    _hiveGroupEvaluation.evaluation = evaluation.value;

    GroupEvaluationProvider().createUpdateGroupEvaluation(_hiveGroupEvaluation);
  }

  void _saveTeacherFeedback() {
    HiveTeacherResponse? _teacherResponse = bloc.resultsBloc.hiveGroupUser
        ?.getTeacherResponseForMonth(bloc.resultsBloc.hiveDate!);

    if (_teacherResponse == null) {
      _teacherResponse = HiveTeacherResponse();
      _teacherResponse.id = UuidGenerator.uuid();
      _teacherResponse.groupId = bloc.resultsBloc.hiveGroupUser?.groupId;
      _teacherResponse.learnerId = bloc.resultsBloc.hiveGroupUser?.userId;
      _teacherResponse.teacherId = CurrentUserProvider().getUserSync().id;
      _teacherResponse.month = bloc.resultsBloc.hiveDate;
      _teacherResponse.isNew = true;
    } else {
      _teacherResponse.isUpdated = true;
    }

    _teacherResponse.response = _teacherFeedbackController.text;

    TeacherResponseProvider()
        .createUpdateTeacherResponse(_teacherResponse)
        .then((value) {
      debugPrint("Feedback saved.");
      setState(() {}); // refresh ParentView
    }).onError((error, stackTrace) {
      debugPrint("Failed to save Feedback.");
    });
  }

  void _saveTransformation() {
    HiveTransformation? _transformation = bloc.resultsBloc.hiveGroupUser
        ?.getTransformationForMonth(bloc.resultsBloc.hiveDate!);

    print(_transformation.toString());

    if (_transformation == null) {
      _transformation = HiveTransformation();
      _transformation.id = UuidGenerator.uuid();
      _transformation.groupId = bloc.resultsBloc.hiveGroupUser?.groupId;
      _transformation.userId = bloc.resultsBloc.hiveGroupUser?.userId;
      _transformation.month = bloc.resultsBloc.hiveDate;
      _transformation.isNew = true;
    } else {
      _transformation.isUpdated = true;
    }
    _transformation.impactStory = _transformationController.text;

    TransformationProvider()
        .createUpdateTransformation(_transformation)
        .then((value) {
      debugPrint("Transformation saved.");
      setState(() {}); // refresh ParentView
    }).onError((error, stackTrace) {
      debugPrint("Failed to save Transformation");
    });
  }

  void _saveLearnerEvaluation(String categoryId, int value) {
    String evaluatorId = CurrentUserProvider().getUserSync().id;

    HiveLearnerEvaluation? _learnerEvaluation = bloc.resultsBloc.hiveGroupUser
        ?.getLearnerEvaluation(
            bloc.resultsBloc.hiveDate!, categoryId, evaluatorId);

    if (_learnerEvaluation == null) {
      _learnerEvaluation = HiveLearnerEvaluation();
      _learnerEvaluation.id = UuidGenerator.uuid();
      _learnerEvaluation.learnerId = bloc.resultsBloc.hiveGroupUser?.userId;
      _learnerEvaluation.groupId = bloc.resultsBloc.hiveGroupUser?.groupId;
      _learnerEvaluation.evaluatorId = evaluatorId;
      _learnerEvaluation.month = bloc.resultsBloc.hiveDate;
      _learnerEvaluation.categoryId = categoryId;
      _learnerEvaluation.isNew = true;
    } else {
      _learnerEvaluation.isUpdated = true;
    }
    _learnerEvaluation.evaluation = value;

    LearnerEvaluationProvider()
        .createUpdateLearnerEvaluation(_learnerEvaluation)
        .then((value) {
      debugPrint("LearnerEvaluation saved.");
      setState(() {}); // refresh ParentView
    }).onError((error, stackTrace) {
      debugPrint("Failed to save LearnerEvaluation");
    });
  }

  Widget _previewSelectedFiles() {
    final List<Widget> _widgetList = [];

    for (File file in _selectedFiles) {
      _widgetList.add(
        InkWell(onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ImagePreview(file))),
          child: Hero(tag: file,
            child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
    color: Colors.white,
    boxShadow: [
      BoxShadow(color: Colors.grey, spreadRadius: 3),
    ],),
              height: 70.h,
              width: 70.w,
              child: ClipRect(
                child: Image.file(
                  file,fit: BoxFit.fill,
                ),
              ),
            ),
          flightShuttleBuilder: (flightContext, animation, direction,
          fromContext, toContext) {
          return Center(child: CircularProgressIndicator(),);
          },
          ),
        ),
      );
    }

    return Wrap(spacing: 10,
    runSpacing: 10,
   
    //  mainAxisSize: MainAxisSize.max,
   //   crossAxisAlignment: CrossAxisAlignment.start,
      children: _widgetList,
     
    );
  }
}


class ImagePreview extends StatelessWidget {
  const ImagePreview(this.file,{ Key? key }) : super(key: key);
final file;
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: InkWell(onTap:()=> Navigator.pop(context),
      child: Hero(tag: file,
      child: Center(child: Image.file(file))),
    ),
      
    );
  }
}
