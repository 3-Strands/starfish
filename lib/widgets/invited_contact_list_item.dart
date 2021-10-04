import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:starfish/models/invite_contact.dart';
import 'package:starfish/widgets/seprator_line_widget.dart';

class InvitedContactListItem extends StatefulWidget {
  final InviteContact contact;

  InvitedContactListItem({
    Key? key,
    required this.contact,
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
                Text(
                  widget.contact.contact.displayName ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF434141),
                  ),
                ),
                Text(
                  '${widget.contact.role}',
                  style: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 16.sp,
                    color: Color(0xFF3475F0),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              widget.contact.contact.phones != null
                  ? widget.contact.contact.phones!.length > 0
                      ? widget.contact.contact.phones!.first.value!
                      : ''
                  : '',
              style: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 18.sp,
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
      ),
    );
  }
}