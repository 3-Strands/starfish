import 'dart:ui';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starfish/apis/hive_api.dart';
import 'package:starfish/modules/results/evaluation/evaluation_categories_summary.dart';
import 'package:starfish/modules/results/evaluation/evalutation_category_slider.dart';
import 'package:starfish/repositories/data_repository.dart';
import 'package:starfish/src/deltas.dart';
import 'package:starfish/src/grpc_extensions.dart';
import 'package:starfish/utils/currentUser.dart';

class CurrentEvaluationCategories extends StatefulWidget {
  const CurrentEvaluationCategories({
    Key? key,
    required this.groupId,
    required this.userId,
    required this.evaluationCategories,
    required this.month,
  }) : super(key: key);

  final String groupId;
  final String userId;
  final List<EvaluationCategory> evaluationCategories;
  final Date month;

  @override
  State<CurrentEvaluationCategories> createState() =>
      _CurrentEvaluationCategoriesState();
}

class _CurrentEvaluationCategoriesState
    extends State<CurrentEvaluationCategories> {
  late final Map<EvaluationCategory, EvaluationResult> _results;

  Date getPreviousMonth() {
    final month = widget.month;
    final isFirstMonth = month.month == 1;
    return Date(
      year: month.year - (isFirstMonth ? 1 : 0),
      month: isFirstMonth ? 12 : month.month - 1,
    );
  }

  @override
  void initState() {
    final userId = widget.userId;
    final month = widget.month;
    final previousMonth = getPreviousMonth();
    final evalutationCategoryMap = {
      for (final evaluationCategory in widget.evaluationCategories)
        evaluationCategory.id: evaluationCategory
    };
    _results = {
      for (final evaluationCategory in widget.evaluationCategories)
        evaluationCategory: EvaluationResult(0),
    };
    for (final learnerEvaluation in globalHiveApi.learnerEvaluation.values) {
      if (learnerEvaluation.learnerId == userId &&
          learnerEvaluation.groupId == widget.groupId) {
        if (learnerEvaluation.month == month) {
          _results[evalutationCategoryMap[learnerEvaluation.categoryId]!]!
              .result = learnerEvaluation.evaluation;
        } else if (learnerEvaluation.month == previousMonth) {
          _results[evalutationCategoryMap[learnerEvaluation.categoryId]!]!
              .lastResult = learnerEvaluation.evaluation;
        }
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final evaluationCategory in widget.evaluationCategories) ...[
          EvaluationCategorySlider(
            evaluationCategory: evaluationCategory,
            initialValue: _results[evaluationCategory]!.result,
            onChange: (value) {
              final dataRepo = context.read<DataRepository>();
              final currentUserId = context.currentUser.id;
              final month = widget.month;
              final userId = widget.userId;
              final groupId = widget.groupId;
              final preexistingLearnerEvaluation = globalHiveApi
                  .learnerEvaluation.values
                  .firstWhereOrNull((eval) =>
                      eval.month == month &&
                      eval.learnerId == userId &&
                      eval.groupId == groupId &&
                      eval.evaluatorId == currentUserId &&
                      eval.categoryId == evaluationCategory.id);
              dataRepo.addDelta(LearnerEvaluationCreateDelta(
                id: preexistingLearnerEvaluation?.id,
                categoryId: evaluationCategory.id,
                evaluation: value,
                evaluatorId: currentUserId,
                groupId: groupId,
                learnerId: userId,
                month: month,
              ));
              setState(() {
                _results[evaluationCategory]!.result = value;
              });
            },
          ),
          SizedBox(height: 10.h),
        ],
        SizedBox(height: 30.h),
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
        EvaluationCategoriesSummary(
          results: _results,
        ),
      ],
    );
  }
}
