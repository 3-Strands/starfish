import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starfish/modules/results/evaluation/current_evaluation_categories.dart';
import 'package:starfish/modules/results/evaluation/evaluation_history.dart';
import 'package:starfish/src/grpc_extensions.dart';
import 'package:starfish/widgets/focusable_text_field.dart';

class TeacherFeedback extends StatelessWidget {
  const TeacherFeedback({
    Key? key,
    this.teacherFeedback,
    required this.evaluationCategories,
    required this.groupUser,
  }) : super(key: key);

  final TeacherResponse? teacherFeedback;
  final List<EvaluationCategory> evaluationCategories;
  final GroupUser groupUser;
  // final GroupEvaluation? groupEvaluation;

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
              height: 5.h,
            ),
            Container(
              decoration: BoxDecoration(
                color: Color(0xFFFFFFFF),
                border: Border.all(
                  color: Color(0xFF979797),
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: FocusableTextField(
                // controller: _teacherFeedbackController,
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
                onFocusChange: (isFocused) {
                  if (isFocused) {
                    return;
                  }
                  // TODO
                  // _saveTeacherFeedback(_teacherFeedbackController.text.trim());
                },
                // onChange: (value) {
                //   _teacherFeedback = value;
                // },
              ),
            ),
            if (evaluationCategories.isNotEmpty) ...[
              SizedBox(
                height: 30.h,
              ),
              CurrentEvaluationCategories(
                groupUser: groupUser,
                evaluationCategories: evaluationCategories,
              ),
              SizedBox(
                height: 30.h,
              ),
              EvaluationHistory(
                groupUser: groupUser,
                evaluationCategories: evaluationCategories,
              ),
            ],
            SizedBox(
              height: 20.h,
            )
          ],
        ),
      ),
    );
  }
}
