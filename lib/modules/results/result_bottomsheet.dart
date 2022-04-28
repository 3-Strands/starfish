import 'dart:io';
import 'dart:ui';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:starfish/bloc/app_bloc.dart';
import 'package:starfish/bloc/provider.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:starfish/constants/assets_path.dart';
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

import 'package:starfish/src/generated/starfish.pb.dart';
import 'package:starfish/utils/date_time_utils.dart';
import 'package:starfish/utils/helpers/snackbar.dart';
import 'package:starfish/utils/helpers/uuid_generator.dart';
import 'package:starfish/widgets/focusable_text_field.dart';
import 'package:starfish/widgets/image_preview.dart';
import 'package:starfish/widgets/month_year_picker/dialogs.dart';
import 'package:starfish/widgets/shapes/slider_thumb.dart';

class ResultWidgetBottomSheet extends StatefulWidget {
  ResultWidgetBottomSheet(this.hiveGroupUser, {Key? key}) : super(key: key);
  HiveGroupUser hiveGroupUser;
  @override
  State<ResultWidgetBottomSheet> createState() =>
      _ResultWidgetBottomSheetState();
}

class _ResultWidgetBottomSheetState extends State<ResultWidgetBottomSheet> {
  late AppBloc bloc;

  bool _isEditMode = false;
  bool isViewActionHistory = false;
  bool isViewCategoryEvalutionHistory = false;
  //double _value = 2.0;

  TextEditingController _teacherFeedbackController = TextEditingController();
  TextEditingController _transformationController = TextEditingController();
  List<File> _selectedFiles = [];

