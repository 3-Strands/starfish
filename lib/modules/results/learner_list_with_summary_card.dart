import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starfish/constants/assets_path.dart';
import 'package:starfish/enums/action_status.dart';
import 'package:starfish/modules/results/cubit/results_cubit.dart';
import 'package:starfish/src/generated/google/type/date.pb.dart';
import 'package:starfish/utils/helpers/extensions/strings.dart';
import 'package:starfish/db/hive_evaluation_category.dart';
import 'package:starfish/db/hive_group_user.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:starfish/src/generated/starfish.pb.dart';
import 'package:starfish/widgets/action_status_count_widget.dart';

class LearnerSummary extends StatelessWidget {
  const LearnerSummary({
    Key? key,
    required this.groupUserResultStatus,
    required this.month,
    //this.leanerEvaluationForGroup,
  }) : super(key: key);

  final GroupUserResultStatus groupUserResultStatus;
  final Date month;
  //final GroupEvaluation? leanerEvaluationForGroup;

  @override
  Widget build(BuildContext context) {
    // TextEditingController _profileController = TextEditingController();
    // _profileController.text = hiveGroupUser.profile ?? '';
    final user = groupUserResultStatus.user;
    final groupUser = groupUserResultStatus.groupUser;
    final groupEvaluation = groupUserResultStatus.groupEvaluation;
    final transformation = groupUserResultStatus.transformation;
    final teacherResponses = groupUserResultStatus.teacherResponses;
    final actionStatus = groupUserResultStatus.actionsStatus;

    final AppLocalizations _appLocalizations = AppLocalizations.of(context)!;
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
                  "${user.name}",
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
                  label: "${_appLocalizations.actionsTabItemText}",
                  done: actionStatus[ActionStatus.DONE] ?? 0,
                  pending: actionStatus[ActionStatus.NOT_DONE] ?? 0,
                  overdue: actionStatus[ActionStatus.OVERDUE] ?? 0,
                ),
                SizedBox(
                  height: 15.h,
                ),
                Text(
                  "${_appLocalizations.learnerProfile}",
                  style: TextStyle(
                      fontSize: 17.sp,
                      fontFamily: "OpenSans",
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
                  child: TextField(
                    maxLength: 500,
                    //controller: _profileController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      // hintText:
                      //     '${_appLocalizations.hintTextTransformationsTextField}',
                      hintStyle: TextStyle(
                        fontFamily: "OpenSans",
                        fontSize: 16.sp,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    maxLines: 3,
                    textInputAction: TextInputAction.done,
                    onSubmitted: (String value) {
                      //  _saveLearnerProfile(hiveGroupUser, value);
                    },
                    /*onFocusChange: (isFocused) {
                      if (isFocused) {
                        return;
                      }
                      _saveLearnerProfile(
                          hiveGroupUser, _profileController.text.trim());
                    },
                    onChanged: (String value) {
                      // userImpactStory = value.trim();
                      // _saveTransformation(userImpactStory, _selectedFiles,
                      //     hiveGroupUser, _currentGroupUserTransformation);
                    },*/
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
                        text: "${_appLocalizations.transformations}: ",
                        style: TextStyle(
                            fontSize: 17.sp,
                            fontFamily: "OpenSans",
                            color: Color(0xFF4F4F4F),
                            fontWeight: FontWeight.w600),
                      ),
                      TextSpan(
                        //  "${hiveGroupUser.getTransformationForMonth(month)?.impactStory ?? ''}",
                        text: transformation?.impactStory ?? '',
                        style: TextStyle(
                          fontFamily: "OpenSans",
                          fontSize: 17.sp,
                          fontStyle: FontStyle.italic,
                          color: Color(0xFF4F4F4F),
                        ),
                      ),
                    ],
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  height: 15.h,
                ),
                Row(
                  children: [
                    Text(
                      "${_appLocalizations.feelingAboutTheGroup}: ",
                      style: TextStyle(
                          fontSize: 17.sp,
                          fontFamily: "OpenSans",
                          fontStyle: FontStyle.normal,
                          color: Color(0xFF4F4F4F),
                          fontWeight: FontWeight.w600),
                    ),
                    if (groupEvaluation != null)
                      Expanded(
                        child: Container(
                          child: Row(
                            children: [
                              groupEvaluation.evaluation ==
                                      GroupEvaluation_Evaluation.GOOD
                                  ? Image.asset(
                                      AssetsPath.thumbsUp,
                                      color: Color(0xFF797979),
                                      height: 15.sp,
                                    )
                                  : Image.asset(
                                      AssetsPath.thumbsDown,
                                      color: Color(0xFF797979),
                                      height: 15.sp,
                                    ),
                              SizedBox(
                                width: 5.w,
                              ),
                              Text(
                                "${groupEvaluation.evaluation.name.toCapitalized()}",
                                style: TextStyle(
                                  fontFamily: "Rubik",
                                  fontSize: 15.sp,
                                  color: Color(0xFF797979),
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
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "${_appLocalizations.feedback}: ",
                        style: TextStyle(
                            fontSize: 17.sp,
                            fontFamily: "OpenSans",
                            color: Color(0xFF4F4F4F),
                            fontWeight: FontWeight.w600),
                      ),
                      TextSpan(
                        text: teacherResponses.length > 0
                            ? teacherResponses.first.response
                            : '',
                        style: TextStyle(
                          fontFamily: "OpenSans",
                          fontSize: 17.sp,
                          fontStyle: FontStyle.italic,
                          color: Color(0xFF4F4F4F),
                        ),
                      ),
                    ],
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  height: 20.h,
                ),
                // _buildCategoryAverageWidget(
                //   groupUser.getLearnerEvaluationsByCategoryForMoth(month),
                // ),
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

  void _saveLearnerProfile(HiveGroupUser groupUser, String profile) async {
    groupUser.profile = profile;
    groupUser.isUpdated = true;
    // await GroupProvider().createUpdateGroupUser(groupUser);

    // // Broadcast to sync learner's profile, as it may a local learner assigned to local group,
    // // sync group and groupmembers
    // FBroadcast.instance().broadcast(
    //   SyncService.kUpdateGroup,
    //   value: groupUser,
    // );
  }
}
