import 'package:flutter/material.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starfish/constants/text_styles.dart';

class SelectListButton extends StatelessWidget {
  final bool enabled;
  final bool multilineSummary;
  final String? summary;
  final String placeholder;
  final VoidCallback? onMoveNext;
  final VoidCallback? onFinished;
  final Widget Function(BuildContext context) listBuilder;

  const SelectListButton({
    Key? key,
    this.enabled = true,
    this.multilineSummary = false,
    this.summary,
    required this.placeholder,
    required this.listBuilder,
    this.onMoveNext,
    this.onFinished,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minHeight: 52.h),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.transparent,
          width: 1.0,
        ),
        color: AppColors.txtFieldBackground,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: InkWell(
        onTap: () async {
          if (enabled) {
            onMoveNext?.call();
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: listBuilder,
              ),
            );
            onFinished?.call();
          }
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  summary ?? placeholder,
                  maxLines: multilineSummary ? null : 1,
                  overflow: multilineSummary ? null : TextOverflow.fade,
                  softWrap: multilineSummary,
                  style:
                      summary == null ? formTitleHintStyle : textFormFieldText,
                ),
              ),
              Icon(Icons.navigate_next_sharp, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}
