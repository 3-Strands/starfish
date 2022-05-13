import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:starfish/bloc/profile_bloc.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:starfish/db/hive_country.dart';
import 'package:starfish/modules/authentication/otp_verification.dart';
import 'package:starfish/select_items/select_drop_down.dart';
import 'package:starfish/utils/helpers/general_functions.dart';
import 'package:starfish/utils/helpers/snackbar.dart';
import 'package:starfish/utils/services/sync_service.dart';
import 'package:starfish/widgets/app_logo_widget.dart';
import 'package:starfish/constants/text_styles.dart';
import 'package:starfish/widgets/constrain_center.dart';
import 'package:starfish/widgets/custom_phone_number.dart';
import 'package:starfish/widgets/title_label_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:starfish/navigation_service.dart';

class PhoneAuthenticationScreen extends StatefulWidget {
  PhoneAuthenticationScreen({Key? key, this.title = ''}) : super(key: key);

  final String title;

  @override
  _PhoneAuthenticationScreenState createState() =>
      _PhoneAuthenticationScreenState();
}

class _PhoneAuthenticationScreenState extends State<PhoneAuthenticationScreen> {
  final _countryCodeController = TextEditingController();
  final _phoneNumberController = TextEditingController();

  final FocusNode _countryCodeFocus = FocusNode();
  final FocusNode _phoneNumberFocus = FocusNode();

  bool _isPhoneNumberEmpty = true;

  HiveCountry _selectedCountry = HiveCountry(
      id: '',
      name: AppLocalizations.of(NavigationService.navigatorKey.currentContext!)!
          .selectCountry,
      diallingCode: '');

  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();

    _isPhoneNumberEmpty = false;

