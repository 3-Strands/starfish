import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starfish/constants/assets_path.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:starfish/src/generated/google/type/date.pb.dart';
import 'package:starfish/src/grpc_extensions.dart';
import 'package:starfish/widgets/action_status_count_widget.dart';

class SummaryForAllLearners extends StatelessWidget {
  const SummaryForAllLearners(
      {Key? key,
      required this.hiveGroup,
      required this.month,
      required this.groupLearnerEvaluationsByCategory,
      required this.groupEvaluationGoodCount,
      required this.groupEvaluationBadCount})
      : super(key: key);

  final Group hiveGroup;
  final Date month;
  final Map<EvaluationCategory, Map<String, int>>
      groupLearnerEvaluationsByCategory;
  final int? groupEvaluationGoodCount;
  final int? groupEvaluationBadCount;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
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
            "${appLocalizations.summaryForAllLearners}",
            style: TextStyle(
                color: Color(0xFFFFFFFF),
                fontFamily: "OpenSans",
                fontSize: 19.sp,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10.h,
          ),
          Center(
            child: Text(
              "${appLocalizations.actionsTabItemText}",
              style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontFamily: "OpenSans",
                  fontSize: 17.sp,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          ActionStatusCountWidget(
            done: 0, //hiveGroup.getActionsCompletedInMonth(month),
            pending: 0, //hiveGroup.getActionsNotYetCompletedInMonth(month),
            overdue: 0, //hiveGroup.getActionsOverdueInMonth(month)
          ),

          // Uncomment once leaner is allowed to update 'GroupEvaluation'
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
            child: Divider(
              color: Color(0xFF5D5D5D),
              thickness: 1,
            ),
          ),
          Center(
              child: Text(
            "${appLocalizations.feelingAboutTheGroup}",
            style: TextStyle(
                color: Color(0xFFFFFFFF),
                fontFamily: "OpenSans",
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
                  "${groupEvaluationGoodCount ?? 0}  ${appLocalizations.goodText}",
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: "Rubik",
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500),
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
                child: Text(
                  "${groupEvaluationBadCount ?? 0} ${appLocalizations.notSoGoodText}",
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: "Rubik",
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500),
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
              "${appLocalizations.averages}",
              style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontFamily: "OpenSans",
                  fontSize: 17.sp,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 10.h),
          _buildCategoryAverageWidget(
              groupLearnerEvaluationsByCategory,
              (hiveGroup.learners != null && hiveGroup.learners!.length > 0)
                  ? hiveGroup.learners!.length
                  : 1),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }

  Widget _buildCategoryAverageWidget(
      Map<EvaluationCategory, Map<String, int>> _learnersEvaluations,
      int learnerCount) {
    List<Widget> _categoryWidgets = [];
    _learnersEvaluations
        .forEach((EvaluationCategory category, Map<String, int> countByMonth) {
      _categoryWidgets.add(_buildCategoryStatics(
          (countByMonth["this-month"] ?? 0) / learnerCount,
          category.name,
          (((countByMonth["this-month"] ?? 0) / learnerCount) -
              ((countByMonth["last-month"] ?? 0) / learnerCount)),
          Color(0xFFFFFFFF),
          countByMonth["last-month"] == 0));
    });
    return Row(
      children: _categoryWidgets,
    );
  }

  Widget _buildCategoryStatics(double count, String categoryName,
      double changeInCount, Color textColor, bool hideGrowthIndicator) {
    return Expanded(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      count > 0 ? "${count.toStringAsFixed(1)}" : "--",
                      style: TextStyle(
                        color: textColor,
                        fontFamily: "OpenSans",
                        fontSize: 30.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (changeInCount != 0 && !hideGrowthIndicator)
                      Image.asset(
                        changeInCount > 0
                            ? AssetsPath.arrowUpIcon
                            : AssetsPath.arrowDownIcon,
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
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}
