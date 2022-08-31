import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:starfish/apis/hive_api.dart';
import 'package:starfish/modules/results/action_statuses.dart';
import 'package:starfish/src/grpc_extensions.dart';
import 'package:starfish/widgets/box_builder.dart';

class ActionHistory extends StatefulWidget {
  const ActionHistory({Key? key, required this.groupUser}) : super(key: key);

  final GroupUser groupUser;

  @override
  State<ActionHistory> createState() => _ActionHistoryState();
}

class _ActionHistoryState extends State<ActionHistory> {
  bool isViewActionHistory = false;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (isViewActionHistory) ...[
          BoxBuilder<LearnerEvaluation>(
            box: globalHiveApi.learnerEvaluation,
            builder: (_, values) {
              final userId = widget.groupUser.userId;
              final now = DateTime.now();
              final thisMonth = Date(year: now.year, month: now.month);
              final monthsToStatusMap = {
                for (final month in values
                    .where((evaluation) =>
                        evaluation.learnerId == userId &&
                        evaluation.groupId == widget.groupUser.groupId &&
                        evaluation.month != thisMonth)
                    .map((evaluation) => evaluation.month)
                    .toSet())
                  month: _ActionStatus(),
              };
              for (final actionUser in globalHiveApi.actionUser.values) {
                if (actionUser.userId == userId) {
                  final dueDate = actionUser.action?.dateDue;
                  monthsToStatusMap[
                          Date(year: dueDate?.year, month: dueDate?.month)]
                      ?.addStatus(actionUser.status);
                }
              }
              final entries = monthsToStatusMap.entries.toList()
                ..sort((a, b) => b.key.compareMonthTo(a.key));
              return Column(
                children: [
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
                  SizedBox(
                    height: 10.h,
                  ),
                  ...entries.map(
                    (item) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          DateFormat("MMM yyyy").format(DateTime(
                              item.key.year, item.key.month)), // eg "JUL 2021",
                          style: TextStyle(
                            fontFamily: "OpenSans",
                            fontSize: 19.sp,
                            color: Color(0xFF434141),
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        ActionStatuses(
                          complete: item.value.complete,
                          notComplete: item.value.incomplete,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
          SizedBox(
            height: 10.h,
          ),
        ],
        Center(
          child: TextButton(
            onPressed: () {
              setState(() {
                isViewActionHistory = !isViewActionHistory;
              });
            },
            child: Text(
              isViewActionHistory
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

class _ActionStatus {
  int complete = 0;
  int incomplete = 0;

  void addStatus(ActionUser_Status status) {
    if (status == ActionUser_Status.COMPLETE) {
      complete += 1;
    } else {
      incomplete += 1;
    }
  }
}
