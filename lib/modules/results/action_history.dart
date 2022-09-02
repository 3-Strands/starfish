import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:starfish/apis/hive_api.dart';
import 'package:starfish/modules/results/history_list_graph.dart';
import 'package:starfish/src/grpc_extensions.dart';
import 'package:starfish/widgets/box_builder.dart';

class ActionHistory extends StatelessWidget {
  const ActionHistory({Key? key, required this.groupUser}) : super(key: key);

  final GroupUser groupUser;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return BoxBuilder<LearnerEvaluation>(
      box: globalHiveApi.learnerEvaluation,
      builder: (_, values) {
        final userId = groupUser.userId;
        final now = DateTime.now();
        final thisMonth = Date(year: now.year, month: now.month);
        final monthsToStatusMap = {
          for (final month in values
              .where((evaluation) =>
                  evaluation.learnerId == userId &&
                  evaluation.groupId == groupUser.groupId &&
                  evaluation.month != thisMonth)
              .map((evaluation) => evaluation.month)
              .toSet())
            month: _ActionStatus(),
        };
        for (final actionUser in globalHiveApi.actionUser.values) {
          if (actionUser.userId == userId) {
            final dueDate = actionUser.action?.dateDue;
            monthsToStatusMap[Date(year: dueDate?.year, month: dueDate?.month)]
                ?.addStatus(actionUser.status);
          }
        }
        final entries = monthsToStatusMap.entries.toList()
          ..sort((a, b) => b.key.compareMonthTo(a.key));
        return HistoryListGraph(
          monthValuesList: entries
              .map((entry) => MonthValues(entry.key, {
                    appLocalizations.done: entry.value.complete,
                    appLocalizations.pending: entry.value.incomplete,
                  }))
              .toList(),
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
