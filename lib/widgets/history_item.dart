import 'package:flutter/material.dart';
import 'package:starfish/db/hive_edit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starfish/src/generated/starfish.pb.dart';
import 'package:starfish/utils/date_time_utils.dart';
import 'package:starfish/widgets/seprator_line_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HistoryItem extends StatelessWidget {
  final HiveEdit? edit;
  final String type;

  HistoryItem({
    Key? key,
    required this.edit,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(color: Colors.transparent),
        margin: EdgeInsets.fromLTRB(0, 10.h, 0, 10.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text.rich(
              TextSpan(
                text: Edit_Event.valueOf(edit!.event!) == Edit_Event.CREATE
                    ? '$type ${AppLocalizations.of(context)!.addedBy}: '
                    : '$type ${AppLocalizations.of(context)!.editedBy}: ',
                style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 18.sp,
                  color: Color(0xFF434141),
                ),
                children: [
                  TextSpan(
                    text: edit?.username ?? 'Unknown',
                    style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF434141),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Text.rich(
              TextSpan(
                text: Edit_Event.valueOf(edit!.event!) == Edit_Event.CREATE
                    ? '$type ${AppLocalizations.of(context)!.addedOn}: '
                    : '$type ${AppLocalizations.of(context)!.editedOn}: ',
                style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 18.sp,
                  color: Color(0xFF434141),
                ),
                children: [
                  TextSpan(
                    text: edit!.time != null
                        ? '${DateTimeUtils.formatDate(edit!.time!, 'dd-MMM-yyyy')}'
                        : 'NA',
                    style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF434141),
                    ),
                  ),
                ],
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
        ));
  }
}
