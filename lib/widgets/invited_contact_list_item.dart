import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starfish/db/hive_user.dart';
import 'package:starfish/widgets/separator_line_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../src/generated/starfish.pb.dart';

class InvitedContactListItem extends StatefulWidget {
  final HiveUser contact;
  final Function(HiveUser, GroupUser_Role) onRoleChange;
  final Function(HiveUser) onRemove;
  final Function(HiveUser) onEditUserInvite;

  const InvitedContactListItem({
    Key? key,
    required this.contact,
    required this.onRoleChange,
    required this.onRemove,
    required this.onEditUserInvite,
  }) : super(key: key);

  _InvitedContactListItemState createState() => _InvitedContactListItemState();
}

class _InvitedContactListItemState extends State<InvitedContactListItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
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
                Container(
                  width: MediaQuery.of(context).size.width / 2,
                  child: Text(
                    widget.contact.name ?? '',
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
                /*Text(
                  AppLocalizations.of(context)!.userStatusInvited.toUpperCase(),
                  style: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 19.sp,
                    color: Color(0xFF3475F0),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),*/
                PopupMenuButton(
                  color: Colors.white,
                  elevation: 20,
                  shape: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Container(
                    child: Text(
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
                    PopupMenuItem(
                      child: Text(
                        AppLocalizations.of(context)!.editInvite,
                        style: TextStyle(
                            color: Color(0xFF3475F0),
                            fontSize: 19.sp,
                            fontWeight: FontWeight.bold),
                      ),
                      value: 0,
                    ),
                    PopupMenuItem(
                      child: Text(
                        AppLocalizations.of(context)!.makeRemove,
                        style: TextStyle(
                            color: Color(0xFF3475F0),
                            fontSize: 19.sp,
                            fontWeight: FontWeight.bold),
                      ),
                      value: 1,
                    ),
                  ],
                  onSelected: (int value) {
                    switch (value) {
                      case 0:
                        widget.onEditUserInvite(widget.contact);
                        // widget.onRoleChange(
                        //     widget.contact, GroupUser_Role.TEACHER);
                        break;
                      case 1:
                        widget.onRemove(widget.contact);
                        break;
                    }
                  },
                ),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              '${widget.contact.phoneWithDialingCode} ',
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
      ),
    );
  }
}
