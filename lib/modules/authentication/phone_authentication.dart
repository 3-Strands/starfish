import 'package:flutter/material.dart';
import 'package:grpc/grpc.dart';
import 'package:hive/hive.dart';
// ignore: import_of_legacy_library_into_null_safe
// import 'package:smart_select/smart_select.dart';
import 'package:starfish/config/routes/routes.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:starfish/constants/app_styles.dart';
import 'package:starfish/constants/strings.dart';
import 'package:starfish/db/hive_country.dart';
import 'package:starfish/db/hive_current_user.dart';
import 'package:starfish/db/hive_database.dart';
import 'package:starfish/main_dev.dart';
import 'package:starfish/repository/app_data_repository.dart';
import 'package:starfish/select_items/select_drop_down.dart';
import 'package:starfish/smart_select/src/model/choice_item.dart';
import 'package:starfish/smart_select/src/model/modal_config.dart';
import 'package:starfish/smart_select/src/tile/tile.dart';
import 'package:starfish/smart_select/src/widget.dart';
import 'package:starfish/src/generated/starfish.pb.dart';
import 'package:starfish/utils/services/sync_service.dart';
// import 'package:starfish/utils/services/sync_service.dart';
import 'package:starfish/widgets/app_logo_widget.dart';
import 'package:starfish/constants/text_styles.dart';
import 'package:starfish/widgets/title_label_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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

  bool _isLoading = false;

  late Box<HiveCountry> _countryBox;
  late List<HiveCountry> _countryList;

// simple usage
  // List<Country> _countriesList = [];

  HiveCountry _selectedCountry =
      HiveCountry(id: '', name: 'Select Country', diallingCode: '');

  @override
  void initState() {
    super.initState();
    _countryBox = Hive.box<HiveCountry>(HiveDatabase.COUNTRY_BOX);

    SyncService obj = SyncService();
    obj.syncAll();

    _getAllCountries();
  }

  void _getAllCountries() {
    _countryList = _countryBox.values.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 118.h),
                  AppLogo(hight: 156.h, width: 163.w),
                  SizedBox(height: 50.h),
                  TitleLabel(
                    title: Strings.phoneAuthenticationTitle,
                    align: TextAlign.center,
                  ),
                  SizedBox(height: 30.h),

                  SelectDropDown(
                    navTitle: Strings.selectCountry,
                    placeholder: Strings.selectCountry,
                    selectedValues: _selectedCountry,
                    choice: SelectType.single,
                    dataSource: DataSourceType.country,
                    onDoneClicked: <T>(country) {
                      setState(() {
                        _selectedCountry = country as HiveCountry;
                        _countryCodeController.text =
                            _selectedCountry.diallingCode;
                      });
                    },
                  ),
                  // available configuration for single choice
                  // Container(
                  //   height: 80.h,
                  //   margin: EdgeInsets.only(left: 15.w, right: 15.w),
                  //   decoration: BoxDecoration(
                  //     color: AppColors.txtFieldBackground,
                  //     borderRadius: BorderRadius.all(
                  //       Radius.circular(10),
                  //     ),
                  //   ),
                  //   child: Center(
                  //     child: SmartSelect<HiveCountry>.single(
                  //       title: Strings.country,
                  //       placeholder: Strings.selectCountry,
                  //       selectedValue: _selectedCountry,
                  //       // value: _selectedCountry,
                  //       onChange: (selected) => setState(() => {
                  //             _selectedCountry = selected.value,
                  //             _countryCodeController.text =
                  //                 _selectedCountry.diallingCode,
                  //           }),
                  //       choiceItems:
                  //           S2Choice.listFrom<HiveCountry, HiveCountry>(
                  //         source: _countryList,
                  //         value: (index, item) => item,
                  //         title: (index, item) => item.name,
                  //         //  group: (index, item) => item['brand'],
                  //       ),
                  //       choiceGrouped: false,
                  //       modalType: S2ModalType.fullPage,
                  //       modalFilter: true,
                  //       modalFilterAuto: true,
                  //       tileBuilder: (context, state) {
                  //         return S2Tile.fromState(
                  //           state,
                  //           isTwoLine: true,
                  //         );
                  //       },
                  //     ),
                  //   ),
                  // ),

                  SizedBox(height: 30.h),
                  _phoneNumberContainer(),
                ],
              ),
            ),
            if (_isLoading == true)
              Center(
                child: CircularProgressIndicator(),
              )
          ],
        ),
      ),
      bottomNavigationBar: _footer(),
    );
  }

  Container _phoneNumberContainer() {
    return Container(
      height: 52.h,
      margin: EdgeInsets.only(left: 15.w),
      child: Row(
        children: [
          Container(
            height: 52.h,
            width: 87.w,
            child: _countryCodeField(),
          ),
          SizedBox(width: 15.w),
          Container(
            height: 52.h,
            width: 243.w,
            child: _phoneNumberField(),
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
        hintText: Strings.countryCodeHint,
        contentPadding: EdgeInsets.fromLTRB(15.0.w, 0.0, 5.0.w, 0.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: Colors.blue,
          ),
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
    );
  }

  TextFormField _phoneNumberField() {
    return TextFormField(
      controller: _phoneNumberController,
      focusNode: _phoneNumberFocus,
      onFieldSubmitted: (term) {
        _phoneNumberFocus.unfocus();
      },
      keyboardType: TextInputType.phone,
      style: textFormFieldText,
      decoration: InputDecoration(
        hintText: Strings.phoneNumberHint,
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
    );
  }

  SizedBox _footer() {
    return SizedBox(
      height: 75.h,
      child: Stack(
        children: [
          Positioned(
            child: new Align(
              alignment: FractionalOffset.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    color: AppColors.txtFieldBackground,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Align(
                        alignment: FractionalOffset.bottomCenter,
                        child: _nextButton(),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container _nextButton() {
    return Container(
      width: 319.w,
      height: 37.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
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
              Strings.next,
              textAlign: TextAlign.start,
              style: buttonTextStyle,
            ),
            onPressed: () {
              Navigator.of(context).pushNamed(Routes.otpVerification);
            },
            style: ElevatedButton.styleFrom(
              primary: AppColors.selectedButtonBG,
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(20.0),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
}
