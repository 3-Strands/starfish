import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:hive/hive.dart';
import 'package:starfish/bloc/app_bloc.dart';
import 'package:starfish/bloc/provider.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:starfish/constants/text_styles.dart';
import 'package:starfish/db/hive_database.dart';
import 'package:starfish/db/hive_group.dart';
import 'package:starfish/utils/helpers/alerts.dart';
import 'package:starfish/utils/helpers/extensions/strings.dart';
import 'package:starfish/utils/helpers/snackbar.dart';
import 'package:starfish/widgets/seprator_line_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GroupEmailWidget extends StatefulWidget {
  final groupData;
  final onUpdateCallBack;
  const GroupEmailWidget(this.groupData, this.onUpdateCallBack, {Key? key})
      : super(key: key);

  @override
  State<GroupEmailWidget> createState() => _GroupEmailWidgetState();
}

class _GroupEmailWidgetState extends State<GroupEmailWidget> {
  late List<HiveGroup> _groupList = [];
  late AppBloc bloc;
  final _emailController = TextEditingController();
  late Box<HiveGroup> _groupBox;

  final _confirmEmailController = TextEditingController();
  bool is_editing = false;
  String email = "";
  String confirmEmail = "";

  @override
  void initState() {
    _groupBox = Hive.box<HiveGroup>(HiveDatabase.GROUP_BOX);
    _getGroups();
    _emailController.text = widget.groupData['email'];
    is_editing = widget.groupData['is_editing'];

    email = widget.groupData["email"];
  }

  void _getGroups() {
    _groupList = _groupBox.values.toList();
  }

