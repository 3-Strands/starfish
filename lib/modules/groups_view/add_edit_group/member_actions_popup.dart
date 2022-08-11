import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starfish/enums/group_user_role.dart';
import 'package:starfish/modules/groups_view/add_edit_group/cubit/add_edit_group_cubit.dart';
import 'package:starfish/modules/groups_view/add_edit_group/edit_user_invite_bottomsheet.dart';
import 'package:starfish/src/grpc_extensions.dart';

enum MemberAction {
  makeAdmin,
  makeTeacher,
  editInvite,
  remove,
}

class MemberActionsPopup extends StatelessWidget {
  const MemberActionsPopup({Key? key, required this.user, required this.role})
      : super(key: key);

  final User user;
  final GroupUser_Role role;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return PopupMenuButton<MemberAction>(
      color: Colors.white,
      elevation: 20,
      shape: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white, width: 2),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Container(
        child: Text(
          user.status == User_Status.ACTIVE
              ? role.about
              : user.status == User_Status.STATUS_UNSPECIFIED
                  ? appLocalizations.userStatusInvited.toUpperCase()
                  : '${role.about} ${appLocalizations.userStatusInvited.toUpperCase()}',
          style: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 19.sp,
            color: Color(0xFF3475F0),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      itemBuilder: (context) => [
        if (user.status == User_Status.ACTIVE && role != GroupUser_Role.ADMIN)
          PopupMenuItem(
            child: Text(
              appLocalizations.makeAdmin,
              style: TextStyle(
                  color: Color(0xFF3475F0),
                  fontSize: 19.sp,
                  fontWeight: FontWeight.bold),
            ),
            value: MemberAction.makeAdmin,
          ),
        if (user.status == User_Status.ACTIVE && role != GroupUser_Role.TEACHER)
          PopupMenuItem(
            child: Text(
              appLocalizations.makeTeacher,
              style: TextStyle(
                  color: Color(0xFF3475F0),
                  fontSize: 19.sp,
                  fontWeight: FontWeight.bold),
            ),
            value: MemberAction.makeTeacher,
          ),
        if (user.status == User_Status.ACCOUNT_PENDING ||
            user.status == User_Status.STATUS_UNSPECIFIED)
          PopupMenuItem(
            child: Text(
              appLocalizations.editInvite,
              style: TextStyle(
                  color: Color(0xFF3475F0),
                  fontSize: 19.sp,
                  fontWeight: FontWeight.bold),
            ),
            value: MemberAction.editInvite,
          ),
        PopupMenuItem(
          child: Text(
            appLocalizations.makeRemove,
            style: TextStyle(
                color: Color(0xFF3475F0),
                fontSize: 19.sp,
                fontWeight: FontWeight.bold),
          ),
          value: MemberAction.remove,
        ),
      ],
      onSelected: (MemberAction value) {
        final cubit = context.read<AddEditGroupCubit>();
        switch (value) {
          case MemberAction.makeAdmin:
            cubit.userRoleChanged(user, GroupUser_Role.ADMIN);
            break;
          case MemberAction.makeTeacher:
            cubit.userRoleChanged(user, GroupUser_Role.TEACHER);
            break;
          case MemberAction.editInvite:
            final widget = BlocProvider.value(
              value: cubit,
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.70,
                child: EditUserInviteBottomSheet(
                  contact: user,
                  role: role,
                ),
              ),
            );
            showModalBottomSheet(
              context: context,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(34.r),
                    topRight: Radius.circular(34.r)),
              ),
              isScrollControlled: true,
              isDismissible: true,
              enableDrag: true,
              builder: (BuildContext context) => widget,
            );
            break;
          case MemberAction.remove:
            cubit.userRemoved(user);
            break;
        }
      },
    );
  }
}
