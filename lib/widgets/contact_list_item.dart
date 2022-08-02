import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:starfish/src/grpc_extensions.dart';
import 'package:starfish/widgets/seprator_line_widget.dart';

class ContactListItem extends StatelessWidget {
  ContactListItem({
    Key? key,
    required this.contact,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  final User contact;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
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
                Expanded(
                  child: Text(
                    contact.name,
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
                if (isSelected)
                  Padding(
                    padding: EdgeInsets.only(left: 10.h),
                    child: Icon(
                      Icons.check_circle,
                      color: AppColors.selectedButtonBG,
                    ),
                  ),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              '${contact.diallingCode} ${contact.phone}',
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
