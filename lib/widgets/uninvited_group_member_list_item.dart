import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starfish/bloc/app_bloc.dart';
import 'package:starfish/bloc/provider.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:starfish/db/hive_current_user.dart';
import 'package:starfish/db/hive_group_user.dart';
import 'package:starfish/db/hive_user.dart';
import 'package:starfish/db/providers/current_user_provider.dart';
import 'package:starfish/repository/current_user_repository.dart';
import 'package:starfish/src/generated/starfish.pb.dart';
import 'package:starfish/utils/helpers/snackbar.dart';
import 'package:starfish/widgets/seprator_line_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UnInvitedGroupMemberListItem extends StatefulWidget {
  final HiveGroupUser groupUser;
  final Function(String) onRemove;
  final Function(HiveUser) onInvite;

  UnInvitedGroupMemberListItem({
    Key? key,
    required this.groupUser,
    required this.onRemove,
    required this.onInvite,
  }) : super(key: key);

  _UnInvitedGroupMemberListItemState createState() =>
      _UnInvitedGroupMemberListItemState();
}

class _UnInvitedGroupMemberListItemState
    extends State<UnInvitedGroupMemberListItem> {
  bool isEditMode = false;
  TextEditingController _dialingCodeController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  late AppBloc bloc;

  @override
  void initState() {
    super.initState();
    _dialingCodeController.text =
        CurrentUserProvider().getUserSync().diallingCodeWithPlus;
  }

  @override
  Widget build(BuildContext context) {
    bloc = Provider.of(context);

    return InkWell(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(color: Colors.transparent),
        margin: EdgeInsets.fromLTRB(0, 10.h, 0, 10.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 35.h,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    widget.groupUser.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF434141),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      /// Display phonenumber input fields
                      setState(() {
                        isEditMode = !isEditMode;
                      });
                    },
                    child: Text(
                      AppLocalizations.of(context)!.inviteGroupUser,
                      style: TextStyle(
                        fontFamily: 'OpenSans',
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFFADADAD),
                      fixedSize: Size(115.w, 18.h),
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(3.0),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      /// Mark this groupuser for deletion
                      widget.groupUser.isDirty = true;
                      bloc.groupBloc.createUpdateGroupUser(widget.groupUser);
                    },
                    icon: Icon(
                      Icons.close,
                      color: AppColors.selectedButtonBG,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Visibility(
              child: Container(
                height: 35.h,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 47.w,
                      child: TextFormField(
                        controller: _dialingCodeController,
                        keyboardType: TextInputType.phone,
                        //style: textFormFieldText,
                        decoration: InputDecoration(
                          //hintText: '', // AppLocalizations.of(context)!.countryCodeHint,
                          contentPadding:
                              EdgeInsets.fromLTRB(15.0.w, 0.0, 5.0.w, 0.0),
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
                    Container(
                      width: 123.w,
                      child: TextFormField(
                        controller: _phoneNumberController,
                        keyboardType: TextInputType.phone,
                        //style: textFormFieldText,
                        decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.fromLTRB(15.0.w, 0.0, 5.0.w, 0.0),
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
                    SizedBox(
                      width: 78.w,
                    ),
                    Container(
                      width: 86.w,
                      child: ElevatedButton(
                        onPressed: () {
                          String _dialingCode = _dialingCodeController.text;
                          String _phoneNumber = _phoneNumberController.text;

                          if (_dialingCode.isEmpty) {
                            StarfishSnackbar.showErrorMessage(context,
                                AppLocalizations.of(context)!.emptyDialingCode);
                          } else if (_phoneNumber.isEmpty) {
                            StarfishSnackbar.showErrorMessage(
                                context,
                                AppLocalizations.of(context)!
                                    .emptyMobileNumbers);
                          } else {
                            ///TODO: invite this user by sending SMS
                            if (widget.groupUser.user != null) {
                              widget.groupUser.user!.diallingCode =
                                  _dialingCode;
                              widget.groupUser.user!.phone = _phoneNumber;
                              widget.groupUser.user!.isUpdated = true;
                              bloc.userBloc
                                  .createUpdateUser(widget.groupUser.user!)
                                  .then((value) =>
                                      widget.onInvite(widget.groupUser.user!));
                            }
                          }
                        },
                        child: Text(
                          AppLocalizations.of(context)!.invite,
                          style: TextStyle(
                            fontFamily: 'OpenSans',
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xFF3475F0),
                          fixedSize: Size(86.w, 35.h),
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(3.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              visible: isEditMode,
            ),
            SizedBox(
              height: 10.h,
            ),
            SepratorLine(
              hight: 1.h,
              edgeInsets: EdgeInsets.only(left: 0.w, right: 0.w),
            ),
          ],
        ),
      ),
    );
  }
}
