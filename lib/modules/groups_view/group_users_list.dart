import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:starfish/enums/group_user_role.dart';
import 'package:starfish/src/grpc_extensions.dart';
import 'package:starfish/widgets/separator_line_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GroupUsersList extends StatelessWidget {
  const GroupUsersList({Key? key, required this.users}) : super(key: key);

  final List<GroupUser> users;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      physics: NeverScrollableScrollPhysics(),
      itemCount: users.length,
      itemBuilder: (context, index) {
        final groupUser = users[index];
        final user = groupUser.user;

        return Container(
          height: 96.h,
          width: MediaQuery.of(context).size.width - 10.0,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Text(
                      user.name,
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        color: AppColors.appTitle,
                        fontFamily: 'OpenSans',
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 10.w),
                    child: Text(
                      user.status == User_Status.ACTIVE
                          ? groupUser.role.about
                          : user.phone.isNotEmpty
                              ? "${groupUser.role.about} " +
                                  appLocalizations.userStatusInvited
                                      .toUpperCase()
                              : '',
                      textAlign: TextAlign.right,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        color: AppColors.appTitle,
                        fontFamily: 'OpenSans',
                        fontSize: 19.sp,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ],
              ),
              Spacer(),
              if (user.hasFullPhone)
                Align(
                  alignment: FractionalOffset.topLeft,
                  child: Text(
                    user.fullPhone,
                    maxLines: 1,
                    style: TextStyle(
                      color: AppColors.appTitle,
                      fontFamily: 'OpenSans',
                      fontSize: 19.sp,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              SizedBox(
                height: 10.h,
              ),
              const SeparatorLine(),
              SizedBox(
                height: 10.h,
              )
            ],
          ),
        );
      },
    );
  }
}
