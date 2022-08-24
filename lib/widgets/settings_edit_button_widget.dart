import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditButton extends StatefulWidget {
  const EditButton({
    Key? key,
    required this.onButtonClicked,
    required this.onSave,
    required this.onCancel,
    this.editMode,
  }) : super(key: key);

  final bool? editMode;
  final Function(bool isEditable) onButtonClicked;
  final Function() onSave;
  final Function() onCancel;

  @override
  _EditButtonState createState() => _EditButtonState();
}

class _EditButtonState extends State<EditButton> {
  bool isEditable = false;

  onButtonClicked(bool isEditable) {}

  @override
  void initState() {
    super.initState();
    //isEditable = widget.editMode ?? false;
  }

  @override
  Widget build(BuildContext context) {
    isEditable = widget.editMode ?? false;
    return isEditable
        ? Row(children: [
            saveButton(),
            SizedBox(width: 5),
            cancelButton(),
          ])
        : editButton();
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
        //height: 44.h,
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.edit,
              color: Colors.blue,
              size: 18.r,
            ),
            Text(
              AppLocalizations.of(context)!.edit,
              style: TextStyle(
                fontSize: 17.sp,
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
        widget.onSave();
      },
      child: Container(
        //width: 53.w,
        //height: 44.h,
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          color: Colors.blue,
        ),
        child: Center(
          child: Text(
            AppLocalizations.of(context)!.save,
            style: TextStyle(
              fontSize: 17.sp,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  InkWell cancelButton() {
    return InkWell(
      onTap: () {
        setState(() {
          isEditable = !isEditable;
        });
        widget.onCancel();
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          color: Colors.grey,
        ),
        child: Center(
          child: Text(
            AppLocalizations.of(context)!.cancel,
            style: TextStyle(
              fontSize: 17.sp,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
