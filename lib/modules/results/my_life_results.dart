import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:intl/intl.dart';
import 'package:starfish/bloc/app_bloc.dart';
import 'package:starfish/bloc/provider.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:starfish/constants/assets_path.dart';
import 'package:starfish/db/hive_current_user.dart';
import 'package:starfish/db/hive_date.dart';
import 'package:starfish/db/hive_evaluation_category.dart';
import 'package:starfish/db/hive_group.dart';
import 'package:starfish/db/hive_group_user.dart';
import 'package:starfish/db/providers/current_user_provider.dart';
import 'package:starfish/src/generated/starfish.pb.dart';
import 'package:starfish/utils/date_time_utils.dart';
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
                                ResultTransformationsWidget(),
                                SizedBox(
                                  height: 10.h,
                                ),
                                _buildFeedbackFromTeachers(),
                                SizedBox(
                                  height: 10.h,
                                ),
                                _buildFeelingAboutGroupCard()
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

  Widget _buildFeelingAboutGroupCard() {
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
                        onPressed: () {},
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                          ),
                          backgroundColor: MaterialStateProperty.all<Color>(
                            //AppColors.completeTaskBGColor),
                            Color(0xFF6DE26B),
                          ),
                        ),
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
                        onPressed: () {},
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4.r),
                              ),
                            ),
                            backgroundColor: MaterialStateProperty.all<Color>(
                              Color(0xFF797979).withOpacity(0.4),
                            )),
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

  Widget _buildFeedbackFromTeachers() {
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
              itemBuilder: (context, index) {
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
                            "Feedback form teacher comes here, which is month specific",
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
                            "${AppLocalizations.of(context)!.teacher}: Matt",
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
              itemCount: 3,
            ),
            SizedBox(
              height: 10.h,
            ),
            if (bloc.resultsBloc.hiveGroupUser != null)
              _buildCurrentEvaluationWidget(
                bloc.resultsBloc.hiveGroupUser!
                    .getLearnerEvaluationsByCategoryForMoth(
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
