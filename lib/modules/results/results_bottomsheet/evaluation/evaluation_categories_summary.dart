import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starfish/apis/hive_api.dart';
import 'package:starfish/src/grpc_extensions.dart';

class EvaluationCategoriesSummary extends StatelessWidget {
  const EvaluationCategoriesSummary({
    Key? key,
    required this.group,
    required this.currentResults,
    this.previousResults,
  }) : super(key: key);

  final Group group;
  final Map<String, LearnerEvaluation> currentResults;
  final Map<String, LearnerEvaluation>? previousResults;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: group.evaluationCategoryIds.map(
        (categoryId) {
          final current = currentResults[categoryId]?.evaluation;
          final previous = previousResults?[categoryId]?.evaluation;
          final difference = current == null ||
                  previous == null ||
                  current == 0 ||
                  previous == 0 ||
                  current == previous
              ? null
              : current - previous;
          return Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "${current ?? 0}",
                      style: TextStyle(
                        fontFeatures: [FontFeature.subscripts()],
                        color: Color(0xFF434141),
                        fontFamily: "OpenSans",
                        fontSize: 30.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    if (difference != null)
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                        child: Text(
                          difference > 0 ? "+$difference" : "-$difference",
                          style: TextStyle(
                            fontFeatures: [FontFeature.superscripts()],
                            fontWeight: FontWeight.bold,
                            color: difference >= 0 ? Colors.green : Colors.red,
                          ),
                        ),
                      ),
                  ],
                ),
                Text(
                  globalHiveApi.evaluationCategory.get(categoryId)?.name ?? '',
                  style: TextStyle(
                    fontSize: 17.sp,
                    fontFamily: "OpenSans",
                    color: Color(0x99434141),
                  ),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          );
        },
      ).toList(),
    );
  }
}
