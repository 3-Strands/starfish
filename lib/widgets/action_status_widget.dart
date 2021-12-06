import 'package:flutter/material.dart';
import 'package:starfish/enums/action_status.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starfish/src/generated/starfish.pb.dart';

class ActionStatusWidget extends StatefulWidget {
  final ActionStatus actionStatus;
  final height;
  final width;
  final Function(ActionStatus newStatus) onTap;

  ActionStatusWidget({
    Key? key,
    required this.actionStatus,
    required this.onTap,
    this.height,
    this.width,
  }) : super(key: key);

  @override
  _ActionStatusWidgetState createState() => _ActionStatusWidgetState();
}

class _ActionStatusWidgetState extends State<ActionStatusWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (widget.actionStatus == ActionStatus.OVERDUE) {
          return;
        }
        if (widget.actionStatus == ActionStatus.DONE) {
          widget.onTap(ActionStatus.NOT_DONE);
        } else if (widget.actionStatus == ActionStatus.NOT_DONE ||
            widget.actionStatus == ActionStatus.UNSPECIFIED_STATUS) {
          widget.onTap(ActionStatus.DONE);
        }
      },
      child: Container(
        height: widget.height, //30.h,
        width: widget.width, //130.w,
        decoration: BoxDecoration(
            color: _statusColor(widget.actionStatus),
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
                if (widget.actionStatus == ActionStatus.DONE)
                  Icon(Icons.check, size: 16.sp, color: Color(0xFF393939)),
                SizedBox(width: 2.sp),
                Text(widget.actionStatus.about,
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
      case ActionStatus.UNSPECIFIED_STATUS:
      default:
        return Colors.white;
    }
  }
}
