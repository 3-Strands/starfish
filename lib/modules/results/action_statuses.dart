import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class ActionStatuses extends StatelessWidget {
  const ActionStatuses({
    Key? key,
    required this.complete,
    required this.notComplete,
    this.overdue,
  }) : super(key: key);

  final int complete;
  final int notComplete;
  final int? overdue;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            width: 99.w,
            decoration: BoxDecoration(
              color: Color(0xFF6DE26B),
              borderRadius: BorderRadius.all(Radius.circular(8.5.r)),
            ),
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
            child: Text(
              Intl.plural(
                complete,
                zero: "$complete ${appLocalizations.done}",
                one: "$complete ${appLocalizations.done}",
                other: "$complete ${appLocalizations.done}",
                args: [complete],
              ),
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: "Rubik",
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            width: 99.w,
            decoration: BoxDecoration(
              color: Color(0xFFFFBE4A),
              borderRadius: BorderRadius.all(Radius.circular(8.5.r)),
            ),
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
            child: Text(
              Intl.plural(
                notComplete,
                zero: "$notComplete ${appLocalizations.pending}",
                one: "$notComplete ${appLocalizations.pending}",
                other: "$notComplete ${appLocalizations.pending}",
                args: [notComplete],
              ),
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: "Rubik",
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          if (overdue != null)
            Container(
              width: 99.w,
              decoration: BoxDecoration(
                color: Color(0xFFFF5E4D),
                borderRadius: BorderRadius.all(Radius.circular(8.5.r)),
              ),
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
              child: Text(
                Intl.plural(
                  overdue!,
                  zero: "$overdue ${appLocalizations.overdue}",
                  one: "$overdue ${appLocalizations.overdue}",
                  other: "$overdue ${appLocalizations.overdue}",
                  args: [overdue!],
                ),
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Rubik",
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
        ],
      ),
    );
  }
}
