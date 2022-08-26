import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:starfish/constants/text_styles.dart';
import 'package:starfish/modules/create_profile/bloc/profile_bloc.dart';
import 'package:starfish/widgets/settings_edit_button_widget.dart';

class EditName extends StatefulWidget {
  const EditName(
      {Key? key,
      required this.lable,
      this.hint,
      this.initialValue,
      required this.onDone})
      : super(key: key);

  final String lable;
  final String? hint;
  final String? initialValue;
  final Function(String value) onDone;

  @override
  State<EditName> createState() => _EditNameState();
}

class _EditNameState extends State<EditName> {
  final _focusNode = FocusNode();
  final _controller = TextEditingController();
  bool inEditMode = false;

  @override
  void initState() {
    super.initState();
    _controller.text = widget.initialValue ?? '';
  }

  @override
  Widget build(BuildContext context) {
    //final appLocalizations = AppLocalizations.of(context)!;
    final profileBloc = context.read<ProfileBloc>();
    return Container(
      //   height: (isNameEditable) ? 84.h : 63.h,
      child: Column(
        children: [
          Container(
            //      height: 22.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.lable,
                  textAlign: TextAlign.end,
                  style: titleTextStyle,
                ),
                EditButton(
                  editMode: inEditMode,
                  onButtonClicked: (value) {
                    // if (inEditMode) {
                    //   widget.onDone(_controller.text);
                    // }
                    setState(() {
                      inEditMode = value;
                    });
                  },
                  onCancel: () {
                    setState(() {
                      inEditMode = false;
                    });
                  },
                  onSave: (() {
                    setState(() {
                      inEditMode = false;
                    });

                    //profileBloc.add(NameChanged(_controller.text));
                  }),
                ),
              ],
            ),
          ),
          //    SizedBox(height: 5.h),
          (inEditMode)
              ? Container(
                  //   height: 52.h,
                  child: TextFormField(
                    controller: _controller,
                    focusNode: _focusNode,
                    onFieldSubmitted: (term) {
                      _focusNode.unfocus();
                    },
                    keyboardType: TextInputType.text,
                    style: textFormFieldText,
                    //initialValue: widget.initialValue,
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      //labelText: widget.hint ?? '',
                      //labelStyle: formTitleHintStyle,
                      alignLabelWithHint: true,
                      hintText: widget.hint ?? '',
                      hintStyle: formTitleHintStyle,
                      contentPadding:
                          EdgeInsets.fromLTRB(15.0.w, 0.0, 5.0.w, 0.0),
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
                )
              : Container(
                  //        height: 36.h,
                  child: Align(
                    alignment: FractionalOffset.topLeft,
                    child: Text(
                      widget.initialValue ?? '',
                      overflow: TextOverflow.ellipsis,
                      style: nameTextStyle,
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
