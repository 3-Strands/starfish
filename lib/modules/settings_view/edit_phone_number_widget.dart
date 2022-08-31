import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:starfish/constants/text_styles.dart';
import 'package:starfish/widgets/settings_edit_button_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditPhoneNumber extends StatefulWidget {
  const EditPhoneNumber({
    Key? key,
    required this.lable,
    this.hint,
    required this.initialDiallingCode,
    required this.initialPhonenumber,
    required this.onInputChanged,
    required this.onInputValidated,
    required this.onFieldSubmitted,
    //required this.onDone,
  }) : super(key: key);

  final String lable;
  final String initialDiallingCode;
  final String initialPhonenumber;
  final String? hint;

  final ValueChanged<PhoneNumber> onInputChanged;
  final Function(bool) onInputValidated;
  final Function(String) onFieldSubmitted;

  @override
  _EditPhoneNumberState createState() => _EditPhoneNumberState();
}

class _EditPhoneNumberState extends State<EditPhoneNumber> {
  bool inEditMode = false;

  final _phoneNumberController = TextEditingController();

  @override
  void initState() {
    _phoneNumberController.text = widget.initialPhonenumber;
    super.initState();
  }

  @override
  void dispose() {
    _phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    final outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        color: Colors.white,
      ),
    );

    return Container(
      //  height: (isMobileEditable) ? 84.h : 63.h,
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
                    if (inEditMode) {
                      //widget.onDone();
                    }
                    setState(
                      () {
                        inEditMode = value;
                      },
                    );
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
                  }),
                ),
              ],
            ),
          ),
          //   SizedBox(height: 5.h),
          (inEditMode)
              ? InternationalPhoneNumberInput(
                  textFieldController: _phoneNumberController,
                  selectorConfig: SelectorConfig(
                    selectorType: PhoneInputSelectorType.DIALOG,
                    showFlags: true,
                    useEmoji: true,
                  ),
                  initialValue: PhoneNumber(
                    isoCode: PhoneNumber.getISO2CodeByPrefix(
                        widget.initialDiallingCode),
                  ),
                  inputDecoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    labelStyle: formTitleHintStyle,
                    hintText: widget.hint,
                    hintStyle: formTitleHintStyle,
                    contentPadding: EdgeInsets.fromLTRB(15.0, 0.0, 5.0, 0.0),
                    border: outlineInputBorder,
                    enabledBorder: outlineInputBorder,
                    // errorBorder: outlineInputBorder,
                    // focusedErrorBorder: outlineInputBorder,
                    focusedBorder: outlineInputBorder,
                    filled: true,
                    fillColor: AppColors.txtFieldBackground,
                  ),
                  onInputChanged: widget.onInputChanged,
                  onInputValidated: widget.onInputValidated,
                  onFieldSubmitted: widget.onFieldSubmitted,
                  errorMessage: appLocalizations.invalidPhoneNumber,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  formatInput: false,
                )
              : Container(
                  //        height: 36.h,
                  child: Align(
                    alignment: FractionalOffset.topLeft,
                    child: Text(
                      widget.initialDiallingCode +
                          ' ' +
                          widget.initialPhonenumber,
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
