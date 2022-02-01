import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:starfish/constants/text_styles.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomPhoneNumber extends StatefulWidget {
  TextEditingController? controller;
  Function(String)? onChanged;
  CustomPhoneNumber({
    Key? key,
    this.controller,
    this.onChanged,
  }) : super(key: key);

  _CustomPhoneNumberState createState() => _CustomPhoneNumberState();
}

class _CustomPhoneNumberState extends State<CustomPhoneNumber> {
  final int MAX_LENGTH = 10;
  int _phoneNumberRemainingDigits = 10;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      TextFormField(
        controller: widget.controller,
        //focusNode: _phoneNumberFocus,
        onChanged: (text) {
          setState(() {
            _phoneNumberRemainingDigits = MAX_LENGTH - text.length;

            //_isPhoneNumberEmpty = text.isEmpty;
          });
          if (widget.onChanged != null) {
            widget.onChanged!(text);
          }
        },
        onFieldSubmitted: (term) {
          //_phoneNumberFocus.unfocus();
        },
        keyboardType: TextInputType.phone,
        style: textFormFieldText,
        decoration: InputDecoration(
          hintText: AppLocalizations.of(context)!.phoneNumberHint,
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
          counterText: '',
        ),
      ),
      Padding(
        padding: EdgeInsets.only(left: 8.w),
        child: Text(
          _phoneNumberStatus(_phoneNumberRemainingDigits),
          style: TextStyle(
            fontFamily: "Rubik",
            fontSize: 16.sp,
            color: _phoneNumberRemainingDigits == 0
                ? Color(0xFF6DE26B)
                : Color(0xFF434141),
          ),
        ),
      ),
    ]);
  }

  String _phoneNumberStatus(int _phoneNumberRemainingDigits) {
    if (_phoneNumberRemainingDigits == 0) {
      return "${AppLocalizations.of(context)!.phoneNumberComplete}";
    } else if (_phoneNumberRemainingDigits == 1) {
      return "$_phoneNumberRemainingDigits ${AppLocalizations.of(context)!.oneNumberMissing}";
    } else if (_phoneNumberRemainingDigits > 0 &&
        _phoneNumberRemainingDigits <= MAX_LENGTH) {
      return "$_phoneNumberRemainingDigits ${AppLocalizations.of(context)!.moreNumbersMissing}";
    } else if (_phoneNumberRemainingDigits < 0) {
      return "${AppLocalizations.of(context)!.tooManyNumbers} ${_phoneNumberRemainingDigits.abs()}";
    } else {
      return '';
    }
  }
}
