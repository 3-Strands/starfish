import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:intl/intl.dart';
import 'package:starfish/bloc/app_bloc.dart';
import 'package:starfish/bloc/provider.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:starfish/constants/assets_path.dart';
import 'package:starfish/db/hive_current_user.dart';
import 'package:starfish/db/hive_date.dart';
import 'package:starfish/db/hive_evaluation_category.dart';
import 'package:starfish/db/hive_file.dart';
import 'package:starfish/db/hive_group.dart';
import 'package:starfish/db/hive_group_evaluation.dart';
import 'package:starfish/db/hive_group_user.dart';
import 'package:starfish/db/hive_teacher_response.dart';
import 'package:starfish/db/hive_transformation.dart';
import 'package:starfish/db/providers/current_user_provider.dart';
import 'package:starfish/db/providers/group_evaluation_provider.dart';
import 'package:starfish/db/providers/teacher_response_provider.dart';
import 'package:starfish/db/providers/transformation_provider.dart';
import 'package:starfish/modules/image_cropper/image_cropper_view.dart';
import 'package:starfish/src/generated/file_transfer.pbgrpc.dart';
import 'package:starfish/src/generated/starfish.pb.dart';
import 'package:starfish/utils/date_time_utils.dart';
import 'package:starfish/utils/helpers/uuid_generator.dart';
import 'package:starfish/widgets/focusable_text_field.dart';
import 'package:starfish/widgets/image_preview.dart';
import 'package:starfish/widgets/month_year_picker/dialogs.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:starfish/widgets/result_transformations_widget.dart';

class MyLifeResults extends StatefulWidget {
  const MyLifeResults({Key? key}) : super(key: key);

  @override
  State<MyLifeResults> createState() => _MyLifeResultsState();
}

class _MyLifeResultsState extends State<MyLifeResults> {
  late AppBloc bloc;
  late HiveCurrentUser currentUser;
  List<File>? imageFiles;
  String? userImpactStory;

  bool _isInitialized = false;

