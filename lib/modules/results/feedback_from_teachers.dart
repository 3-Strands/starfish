import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:starfish/constants/assets_path.dart';
import 'package:starfish/src/grpc_extensions.dart';

class FeedbackFromTeachers extends StatelessWidget {
  const FeedbackFromTeachers({
    Key? key,
    required this.groupUser,
    this.teacherResponses,
    required this.learnerEvaluations,
    required this.month,
  }) : super(key: key);

  final GroupUser groupUser;
  final Date month;
  final List<TeacherResponse>? teacherResponses;
  final Map<EvaluationCategory, Map<String, int>> learnerEvaluations;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

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
              "${appLocalizations.feedbackFromGroupTeacher}",
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
              itemCount: teacherResponses?.length ?? 0,
              itemBuilder: (context, index) {
                final _teacherResponse = teacherResponses![index];
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
                            "${_teacherResponse.response}",
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
                            "${appLocalizations.teacher}: ${_teacherResponse.teacher?.name ?? ''}",
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
            _buildCurrentEvaluationWidget(learnerEvaluations),
            SizedBox(
              height: 10.h,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentEvaluationWidget(
      Map<EvaluationCategory, Map<String, int>> _learnersEvaluations) {
    List<Widget> _currentEvaluationWidget = [];
    _learnersEvaluations
        .forEach((EvaluationCategory category, Map<String, int> countByMonth) {
      _currentEvaluationWidget.add(_buildCategoryStatics(
          countByMonth["this-month"] ?? 0,
          category.name,
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
                    changeInCount == 0
                        ? AssetsPath.arrowRight
                        : changeInCount > 0
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
}
