import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starfish/apis/hive_api.dart';
import 'package:starfish/modules/results/results_bottomsheet/evaluation/evaluation_category_slider.dart';
import 'package:starfish/modules/results/results_bottomsheet/cubit/results_bottomsheet_cubit.dart';

class CurrentEvaluationCategories extends StatefulWidget {
  const CurrentEvaluationCategories({super.key});

  @override
  State<CurrentEvaluationCategories> createState() =>
      _CurrentEvaluationCategoriesState();
}

class _CurrentEvaluationCategoriesState
    extends State<CurrentEvaluationCategories> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResultsBottomsheetCubit, ResultsBottomsheetState>(
      buildWhen: (previous, current) =>
          previous.isDifferentSnapshotFrom(current),
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (final evaluationCategoryId
                in state.group.evaluationCategoryIds) ...[
              SizedBox(height: 10.h),
              EvaluationCategorySlider(
                evaluationCategory:
                    globalHiveApi.evaluationCategory.get(evaluationCategoryId)!,
                initialValue:
                    state.evaluations.current[evaluationCategoryId]?.evaluation,
                onChange: (value) {
                  context
                      .read<ResultsBottomsheetCubit>()
                      .evaluationCategoryChanged(evaluationCategoryId, value);
                },
              ),
            ],
          ],
        );
      },
    );
  }
}
