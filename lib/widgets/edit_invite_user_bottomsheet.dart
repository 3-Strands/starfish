import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:starfish/models/invite_contact.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:starfish/src/generated/starfish.pb.dart';

class EditInviteUserBottomSheet extends StatefulWidget {
  final InviteContact contact;
  EditInviteUserBottomSheet(this.contact, {Key? key}) : super(key: key);

  @override
  State<EditInviteUserBottomSheet> createState() =>
      _EditInviteUserBottomSheetState();
}

class _EditInviteUserBottomSheetState extends State<EditInviteUserBottomSheet> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _contactNumberController = TextEditingController();
  late AppLocalizations _appLocalizations;

  @override
  void initState() {
    _nameController.text = widget.contact.displayName!;
    _contactNumberController.text = widget.contact.phoneNumber;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _appLocalizations = AppLocalizations.of(context)!;
    return Container(
      height: MediaQuery.of(context).size.height * 0.70,
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(34.r)),
        color: Color(0xFFEFEFEF),
      ),
      child: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.white,
              margin: EdgeInsets.only(
                top: 40.h,
              ),
              child: Container(
                //  margin: EdgeInsets.only(left: 15.0.w, right: 15.0.w),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 15.0.w, right: 15.0.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 10.h,
                          ),
                          Text(
                            _appLocalizations.editInvite,
                            style: TextStyle(
                              fontSize: 18.sp,
                              color: Color(0xFF316FE3),
                              fontFamily: 'OpenSans',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          Text(
                            _appLocalizations.name,
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: Color(0xFF434141),
                              fontFamily: 'OpenSans',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          TextFormField(
                            controller: _nameController,
                            style: TextStyle(
                              fontSize: 20.sp,
                              color: Color(0xFF000000),
                              fontFamily: 'OpenSans',
                              fontWeight: FontWeight.bold,
                            ),
                            keyboardType: TextInputType.url,
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.fromLTRB(15.0.w, 0.0, 5.0.w, 0.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                              filled: true,
                              fillColor: AppColors.txtFieldBackground,
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Text(
                            _appLocalizations.contactNumber,
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: Color(0xFF434141),
                              fontFamily: 'OpenSans',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          TextFormField(
                            controller: _contactNumberController,
                            style: TextStyle(
                              fontSize: 20.sp,
                              color: Color(0xFF000000),
                              fontFamily: 'OpenSans',
                              fontWeight: FontWeight.bold,
                            ),
                            keyboardType: TextInputType.url,
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.fromLTRB(15.0.w, 0.0, 5.0.w, 0.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                              filled: true,
                              fillColor: AppColors.txtFieldBackground,
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Text(
                            _appLocalizations.role,
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: Color(0xFF434141),
                              fontFamily: 'OpenSans',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Center(
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Color(0xFFEFEFEF),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8.5.r))),
                              child: DropdownButtonHideUnderline(
                                child: ButtonTheme(
                                  alignedDropdown: true,
                                  child: DropdownButton2<GroupUser_Role>(
                                    onChanged: (value) {},
                                    //   offset: Offset(0, -10),
                                    dropdownMaxHeight: 150.h,
                                    scrollbarAlwaysShow: true,
                                    isExpanded: true,
                                    iconSize: 35,
                                    style: TextStyle(
                                      color: Color(0xFFEFEFEF),
                                      fontSize: 19.sp,
                                      fontFamily: 'OpenSans',
                                    ),

                                    items: GroupUser_Role.values
                                        .where((element) => false)
                                        .map<DropdownMenuItem<GroupUser_Role>>(
                                            (value) {
                                      return DropdownMenuItem<GroupUser_Role>(
                                        value: value,
                                        child: Text(
                                          value.name,
                                          style: TextStyle(
                                            color: Color(0xFF434141),
                                            fontSize: 17.sp,
                                            fontFamily: 'OpenSans',
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 75.h,
                          // padding: EdgeInsets.symmetric(vertical: 18.75.h, horizontal: 30.w),
                          color: AppColors.txtFieldBackground,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(left: 10.h),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      // _filteredContactList.clear();
                                      // _loadContacts();

                                      Navigator.of(context).pop();
                                    },
                                    child: Text(_appLocalizations.cancel),
                                  ),
                                ),
                              ),
                              SizedBox(width: 25.w),
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(right: 10.h),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      //   _validateAndCreateUpdateGroup();
                                    },
                                    child: Text(_appLocalizations.update),
                                    style: ElevatedButton.styleFrom(
                                      primary: AppColors.selectedButtonBG,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}