    SyncService obj = SyncService();
    obj.syncAll();
  }

  @override
  Widget build(BuildContext context) {
    ProfileBloc _profileBloc = new ProfileBloc();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Padding(
          padding: EdgeInsets.only(bottom: footerHeight),
          child: Center(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
              shrinkWrap: true,
              children: <Widget>[
                AppLogo(hight: 156.h, width: 163.w),
                SizedBox(height: 50.h),
                TitleLabel(
                  title: AppLocalizations.of(context)!
                      .phoneAuthenticationTitle,
                  align: TextAlign.center,
                ),
                SizedBox(height: 30.h),
                ConstrainCenter(
                  child: StreamBuilder(
                    stream: _profileBloc.countries,
                    builder: (BuildContext context,
                        AsyncSnapshot<List<HiveCountry>?> snapshot) {
                      if (snapshot.hasData) {
                        snapshot.data!
                            .sort((a, b) => a.name.compareTo(b.name));
                        return SelectDropDown(
                          navTitle:
                              AppLocalizations.of(context)!.selectCountry,
                          placeholder:
                              AppLocalizations.of(context)!.selectCountry,
                          selectedValues: _selectedCountry,
                          dataSource: snapshot.data,
                          type: SelectType.single,
                          dataSourceType: DataSourceType.country,
                          onDoneClicked: <T>(country) {
                            setState(() {
                              _selectedCountry = country as HiveCountry;
                              _countryCodeController
                                  .text = _selectedCountry.diallingCode
                                      .startsWith("+")
                                  ? _selectedCountry.diallingCode
                                  : "+${_selectedCountry.diallingCode}";
                            });
                          },
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                ),
                SizedBox(height: 30.h),
                _phoneNumberContainer(),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _footer(),
      //  bottomNavigationBar: _footer(),
    );
  }

  Widget _phoneNumberContainer() {
    return ConstrainCenter(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 87.w,
            child: _countryCodeField(),
          ),
          SizedBox(width: 15.w),
          Expanded(
            flex: 1,
            child: CustomPhoneNumber(
              controller: _phoneNumberController,
              onChanged: (text) {
                setState(() {
                  _isPhoneNumberEmpty = text.isEmpty;
                });
              },
            ),
          )
        ],
      ),
    );
  }

  TextFormField _countryCodeField() {
    return TextFormField(
      controller: _countryCodeController,
      focusNode: _countryCodeFocus,
      onFieldSubmitted: (term) {
        _fieldFocusChange(context, _countryCodeFocus, _phoneNumberFocus);
      },
      keyboardType: TextInputType.phone,
      style: textFormFieldText,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.never,
        labelText: AppLocalizations.of(context)!.countryCodeHint,
        labelStyle: formTitleHintStyle,
        alignLabelWithHint: true,
        // hintText: AppLocalizations.of(context)!.countryCodeHint,
        // hintStyle: formTitleHintStyle,
        contentPadding: EdgeInsets.fromLTRB(15.0.w, 0.0, 5.0.w, 0.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(
            color: Colors.blue,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        filled: true,
        fillColor: AppColors.txtFieldBackground,
      ),
    );
  }

  get footerHeight => 75.h;

  Container _footer() {
    return Container(
      height: footerHeight,
      child: Container(
        color: AppColors.txtFieldBackground,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
          child: Align(
            alignment: FractionalOffset.bottomCenter,
            child: _nextButton(),
          ),
        ),
      ),
    );
  }

  Container _nextButton() {
    return Container(
      width: 319.w,
      height: 37.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(20.r),
        ),
        color: AppColors.selectedButtonBG,
      ),
      child: Padding(
        padding: EdgeInsets.all(0.0),
        child: SizedBox(
          width: 319.w,
          height: 37.h,
          child: ElevatedButton(
            child: Text(
              AppLocalizations.of(context)!.next,
              textAlign: TextAlign.start,
              style: buttonTextStyle,
            ),
            onPressed: () async {
              String validationMsg =
                  GeneralFunctions.validateMobile(_phoneNumberController.text);
              if (validationMsg.isNotEmpty) {
                return StarfishSnackbar.showErrorMessage(
                    context, validationMsg);
              } else {
                EasyLoading.show();

                if (kIsWeb) {
                  _authenticateOnWeb(
                      _countryCodeController.text, _phoneNumberController.text);
                } else {
                  _authenticateOnDevice(
                      _countryCodeController.text, _phoneNumberController.text);
                }
              }
            },
            style: ElevatedButton.styleFrom(
              primary: (_isPhoneNumberEmpty)
                  ? Colors.grey
                  : AppColors.selectedButtonBG,
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(20.r),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _authenticateOnDevice(String dialingCode, String phoneNumber) async {
    final String phoneNumberWithDialingCode = dialingCode + phoneNumber;
    await auth.verifyPhoneNumber(
      phoneNumber: phoneNumberWithDialingCode,
      verificationCompleted: (PhoneAuthCredential credential) {
        EasyLoading.dismiss();
      },
      verificationFailed: (FirebaseAuthException e) {
        EasyLoading.dismiss();
        if (e.code == 'invalid-phone-number') {
          return StarfishSnackbar.showErrorMessage(context, e.message ?? '');
        }
      },
      codeSent: (String verificationId, int? resendToken) async {
        EasyLoading.dismiss();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OTPVerificationScreen(
              varificationId: verificationId,
              resentToken: resendToken,
              dialingCode: dialingCode,
              phoneNumber: phoneNumber,
              timeout: 60,
            ),
          ),
        );
      },
      timeout: Duration(seconds: 60),
      codeAutoRetrievalTimeout: (String verificationId) {
        // Auto-resolution timed out...
      },
    );
  }

  _authenticateOnWeb(String dialingCode, String phoneNumber) async {
    await auth
        .signInWithPhoneNumber(dialingCode + phoneNumber)
        .then((confirmationResult) => {
              EasyLoading.dismiss(),
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OTPVerificationScreen(
                    varificationId: '',
                    confirmationResult: confirmationResult,
                    dialingCode: dialingCode,
                    phoneNumber: phoneNumber,
                    timeout: 60,
                  ),
                ),
              ),
            })
        .onError((error, stackTrace) => {
              EasyLoading.dismiss(),
            });
  }

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
}
