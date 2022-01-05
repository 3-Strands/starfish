import 'package:flutter/material.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:starfish/enums/action_status.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserActionStatusWidget extends StatelessWidget {
  final ActionStatus title;
  final height;
  final width;

  const UserActionStatusWidget({
    Key? key,
    required this.title,
    this.height,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: this.height, //20.h,
      width: this.width, //100.w,
      decoration: BoxDecoration(
          color: _statusColor(title),
          borderRadius: BorderRadius.all(Radius.circular(10.sp))),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spacer(),
            if (title == ActionStatus.DONE)
              Icon(Icons.check, size: 16.sp, color: Color(0xFF393939)),
            SizedBox(width: 2.sp),
            Text(
              title.aboutGroup,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: AppColors.txtFieldTextColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp,
                  fontFamily: 'Rubik'),
            ),
            Spacer()
          ],
        ),
      ),
    );
  }

  Color _statusColor(ActionStatus status) {
    switch (status) {
      case ActionStatus.DONE:
        return Color(0xFF6DE26B);
      case ActionStatus.NOT_DONE:
        return Color(0xFFFFBE4A);
      case ActionStatus.OVERDUE:
        return Color(0xFFFF5E4D);
      default:
        return Colors.white;
    }
  }
}