  @override
  Widget build(BuildContext context) {
    bloc = Provider.of(context);

    // call init only once
    if (bloc.resultsBloc.hiveGroup == null) {
      bloc.resultsBloc.init();
    }

    currentUser = CurrentUserProvider().getUserSync();
    return FocusDetector(
      onFocusGained: () {},
      onFocusLost: () {},
      child: Scaffold(
        backgroundColor: AppColors.resultsScreenBG,
        body: Scrollbar(
          thickness: 5.w,
          isAlwaysShown: false,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 20.h,
                ),
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
                    //width: 345.w,
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
                        DateTimeUtils.formatHiveDate(bloc.resultsBloc.hiveDate!,
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
                SizedBox(height: 15.h),
                bloc.resultsBloc.groupsWithLearnerRole.isNotEmpty
                    ? ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: bloc.resultsBloc.groupsWithLearnerRole
                            .length, //bloc.resultsBloc.hiveGroup!.learners!.length,
                        itemBuilder: (BuildContext context, index) {
                          HiveGroup _hiveGroup =
                              bloc.resultsBloc.groupsWithLearnerRole[index];
                          HiveGroupUser? _hiveGroupUser = _hiveGroup.learners
                              ?.firstWhereOrNull((element) =>
                                  element.userId == currentUser.id);

                          return Container(
                            key: UniqueKey(),
                            margin: EdgeInsets.only(left: 15.w, right: 15.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                index != 0
                                    ? SizedBox(
                                        height: 10.h,
                                      )
                                    : Container(),
                                Text(
                                  '${_hiveGroup.name}',
                                  style: TextStyle(
                                      fontFamily: "OpenSans",
                                      fontWeight: FontWeight.bold,
                                      fontSize: 19.sp),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                _buildActionCard(_hiveGroupUser),
                                SizedBox(
                                  height: 10.h,
                                ),
                                _buildTransformationWidget(
                                    hiveGroupUser: _hiveGroupUser!,
                                    learnerId: currentUser.id,
                                    groupId: _hiveGroup.id!,
                                    month: bloc.resultsBloc.hiveDate!),
                                SizedBox(
                                  height: 10.h,
                                ),
                                _buildFeedbackFromTeachers(
                                    hiveGroupUser: _hiveGroupUser,
                                    learnerId: currentUser.id,
                                    groupId: _hiveGroup.id!,
                                    month: bloc.resultsBloc.hiveDate!),
                                SizedBox(
                                  height: 10.h,
                                ),
                                _buildFeelingAboutGroupCard(
                                    hiveGroupUser: _hiveGroupUser,
                                    learnerId: currentUser.id,
                                    groupId: _hiveGroup.id!,
                                    month: bloc.resultsBloc.hiveDate!)
                              ],
                            ),
                          );
                        })
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
                SizedBox(
                  height: 20.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeelingAboutGroupCard(
      {required HiveGroupUser hiveGroupUser,
      required String learnerId,
      required String groupId,
      required HiveDate month}) {
    HiveGroupEvaluation? _hiveGroupEvalution = GroupEvaluationProvider()
        .getGroupUserGroupEvaluation(learnerId, groupId)
        .where((element) => element.month != null
            ? (element.month!.year == month.year &&
                element.month!.month == month.month)
            : false)
        .firstOrNull;

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
          child: Column(children: [
            SizedBox(
              height: 5.h,
            ),
            Text(
              '${AppLocalizations.of(context)!.howDoYouFeelAboutThisGroup}',
              style: TextStyle(
                color: Color(0xFF4F4F4F),
                fontFamily: "OpenSans",
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Container(
                      //   height: 45.h,
                      decoration: BoxDecoration(),
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _saveGroupEvaluations(
                                hiveGroupUser, _hiveGroupEvalution,
                                evaluation: GroupEvaluation_Evaluation.GOOD);
                          });
                        },
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4.r),
                              ),
                            ),
                            backgroundColor: (_hiveGroupEvalution != null &&
                                    GroupEvaluation_Evaluation.valueOf(
                                            _hiveGroupEvalution.evaluation!) ==
                                        GroupEvaluation_Evaluation.GOOD)
                                ? MaterialStateProperty.all<Color>(
                                    Color(0xFF6DE26B))
                                : MaterialStateProperty.all<Color>(
                                    Color(0xFFC9C9C9))),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              AssetsPath.thumbsUp,
                              width: 15.w,
                            ),
                            SizedBox(
                              width: 3.w,
                            ),
                            Text(
                              AppLocalizations.of(context)!.goodText,
                              style: TextStyle(
                                  fontSize: 17.sp,
                                  fontFamily: "Rubik",
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Expanded(
                    child: Container(
                      //   height: 45.h,
                      decoration: BoxDecoration(),
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _saveGroupEvaluations(
                                hiveGroupUser, _hiveGroupEvalution,
                                evaluation: GroupEvaluation_Evaluation.BAD);
                          });
                        },
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4.r),
                              ),
                            ),
                            backgroundColor: (_hiveGroupEvalution != null &&
                                    GroupEvaluation_Evaluation.valueOf(
                                            _hiveGroupEvalution.evaluation!) ==
                                        GroupEvaluation_Evaluation.BAD)
                                ? MaterialStateProperty.all<Color>(
                                    Color(0xFFFFBE4A))
                                : MaterialStateProperty.all<Color>(
                                    Color(0xFFC9C9C9))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              AssetsPath.thumbsDown,
                              width: 15.w,
                            ),
                            SizedBox(
                              width: 3.w,
                            ),
                            Expanded(
                              child: Text(
                                AppLocalizations.of(context)!.notSoGoodText,
                                style: TextStyle(
                                    fontSize: 17.sp,
                                    fontFamily: "Rubik",
                                    color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
          ]),
        ));
  }

  Widget _buildFeedbackFromTeachers(
      {required HiveGroupUser hiveGroupUser,
      required String learnerId,
      required String groupId,
      required HiveDate month}) {
    List<HiveTeacherResponse> _feedbacksFromTeachers = TeacherResponseProvider()
        .getGroupUserTeacherResponse(learnerId, groupId)
        .where((element) => element.month != null
            ? (element.month!.year == month.year &&
                element.month!.month == month.month)
            : false)
        .toList();

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
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 10.h,
            ),
            Text(
              "${AppLocalizations.of(context)!.feedbackFromGroupTeacher}",
              style: TextStyle(
                fontFamily: "OpenSans",
                color: Color(0xFF4F4F4F),
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 10.h,
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: _feedbacksFromTeachers.length,
              itemBuilder: (context, index) {
                HiveTeacherResponse _hiveTeacherResponse =
                    _feedbacksFromTeachers[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
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
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${_hiveTeacherResponse.response}",
                            style: TextStyle(
                              fontFamily: "OpenSans",
                              fontSize: 16.sp,
                              fontStyle: FontStyle.italic,
                              color: Color(0xFF797979),
                            ),
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Text(
                            "${AppLocalizations.of(context)!.teacher}: ${_hiveTeacherResponse.teacher?.name ?? ''}",
                            style: TextStyle(
                              fontFamily: "OpenSans",
                              fontSize: 16.sp,
                              color: Color(0xFF797979),
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                  ],
                );
              },
            ),
            SizedBox(
              height: 10.h,
            ),
            if (bloc.resultsBloc.hiveGroupUser != null)
              _buildCurrentEvaluationWidget(
                hiveGroupUser.getLearnerEvaluationsByCategoryForMoth(
                    bloc.resultsBloc.hiveDate!),
              ),
            SizedBox(
              height: 10.h,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentEvaluationWidget(
      Map<HiveEvaluationCategory, Map<String, int>> _learnersEvaluations) {
    List<Widget> _currentEvaluationWidget = [];
    _learnersEvaluations.forEach(
        (HiveEvaluationCategory category, Map<String, int> countByMonth) {
      _currentEvaluationWidget.add(_buildCategoryStatics(
          countByMonth["this-month"] ?? 0,
          category.name!,
          ((countByMonth["this-month"] ?? 0) -
              (countByMonth["last-month"] ?? 0)),
          Color(0xFF797979)));
    });
    return Row(
      children: _currentEvaluationWidget,
    );
  }

  Widget _buildCategoryStatics(
      int count, String categoryName, int changeInCount, Color textColor) {
    return Expanded(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    "$count",
                    style: TextStyle(
                        color: textColor,
                        fontFamily: "OpenSans",
                        fontSize: 30.sp,
                        fontWeight: FontWeight.bold),
                  ),
                  Image.asset(
                    changeInCount > 0
                        ? AssetsPath.arrowUpIcon
                        : AssetsPath.arrowDownIcon,
                  ),
                ],
              ),
              Text(
                "$categoryName",
                style: TextStyle(
                  fontSize: 15.sp,
                  color: Color(0xFF000000),
                  fontFamily: "Rubik",
                ),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionCard(HiveGroupUser? _hiveGroupUser) {
    return Card(
      //   margin: EdgeInsets.only(left: 15.w, right: 15.w),
      color: Color(0xFFEFEFEF),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Container(
        padding: EdgeInsets.only(left: 15.w, right: 15.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 10.h),
            Text(
              "${AppLocalizations.of(context)!.resultMoreThenOneActionCompleted}",
              style: TextStyle(
                  fontSize: 19.sp,
                  color: Color(0xFF4F4F4F),
                  fontWeight: FontWeight.w600,
                  fontFamily: "OpenSans"),
            ),
            SizedBox(
              height: 10.h,
            ),
            /*_buildMonthlyActionWidget(
                bloc.resultsBloc.actionUserStatusForSelectedMonth(
                    _hiveGroupUser, bloc.resultsBloc.hiveDate!),
                displayOverdue: true),*/

            _buildMonthlyActionWidget(
                _hiveGroupUser?.getActionsCompletedInMonth(
                        bloc.resultsBloc.hiveDate!) ??
                    0,
                _hiveGroupUser?.getActionsNotCompletedInMonth(
                        bloc.resultsBloc.hiveDate!) ??
                    0,
                _hiveGroupUser?.getActionsOverdueInMonth(
                        bloc.resultsBloc.hiveDate!) ??
                    0,
                displayOverdue: true),
            SizedBox(
              height: 10.h,
            ),
            Text(
              "${AppLocalizations.of(context)!.reslutCompleteActionHelpText}",
              style: TextStyle(
                fontFamily: "OpenSans",
                fontStyle: FontStyle.italic,
                fontSize: 14.sp,
                color: Color(0xFF797979),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 10.h,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMonthlyActionWidget(int complete, int notComplete, int overdue,
      {displayOverdue = false}) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
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
      ),
    );
  }

  Card _buildTransformationWidget(
      {required HiveGroupUser hiveGroupUser,
      required String learnerId,
      required String groupId,
      required HiveDate month}) {
    TextEditingController _transformationController = TextEditingController();
    List<HiveFile> _hiveFiles = [];
    List<File> _selectedFiles = [];

    HiveTransformation? _currentGroupUserTransformation =
        TransformationProvider()
            .getGroupUserTransformations(learnerId, groupId)
            .where((element) => element.month != null
                ? (element.month!.year == month.year &&
                    element.month!.month == month.month)
                : false)
            .firstOrNull;

    if (_currentGroupUserTransformation != null &&
        _currentGroupUserTransformation.impactStory != null) {
      _transformationController.text =
          _currentGroupUserTransformation.impactStory!;
    }

    if (_currentGroupUserTransformation != null &&
        _currentGroupUserTransformation.localFiles.isNotEmpty) {
      _hiveFiles = _currentGroupUserTransformation.localFiles;
    }
    return Card(
      color: Color(0xE6EFEFEF),
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
                  if (isFocused) {
                    return;
                  }
                },
                onChange: (String value) {
                  userImpactStory = value.trim();
                  _saveTransformation(userImpactStory, _selectedFiles,
                      hiveGroupUser, _currentGroupUserTransformation);
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

            if (_selectedFiles.isNotEmpty ||
                (_currentGroupUserTransformation != null &&
                    _currentGroupUserTransformation.localFiles.isNotEmpty &&
                    _hiveFiles != null &&
                    _hiveFiles.isNotEmpty))
              _previewSelectedFiles(_hiveFiles, _selectedFiles),
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
                      if ((_selectedFiles.length + (_hiveFiles.length)) >= 5) {
                        Fluttertoast.showToast(
                            msg:
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
                                      var fileSize = _newFile
                                          .readAsBytesSync()
                                          .lengthInBytes;
                                      if (fileSize > 5 * 1024 * 1024) {
                                        Fluttertoast.showToast(
                                            msg: AppLocalizations.of(context)!
                                                .imageSizeValidation);
                                      } else {
                                        setState(() {
                                          _selectedFiles.add(_newFile);
                                          _saveTransformation(
                                              _transformationController.text,
                                              _selectedFiles,
                                              hiveGroupUser,
                                              _currentGroupUserTransformation);
                                          _selectedFiles.clear();
                                        });
                                      }
                                    }),
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

            SizedBox(
              height: 20.h,
            ),
          ],
        ),
      ),
    );
  }

  void _saveTransformation(String? _impactStory, List<File> _files,
      HiveGroupUser hiveGroupUser, HiveTransformation? _hiveTransformation) {
    // _hiveTransformation = widget.hiveGroupUser
    //     .getTransformationForMonth(bloc.resultsBloc.hiveDate!);
    if (_impactStory != null) {
      if (_hiveTransformation == null) {
        _hiveTransformation = HiveTransformation();
        _hiveTransformation.id = UuidGenerator.uuid();
        _hiveTransformation.groupId = hiveGroupUser.groupId;
        _hiveTransformation.userId = hiveGroupUser.userId;
        _hiveTransformation.month = bloc.resultsBloc.hiveDate!;
        _hiveTransformation.isNew = true;
      } else {
        _hiveTransformation.isUpdated = true;
      }

      _hiveTransformation.impactStory = _impactStory;
    }

    List<HiveFile> _transformationFiles = [];

    if (_files.isNotEmpty) {
      _files.forEach((_file) {
        _transformationFiles.add(HiveFile(
          entityId: _hiveTransformation!.id,
          entityType: EntityType.TRANSFORMATION.value,
          filepath: _file.path,
          filename: _file.path.split("/").last,
          isSynced: false,
        ));
      });
    }

    TransformationProvider()
        .createUpdateTransformation(_hiveTransformation!,
            transformationFiles: _transformationFiles)
        .then((value) {
      debugPrint("Transformation saved.");
      // save files also
    }).onError((error, stackTrace) {
      debugPrint("Failed to save Transformation");
    });
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
      hideActions: true,
    );
  }

  Widget _previewSelectedFiles(
      List<HiveFile> _hiveFiles, List<File> _selectedFiles) {
    final List<Widget> _widgetList = [];

    for (File file in _selectedFiles) {
      _widgetList.add(_imagePreview(
          file: file,
          onDelete: () {
            setState(() {
              _selectedFiles.remove(file);
            });
          }));
    }

    if (_hiveFiles.isNotEmpty) {
      for (HiveFile _hiveFile in _hiveFiles) {
        File file = File(_hiveFile.filepath!);
        _widgetList.add(_imagePreview(
            file: file,
            onDelete: () {
              setState(() {
                _hiveFile.delete();
              });
            }));
      }
    }

    return GridView.count(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: (_selectedFiles.length == 1 && _hiveFiles.length == 0) ||
              (_hiveFiles.length == 1 && _selectedFiles.length == 0)
          ? 1
          : 2,
      childAspectRatio: 1,
      children: _widgetList,
    );
  }

  Widget _imagePreview({required File file, required Function onDelete}) {
    return Stack(
      alignment: AlignmentDirectional.topEnd,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.only(top: 10.0, right: 10.0),
          child: Container(
            child: InkWell(
              onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => ImagePreview(file))),
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
                      fit: BoxFit.scaleDown,
                      //  height: 130.h,
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
            // setState(() {
            //   _selectedFiles.remove(file);
            // });
            onDelete();
          },
          icon: Icon(
            Icons.delete,
            color: Colors.red,
          ),
        ),
      ],
    );
  }

  void _saveGroupEvaluations(
      HiveGroupUser hiveGroupUser, HiveGroupEvaluation? _hiveGroupEvalution,
      {required GroupEvaluation_Evaluation evaluation}) {
    if (_hiveGroupEvalution == null) {
      _hiveGroupEvalution = HiveGroupEvaluation();
      _hiveGroupEvalution.id = UuidGenerator.uuid();
      _hiveGroupEvalution.groupId = hiveGroupUser.groupId;
      _hiveGroupEvalution.userId = hiveGroupUser.userId;
      _hiveGroupEvalution.month = bloc.resultsBloc.hiveDate!;
      _hiveGroupEvalution.isNew = true;
    } else {
      _hiveGroupEvalution.isUpdated = true;
    }

    _hiveGroupEvalution.evaluation = evaluation.value;

    GroupEvaluationProvider()
        .createUpdateGroupEvaluation(_hiveGroupEvalution)
        .then((value) {
      debugPrint("Evaluaitons saved.");
      // save files also
    }).onError((error, stackTrace) {
      debugPrint("Evaluations to save Transformation");
    });
  }
}
