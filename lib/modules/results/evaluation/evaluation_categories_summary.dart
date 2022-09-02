import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starfish/src/grpc_extensions.dart';

class EvaluationCategoriesSummary extends StatelessWidget {
  const EvaluationCategoriesSummary({Key? key, required this.results})
      : super(key: key);

  final Map<EvaluationCategory, EvaluationResult> results;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: results.entries.map(
        (entry) {
          final difference = entry.value.difference;
          return Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "${entry.value.result}",
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
                  entry.key.name,
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

class EvaluationResult {
  EvaluationResult(this.result, [this.lastResult]);

  int result;
  int? lastResult;

  int? get difference => lastResult == null ||
          lastResult == 0 ||
          result == 0 ||
          lastResult == result
      ? null
      : result - lastResult!;
}
