import 'package:flutter/material.dart';
import 'package:starfish/bloc/provider.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:starfish/db/hive_action.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:starfish/modules/actions_view/add_edit_action.dart';
import 'package:starfish/utils/date_time_utils.dart';
import 'package:starfish/utils/helpers/alerts.dart';
import 'package:starfish/widgets/action_status_widget.dart';

class MyActionListItem extends StatelessWidget {
  final int index;
  final HiveAction action;
  final bool displayActions;
  final Function(HiveAction action) onActionTap;

  const MyActionListItem(
      {required this.action,
      required this.onActionTap,
      required this.index,
      this.displayActions = false});

  @override
  Widget build(BuildContext context) {
    //final bloc = Provider.of(context);
    AppLocalizations _appLocalizations = AppLocalizations.of(context)!;
    return Card(
      margin: EdgeInsets.only(left: 15.w, right: 15.w, top: 5.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      color: AppColors.txtFieldBackground,
      child: InkWell(
        onTap: () {
          onActionTap(action);
        },
        child: Padding(
          padding:
              EdgeInsets.only(left: 5.w, right: 5.w, top: 5.h, bottom: 15.h),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 10.w),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "#${index + 1}",
                      style: TextStyle(
                          color: Color(0xFF797979),
                          fontSize: 19.sp,
                          fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 8.w, right: 8.w),
                        child: Text(
                          action.name!,
                          //maxLines: 1,
                          //overflow: TextOverflow.ellipsis,
                          //softWrap: false,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 19.sp,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 30.w,
                      height: 40.h,
                      child: displayActions
                          ? PopupMenuButton(
                              icon: Icon(
                                Icons.more_vert,
                                color: Color(0xFF3475F0),
                                size: 30,
                              ),
                              color: Colors.white,
                              elevation: 20,
                              shape: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.white, width: 2),
                                  borderRadius: BorderRadius.circular(12.r)),
                              enabled: true,
                              onSelected: (value) {
                                switch (value) {
                                  case 0:
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => AddEditAction(
                                          action: action,
                                        ),
                                      ),
                                    ).then((value) => FocusScope.of(context)
                                        .requestFocus(new FocusNode()));
                                    break;
                                  case 1:
                                    _deleteAction(context, action);

                                    break;
                                }
                              },
                              itemBuilder: (context) => [
                                PopupMenuItem(
                                  child: Text(
                                    _appLocalizations.editActionText,
                                    style: TextStyle(
                                        color: Color(0xFF3475F0),
                                        fontSize: 19.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  value: 0,
                                ),
                                PopupMenuItem(
                                  child: Text(
                                    _appLocalizations.deleteActionText,
                                    style: TextStyle(
                                        color: Color(0xFF3475F0),
                                        fontSize: 19.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  value: 1,
                                ),
                              ],
                            )
                          : Container(),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ActionStatusWidget(
                    onTap: (_) {
                      onActionTap(action);
                    },
                    actionStatus: action.actionStatus,

                    ///
                    height: 30.h,
                    width: 130.w,
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Text(
                    '${_appLocalizations.due}: ${action.dateDue != null && action.hasValidDueDate ? DateTimeUtils.formatHiveDate(action.dateDue!) : "NA"}',
                    style: TextStyle(
                      color: Color(0xFF797979),
                      fontSize: 19.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  _deleteAction(BuildContext context, HiveAction action) {
    final bloc = Provider.of(context);
    final AppLocalizations _appLocalizations = AppLocalizations.of(context)!;
    Alerts.showMessageBox(
        context: context,
        title: _appLocalizations.deleteActionTitle,
        message: _appLocalizations.deleteActionMessage,
        positiveButtonText: _appLocalizations.delete,
        negativeButtonText: _appLocalizations.cancel,
        positiveActionCallback: () {
          // Mark this action for deletion
          action.isDirty = true;
          bloc.actionBloc.createUpdateAction(action);
        },
        negativeActionCallback: () {});
  }
}
