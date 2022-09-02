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
    required this.groupUser,
    required this.evaluationCategories,
  }) : super(key: key);

  final GroupUser groupUser;
  final List<EvaluationCategory> evaluationCategories;

  @override
  State<CurrentEvaluationCategories> createState() =>
      _CurrentEvaluationCategoriesState();
}

class _CurrentEvaluationCategoriesState
    extends State<CurrentEvaluationCategories> {
  late final Map<EvaluationCategory, EvaluationResult> _results;

  Date getLastMonth() {
    final now = DateTime.now();
    final isFirstMonth = now.month == 1;
    return Date(
      year: now.year - (isFirstMonth ? 1 : 0),
      month: isFirstMonth ? 12 : now.month - 3,
    );
  }

  Date getCurrentMonth() {
    final now = DateTime.now();
    return Date(year: now.year, month: now.month);
  }

  @override
  void initState() {
    final userId = widget.groupUser.userId;
    final groupId = widget.groupUser.groupId;
    final thisMonth = getCurrentMonth();
    final lastMonth = getLastMonth();
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
          learnerEvaluation.groupId == groupId) {
        if (learnerEvaluation.month == thisMonth) {
          _results[evalutationCategoryMap[learnerEvaluation.categoryId]!]!
              .result = learnerEvaluation.evaluation;
        } else if (learnerEvaluation.month == lastMonth) {
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
            groupUser: widget.groupUser,
            evaluationCategory: evaluationCategory,
            initialValue: _results[evaluationCategory]!.result,
            onChange: (value) {
              final dataRepo = context.read<DataRepository>();
              final currentUserId = context.currentUser.id;
              final thisMonth = getCurrentMonth();
              final userId = widget.groupUser.userId;
              final groupId = widget.groupUser.groupId;
              final preexistingLearnerEvaluation = globalHiveApi
                  .learnerEvaluation.values
                  .firstWhereOrNull((eval) =>
                      eval.month == thisMonth &&
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
                month: thisMonth,
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
