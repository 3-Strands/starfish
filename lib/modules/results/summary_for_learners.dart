import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starfish/bloc/app_bloc.dart';
import 'package:starfish/bloc/provider.dart';
import 'package:starfish/db/hive_evaluation_category.dart';
import 'package:starfish/db/hive_group.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SummaryForAllLearners extends StatelessWidget {
  const SummaryForAllLearners({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppBloc bloc = Provider.of(context);
    return Container(
      decoration: BoxDecoration(
          color: Color(0xFF424242),
          borderRadius: BorderRadius.all(Radius.circular(10.r))),
      margin: EdgeInsets.only(left: 15.w, right: 15.w),
      padding: EdgeInsets.only(left: 10.w, right: 10.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 10.h,
          ),
          Text(
            "${AppLocalizations.of(context)!.summaryForAllLearners}",
            style: TextStyle(
                color: Color(0xFFFFFFFF),
                fontFamily: "Rubik Medium",
                fontSize: 19.sp,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10.h,
          ),
          Center(
            child: Text(
              "${AppLocalizations.of(context)!.actionsTabItemText}",
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
                    borderRadius: BorderRadius.all(Radius.circular(8.5.r))),
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
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
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
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
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
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
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
            child: Divider(
              color: Color(0xFF5D5D5D),
              thickness: 1,
            ),
          ),
          Center(
              child: Text(
            "${AppLocalizations.of(context)!.feelingAboutTheGroup}",
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
                    borderRadius: BorderRadius.all(Radius.circular(8.5.r))),
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                child: Text(
                  "${bloc.resultsBloc.hiveGroup?.learnersEvaluationGood} ${AppLocalizations.of(context)!.goodText}",
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: "Rubik Medium",
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                width: 20.w,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Color(0xFFC6C6C6),
                    borderRadius: BorderRadius.all(Radius.circular(8.5.r))),
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                child: Flexible(
                  child: Text(
                    "${bloc.resultsBloc.hiveGroup?.learnersEvaluationNotGood} ${AppLocalizations.of(context)!.notSoGoodText}",
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
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
            child: Divider(
              color: Color(0xFF5D5D5D),
              thickness: 1,
            ),
          ),
          Center(
            child: Text(
              "${AppLocalizations.of(context)!.averages}",
              style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontFamily: "Open Sans Bold",
                  fontSize: 17.sp,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 10.h),
          _buildCategoryAverageWidget(
              bloc.resultsBloc.getGroupLearnerEvaluationsByCategory()),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }

  Widget _buildCategoryAverageWidget(
      Map<HiveEvaluationCategory, Map<String, int>> _learnersEvaluations) {
    List<Widget> _categoryWidgets = [];
    _learnersEvaluations.forEach(
        (HiveEvaluationCategory category, Map<String, int> countByMonth) {
      _categoryWidgets.add(_buildCategoryStatics(
          countByMonth["this-month"] ?? 0,
          category.name!,
          ((countByMonth["this-month"] ?? 0) -
              (countByMonth["last-month"] ?? 0)),
          Color(0xFFFFFFFF)));
    });
    return Row(
      children: _categoryWidgets,
    );
  }

  Widget _buildCategoryStatics(
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
                  Text(
                    "$count",
                    style: TextStyle(
                      color: textColor,
                      fontFamily: "Rubik Medium",
                      fontSize: 30.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (changeInCount != 0)
                    Icon(
                      changeInCount > 0
                          ? Icons.arrow_upward
                          : Icons.arrow_downward,
                      color: changeInCount > 0
                          ? Color(0xFF6DE26B)
                          : Color(0xFFFF5E4D),
                    ),
                ],
              ),
            ),
            Text(
              "$categoryName",
              style: TextStyle(
                fontSize: 15.sp,
                color: textColor,
                fontFamily: "Rubik",
              ),
            )
          ],
        ),
      ),
    );
  }
}