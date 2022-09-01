import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:starfish/src/grpc_extensions.dart';

@deprecated
class HistoryListByMonth extends StatefulWidget {
  const HistoryListByMonth({Key? key, required this.builder}) : super(key: key);

  final WidgetBuilder builder;

  @override
  State<HistoryListByMonth> createState() => _HistoryListByMonthState();
}

class _HistoryListByMonthState extends State<HistoryListByMonth> {
  bool isActive = false;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (isActive) ...[
          Text(
            appLocalizations.history,
            style: TextStyle(
              fontFeatures: [FontFeature.subscripts()],
              color: Color(0xFF434141),
              fontFamily: "OpenSans",
              fontSize: 19.sp,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.left,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child: widget.builder(context),
          ),
        ],
        Center(
          child: TextButton(
            onPressed: () {
              setState(() {
                isActive = !isActive;
              });
            },
            child: Text(
              isActive
                  ? appLocalizations.hideHistory
                  : appLocalizations.viewHistory,
              style: TextStyle(
                fontSize: 16.sp,
                fontFamily: "Open",
                color: Color(0xFF3475F0),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class HistoryListByMonthItem extends StatelessWidget {
  const HistoryListByMonthItem(
      {Key? key, required this.month, required this.child})
      : super(key: key);

  final Date month;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 10.h,
        ),
        Text(
          DateFormat("MMM yyyy")
              .format(DateTime(month.year, month.month)), // eg "JUL 2021",
          style: TextStyle(
            fontFamily: "OpenSans",
            fontSize: 19.sp,
            color: Color(0xFF434141),
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        child,
        SizedBox(
          height: 10.h,
        ),
        Divider(
          thickness: 1.0,
          color: Colors.grey,
        ),
      ],
    );
  }
}
