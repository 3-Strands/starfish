import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ActionStatusCountWidget extends StatelessWidget {
  const ActionStatusCountWidget({
    Key? key,
    this.label,
    required this.done,
    required this.pending,
    required this.overdue,
  }) : super(key: key);

  final String? label;
  final int done;
  final int pending;
  final int overdue;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          if (label != null) ...[
            Center(
              child: Text(
                this.label!, //"${AppLocalizations.of(context)!.actionsTabItemText}",
                style: TextStyle(
                    fontSize: 17.sp,
                    fontFamily: "OpenSans ",
                    color: Color(0xFF4F4F4F),
                    fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(
              width: 5.w,
            ),
          ],
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: Color(0xFF6DE26B),
                  borderRadius: BorderRadius.all(Radius.circular(8.5.r))),
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
              child: Text(
                "$done\n${AppLocalizations.of(context)!.done}",
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Rubik",
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(
            width: 10.w,
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: Color(0xFFFFBE4A),
                  borderRadius: BorderRadius.all(Radius.circular(8.5.r))),
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
              child: Text(
                "$pending\n${AppLocalizations.of(context)!.pending}",
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Rubik",
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(
            width: 10.w,
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: Color(0xFFFF5E4D),
                  borderRadius: BorderRadius.all(Radius.circular(8.5.r))),
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
              child: Text(
                "$overdue\n${AppLocalizations.of(context)!.overdue}",
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Rubik",
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