  late AppLocalizations _appLocalizations;
  @override
  Widget build(BuildContext context) {
    bloc = Provider.of(context);

    _appLocalizations = AppLocalizations.of(context)!;
    return Container(
      //height: (item['is_editing'] == false) ? 200.h : 240.h,
      margin: EdgeInsets.only(left: 5.0, top: 10.0, right: 5.0),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                //width: 200.w,
                //height: 25.h,
                child: Align(
                  alignment: FractionalOffset.topLeft,
                  child: Text(getGroupName(widget.groupData['id']),
                      style: titleTextStyle),
                ),
              ),
              InkWell(
                  onTap: () {
                    setState(() {
                      email = _emailController.text;
                      confirmEmail = _confirmEmailController.text;
                    });
                    if (is_editing == false) {
                      setState(() {
                        is_editing = !is_editing;
                      });
                    } else {
                      if (_emailController.text == '') {
                        Alerts.showMessageBox(
                            context: context,
                            title: _appLocalizations.dialogAlert,
                            message: _appLocalizations.emptyEmail,
                            positiveButtonText: _appLocalizations.ok,
                            positiveActionCallback: () {});
                      } else if (!_emailController.text.isValidEmail()) {
                        Alerts.showMessageBox(
                            context: context,
                            title: _appLocalizations.dialogAlert,
                            message: _appLocalizations.alertInvalidEmaill,
                            positiveButtonText: _appLocalizations.ok,
                            positiveActionCallback: () {});
                      } else if (_confirmEmailController.text.isEmpty) {
                        Alerts.showMessageBox(
                            context: context,
                            title: _appLocalizations.dialogAlert,
                            message: _appLocalizations.emptyEmail,
                            positiveButtonText: _appLocalizations.ok,
                            positiveActionCallback: () {});
                      } else if (!_confirmEmailController.text.isValidEmail()) {
                        Alerts.showMessageBox(
                            context: context,
                            title: _appLocalizations.dialogAlert,
                            message: _appLocalizations.alertInvalidEmaill,
                            positiveButtonText: _appLocalizations.ok,
                            positiveActionCallback: () {});
                      } else if (_emailController.text !=
                          _confirmEmailController.text) {
                        Alerts.showMessageBox(
                            context: context,
                            title: _appLocalizations.dialogAlert,
                            message: _appLocalizations.alertEmailDoNotMatch,
                            positiveButtonText: _appLocalizations.ok,
                            positiveActionCallback: () {});
                      } else {
                        if (is_editing == true) {
                          // _updateGroupLinkedEmaill(
                          //     widget.groupDate['id'], email);
                          widget.onUpdateCallBack(
                              widget.groupData['id'], email);
                          _emailController.text = email;
                        }
                        setState(() {
                          is_editing = !is_editing;
                        });
                      }
                    }
                  },
                  child: (is_editing == false) ? editButton() : saveButton()),
              SizedBox(width: 5),
              if (is_editing == true)
                InkWell(
                  child: cancelButton(),
                  onTap: () => setState(() {
                    is_editing = false;
                    email = widget.groupData['email'];
                    _emailController.text = widget.groupData["email"];
                    _confirmEmailController.text = "";
                  }),
                ),
            ],
          ),
          SizedBox(
            height: 20.h,
          ),
          Container(
            //height: 45.h,
            child: Align(
              alignment: FractionalOffset.topLeft,
              child: Text(_appLocalizations.projectAdminEmailSectionTitle,
                  style: titleTextStyle),
            ),
          ),
          SizedBox(height: 10.h),
          Container(
            //height: 52.h,
            child: InkWell(
              onTap: () {
                setState(() {
                  is_editing = true;
                });
              },
              child: TextFormField(
                enabled: is_editing,
                controller: _emailController,
                // focusNode: _emailFocus,
                // onFieldSubmitted: (term) {
                //   _groups[index]['email'] = term;
                //   _emailController.text = term;
                //   //  _emailFocus.unfocus();
                // },
                keyboardType: TextInputType.emailAddress,
                style: textFormFieldText,
                decoration: InputDecoration(
                  labelText: _appLocalizations.emailHint,
                  labelStyle: formTitleHintStyle,
                  floatingLabelBehavior: FloatingLabelBehavior.never,

                  // hintText: _appLocalizations.emailHint,
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
              ),
            ),
          ),
          SizedBox(height: 10.h),
          Visibility(
            visible: is_editing,
            child: Container(
              //height: 52.h,
              child: TextFormField(
                enabled: is_editing,
                controller: _confirmEmailController,
                //   focusNode: _confirmEmailFocus,
                // onFieldSubmitted: (term) {
                //   _groups[index]['confirm_email'] = term;
                //   _confirmEmailController.text = term;
                //   // _confirmEmailController.text = term;
                //   // if (_emailController.text.isValidEmail() &&
                //   //     _emailController.text ==
                //   //         _confirmEmailController.text) {
                //   //     Alerts.showMessageBox(
                //   //         context: context,
                //   //         title:
                //   //             _appLocalizations.dialogAlert,
                //   //         message: _appLocalizations
                //   //             .alertSaveAdminEmail,
                //   //         negativeButtonText:
                //   //             _appLocalizations.no,
                //   //         positiveButtonText:
                //   //             _appLocalizations.yes,
                //   //         negativeActionCallback: () {},
                //   //         positiveActionCallback: () {
                //   //           _updateGroupLinkedEmaill(
                //   //               item['id'], _emailController.text);
                //   //         });

                //   //  //  _confirmEmailFocus.unfocus();
                //   //   } else {
                //   //     Alerts.showMessageBox(
                //   //         context: context,
                //   //         title:
                //   //             _appLocalizations.dialogAlert,
                //   //         message: _appLocalizations
                //   //             .alertEmailDoNotMatch,
                //   //         positiveButtonText:
                //   //             _appLocalizations.ok,
                //   //         positiveActionCallback: () {});
                //   //   }
                // },
                keyboardType: TextInputType.emailAddress,
                style: textFormFieldText,
                decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  labelText: _appLocalizations.confirmEmailHint,
                  labelStyle: formTitleHintStyle,
                  // hintText:
                  //     _appLocalizations.confirmEmailHint,
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
              ),
            ),
          ),
          SizedBox(height: 15.h),
          SepratorLine(
              hight: .5.h, edgeInsets: EdgeInsets.only(left: 10.w, right: 10.w))
        ],
      ),
    );
  }

  Container editButton() {
    return Container(
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
            _appLocalizations.edit,
            style: TextStyle(
              fontSize: 17.sp,
              color: Colors.blue,
            ),
          )
        ],
      ),
    );
  }

  Container saveButton() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        color: Colors.blue,
      ),
      child: Center(
        child: Text(
          _appLocalizations.save,
          style: TextStyle(
            fontSize: 17.sp,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Container cancelButton() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        color: Colors.grey,
      ),
      child: Center(
        child: Text(
          _appLocalizations.cancel,
          style: TextStyle(
            fontSize: 17.sp,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  String getGroupName(String groupId) {
    return _groupList.firstWhere((element) => element.id == groupId).name ?? '';
  }
}
