import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starfish/apis/hive_api.dart';
import 'package:starfish/modules/results/results_bottomsheet/cubit/results_bottomsheet_cubit.dart';
import 'package:starfish/modules/results/results_bottomsheet/evaluation/current_evaluation_categories.dart';
import 'package:starfish/modules/results/results_bottomsheet/evaluation/evaluation_history.dart';
import 'package:starfish/src/grpc_extensions.dart';
import 'package:starfish/widgets/focusable_text_field.dart';

class TeacherFeedback extends StatelessWidget {
  const TeacherFeedback({
    Key? key,
    required this.group,
  }) : super(key: key);

  final Group group;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return Card(
      color: Color(0xFFEFEFEF),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(
            10,
          ),
        ),
      ),
      child: Container(
        padding: EdgeInsets.only(left: 15.w, right: 15.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 10.h,
            ),
            Text(
              appLocalizations.teacherFeedbackForLearner,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 17.sp,
                fontFamily: "OpenSans",
                color: Color(0xFF4F4F4F),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 10.h,
            ),
            BlocBuilder<ResultsBottomsheetCubit, ResultsBottomsheetState>(
              buildWhen: (previous, current) =>
                  previous.isDifferentSnapshotFrom(current),
              builder: (context, state) {
                return FocusableTextField(
                  key: UniqueKey(),
                  // controller: _teacherFeedbackController,
                  initialValue: state.teacherResponse?.response,
                  keyboardType: TextInputType.text,
                  maxCharacters: 200,
                  decoration: InputDecoration(
                    counterText: "",
                    hintText: "",
                    hintStyle: TextStyle(
                      fontFamily: "OpenSans",
                      fontSize: 16.sp,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  maxLines: 3,
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (value) {
                    context
                        .read<ResultsBottomsheetCubit>()
                        .teacherResponseChanged(value.trim());
                  },
                );
              },
            ),
            SizedBox(height: 20.h),
            if (group.evaluationCategoryIds.isNotEmpty) ...[
              const CurrentEvaluationCategories(),
              SizedBox(height: 20.h),
              const EvaluationHistory(),
              SizedBox(height: 20.h),
            ],
          ],
        ),
      ),
    );
  }
}
