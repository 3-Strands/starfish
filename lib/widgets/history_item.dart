import 'package:flutter/material.dart';
import 'package:starfish/db/hive_edit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starfish/src/generated/starfish.pb.dart';
import 'package:starfish/utils/date_time_utils.dart';
import 'package:starfish/widgets/separator_line_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HistoryItem extends StatelessWidget {
  final Edit edit;
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
                text: edit.event == Edit_Event.CREATE
                    ? '$type ${AppLocalizations.of(context)!.historyAddedBy}: '
                    : '$type ${AppLocalizations.of(context)!.historyEditedBy}: ',
                style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 21.5.sp,
                  color: Color(0xFF434141),
                ),
                children: [
                  TextSpan(
                    text: edit.username,
                    style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 21.5.sp,
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
                text: edit.event == Edit_Event.CREATE
                    ? '$type ${AppLocalizations.of(context)!.historyAddedOn}: '
                    : '$type ${AppLocalizations.of(context)!.historyEditedOn}: ',
                style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 21.5.sp,
                  color: Color(0xFF434141),
                ),
                children: [
                  TextSpan(
                    text:
                        '${DateTimeUtils.formatDate(edit.time.toDateTime(toLocal: true), 'dd-MMM-yyyy')}',
                    style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 21.5.sp,
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
            const SeparatorLine(),
          ],
        ));
  }
}
