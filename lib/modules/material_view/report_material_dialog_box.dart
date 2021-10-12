import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:starfish/constants/strings.dart';
import 'package:starfish/constants/text_styles.dart';
import 'package:starfish/db/hive_current_user.dart';
import 'package:starfish/db/hive_database.dart';
import 'package:starfish/db/hive_material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starfish/db/hive_material_feedback.dart';
import 'package:starfish/utils/helpers/alerts.dart';
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

  late Box<HiveMaterialFeedback> _materialFeedbackBox;
  late Box<HiveCurrentUser> _currentUserBox;

  late HiveCurrentUser _user;

  bool isDetailEmpty = true;

  @override
  void initState() {
    super.initState();
    _currentUserBox = Hive.box<HiveCurrentUser>(HiveDatabase.CURRENT_USER_BOX);

    _materialFeedbackBox =
        Hive.box<HiveMaterialFeedback>(HiveDatabase.MATERIAL_FEEDBACK_BOX);

    _getCurrentUser();
  }

  void _getCurrentUser() {
    _user = _currentUserBox.values.first;
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
            widget.material.title ?? '',
            style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 20.h,
          ),
          Text(
            Strings.reportDialogDetailText,
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
              onChanged: (text) {
                setState(() {
                  isDetailEmpty = (text.isNotEmpty) ? false : true;
                });
              },
              maxLines: 4,
              keyboardType: TextInputType.text,
              style: textFormFieldText,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(10.w, 10.0, 0.0, 10.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
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
                      _materialFeedbackBox
                          .add(_materialFeedback)
                          .then(
                              (value) => debugPrint('$value record(s) saved.'))
                          .onError((error, stackTrace) =>
                              debugPrint('$error record(s) saved.'))
                          .whenComplete(() => {
                                Alerts.showMessageBox(
                                    context: context,
                                    title: Strings.dialogInfo,
                                    message: Strings.addMaterialFeedbackSuccess,
                                    callback: () {
                                      Navigator.of(context).pop();
                                    })
                              });
                    },
                    child: Text(
                      Strings.sendFeedback,
                      style: TextStyle(
                        fontFamily: 'OpenSans',
                        fontWeight: FontWeight.normal,
                        fontSize: 16.sp,
                        color: (isDetailEmpty)
                            ? AppColors.unselectedButtonBG
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
