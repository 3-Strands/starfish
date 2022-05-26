import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starfish/constants/assets_path.dart';
import 'package:starfish/db/hive_date.dart';
import 'package:starfish/db/hive_evaluation_category.dart';
import 'package:starfish/db/hive_group_user.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:starfish/widgets/action_status_count_widget.dart';
import 'package:starfish/widgets/focusable_text_field.dart';

class LearnerSummary extends StatelessWidget {
  final HiveGroupUser hiveGroupUser;
  final HiveDate month;

  const LearnerSummary(
      {Key? key, required this.hiveGroupUser, required this.month})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    //AppBloc bloc = Provider.of(context);
    return Column(
      children: [
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
                    fontFamily: "OpenSans",
                    fontSize: 19.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                ActionStatusCountWidget(
                    label:
                        "${AppLocalizations.of(context)!.actionsTabItemText}",
                    done: hiveGroupUser.getActionsCompletedInMonth(month),
                    pending: hiveGroupUser.getActionsNotCompletedInMonth(month),
                    overdue: hiveGroupUser.getActionsOverdueInMonth(month)),
                SizedBox(
                  height: 15.h,
                ),
                Text(
                  "${AppLocalizations.of(context)!.learnerProfile}",
                  style: TextStyle(
                      fontSize: 17.sp,
                      fontFamily: "OpenSans ",
                      color: Color(0xFF4F4F4F),
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 5.h,
                ),
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
                    //   controller: _transformationController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      // hintText:
                      //     '${AppLocalizations.of(context)!.hintTextTransformationsTextField}',
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
                      // userImpactStory = value.trim();
                      // _saveTransformation(userImpactStory, _selectedFiles,
                      //     hiveGroupUser, _currentGroupUserTransformation);
                    },
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Divider(
                  thickness: 1.0,
                  color: Colors.grey,
                ),
                SizedBox(
                  height: 10.h,
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            "${AppLocalizations.of(context)!.transformations}: ",
                        style: TextStyle(
                            fontSize: 17.sp,
                            fontFamily: "OpenSans ",
                            color: Color(0xFF4F4F4F),
                            fontWeight: FontWeight.w600),
                      ),
                      TextSpan(
                        //  "${hiveGroupUser.getTransformationForMonth(month)?.impactStory ?? ''}",
                        text: (hiveGroupUser
                                        .getTransformationForMonth(month)
                                        ?.impactStory
                                        ?.length ??
                                    0) >
                                25
                            ? "${hiveGroupUser.getTransformationForMonth(month)?.impactStory?.substring(0, 25) ?? ''}..."
                            : "${hiveGroupUser.getTransformationForMonth(month)?.impactStory ?? ''}",
                        style: TextStyle(
                          fontFamily: "OpenSans",
                          fontSize: 17.sp,
                          fontStyle: FontStyle.italic,
                          color: Color(0xFF4F4F4F),
                        ),
                      ),
                    ],
                  ),
                ),
                /*SizedBox(
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
                ),*/
                SizedBox(
                  height: 15.h,
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "${AppLocalizations.of(context)!.feedback}: ",
                        style: TextStyle(
                            fontSize: 17.sp,
                            fontFamily: "OpenSans ",
                            color: Color(0xFF4F4F4F),
                            fontWeight: FontWeight.w600),
                      ),
                      TextSpan(
                        text: (hiveGroupUser
                                        .getTeacherResponseForMonth(month)
                                        ?.response
                                        ?.length ??
                                    0) >
                                25
                            ? "${hiveGroupUser.getTeacherResponseForMonth(month)?.response?.substring(0, 25) ?? ''}..."
                            : "${hiveGroupUser.getTeacherResponseForMonth(month)?.response ?? ''}",
                        style: TextStyle(
                          fontFamily: "OpenSans",
                          fontSize: 17.sp,
                          fontStyle: FontStyle.italic,
                          color: Color(0xFF4F4F4F),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                _buildCategoryAverageWidget(
                  hiveGroupUser.getLearnerEvaluationsByCategoryForMoth(month),
                ),
                SizedBox(height: 10.h),
              ],
            ),
          ),
        ),
      ],
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
          Color(0xFF797979),
          (countByMonth["last-month"] == 0 ||
              countByMonth["this-month"] == 0)));
    });
    return Row(
      children: _categoryWidgets,
    );
  }

  Widget _buildCategoryStatics(int count, String categoryName,
      int changeInCount, Color textColor, bool hideGrowthIndicator) {
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
                    count > 0 ? "$count" : "--",
                    style: TextStyle(
                        color: textColor,
                        fontFamily: "OpenSans",
                        fontSize: 30.sp,
                        fontWeight: FontWeight.bold),
                  ),
                  if (changeInCount != 0 && !hideGrowthIndicator)
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
}
