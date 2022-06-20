// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:fbroadcast/fbroadcast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:starfish/bloc/provider.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:starfish/db/hive_group.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:starfish/modules/groups_view/add_edit_group_screen.dart';
import 'package:starfish/src/generated/starfish.pb.dart';
import 'package:starfish/utils/helpers/alerts.dart';
import 'package:starfish/utils/services/sync_service.dart';

class GroupListItem extends StatelessWidget {
  final HiveGroup group;
  final Function(HiveGroup group) onGroupTap;
  final Function(HiveGroup group) onLeaveGroupTap;

  const GroupListItem(
      {required this.group,
      required this.onGroupTap,
      required this.onLeaveGroupTap});

  @override
  Widget build(BuildContext context) {
    AppLocalizations _appLocalizations = AppLocalizations.of(context)!;

    int countActionsCompleted = group.actionsCompleted;
    int countActionsNotDoneYet = group.actionsNotDoneYet;
    int countActionsOverdue = group.actionsOverdue;
    bool maintainSize =
        (countActionsCompleted + countActionsNotDoneYet + countActionsOverdue) >
            0;
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
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            IntrinsicHeight(
              //height: 20.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            right: 8.w,
                          ),
                          child: Text(
                            '${group.name}',
                            //overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontFamily: 'OpenSans',
                              fontSize: 17.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.txtFieldTextColor,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Text(
                          '${_appLocalizations.adminNamePrifix}: ${group.adminName}',
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
                  // Spacer(),
                  if (group.currentUserRole! == GroupUser_Role.ADMIN)
                    PopupMenuButton(
                      icon: Icon(
                        Icons.more_vert,
                        color: Color(0xFF3475F0),
                        size: 30,
                      ),
                      color: Colors.white,
                      elevation: 20,
                      shape: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white, width: 2),
                          borderRadius: BorderRadius.circular(12.r)),
                      enabled: true,
                      onSelected: (value) {
                        switch (value) {
                          case 0:
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddEditGroupScreen(
                                  group: group,
                                ),
                              ),
                            ).then((value) => FocusScope.of(context)
                                .requestFocus(new FocusNode()));
                            break;
                          case 1:
                            _deleteGroup(context, group);

                            break;
                        }
                      },
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          child: Text(
                            _appLocalizations.editGroup,
                            style: TextStyle(
                                color: Color(0xFF3475F0),
                                fontSize: 19.sp,
                                fontWeight: FontWeight.bold),
                          ),
                          value: 0,
                        ),
                        PopupMenuItem(
                          child: Text(
                            _appLocalizations.deleteGroup,
                            style: TextStyle(
                                color: Color(0xFF3475F0),
                                fontSize: 19.sp,
                                fontWeight: FontWeight.bold),
                          ),
                          value: 1,
                        ),
                      ],
                    ),

                  // CustomIconButton(
                  //   icon: Icon(
                  //     Icons.edit,
                  //     color: Colors.blue,
                  //     size: 18.r,
                  //   ),
                  //   text: _appLocalizations.edit,
                  //   onButtonTap: () {
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //         builder: (context) => AddEditGroupScreen(
                  //           group: group,
                  //         ),
                  //       ),
                  //     ).then((value) => FocusScope.of(context)
                  //         .requestFocus(new FocusNode()));
                  //   },
                  // ),
                  if (group.currentUserRole! == GroupUser_Role.LEARNER ||
                      group.currentUserRole! == GroupUser_Role.TEACHER)
                    ElevatedButton(
                      onPressed: () {
                        this.onLeaveGroupTap(group);
                      },
                      child: Text(
                        _appLocalizations.leaveThisGroup,
                        style: TextStyle(
                          fontFamily: 'OpenSans',
                          fontSize: 14.5.sp,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      style: ElevatedButton.styleFrom(
                          primary: AppColors.selectedButtonBG,
                          fixedSize: Size(130.w, 20.h)),
                    ),
                ],
              ),
            ),
            SizedBox(height: 10.h),
            // Text(
            //   '${_appLocalizations.adminNamePrifix}: ${group.adminName}',
            //   textAlign: TextAlign.left,
            //   style: TextStyle(
            //     fontFamily: 'OpenSans',
            //     fontSize: 14.5.sp,
            //     fontWeight: FontWeight.w500,
            //     color: Color(0xFF797979),
            //   ),
            // ),
            SizedBox(height: 20.h),
            if (group.currentUserRole == GroupUser_Role.ADMIN ||
                group.currentUserRole == GroupUser_Role.TEACHER)
              InkWell(
                onTap: () {
                  onGroupTap(group);
                },
                child: Container(
                  height: 36.h,
                  width: 326.w,
                  decoration: BoxDecoration(
                      color: Color(0xFFDDDDDD),
                      borderRadius: BorderRadius.all(Radius.circular(8.5.r))),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                    child: Text(
                      _appLocalizations.viewTeachersAndLearners,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontFamily: 'Rubic',
                        fontSize: 14.5.sp,
                      ),
                    ),
                  ),
                ),
              ),
            SizedBox(height: 10.h),
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Visibility(
                    child: InkWell(
                      onTap: () {
                        if (GroupUser_Role.valueOf(group.userRole!.value) !=
                            GroupUser_Role.LEARNER) _navigateToAction(group);
                      },
                      child: Container(
                        width: 99.w,
                        decoration: BoxDecoration(
                            color: Color(0xFF6DE26B),
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.5.r))),
                        padding: EdgeInsets.symmetric(
                            vertical: 10.h, horizontal: 10.w),
                        child: Text(
                          //"${group.actionsCompleted} ${_appLocalizations.actionsCompleted}",
                          Intl.plural(countActionsCompleted,
                              zero:
                                  "$countActionsCompleted ${_appLocalizations.zeroOrOneActionCompleted}",
                              one: "$countActionsCompleted ${_appLocalizations.zeroOrOneActionCompleted}",
                              other: "$countActionsCompleted ${_appLocalizations.moreThenOneActionCompleted}",
                              args: [countActionsCompleted]),
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Rubik",
                            fontSize: 17.sp,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    maintainAnimation: maintainSize,
                    maintainState: maintainSize,
                    maintainSize: maintainSize,
                    visible: countActionsCompleted > 0,
                  ),
                  Spacer(),
                  Visibility(
                    child: InkWell(
                      onTap: () {
                        if (GroupUser_Role.valueOf(group.userRole!.value) !=
                            GroupUser_Role.LEARNER) _navigateToAction(group);
                      },
                      child: Container(
                        width: 99.w,
                        decoration: BoxDecoration(
                            color: Color(0xFFFFBE4A),
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.5.r))),
                        padding: EdgeInsets.symmetric(
                            vertical: 10.h, horizontal: 10.w),
                        child: Text(
                          //"${group.actionsNotDoneYet} ${_appLocalizations.actionsIncompleted}",
                          Intl.plural(countActionsNotDoneYet,
                              zero:
                                  "$countActionsNotDoneYet ${_appLocalizations.zeroOrOneActionsIncompleted}",
                              one: "$countActionsNotDoneYet ${_appLocalizations.zeroOrOneActionsIncompleted}",
                              other: "$countActionsNotDoneYet ${_appLocalizations.moreThenOneActionsIncompleted}",
                              args: [countActionsNotDoneYet]),
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Rubik",
                            fontSize: 17.sp,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    maintainAnimation: maintainSize,
                    maintainState: maintainSize,
                    maintainSize: maintainSize,
                    visible: countActionsNotDoneYet > 0,
                  ),
                  Spacer(),
                  Visibility(
                    child: InkWell(
                      onTap: () {
                        if (GroupUser_Role.valueOf(group.userRole!.value) !=
                            GroupUser_Role.LEARNER) _navigateToAction(group);
                      },
                      child: Container(
                        width: 99.w,
                        decoration: BoxDecoration(
                            color: Color(0xFFFF5E4D),
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.5.r))),
                        padding: EdgeInsets.symmetric(
                            vertical: 10.h, horizontal: 10.w),
                        child: Text(
                          //"${group.actionsOverdue} ${_appLocalizations.actionsOverdue}",
                          Intl.plural(countActionsOverdue,
                              zero:
                                  "$countActionsOverdue ${_appLocalizations.zeroOrOneActionsOverdue}",
                              one: "$countActionsOverdue ${_appLocalizations.zeroOrOneActionsOverdue}",
                              other: "$countActionsOverdue ${_appLocalizations.moreThenOneActionsOverdue}",
                              args: [countActionsOverdue]),
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Rubik",
                            fontSize: 17.sp,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    maintainAnimation: maintainSize,
                    maintainState: maintainSize,
                    maintainSize: maintainSize,
                    visible: countActionsOverdue > 0,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      elevation: 5,
    );
  }

  _deleteGroup(BuildContext context, HiveGroup group) {
    final bloc = Provider.of(context);
    AppLocalizations _appLocalizations = AppLocalizations.of(context)!;

    Alerts.showMessageBox(
        context: context,
        title: _appLocalizations.deleteGroupTitle,
        message: _appLocalizations.deleteGroupMessage,
        positiveButtonText: _appLocalizations.delete,
        negativeButtonText: _appLocalizations.cancel,
        positiveActionCallback: () {
          // Mark this group for deletion
          group.status = Group_Status.INACTIVE.value;
          group.isUpdated = true;
          bloc.groupBloc.addEditGroup(group).then((_) {
            // Broadcast to sync the delete Group with the server
            FBroadcast.instance().broadcast(
              SyncService.kUpdateGroup,
            );
          });
        },
        negativeActionCallback: () {});
  }

  _navigateToAction(HiveGroup group) {
    FBroadcast.instance().broadcast(
      "switchToActionTab",
      value: group,
    );
  }
}
