import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starfish/apis/hive_api.dart';
import 'package:starfish/modules/results/history_list_graph.dart';
import 'package:starfish/modules/results/results_bottomsheet/cubit/results_bottomsheet_cubit.dart';
import 'package:starfish/modules/results/results_bottomsheet/evaluation/evaluation_categories_summary.dart';
import 'package:starfish/src/grpc_extensions.dart';
import 'package:starfish/widgets/box_builder.dart';

class EvaluationHistory extends StatelessWidget {
  const EvaluationHistory({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return BlocBuilder<ResultsBottomsheetCubit, ResultsBottomsheetState>(
      buildWhen: (previous, current) =>
          previous.isDifferentSnapshotFrom(current),
      builder: (context, state) {
        final monthInView = state.month;
        final groupId = state.group.id;
        final userId = state.learner.id;
        final evaluationCategories = state.group.evaluationCategoryIds.map(
          (evaluationCategoryId) =>
              globalHiveApi.evaluationCategory.get(evaluationCategoryId)!,
        );
        return BoxBuilder<LearnerEvaluation>(
          box: globalHiveApi.learnerEvaluation,
          builder: (_, values) {
            final monthsToStatusMap = <Date, Map<String, int>>{};
            var earliestMonth = monthInView;
            var latestMonth = monthInView;
            for (final learnerEvaluation
                in globalHiveApi.learnerEvaluation.values) {
              if (learnerEvaluation.learnerId == userId &&
                  learnerEvaluation.groupId == groupId &&
                  learnerEvaluation.month != monthInView) {
                final monthEvaluations =
                    (monthsToStatusMap[learnerEvaluation.month] ??= {});
                monthEvaluations[learnerEvaluation.categoryId] =
                    learnerEvaluation.evaluation;
                if (learnerEvaluation.month.compareMonthTo(earliestMonth) < 0) {
                  earliestMonth = learnerEvaluation.month;
                } else if (learnerEvaluation.month.compareMonthTo(latestMonth) >
                    0) {
                  latestMonth = learnerEvaluation.month;
                }
              }
            }
            final allMonths = DateExt.monthsInRange(earliestMonth, latestMonth)
                .where((month) => month != monthInView)
                .toList();
            if (allMonths.isEmpty) {
              return const SizedBox();
            }
            return HistoryListGraph(
              headerBuilder: (context) => Padding(
                padding: EdgeInsets.only(top: 20.h, bottom: 30.h),
                child: Column(
                  children: [
                    Text(
                      appLocalizations.currentEvaluation,
                      style: TextStyle(
                        fontFeatures: [FontFeature.subscripts()],
                        color: Color(0xFF434141),
                        fontFamily: "OpenSans",
                        fontSize: 19.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    BlocBuilder<ResultsBottomsheetCubit,
                        ResultsBottomsheetState>(
                      builder: (context, state) {
                        return EvaluationCategoriesSummary(
                          group: state.group,
                          currentResults: state.evaluations.current,
                          previousResults: state.evaluations.previous,
                        );
                      },
                    ),
                  ],
                ),
              ),
              largestPossible: 5,
              monthValuesList: allMonths.reversed.map((month) {
                final valuesForMonth = monthsToStatusMap[month];
                return MonthValues(month, {
                  for (final evaluationCategory in evaluationCategories)
                    evaluationCategory.name:
                        valuesForMonth?[evaluationCategory.id] ?? 0
                });
              }).toList(),
            );
          },
        );
      },
    );
  }
}
