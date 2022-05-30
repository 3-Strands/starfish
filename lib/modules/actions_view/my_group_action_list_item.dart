import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:starfish/bloc/provider.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:starfish/db/hive_action.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:starfish/enums/action_status.dart';
import 'package:starfish/modules/actions_view/add_edit_action.dart';
import 'package:starfish/utils/date_time_utils.dart';
import 'package:starfish/utils/helpers/alerts.dart';
import 'package:template_string/template_string.dart';
import 'package:starfish/src/generated/starfish.pb.dart';

class MyGroupActionListItem extends StatelessWidget {
  final HiveAction action;
  final index;
  final Function(HiveAction action) onActionTap;

  const MyGroupActionListItem(
      {Key? key, required this.action, required this.onActionTap, this.index});

  @override
  Widget build(BuildContext context) {
    AppLocalizations _appLocalizations = AppLocalizations.of(context)!;

    int countActionStatusDone =
        action.memberCountByActionStatus(ActionStatus.DONE);
    int countActionStatusNotDone =
        action.memberCountByActionStatus(ActionStatus.NOT_DONE);
    int countActionStatusOverdue =
        action.memberCountByActionStatus(ActionStatus.OVERDUE);

    bool maintainSize = (countActionStatusDone +
            countActionStatusNotDone +
            countActionStatusOverdue) >
        0;

    int _thumbsUp = action.learnerCountByEvaluation(ActionUser_Evaluation.GOOD);
    int _thumbsDown =
        action.learnerCountByEvaluation(ActionUser_Evaluation.BAD);
    int _totalLearners =
        (action.learners != null && action.learners!.length > 0)
            ? action.learners!.length
            : 1;

    return Card(
      margin: EdgeInsets.only(left: 15.w, right: 15.w, top: 5.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      color: AppColors.txtFieldBackground,
      child: InkWell(
        onTap: () {
          onActionTap(action);
        },
        child: Padding(
          padding:
              EdgeInsets.only(left: 5.w, right: 5.w, top: 5.h, bottom: 15.h),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 10.w),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "#${index + 1}",
                      style: TextStyle(
                          color: Color(0xFF797979),
                          fontSize: 19.sp,
                          fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 8.0, right: 8),
                        child: Text(
                          action.name ?? '',
                          //maxLines: 1,
                          //overflow: TextOverflow.ellipsis,
                          //softWrap: false,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 19.sp,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 30.w,
                      height: 40.h,
                      child: PopupMenuButton(
                          icon: Icon(
                            Icons.more_vert,
                            color: Color(0xFF3475F0),
                          ),
                          color: Colors.white,
                          elevation: 20,
                          shape: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white, width: 2),
                              borderRadius: BorderRadius.circular(12.r)),
                          enabled: true,
                          onSelected: (value) {
                            switch (value) {
                              case 0:
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AddEditAction(
                                      action: action,
                                    ),
                                  ),
                                ).then((value) => FocusScope.of(context)
                                    .requestFocus(new FocusNode()));
                                break;
                              case 1:
                                _deleteAction(context, action);

                                break;
                            }
                          },
                          itemBuilder: (context) => [
                                PopupMenuItem(
                                  child: Text(
                                    _appLocalizations.editActionText,
                                    style: TextStyle(
                                        color: Color(0xFF3475F0),
                                        fontSize: 19.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  value: 0,
                                ),
                                PopupMenuItem(
                                  child: Text(
                                    _appLocalizations.deleteActionText,
                                    style: TextStyle(
                                        color: Color(0xFF3475F0),
                                        fontSize: 19.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  value: 1,
                                ),
                              ]),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      width: 8.w,
                    ),
                    Visibility(
                      child: Container(
                        width: 99.w,
                        decoration: BoxDecoration(
                          color: Color(0xFF6DE26B),
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.5.r),
                          ),
                        ),
                        padding: EdgeInsets.symmetric(
                            vertical: 10.h, horizontal: 6.w),
                        child: Text(
                          Intl.plural(countActionStatusDone,
                              zero:
                                  "$countActionStatusDone ${_appLocalizations.zeroOrOneMemberDidIt}",
                              one: "$countActionStatusDone ${_appLocalizations.zeroOrOneMemberDidIt}",
                              other: "$countActionStatusDone ${_appLocalizations.moreThenOneMembersDidIt}",
                              args: [countActionStatusDone]),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Rubik",
                            fontSize: 17.sp,
                          ),
                        ),
                      ),
                      maintainAnimation: maintainSize,
                      maintainState: maintainSize,
                      maintainSize: maintainSize,
                      visible: countActionStatusDone > 0,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Visibility(
                        child: Container(
                          width: 99.w,
                          decoration: BoxDecoration(
                            color: Color(0xFFFFBE4A),
                            borderRadius: BorderRadius.all(
                              Radius.circular(8.5.r),
                            ),
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: 10.h, horizontal: 6.w),
                          child: Text(
                            Intl.plural(countActionStatusNotDone,
                                zero:
                                    "$countActionStatusNotDone ${_appLocalizations.zeroOrOneMemberDidNotDoItYet}",
                                one: "$countActionStatusNotDone ${_appLocalizations.zeroOrOneMemberDidNotDoItYet}",
                                other: "$countActionStatusNotDone ${_appLocalizations.moreThenOneMembersDidNotDoItYet}",
                                args: [countActionStatusNotDone]),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Rubik",
                              fontSize: 17.sp,
                            ),
                          ),
                        ),
                        maintainAnimation: maintainSize,
                        maintainState: maintainSize,
                        maintainSize: maintainSize,
                        visible: countActionStatusNotDone > 0),
                    SizedBox(
                      width: 10.w,
                    ),
                    Visibility(
                      child: Container(
                        width: 99.w,
                        decoration: BoxDecoration(
                          color: Color(0xFFFF5E4D),
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.5.r),
                          ),
                        ),
                        padding: EdgeInsets.symmetric(
                            vertical: 10.h, horizontal: 6.w),
                        child: Text(
                          Intl.plural(countActionStatusOverdue,
                              zero:
                                  "$countActionStatusOverdue ${_appLocalizations.zeroOrOneMemberIsOverdue}",
                              one: "$countActionStatusOverdue ${_appLocalizations.zeroOrOneMemberIsOverdue}",
                              other: "$countActionStatusOverdue ${_appLocalizations.moreThenOneMembersIsOverdue}",
                              args: [countActionStatusOverdue]),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Rubik",
                            fontSize: 17.sp,
                          ),
                        ),
                      ),
                      maintainAnimation: maintainSize,
                      maintainState: maintainSize,
                      maintainSize: maintainSize,
                      visible: countActionStatusOverdue > 0,
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 5.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _appLocalizations.voteByLearners
                              .insertTemplateValues({
                            'votes':
                                ((_thumbsUp / _totalLearners) * 100).round()
                          }),
                          style: TextStyle(
                            fontFamily: 'OpenSans',
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF000000),
                          ),
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        SvgPicture.asset(
                          'assets/images/thumbs_up_solid.svg',
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          _appLocalizations.voteByLearners
                              .insertTemplateValues({
                            'votes':
                                ((_thumbsDown / _totalLearners) * 100).round()
                          }),
                          style: TextStyle(
                            textBaseline: TextBaseline.ideographic,
                            fontFamily: 'OpenSans',
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF000000),
                          ),
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        SvgPicture.asset(
                          'assets/images/thumbs_down_solid.svg',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                  child: Text(
                    '${_appLocalizations.due}: ${action.dateDue != null && action.hasValidDueDate ? DateTimeUtils.formatHiveDate(action.dateDue!) : "NA"}',
                    style: TextStyle(
                      color: Color(0xFF797979),
                      fontSize: 19.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _deleteAction(BuildContext context, HiveAction action) {
    final bloc = Provider.of(context);
    final AppLocalizations _appLocalizations = AppLocalizations.of(context)!;
    Alerts.showMessageBox(
        context: context,
        title: _appLocalizations.deleteActionTitle,
        message: _appLocalizations.deleteActionMessage,
        positiveButtonText: _appLocalizations.delete,
        negativeButtonText: _appLocalizations.cancel,
        positiveActionCallback: () {
          // Mark this action for deletion
          action.isDirty = true;
          bloc.actionBloc.createUpdateAction(action);
        },
        negativeActionCallback: () {});
  }
}
