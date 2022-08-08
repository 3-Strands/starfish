import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starfish/src/grpc_extensions.dart';
import 'package:starfish/widgets/separator_line_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:starfish/enums/group_user_role.dart';

class GroupMemberListItem extends StatelessWidget {
  final GroupUser groupUser;
  final User user;
  final Function(GroupUser, GroupUser_Role) onChangeUserRole;
  final Function(GroupUser) onRemoveUser;
  final Function(GroupUser, User) onEditUserInvite;

  const GroupMemberListItem({
    Key? key,
    required this.groupUser,
    required this.user,
    required this.onChangeUserRole,
    required this.onRemoveUser,
    required this.onEditUserInvite,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.transparent),
      margin: EdgeInsets.fromLTRB(0, 10.h, 0, 10.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                // width: MediaQuery.of(context).size.width / 2,
                child: Text(
                  user.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 21.5.sp,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF434141),
                  ),
                ),
              ),
              // if (groupUser.user != null &&
              //     User_Status.valueOf(groupUser.user!.status!) !=
              //         User_Status.ACTIVE)
              //   Text(
              //     AppLocalizations.of(context)!.userStatusInvited.toUpperCase(),
              //     style: TextStyle(
              //       fontFamily: 'OpenSans',
              //       fontSize: 19.sp,
              //       color: Color(0xFF3475F0),
              //     ),
              //   ),
              // if (groupUser.user != null &&
              //     User_Status.valueOf(groupUser.user!.status!) ==
              //         User_Status.ACTIVE)
              PopupMenuButton(
                color: Colors.white,
                elevation: 20,
                shape: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 2),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Container(
                  child: Text(
                    user.status == User_Status.ACTIVE
                        ? groupUser.role.about
                        : user.status == User_Status.STATUS_UNSPECIFIED
                            ? AppLocalizations.of(context)!
                                .userStatusInvited
                                .toUpperCase()
                            : '${groupUser.role.about}' +
                                " " +
                                AppLocalizations.of(context)!
                                    .userStatusInvited
                                    .toUpperCase(),
                    style: TextStyle(
                        fontFamily: 'OpenSans',
                        fontSize: 19.sp,
                        color: Color(0xFF3475F0),
                        overflow: TextOverflow.ellipsis),
                  ),
                ),
                itemBuilder: (context) => [
                  if (user.status == User_Status.ACTIVE)
                    PopupMenuItem(
                      child: Text(
                        AppLocalizations.of(context)!.makeAdmin,
                        style: TextStyle(
                            color: Color(0xFF3475F0),
                            fontSize: 19.sp,
                            fontWeight: FontWeight.bold),
                      ),
                      value: 0,
                    ),
                  if (user.status == User_Status.ACCOUNT_PENDING ||
                      user.status == User_Status.STATUS_UNSPECIFIED)
                    PopupMenuItem(
                      child: Text(
                        AppLocalizations.of(context)!.editInvite,
                        style: TextStyle(
                            color: Color(0xFF3475F0),
                            fontSize: 19.sp,
                            fontWeight: FontWeight.bold),
                      ),
                      value: 3,
                    ),
                  if (user.status == User_Status.ACTIVE)
                    PopupMenuItem(
                      child: Text(
                        AppLocalizations.of(context)!.makeTeacher,
                        style: TextStyle(
                            color: Color(0xFF3475F0),
                            fontSize: 19.sp,
                            fontWeight: FontWeight.bold),
                      ),
                      value: 1,
                    ),
                  PopupMenuItem(
                    child: Text(
                      AppLocalizations.of(context)!.makeRemove,
                      style: TextStyle(
                          color: Color(0xFF3475F0),
                          fontSize: 19.sp,
                          fontWeight: FontWeight.bold),
                    ),
                    value: 2,
                  ),
                ],
                onSelected: (int value) {
                  switch (value) {
                    case 0:
                      onChangeUserRole(groupUser, GroupUser_Role.ADMIN);
                      break;
                    case 1:
                      onChangeUserRole(groupUser, GroupUser_Role.TEACHER);
                      break;
                    case 2:
                      onRemoveUser(groupUser);
                      break;
                    case 3:
                      // TODO: edit Invite
                      onEditUserInvite(groupUser, user);
                      break;
                  }
                  /*switch (value) {
                    case 0:
                      groupUser.role = GroupUser_Role.ADMIN.value;
                      groupUser.isUpdated = true;
                      break;
                    case 1:
                      groupUser.role = GroupUser_Role.TEACHER.value;
                      groupUser.isUpdated = true;
                      break;
                    case 2:
                      groupUser.isDirty = true;
                      break;
                    default:
                  }
                  bloc.groupBloc.createUpdateGroupUser(groupUser);*/
                },
              ),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          Text(
            '${user.fullPhone}',
            // groupUser.phone,
            style: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 21.5.sp,
              color: Color(0xFF434141),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          const SeparatorLine(),
        ],
      ),
    );
  }
}
