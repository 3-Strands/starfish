import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starfish/apis/hive_api.dart';
import 'package:starfish/modules/results/history_list_graph.dart';
import 'package:starfish/src/grpc_extensions.dart';
import 'package:starfish/widgets/box_builder.dart';

class ActionHistory extends StatelessWidget {
  const ActionHistory({
    Key? key,
    required this.groupId,
    required this.userId,
    required this.month,
  }) : super(key: key);

  final String groupId;
  final String userId;
  final Date month;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return BoxItemBuilder<User>(
      boxKey: userId,
      box: globalHiveApi.user,
      builder: (_, user) {
        final monthsToStatusMap = <Date, _ActionStatus>{};
        var earliestMonth = month;
        var latestMonth = month;
        for (final actionUser in user!.actions) {
          final dueDate = actionUser.action?.dateDue;
          if (dueDate?.isValidDate ?? false) {
            final month = Date(year: dueDate!.year, month: dueDate.month);
            if (month != this.month) {
              (monthsToStatusMap[month] ??= _ActionStatus())
                ..addStatus(actionUser.status);
              if (month.compareMonthTo(earliestMonth) < 0) {
                earliestMonth = month;
              } else if (month.compareMonthTo(latestMonth) > 0) {
                latestMonth = month;
              }
            }
          }
        }
        final allMonths = DateExt.monthsInRange(earliestMonth, latestMonth)
            .where((month) => month != this.month)
            .toList();
        if (allMonths.isEmpty) {
          return SizedBox(height: 10.h);
        }
        return Padding(
          padding: EdgeInsets.only(top: 20.h),
          child: HistoryListGraph(
            monthValuesList: allMonths.reversed.map((month) {
              final status = monthsToStatusMap[month];
              return MonthValues(month, {
                appLocalizations.done: status?.complete ?? 0,
                appLocalizations.pending: status?.incomplete ?? 0,
              });
            }).toList(),
          ),
        );
      },
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
