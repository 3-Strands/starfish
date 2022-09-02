import 'package:flutter/material.dart';
import 'package:starfish/apis/hive_api.dart';
import 'package:starfish/modules/results/history_list_graph.dart';
import 'package:starfish/src/grpc_extensions.dart';
import 'package:starfish/widgets/box_builder.dart';

class EvaluationHistory extends StatelessWidget {
  const EvaluationHistory(
      {Key? key, required this.groupUser, required this.evaluationCategories})
      : super(key: key);

  final GroupUser groupUser;
  final List<EvaluationCategory> evaluationCategories;

  @override
  Widget build(BuildContext context) {
    return BoxBuilder<LearnerEvaluation>(
      box: globalHiveApi.learnerEvaluation,
      builder: (_, values) {
        final userId = groupUser.userId;
        final groupId = groupUser.groupId;
        final now = DateTime.now();
        final thisMonth = Date(year: now.year, month: now.month);
        final evaluationCategoryMap = {
          for (final evaluationCategory in evaluationCategories)
            evaluationCategory.id: evaluationCategory.name
        };
        final monthsToStatusMap = <Date, Map<String, int>>{};
        for (final learnerEvaluation
            in globalHiveApi.learnerEvaluation.values) {
          if (learnerEvaluation.learnerId == userId &&
              learnerEvaluation.groupId == groupId &&
              learnerEvaluation.month != thisMonth) {
            final monthEvaluations =
                (monthsToStatusMap[learnerEvaluation.month] ??= {});
            monthEvaluations[
                    evaluationCategoryMap[learnerEvaluation.categoryId]!] =
                learnerEvaluation.evaluation;
          }
        }
        final entries = monthsToStatusMap.entries.toList()
          ..sort((a, b) => b.key.compareMonthTo(a.key));
        return HistoryListGraph(
          largestPossible: 5,
          monthValuesList: entries
              .map((entry) => MonthValues(entry.key, entry.value))
              .toList(),
        );
      },
    );
  }
}
