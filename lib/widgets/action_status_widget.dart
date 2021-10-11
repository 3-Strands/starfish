import 'package:flutter/material.dart';
import 'package:starfish/enums/action_status.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ActionStatusWidget extends StatelessWidget {
  final title;
  final height;
  final width;

  const ActionStatusWidget({
    Key? key,
    this.title, this.height, this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: this.height,//30.h,
      width: this.width,//130.w,
      decoration: BoxDecoration(
          color: title == ActionStatus.done
              ? Color(0xFF6DE26B)
              : (title == ActionStatus.notdone)
                  ? Color(0xFFFFBE4A)
                  : Color(0xFFFF5E4D),
          borderRadius: BorderRadius.all(Radius.circular(4.sp))),
      child: Padding(
        padding:
            EdgeInsets.only(left: 8.sp, right: 8.sp, top: 2.sp, bottom: 2.sp),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Spacer(),
              if (title == ActionStatus.done)
                Icon(Icons.check, size: 16.sp, color: Color(0xFF393939)),
              SizedBox(width: 2.sp),
              Text(title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                      fontFamily: 'Rubik')),
              Spacer()
            ],
          ),
        ),
      ),
    );
  }
}