  @override
  Widget build(BuildContext context) {
    bloc = Provider.of(context);
    bloc.resultsBloc.init();
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
                                '${widget.hiveGroupUser.group!.name}',
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
                          print("PRE DATE: ${bloc.resultsBloc.hiveDate}");
                          final selected = await _selectMonth(bloc);
                          print("POST DATE: $selected");
                          if (selected != null) {
                            HiveDate _hiveDate = HiveDate.create(
                                selected.year, selected.month, 0);

                            setState(() {
                              bloc.resultsBloc.hiveDate = _hiveDate;
                              print("POST DATE: ${bloc.resultsBloc.hiveDate}");
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
                                setState(() {
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
  }

  Widget _buildTeacherFeedBackCard() {
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
                        setState(() {
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
    HiveDate _currentMonth = DateTimeUtils.toHiveDate(DateTime.now());
    _currentMonth.day = 0;

    List<HiveDate> _historyAvailableMonths =
        bloc.resultsBloc.getListOfAvailableHistoryMonths();
    _historyAvailableMonths.sort((a, b) => b.compareTo(a));
    if (_historyAvailableMonths.contains(_currentMonth)) {
      _historyAvailableMonths.remove(_currentMonth);
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
              ),
              SizedBox(
                height: 10.h,
              ),
              Divider(
                thickness: 1.0,
                color: Colors.grey,
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
                  Visibility(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                      child: Text(
                        changeInCount > 0
                            ? "+$changeInCount"
                            : "$changeInCount",
                        style: TextStyle(
                          fontFeatures: [FontFeature.superscripts()],
                          fontWeight: FontWeight.bold,
                          color: changeInCount > 0 ? Colors.green : Colors.red,
                        ),
                      ),
                    ),
                    visible: changeInCount != 0,
                  ),
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

            Column(
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
                      child: ElevatedButton(
                        onPressed: () async {
                          if ((!_isEditMode && _selectedFiles.length >= 5)) {
                            StarfishSnackbar.showErrorMessage(context,
                                AppLocalizations.of(context)!.maxFilesSelected);
                          } else {
                            FilePickerResult? result =
                                await FilePicker.platform.pickFiles(
                              allowMultiple: false,
                              type: FileType.image,
                              //  allowedExtensions: ['jpg', 'png', 'jpeg'],
                            );

                            if (result != null) {
                              // if single selected file is IMAGE, open image in Cropper
                              if (result.count == 1) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ImageCropperScreen(
                                      sourceImage: File(result.paths.first!),
                                      onDone: (File? _newFile) {
                                        if (_newFile == null) {
                                          return;
                                        }

                                        setState(() {
                                          _selectedFiles.add(_newFile);
                                          print(
                                              'pathhhhhhh${_selectedFiles[0].path}');
                                        });
                                      },
                                    ),
                                  ),
                                ).then((value) => {
                                      // Handle cropped image here
                                    });
                              } else {
                                setState(() {
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
                      )),
                ),
              ],
            ),

            SizedBox(
              height: 20.h,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionCard() {
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
            _buildMonthlyActionWidget(
                bloc.resultsBloc.actionUserStatusForSelectedMonth(
                    bloc.resultsBloc.hiveDate!),
                displayOverdue: true),
            Column(
              children: [
                Visibility(
                  visible: isViewActionHistory,
                  child: SizedBox(
                    height: 15.h,
                  ),
                ),
                Visibility(
                  visible: isViewActionHistory,
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
                    visible: isViewActionHistory,
                    child: _buildActionHistoryWidget()),
                SizedBox(
                  height: 10.h,
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      isViewActionHistory = !isViewActionHistory;
                    });
                  },
                  child: Text(
                    isViewActionHistory
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
    HiveDate _currentMonth = DateTimeUtils.toHiveDate(DateTime.now());
    _currentMonth.day = 0;

    List<HiveDate> _historyAvailableMonths =
        bloc.resultsBloc.getListOfAvailableHistoryMonths();
    _historyAvailableMonths.sort((a, b) => b.compareTo(a));
    if (_historyAvailableMonths.contains(_currentMonth)) {
      _historyAvailableMonths.remove(_currentMonth);
    }

    _historyAvailableMonths.forEach((element) {
      print(DateTimeUtils.formatHiveDate(element,
          requiredDateFormat: 'dd MMM yyyy'));
    });
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
              _buildMonthlyActionWidget(bloc.resultsBloc
                  .actionUserStatusForSelectedMonth(
                      _historyAvailableMonths.elementAt(index))),
              SizedBox(
                height: 10.h,
              ),
            ],
          );
        });
  }

  Widget _buildMonthlyActionWidget(Map<String, int> actionStatusCount,
      {displayOverdue = false}) {
    int complete = actionStatusCount['done'] ?? 0;
    int notComplete = actionStatusCount['not_done'] ?? 0;
    int overdue = actionStatusCount['overdue'] ?? 0;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: Container(
            width: 99.w,
            decoration: BoxDecoration(
                color: Color(0xFF6DE26B),
                borderRadius: BorderRadius.all(Radius.circular(8.5.r))),
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
            child: Text(
              Intl.plural(
                complete,
                zero:
                    "$complete ${AppLocalizations.of(context)!.resultZeroOrOneActionCompleted}",
                one:
                    "$complete ${AppLocalizations.of(context)!.resultZeroOrOneActionCompleted}",
                other:
                    "$complete ${AppLocalizations.of(context)!.resultMoreThenOneActionCompleted}",
                args: [complete],
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
          width: 10.w,
        ),
        Expanded(
          child: Container(
            width: 99.w,
            decoration: BoxDecoration(
                color: Color(0xFFFFBE4A),
                borderRadius: BorderRadius.all(Radius.circular(8.5.r))),
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
            child: Text(
              Intl.plural(
                notComplete,
                zero:
                    "$notComplete ${AppLocalizations.of(context)!.resultZeroOrOneActionsIncompleted}",
                one:
                    "$notComplete ${AppLocalizations.of(context)!.resultZeroOrOneActionsIncompleted}",
                other:
                    "$notComplete ${AppLocalizations.of(context)!.resultMoreThenOneActionsIncompleted}",
                args: [notComplete],
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
        if (displayOverdue == true) ...[
          SizedBox(
            width: 10.w,
          ),
          Expanded(
            child: Container(
              width: 99.w,
              decoration: BoxDecoration(
                  color: Color(0xFFFF5E4D),
                  borderRadius: BorderRadius.all(Radius.circular(8.5.r))),
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
              child: Text(
                Intl.plural(
                  overdue,
                  zero:
                      "$overdue ${AppLocalizations.of(context)!.resultZeroOrOneActionsOverdue}",
                  one:
                      "$overdue ${AppLocalizations.of(context)!.resultZeroOrOneActionsOverdue}",
                  other:
                      "$overdue ${AppLocalizations.of(context)!.resultMoreThenOneActionsOverdue}",
                  args: [overdue],
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
        ]
      ],
    );
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
      _hiveGroupEvaluation.month = bloc.resultsBloc.hiveDate!.toMonth;
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
      _teacherResponse.month = bloc.resultsBloc.hiveDate!.toMonth;
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

    if (_transformation == null) {
      _transformation = HiveTransformation();
      _transformation.id = UuidGenerator.uuid();
      _transformation.groupId = bloc.resultsBloc.hiveGroupUser?.groupId;
      _transformation.userId = bloc.resultsBloc.hiveGroupUser?.userId;
      _transformation.month = bloc.resultsBloc.hiveDate!.toMonth;
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

    debugPrint(
        "LearnerEvaluation saved for Month: ${bloc.resultsBloc.hiveDate}");
    debugPrint(
        "LearnerEvaluation saved for PreviousDate: ${bloc.resultsBloc.hivePreviousDate}");
    HiveLearnerEvaluation? _learnerEvaluation = bloc.resultsBloc.hiveGroupUser
        ?.getLearnerEvaluation(
            bloc.resultsBloc.hiveDate!, categoryId, evaluatorId);

    if (_learnerEvaluation == null) {
      _learnerEvaluation = HiveLearnerEvaluation();
      _learnerEvaluation.id = UuidGenerator.uuid();
      _learnerEvaluation.learnerId = bloc.resultsBloc.hiveGroupUser?.userId;
      _learnerEvaluation.groupId = bloc.resultsBloc.hiveGroupUser?.groupId;
      _learnerEvaluation.evaluatorId = evaluatorId;
      _learnerEvaluation.month = bloc.resultsBloc.hiveDate!.toMonth;
      _learnerEvaluation.categoryId = categoryId;
      _learnerEvaluation.isNew = true;
    } else {
      _learnerEvaluation.isUpdated = true;
    }
    _learnerEvaluation.evaluation = value;

    /*LearnerEvaluationProvider()
        .createUpdateLearnerEvaluation(_learnerEvaluation)
        .then((value) {
      debugPrint("LearnerEvaluation saved.");
      setState(() {}); // refresh ParentView
    }).onError((error, stackTrace) {
      debugPrint("Failed to save LearnerEvaluation");
    });*/
  }

  Widget _previewSelectedFiles() {
    final List<Widget> _widgetList = [];

    if (_selectedFiles.length == 1) {
      _widgetList.add(Expanded(
        child: Stack(
          alignment: AlignmentDirectional.topEnd,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              //color: Colors.blue,
              padding: const EdgeInsets.only(top: 10.0, right: 0.0),
              child: Container(
                //color: Colors.amber,
                width: MediaQuery.of(context).size.width / 2,
                child: InkWell(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          ImagePreview(_selectedFiles.first))),
                  child: Hero(
                    tag: _selectedFiles.first,
                    child: Card(
                      margin: const EdgeInsets.only(top: 12.0, right: 12.0),
                      shape: BeveledRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.file(
                          _selectedFiles.first,
                          fit: BoxFit.fill,
                          height: 130.h,
                        ),
                      ),
                    ),
                    flightShuttleBuilder: (flightContext, animation, direction,
                        fromContext, toContext) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  _selectedFiles.remove(_selectedFiles.first);
                });
              },
              icon: Icon(
                Icons.delete,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ));
    } else {
      for (File file in _selectedFiles) {
        _widgetList.add(Stack(
          alignment: AlignmentDirectional.topEnd,
          children: [
            Container(
              //color: Colors.blue,
              padding: const EdgeInsets.only(top: 10.0, right: 10.0),
              child: Container(
                //color: Colors.amber,
                child: InkWell(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ImagePreview(file))),
                  child: Hero(
                    tag: file,
                    child: Card(
                      margin: const EdgeInsets.only(top: 12.0, right: 12.0),
                      shape: BeveledRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.file(
                          file,
                          fit: BoxFit.cover,
                          height: 130.h,
                        ),
                      ),
                    ),
                    flightShuttleBuilder: (flightContext, animation, direction,
                        fromContext, toContext) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  _selectedFiles.remove(file);
                });
              },
              icon: Icon(
                Icons.delete,
                color: Colors.red,
              ),
            ),
          ],
        ));
      }
    }

    return GridView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: _selectedFiles.length == 1 ? 1 : 2,
      ),
      children: _widgetList,
    );
  }
}
