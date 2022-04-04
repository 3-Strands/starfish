import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:starfish/constants/text_styles.dart';
import 'package:starfish/db/hive_current_user.dart';
import 'package:starfish/db/hive_database.dart';
import 'package:starfish/db/hive_material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starfish/db/hive_material_feedback.dart';
import 'package:starfish/db/providers/current_user_provider.dart';
import 'package:starfish/utils/helpers/alerts.dart';
import 'package:starfish/widgets/seprator_line_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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

  late Box<HiveMaterialFeedback> _materialFeedbackBox;

  late HiveCurrentUser _user;

  bool isDetailEmpty = true;

  @override
  void initState() {
    super.initState();

    _materialFeedbackBox =
        Hive.box<HiveMaterialFeedback>(HiveDatabase.MATERIAL_FEEDBACK_BOX);

    _getCurrentUser();
  }

  void _getCurrentUser() {
    _user = CurrentUserProvider().getUserSync(); 
  }

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
      //height: 264.h,
      width: 315.w,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: AppColors.popDialogBGColor,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            height: 15.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 61.w),
            child: Text(
              widget.material.title ?? '',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 20.5.sp, fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Text(
            AppLocalizations.of(context)!.reportDialogDetailText,
            style: TextStyle(fontSize: 15.5.sp),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 10.h,
          ),
          Container(
            //height: 110.h,
            width: 280.w,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
              child: TextFormField(
                controller: _reportTextController,
                focusNode: _reportTextFocus,
                onFieldSubmitted: (term) {
                  _reportTextFocus.unfocus();
                },
                onChanged: (text) {
                  setState(() {
                    isDetailEmpty = (text.isNotEmpty) ? false : true;
                  });
                },
                maxLines: 4,
                keyboardType: TextInputType.text,
                style: textFormFieldText,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(10.w, 10.h, 0.0, 10.h),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide: BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                  focusedBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  filled: true,
                  fillColor: AppColors.txtFieldBackground,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          SepratorLine(hight: 1.0, edgeInsets: EdgeInsets.zero),
          Container(
            //height: 44.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      AppLocalizations.of(context)!.cancel,
                      style: cancelButtonTextStyle,
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
                    onPressed: () {
                      if (isDetailEmpty) {
                        return;
                      }

                      HiveMaterialFeedback _materialFeedback =
                          HiveMaterialFeedback();

                      _materialFeedback.isNew = true;
                      _materialFeedback.type = '1';
                      _materialFeedback.reporterId = _user.id;
                      _materialFeedback.report = _reportTextController.text;
                      _materialFeedback.materialId = widget.material.id!;
                      _materialFeedbackBox.add(_materialFeedback).then((value) {
                        Alerts.showMessageBox(
                          context: context,
                          title: AppLocalizations.of(context)!.dialogInfo,
                          message: AppLocalizations.of(context)!
                              .addMaterialFeedbackSuccess,
                          callback: () {
                            Navigator.of(context).pop();
                          },
                        );
                      }).onError((error, stackTrace) {
                        debugPrint('$error record(s) saved.');
                      }).whenComplete((() {}));
                    },
                    child: Text(
                      AppLocalizations.of(context)!.sendFeedback,
                      style: TextStyle(
                        fontFamily: 'OpenSans',
                        fontWeight: FontWeight.normal,
                        fontSize: 19.sp,
                        color: (isDetailEmpty)
                            ? Color(0xFF797979)
                            : AppColors.selectedButtonBG,
                      ),
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
