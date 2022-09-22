import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:starfish/modules/dashboard/cubit/dashboard_navigation_cubit.dart';
import 'package:starfish/modules/groups_view/add_edit_group/add_edit_group_screen.dart';
// import 'package:starfish/modules/groups_view/add_edit_group_screen.dart';
import 'package:starfish/modules/groups_view/cubit/groups_cubit.dart';
import 'package:starfish/repositories/model_wrappers/group_with_actions_and_roles.dart';
import 'package:starfish/src/generated/starfish.pb.dart';
import 'package:starfish/utils/helpers/alerts.dart';

class GroupListItem extends StatelessWidget {
  final GroupWithActionsAndRoles groupPlus;
  final Function(Group group) onGroupTap;
  final Function(Group group) onLeaveGroupTap;

  const GroupListItem({
    required this.groupPlus,
    required this.onGroupTap,
    required this.onLeaveGroupTap,
  });

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    final completedActions = groupPlus.completedActions;
    final incompleteActions = groupPlus.incompleteActions;
    final overdueActions = groupPlus.overdueActions;
    final myRole = groupPlus.myRole;
    final myRoleIsTeacherOrAdmin =
        myRole == GroupUser_Role.ADMIN || myRole == GroupUser_Role.TEACHER;
    final group = groupPlus.group;
    final hasActions =
        (completedActions + incompleteActions + overdueActions) > 0;

    final goToGroup = myRole != GroupUser_Role.LEARNER
        ? () {
            context.read<DashboardNavigationCubit>().navigationRequested(
                  const ActionsTab(ActionTab.ACTIONS_MY_GROUPS),
                );
          }
        : null;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      color: AppColors.txtFieldBackground,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        group.name,
                        //overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontFamily: 'OpenSans',
                          fontSize: 17.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.txtFieldTextColor,
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        '${appLocalizations.adminNamePrifix}: ${groupPlus.myRole == GroupUser_Role.ADMIN ? appLocalizations.adminNameMe : groupPlus.admin?.name ?? groupPlus.teacher?.name ?? appLocalizations.unknownUser}',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontFamily: 'OpenSans',
                          fontSize: 14.5.sp,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF797979),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8.w),
                  child: myRole == GroupUser_Role.ADMIN
                      ? PopupMenuButton(
                          icon: Icon(
                            Icons.more_vert,
                            color: Color(0xFF3475F0),
                            size: 30,
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
                                    builder: (context) => AddEditGroup(
                                      group: group,
                                    ),
                                  ),
                                );
                                break;
                              case 1:
                                Alerts.showMessageBox(
                                  context: context,
                                  title: appLocalizations.deleteGroupTitle,
                                  message: appLocalizations.deleteGroupMessage,
                                  positiveButtonText: appLocalizations.delete,
                                  negativeButtonText: appLocalizations.cancel,
                                  positiveActionCallback: () {
                                    context
                                        .read<GroupsCubit>()
                                        .groupDeleted(group);
                                  },
                                  negativeActionCallback: () {},
                                );
                                break;
                            }
                          },
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              child: Text(
                                appLocalizations.editGroup,
                                style: TextStyle(
                                    color: Color(0xFF3475F0),
                                    fontSize: 19.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              value: 0,
                            ),
                            PopupMenuItem(
                              child: Text(
                                appLocalizations.deleteGroup,
                                style: TextStyle(
                                    color: Color(0xFF3475F0),
                                    fontSize: 19.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              value: 1,
                            ),
                          ],
                        )
                      : ElevatedButton(
                          onPressed: () {
                            this.onLeaveGroupTap(group);
                          },
                          child: Text(
                            appLocalizations.leaveThisGroup,
                            style: TextStyle(
                              fontFamily: 'OpenSans',
                              fontSize: 14.5.sp,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: AppColors.selectedButtonBG,
                          ),
                        ),
                ),
              ],
            ),
            if (myRoleIsTeacherOrAdmin || hasActions) SizedBox(height: 20.h),
            if (myRoleIsTeacherOrAdmin)
              InkWell(
                onTap: () {
                  onGroupTap(group);
                },
                child: Container(
                  height: 36.h,
                  width: 326.w,
                  decoration: BoxDecoration(
                      color: const Color(0xFFDDDDDD),
                      borderRadius: BorderRadius.all(Radius.circular(8.5.r))),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                    child: Text(
                      appLocalizations.viewTeachersAndLearners,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontFamily: 'Rubic',
                        fontSize: 14.5.sp,
                      ),
                    ),
                  ),
                ),
              ),
            if (myRoleIsTeacherOrAdmin && hasActions) SizedBox(height: 10.h),
            if (hasActions)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Visibility(
                    child: InkWell(
                      onTap: goToGroup,
                      child: Container(
                        width: 99.w,
                        decoration: BoxDecoration(
                            color: Color(0xFF6DE26B),
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.5.r))),
                        padding: EdgeInsets.symmetric(
                            vertical: 10.h, horizontal: 10.w),
                        child: Text(
                          //"${group.actionsCompleted} ${appLocalizations.actionsCompleted}",
                          Intl.plural(completedActions,
                              zero:
                                  "$completedActions ${appLocalizations.zeroOrOneActionCompleted}",
                              one: "$completedActions ${appLocalizations.zeroOrOneActionCompleted}",
                              other: "$completedActions ${appLocalizations.moreThenOneActionCompleted}",
                              args: [completedActions]),
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Rubik",
                            fontSize: 17.sp,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    maintainSize: true,
                    maintainAnimation: true,
                    maintainState: true,
                    visible: completedActions > 0,
                  ),
                  Visibility(
                    child: InkWell(
                      onTap: goToGroup,
                      child: Container(
                        width: 99.w,
                        decoration: BoxDecoration(
                            color: Color(0xFFFFBE4A),
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.5.r))),
                        padding: EdgeInsets.symmetric(
                            vertical: 10.h, horizontal: 10.w),
                        child: Text(
                          //"${group.actionsNotDoneYet} ${appLocalizations.actionsIncompleted}",
                          Intl.plural(incompleteActions,
                              zero:
                                  "$incompleteActions ${appLocalizations.zeroOrOneActionsIncompleted}",
                              one: "$incompleteActions ${appLocalizations.zeroOrOneActionsIncompleted}",
                              other: "$incompleteActions ${appLocalizations.moreThenOneActionsIncompleted}",
                              args: [incompleteActions]),
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Rubik",
                            fontSize: 17.sp,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    maintainSize: true,
                    maintainAnimation: true,
                    maintainState: true,
                    visible: incompleteActions > 0,
                  ),
                  Visibility(
                    child: InkWell(
                      onTap: goToGroup,
                      child: Container(
                        width: 99.w,
                        decoration: BoxDecoration(
                            color: Color(0xFFFF5E4D),
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.5.r))),
                        padding: EdgeInsets.symmetric(
                            vertical: 10.h, horizontal: 10.w),
                        child: Text(
                          //"${group.actionsOverdue} ${appLocalizations.actionsOverdue}",
                          Intl.plural(overdueActions,
                              zero:
                                  "$overdueActions ${appLocalizations.zeroOrOneActionsOverdue}",
                              one: "$overdueActions ${appLocalizations.zeroOrOneActionsOverdue}",
                              other: "$overdueActions ${appLocalizations.moreThenOneActionsOverdue}",
                              args: [overdueActions]),
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Rubik",
                            fontSize: 17.sp,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    maintainSize: true,
                    maintainAnimation: true,
                    maintainState: true,
                    visible: overdueActions > 0,
                  ),
                ],
              ),
          ],
        ),
      ),
      elevation: 5,
    );
  }
}
