import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:starfish/db/hive_user.dart';
import 'package:starfish/widgets/seprator_line_widget.dart';

class ContactListItem extends StatefulWidget {
  final HiveUser contact;
  final Function(HiveUser) onTap;

  ContactListItem({
    Key? key,
    required this.contact,
    required this.onTap,
  }) : super(key: key);

  _ContactListItemState createState() => _ContactListItemState();
}

class _ContactListItemState extends State<ContactListItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          widget.contact.isSelected = !widget.contact.isSelected;
        });
        widget.onTap(widget.contact);
      },
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
                  width: MediaQuery.of(context).size.width - 70.0,
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
                Visibility(
                  child: Icon(
                    Icons.check_circle,
                    color: AppColors.selectedButtonBG,
                  ),
                  visible: widget.contact.isSelected,
                ),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              '${widget.contact.diallingCode ?? ''} ${widget.contact.phone ?? ''} ',
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
      ),
    );
  }
}
