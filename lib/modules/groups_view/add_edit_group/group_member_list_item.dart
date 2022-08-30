import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:starfish/modules/groups_view/add_edit_group/cubit/add_edit_group_cubit.dart';
import 'package:starfish/modules/groups_view/add_edit_group/member_actions_popup.dart';
import 'package:starfish/modules/groups_view/add_edit_group/phone_number_form.dart';
import 'package:starfish/src/grpc_extensions.dart';
import 'package:starfish/utils/currentUser.dart';
import 'package:starfish/widgets/separator_line_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GroupMemberListItem extends StatefulWidget {
  final GroupUser_Role role;
  final User user;
  final bool wasAddedPreviously;

  const GroupMemberListItem({
    Key? key,
    required this.role,
    required this.user,
    required this.wasAddedPreviously,
  }) : super(key: key);

  @override
  State<GroupMemberListItem> createState() => _GroupMemberListItemState();
}

class _GroupMemberListItemState extends State<GroupMemberListItem> {
  bool _isAddingPhoneNumber = false;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final user = widget.user;
    final userId = user.id;
    final cubitState = context.watch<AddEditGroupCubit>().state;
    final hasPhoneNumberChanged = cubitState.phoneChanges.containsKey(userId);
    final hasPhone = hasPhoneNumberChanged || user.hasFullPhone;

    return Padding(
      padding: EdgeInsets.fromLTRB(0, 10.h, 0, 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  cubitState.nameChanges[userId] ?? user.name,
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
              if (!hasPhone && widget.wasAddedPreviously)
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _isAddingPhoneNumber = !_isAddingPhoneNumber;
                    });
                  },
                  child: Text(
                    appLocalizations.inviteGroupUser,
                    style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 14.5.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFFADADAD),
                    fixedSize: Size(115.w, 18.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3.0),
                    ),
                  ),
                ),
              hasPhone
                  ? MemberActionsPopup(user: user, role: widget.role)
                  : IconButton(
                      onPressed: () {
                        context.read<AddEditGroupCubit>().userRemoved(user);
                      },
                      icon: Icon(
                        Icons.close,
                        color: AppColors.selectedButtonBG,
                      ),
                    ),
            ],
          ),
          if (hasPhone)
            Padding(
              padding: EdgeInsets.only(top: 10.h),
              child: Text(
                hasPhoneNumberChanged
                    ? '+${cubitState.diallingCodeChanges[userId]!} ${cubitState.phoneChanges[userId]!}'
                    : user.fullPhone,
                // groupUser.phone,
                style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 21.5.sp,
                  color: Color(0xFF434141),
                ),
              ),
            ),
          if (_isAddingPhoneNumber)
            Padding(
              padding: EdgeInsets.only(top: 15.h),
              child: PhoneNumberForm(
                initialDiallingCode: context.currentUser.diallingCodeWithPlus,
                onInvite: (diallingCode, phoneNumber) {
                  context
                      .read<AddEditGroupCubit>()
                      .userNumberAdded(user, diallingCode, phoneNumber);
                  setState(() {
                    _isAddingPhoneNumber = false;
                  });
                },
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
