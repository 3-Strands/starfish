import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starfish/bloc/app_bloc.dart';
import 'package:starfish/bloc/provider.dart';
import 'package:starfish/db/hive_group_user.dart';
import 'package:starfish/db/hive_learner_evaluation.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LearnerSummary extends StatelessWidget {
  HiveGroupUser hiveGroupUser;
  LearnerSummary({Key? key, required this.hiveGroupUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppBloc bloc = Provider.of(context);
    return Column(
      children: [
        SizedBox(
          height: 10.h,
        ),
        Card(
          margin: EdgeInsets.only(left: 15.w, right: 15.w),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  "${hiveGroupUser.name}",
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
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Center(
                        child: Text(
                          "${AppLocalizations.of(context)!.actionsTabItemText}",
                          style: TextStyle(
                              color: Color(
                                0xFF4F4F4F,
                              ),
                              fontFamily: "OpenSans Semibold",
                              fontSize: 17.sp),
                        ),
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      Expanded(
                        child: Container(
                          //   width: 99.w,
                          decoration: BoxDecoration(
                              color: Color(0xFF6DE26B),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.5.r))),
                          padding: EdgeInsets.symmetric(
                              vertical: 8.h, horizontal: 8.w),
                          child: Text(
                            "${hiveGroupUser.actionsCompleted} ${AppLocalizations.of(context)!.done}",
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: "Rubik Medium",
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      Expanded(
                        child: Container(
                          //    width: 99.w,
                          decoration: BoxDecoration(
                              color: Color(0xFFFFBE4A),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.5.r))),
                          padding: EdgeInsets.symmetric(
                              vertical: 8.h, horizontal: 8.w),
                          child: Text(
                            "${hiveGroupUser.actionsNotCompleted} ${AppLocalizations.of(context)!.pending}",
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: "Rubik Medium",
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      Expanded(
                        child: Container(
                          //     width: 99.w,
                          decoration: BoxDecoration(
                              color: Color(0xFFFF5E4D),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.5.r))),
                          padding: EdgeInsets.symmetric(
                              vertical: 8.h, horizontal: 8.w),
                          child: Text(
                            "${hiveGroupUser.actionsOverdue} ${AppLocalizations.of(context)!.overdue}",
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: "Rubik Medium",
                                fontSize: 14.sp,
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
                      "${AppLocalizations.of(context)!.transformation}: ",
                      style: TextStyle(
                          fontSize: 17.sp,
                          fontFamily: "Open Sans Semibold",
                          color: Color(0xFF4F4F4F),
                          fontWeight: FontWeight.w600),
                    ),
                    Expanded(
                      child: Container(
                        child: Text(
                          "${hiveGroupUser.getTransformationForMonth(bloc.resultsBloc.hiveDate!)}",
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
                      "${AppLocalizations.of(context)!.feelingAboutTheGroup}: ",
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
                              "${hiveGroupUser.getGroupEvaluationForMonth(bloc.resultsBloc.hiveDate!)}",
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
                      "${AppLocalizations.of(context)!.feedback}: ",
                      style: TextStyle(
                          fontSize: 17.sp,
                          fontFamily: "Open Sans Semibold",
                          color: Color(0xFF4F4F4F),
                          fontWeight: FontWeight.w600),
                    ),
                    Expanded(
                      child: Container(
                        child: Text(
                          "${hiveGroupUser.getTeacherResponseForMonth(bloc.resultsBloc.hiveDate!)}",
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
                _buildCategoryAverageWidget(
                    hiveGroupUser.getLearnerEvaluationForMonth(
                            bloc.resultsBloc.hiveDate!) ??
                        []),
                SizedBox(height: 10.h),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryAverageWidget(
      List<HiveLearnerEvaluation> _learnersEvaluationsList) {
    List<Widget> _categoryWidgets = [];
    _learnersEvaluationsList.forEach((HiveLearnerEvaluation learnerEvaluation) {
      _categoryWidgets.add(
        _buildCategoryStatics(learnerEvaluation.evaluation!,
            learnerEvaluation.name!, Color(0xFFFFFFFF)),
      );
    });
    return Row(
      children: _categoryWidgets,
    );
  }

  Widget _buildCategoryStatics(
      int count, String categoryName, Color textColor) {
    return Expanded(
      child: Container(
        child: Column(
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
              "$categoryName",
              style: TextStyle(
                  fontSize: 15.sp, color: textColor, fontFamily: "Rubik"),
            )
          ],
        ),
      ),
    );
  }
}
