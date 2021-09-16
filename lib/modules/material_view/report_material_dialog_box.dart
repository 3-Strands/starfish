import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:starfish/constants/strings.dart';
import 'package:starfish/constants/text_styles.dart';
import 'package:starfish/db/hive_material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starfish/widgets/seprator_line_widget.dart';

class ReportMaterialDialogBox extends StatefulWidget {
  final HiveMaterial material;

  ReportMaterialDialogBox({required this.material});

  @override
  _ReportMaterialDialogBoxState createState() =>
      _ReportMaterialDialogBoxState();
}

class _ReportMaterialDialogBoxState extends State<ReportMaterialDialogBox> {
  final _reportTextController = TextEditingController();

  final FocusNode _reportTextFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Container(
      height: 264.h,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: AppColors.popDialogBGColor,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            height: 15.h,
          ),
          Text(
            widget.material.title,
            style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 20.h,
          ),
          Text(
            'Explain why this material is inappropriate',
            style: TextStyle(fontSize: 13.sp),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 10.h,
          ),
          Container(
            height: 111.h,
            margin: EdgeInsets.fromLTRB(18.w, 0.0, 18.w, 0.0),
            child: TextFormField(
              controller: _reportTextController,
              focusNode: _reportTextFocus,
              onFieldSubmitted: (term) {
                _reportTextFocus.unfocus();
              },
              maxLines: 4,
              keyboardType: TextInputType.text,
              style: textFormFieldText,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(15.0.w, 0.0, 5.0.w, 0.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
                filled: true,
                fillColor: AppColors.txtFieldBackground,
              ),
            ),
          ),
          SizedBox(
            height: 25.h,
          ),
          SepratorLine(hight: 1.0, edgeInsets: EdgeInsets.zero),
          Container(
            height: 44.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      Strings.cancel,
                      style: resentOTPTextStyle,
                    ),
                  ),
                ),
                SizedBox(
                  width: 1.w,
                  height: 44.h,
                  child: ColoredBox(color: AppColors.sepratorLineColor),
                ),
                Expanded(
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      Strings.sendFeedback,
                      style: resentOTPTextStyle,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
