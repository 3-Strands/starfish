import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:starfish/enums/action_status.dart';
import 'package:starfish/modules/results/cubit/results_cubit.dart';
import 'package:starfish/modules/results/feedback_from_teachers.dart';
import 'package:starfish/modules/results/group_evaluation_view.dart';
import 'package:starfish/modules/results/user_transformaiton.dart';
import 'package:starfish/src/grpc_extensions.dart';
import 'package:starfish/utils/date_time_utils.dart';
import 'package:starfish/widgets/month_year_picker/dialogs.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:starfish/wrappers/file_system.dart';

class MyLifeResults extends StatefulWidget {
  const MyLifeResults({Key? key}) : super(key: key);

  @override
  _MyLifeResultsState createState() => _MyLifeResultsState();
}

class _MyLifeResultsState extends State<MyLifeResults> {
  List<File>? imageFiles;
  String? userImpactStory;

  late AppLocalizations appLocalizations;

  @override
  Widget build(BuildContext context) {
    appLocalizations = AppLocalizations.of(context)!;
    return Scrollbar(
      thickness: 5.w,
      thumbVisibility: false,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20.h,
            ),
            BlocBuilder<ResultsCubit, ResultsState>(
                buildWhen: (previous, current) =>
                    previous.month != current.month,
                builder: (context, state) {
                  return InkWell(
                    onTap: () async {
                      DateTime? selected = await _selectMonth(state.month);
                      if (selected != null) {
                        context.read<ResultsCubit>().updateMonthFilter(
                              Date(year: selected.year, month: selected.month),
                            );
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
                          DateTimeUtils.formatHiveDate(state.month,
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
                  );
                }),
            SizedBox(
              height: 20.h,
            ),
            BlocBuilder<ResultsCubit, ResultsState>(
                buildWhen: (previous, current) =>
                    previous.month != current.month,
                builder: (context, state) {
                  final resultsToShow = state.myLifeResultsToShow;
                  final groupUserResultsList =
                      resultsToShow.groupUserResultsStatusList;

                  if (groupUserResultsList.isEmpty) {
                    return Container(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            '${appLocalizations.joinOrCreateGroupMessage}',
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
                    );
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: groupUserResultsList.length,
                    itemBuilder: (BuildContext context, index) {
                      final _groupUserResultStatus =
                          groupUserResultsList.elementAt(index);

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
                              '${_groupUserResultStatus.group?.name}',
                              style: TextStyle(
                                  fontFamily: "OpenSans",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 19.sp),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            _buildActionCard(
                                _groupUserResultStatus.actionsStatus),
                            SizedBox(
                              height: 10.h,
                            ),
                            UserTransformation(
                              groupUser: _groupUserResultStatus.groupUser,
                              month: state.month,
                              transformation:
                                  _groupUserResultStatus.transformation,
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            FeedbackFromTeachers(
                              groupUser: _groupUserResultStatus.groupUser,
                              teacherResponses:
                                  _groupUserResultStatus.teacherResponses,
                              month: state.month,
                              learnerEvaluations:
                                  _groupUserResultStatus.learnerEvaluations,
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            GroupEvaluationWidget(
                              groupUser: _groupUserResultStatus.groupUser,
                              month: state.month,
                              groupEvaluation:
                                  _groupUserResultStatus.groupEvaluation,
                            ),
                          ],
                        ),
                      );
                    },
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

  Widget _buildActionCard(Map<ActionStatus, int> actionsStatus) {
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
              "${appLocalizations.resultMoreThenOneActionCompleted}",
              style: TextStyle(
                  fontSize: 19.sp,
                  color: Color(0xFF4F4F4F),
                  fontWeight: FontWeight.w600,
                  fontFamily: "OpenSans"),
            ),
            SizedBox(
              height: 10.h,
            ),
            _buildMonthlyActionWidget(
              actionsStatus[ActionStatus.DONE] ?? 0,
              actionsStatus[ActionStatus.NOT_DONE] ?? 0,
              actionsStatus[ActionStatus.OVERDUE] ?? 0,
              displayOverdue: true,
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              "${appLocalizations.reslutCompleteActionHelpText}",
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
                      "$complete ${appLocalizations.resultZeroOrOneActionCompleted}",
                  one:
                      "$complete ${appLocalizations.resultZeroOrOneActionCompleted}",
                  other:
                      "$complete ${appLocalizations.resultMoreThenOneActionCompleted}",
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
                      "$notComplete ${appLocalizations.resultZeroOrOneActionsIncompleted}",
                  one:
                      "$notComplete ${appLocalizations.resultZeroOrOneActionsIncompleted}",
                  other:
                      "$notComplete ${appLocalizations.resultMoreThenOneActionsIncompleted}",
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
                        "$overdue ${appLocalizations.resultZeroOrOneActionsOverdue}",
                    one:
                        "$overdue ${appLocalizations.resultZeroOrOneActionsOverdue}",
                    other:
                        "$overdue ${appLocalizations.resultMoreThenOneActionsOverdue}",
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

  Future<DateTime?> _selectMonth(Date month) async {
    // reference for the MonthYearPickerLocalizations is add in app.dart
    return await showMonthYearPicker(
      context: context,
      initialDate: DateTimeUtils.toDateTime(
          DateTimeUtils.formatHiveDate(month,
              requiredDateFormat: "dd-MMM-yyyy"),
          "dd-MMM-yyyy"),
      firstDate: DateTime(DateTime.now().year - 10),
      lastDate: DateTime(DateTime.now().year + 10),
      hideActions: true,
    );
  }
}
