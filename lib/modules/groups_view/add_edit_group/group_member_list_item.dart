import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starfish/bloc/data_bloc.dart';
import 'package:starfish/bloc/provider.dart';
import 'package:starfish/db/hive_group_user.dart';
import 'package:starfish/db/hive_user.dart';
import 'package:starfish/src/generated/starfish.pb.dart';
import 'package:starfish/widgets/seprator_line_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:starfish/enums/group_user_role.dart';

class GroupMemberListItem extends StatefulWidget {
  final HiveGroupUser groupUser;
  final HiveUser user;
  final Function(HiveGroupUser, GroupUser_Role) onChangeUserRole;
  final Function(HiveGroupUser) onRemoveUser;
  final Function(HiveGroupUser, HiveUser) onEditUserInvite;

  const GroupMemberListItem({
    Key? key,
    required this.groupUser,
    required this.user,
    required this.onChangeUserRole,
    required this.onRemoveUser,
    required this.onEditUserInvite,
  }) : super(key: key);

  _GroupMemberListItemState createState() => _GroupMemberListItemState();
}

class _GroupMemberListItemState extends State<GroupMemberListItem> {
  late DataBloc bloc;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bloc = Provider.of(context);
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
                  widget.user.name ?? '',
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
              // if (widget.groupUser.user != null &&
              //     User_Status.valueOf(widget.groupUser.user!.status!) !=
              //         User_Status.ACTIVE)
              //   Text(
              //     AppLocalizations.of(context)!.userStatusInvited.toUpperCase(),
              //     style: TextStyle(
              //       fontFamily: 'OpenSans',
              //       fontSize: 19.sp,
              //       color: Color(0xFF3475F0),
              //     ),
              //   ),
              // if (widget.groupUser.user != null &&
              //     User_Status.valueOf(widget.groupUser.user!.status!) ==
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
                    User_Status.valueOf(widget.user.status!) ==
                            User_Status.ACTIVE
                        ? '${GroupUser_Role.valueOf(widget.groupUser.role!)!.about}'
                        : User_Status.valueOf(widget.user.status!) ==
                                User_Status.STATUS_UNSPECIFIED
                            ? AppLocalizations.of(context)!
                                .userStatusInvited
                                .toUpperCase()
                            : '${GroupUser_Role.valueOf(widget.groupUser.role!)!.about}' +
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
                  if (User_Status.valueOf(widget.user.status!) ==
                      User_Status.ACTIVE)
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
                  if (User_Status.valueOf(widget.user.status!) ==
                      User_Status.ACCOUNT_PENDING || User_Status.valueOf(widget.user.status!) ==
                      User_Status.STATUS_UNSPECIFIED)
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
                  if (User_Status.valueOf(widget.user.status!) ==
                      User_Status.ACTIVE)
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
                      widget.onChangeUserRole(
                          widget.groupUser, GroupUser_Role.ADMIN);
                      break;
                    case 1:
                      widget.onChangeUserRole(
                          widget.groupUser, GroupUser_Role.TEACHER);
                      break;
                    case 2:
                      widget.onRemoveUser(widget.groupUser);
                      break;
                    case 3:
                      // TODO: edit Invite
                      widget.onEditUserInvite(widget.groupUser, widget.user);
                      break;
                  }
                  /*switch (value) {
                    case 0:
                      widget.groupUser.role = GroupUser_Role.ADMIN.value;
                      widget.groupUser.isUpdated = true;
                      break;
                    case 1:
                      widget.groupUser.role = GroupUser_Role.TEACHER.value;
                      widget.groupUser.isUpdated = true;
                      break;
                    case 2:
                      widget.groupUser.isDirty = true;
                      break;
                    default:
                  }
                  bloc.groupBloc.createUpdateGroupUser(widget.groupUser);*/
                },
              ),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          Text(
            '${widget.user.phoneWithDialingCode}',
            // widget.groupUser.phone,
            style: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 21.5.sp,
              color: Color(0xFF434141),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          SepratorLine(
            hight: 1.h,
            edgeInsets: EdgeInsets.only(left: 0.w, right: 0.w),
          ),
        ],
      ),
    );
  }
}
