import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditButton extends StatefulWidget {
  final Function(bool isEditable) onButtonClicked;
  EditButton({Key? key, required this.onButtonClicked}) : super(key: key);

  @override
  _EditButtonState createState() => _EditButtonState();
}

class _EditButtonState extends State<EditButton> {
  bool isEditable = false;

  onButtonClicked(bool isEditable) {}

  @override
  Widget build(BuildContext context) {
    return (isEditable) ? saveButton() : editButton();
  }

  InkWell editButton() {
    return InkWell(
      onTap: () {
        setState(() {
          isEditable = !isEditable;
        });
        widget.onButtonClicked(isEditable);
      },
      child: Container(
        width: 48.w,
        height: 44.h,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.edit,
              color: Colors.blue,
              size: 18.sp,
            ),
            Text(
              AppLocalizations.of(context)!.edit,
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.blue,
              ),
            )
          ],
        ),
      ),
    );
  }

  InkWell saveButton() {
    return InkWell(
      onTap: () {
        setState(() {
          isEditable = !isEditable;
        });
        widget.onButtonClicked(isEditable);
      },
      child: Container(
        width: 53.w,
        height: 44.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          color: Colors.blue,
        ),
        child: Center(
          child: Text(
            AppLocalizations.of(context)!.save,
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
