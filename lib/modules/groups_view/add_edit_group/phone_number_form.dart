import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:starfish/utils/helpers/snackbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PhoneNumberForm extends StatefulWidget {
  final String initialDiallingCode;
  final void Function(String diallingCode, String phonenumber)? onInvite;

  PhoneNumberForm({
    Key? key,
    this.onInvite,
    this.initialDiallingCode = '',
  }) : super(key: key);

  _PhoneNumberFormState createState() => _PhoneNumberFormState();
}

class _PhoneNumberFormState extends State<PhoneNumberForm> {
  final _diallingCodeController = TextEditingController();
  final _phoneNumberController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _diallingCodeController.text = widget.initialDiallingCode;
  }

  @override
  void dispose() {
    _diallingCodeController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    final appLocalizations = AppLocalizations.of(context)!;

    final diallingCode = _diallingCodeController.text;
    final phoneNumber = _phoneNumberController.text;

    if (diallingCode.isEmpty) {
      StarfishSnackbar.showErrorMessage(
          context, appLocalizations.emptyDialingCode);
    } else if (phoneNumber.isEmpty) {
      StarfishSnackbar.showErrorMessage(
          context, appLocalizations.emptyMobileNumbers);
    } else {
      //invite this user by sending SMS
      widget.onInvite?.call(
        diallingCode.startsWith("+")
            ? diallingCode.substring(1) // Remove '+' from dialling code
            : diallingCode,
        phoneNumber,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return SizedBox(
      height: 35.h,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            width: 47.w,
            child: TextFormField(
              controller: _diallingCodeController,
              keyboardType: TextInputType.phone,
              onFieldSubmitted: (_) => _handleSubmit(),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(15.0.w, 0.0, 5.0.w, 0.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(3.0),
                  borderSide: BorderSide(
                    color: Colors.blue,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(3.0),
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(3.0),
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
            width: 11.w,
          ),
          SizedBox(
            width: 123.w,
            child: TextFormField(
              controller: _phoneNumberController,
              keyboardType: TextInputType.phone,
              onFieldSubmitted: (_) => _handleSubmit(),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(15.0.w, 0.0, 5.0.w, 0.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(3.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(3.0),
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(3.0),
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
                filled: true,
                fillColor: AppColors.txtFieldBackground,
              ),
            ),
          ),
          const Spacer(),
          Container(
            width: 86.w,
            child: ElevatedButton(
              onPressed: _handleSubmit,
              child: Text(
                appLocalizations.invite,
                style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 14.5.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF3475F0),
                fixedSize: Size(86.w, 35.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
