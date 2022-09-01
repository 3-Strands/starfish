import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starfish/src/grpc_extensions.dart';
import 'package:starfish/widgets/shapes/slider_thumb.dart';

class EvaluationCategorySlider extends StatefulWidget {
  const EvaluationCategorySlider({
    Key? key,
    required this.groupUser,
    required this.evaluationCategory,
    required this.initialValue,
    this.onChange,
  }) : super(key: key);

  final GroupUser groupUser;
  final EvaluationCategory evaluationCategory;
  final int? initialValue;
  final void Function(int value)? onChange;

  @override
  State<EvaluationCategorySlider> createState() =>
      _EvaluationCategorySliderState();
}

class _EvaluationCategorySliderState extends State<EvaluationCategorySlider> {
  late int value;

  @override
  void initState() {
    value = widget.initialValue ?? 3;
    super.initState();
  }

  String getCurrentLabel() {
    final appLocalizations = AppLocalizations.of(context)!;
    switch (value) {
      case 0:
        return "";
      case 1:
        return appLocalizations.poorText;
      case 2:
        return appLocalizations.notSoGoodText;
      case 3:
        return appLocalizations.acceptableText;
      case 4:
        return appLocalizations.goodText;
      case 5:
        return appLocalizations.greatText;
      default:
        throw Exception("Unexpected slider value $value");
    }
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.evaluationCategory.name,
          style: TextStyle(
            fontFamily: "OpenSans",
            fontSize: 19.sp,
            fontWeight: FontWeight.bold,
            color: Color(0xFF434141),
          ),
          textAlign: TextAlign.left,
        ),
        SizedBox(
          height: 10.h,
        ),
        Container(
          child: SliderTheme(
            data: SliderTheme.of(context).copyWith(
              thumbShape: SliderThumb(),
              valueIndicatorColor: Colors.transparent,
              valueIndicatorTextStyle: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              showValueIndicator: ShowValueIndicator.never,
            ),
            child: Slider(
              activeColor: Color(0xFFFCDFBA),
              inactiveColor: Color(0xFFFCDFBA),
              thumbColor: Color(0xFFE5625C),
              max: 5.0,
              min: 0.0,
              divisions: 5,
              value: value.toDouble(),
              label: getCurrentLabel(),
              onChanged: (double value) {
                setState(() {
                  this.value = value.toInt();
                });

                widget.onChange?.call(this.value);
              },
            ),
          ),
        ),
        SizedBox(
          height: 5.h,
        ),
        Text(
          value == 0
              ? appLocalizations.dragToSelect
              : widget.evaluationCategory.getEvaluationNameFromValue(value),
          style: TextStyle(
            fontStyle: FontStyle.italic,
            fontFamily: "OpenSans",
            fontSize: 14.sp,
            color: Color(0xFF797979),
          ),
        ),
        SizedBox(
          height: 5.h,
        ),
      ],
    );
  }
}
