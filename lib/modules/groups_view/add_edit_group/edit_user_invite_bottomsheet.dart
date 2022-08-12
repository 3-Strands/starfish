import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:starfish/modules/groups_view/add_edit_group/cubit/add_edit_group_cubit.dart';
import 'package:starfish/src/grpc_extensions.dart';

class EditUserInviteBottomSheet extends StatefulWidget {
  final GroupUser_Role role;
  final User contact;

  const EditUserInviteBottomSheet({
    Key? key,
    required this.contact,
    required this.role,
  }) : super(key: key);

  @override
  State<EditUserInviteBottomSheet> createState() =>
      _EditUserInviteBottomSheetState();
}

class _EditUserInviteBottomSheetState extends State<EditUserInviteBottomSheet> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _contactNumberController = TextEditingController();
  TextEditingController _dialingController = TextEditingController();

  late GroupUser_Role _selectedGroupUserRole;

  @override
  void initState() {
    super.initState();

    _selectedGroupUserRole = widget.role;

    _nameController.text = widget.contact.name;
    _contactNumberController.text = widget.contact.phone;
    _dialingController.text = widget.contact.diallingCodeWithPlus;
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: EdgeInsets.only(
              bottom: 15.0.w,
              top: 40.h,
              left: 15.0.w,
              right: 15.0.w,
            ),
            children: <Widget>[
              SizedBox(
                height: 10.h,
              ),
              Text(
                appLocalizations.editInvite,
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
                appLocalizations.name,
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
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(15.0.w, 0.0, 5.0.w, 0.0),
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
                appLocalizations.contactNumber,
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
              Row(
                children: [
                  Container(
                      width: 60.w,
                      child: TextFormField(
                        controller: _dialingController,
                        style: TextStyle(
                          fontSize: 20.sp,
                          color: Color(0xFF000000),
                          fontFamily: 'OpenSans',
                          fontWeight: FontWeight.bold,
                        ),
                        keyboardType: TextInputType.phone,
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
                      )),
                  SizedBox(
                    width: 15.w,
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: _contactNumberController,
                      style: TextStyle(
                        fontSize: 20.sp,
                        color: Color(0xFF000000),
                        fontFamily: 'OpenSans',
                        fontWeight: FontWeight.bold,
                      ),
                      keyboardType: TextInputType.number,
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
                  ),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                appLocalizations.role,
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
                      borderRadius: BorderRadius.all(Radius.circular(8.5.r))),
                  child: DropdownButtonHideUnderline(
                    child: ButtonTheme(
                      alignedDropdown: true,
                      child: DropdownButton2<GroupUser_Role>(
                        onChanged: (value) {
                          setState(() {
                            _selectedGroupUserRole =
                                value ?? GroupUser_Role.LEARNER;
                          });
                        },
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
                        value: _selectedGroupUserRole,
                        items: [GroupUser_Role.TEACHER, GroupUser_Role.LEARNER]
                            .map<DropdownMenuItem<GroupUser_Role>>((value) {
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
        SafeArea(
          child: Container(
            height: 75.h,
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            color: AppColors.txtFieldBackground,
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(appLocalizations.cancel),
                  ),
                ),
                SizedBox(width: 25.w),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<AddEditGroupCubit>().userUpdated(
                            widget.contact,
                            name: _nameController.text,
                            diallingCode:
                                _dialingController.text.replaceAll('+', ''),
                            phone: _contactNumberController.text,
                            role: _selectedGroupUserRole,
                          );
                      Navigator.of(context).pop();
                    },
                    child: Text(appLocalizations.update),
                    style: ElevatedButton.styleFrom(
                      primary: AppColors.selectedButtonBG,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
