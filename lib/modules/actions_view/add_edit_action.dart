import 'package:fbroadcast/fbroadcast.dart';
import 'package:flutter/material.dart';
import 'package:starfish/bloc/app_bloc.dart';
import 'package:starfish/bloc/provider.dart';
import 'package:getwidget/components/dropdown/gf_multiselect.dart';
import 'package:getwidget/getwidget.dart';
import 'package:starfish/config/routes/routes.dart';
import 'package:starfish/constants/app_colors.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_svg/flutter_svg.dart';
import 'package:starfish/constants/assets_path.dart';
import 'package:starfish/constants/strings.dart';
import 'package:starfish/constants/text_styles.dart';
import 'package:starfish/db/hive_action.dart';
import 'package:starfish/modules/actions_view/action_type_selector.dart';
import 'package:starfish/modules/settings_view/settings_view.dart';
import 'package:starfish/src/generated/starfish.pb.dart';
import 'package:starfish/utils/date_time_utils.dart';
import 'package:starfish/utils/helpers/alerts.dart';
import 'package:starfish/utils/helpers/snackbar.dart';
import 'package:starfish/utils/helpers/uuid_generator.dart';
import 'package:starfish/utils/services/sync_service.dart';
import 'package:starfish/widgets/app_logo_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddEditAction extends StatefulWidget {
  final HiveAction? action;

  const AddEditAction({
    Key? key,
    this.action,
  }) : super(key: key);

  @override
  _AddEditActionState createState() => _AddEditActionState();
}

class _AddEditActionState extends State<AddEditAction>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late AppBloc bloc;

  final _actionNameController = TextEditingController();

  bool _isEditMode = false;

  Action_Type? _selectedActionType;
  String? _instructions;
  String? _question;
  DateTime? _dueDate;

  @override
  void initState() {
    super.initState();
    if (widget.action != null) {
      _isEditMode = true;
    }
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  _selectDate(BuildContext context) async {
    showDatePicker(
      context: context,
      currentDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
      initialDate: _dueDate ?? DateTime.now(),
    ).then((DateTime? dateTime) {
      if (dateTime == null) {
        return;
      }
      setState(() {
        _dueDate = dateTime;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    bloc = Provider.of(context);

    return Scaffold(
      backgroundColor: AppColors.actionScreenBG,
      appBar: AppBar(
        backgroundColor: AppColors.actionScreenBG,
        automaticallyImplyLeading: false,
        title: Container(
          height: 64.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              AppLogo(hight: 36.h, width: 37.w),
              Text(
                _isEditMode ? Strings.editActionText : Strings.addActionText,
                style: dashboardNavigationTitle,
              ),
              IconButton(
                icon: SvgPicture.asset(AssetsPath.settings),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SettingsScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Strings.reuseActionText,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF434141)),
                ),
                SizedBox(height: 13.h),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(Routes.selectActions).then(
                          (value) => FocusScope.of(context).requestFocus(
                            new FocusNode(),
                          ),
                        );
                  },
                  child: Container(
                    height: 52.h,
                    width: 345.w,
                    decoration: BoxDecoration(
                        color: Color(0xFFEFEFEF),
                        borderRadius: BorderRadius.all(Radius.circular(10.sp))),
                    child: Padding(
                      padding: EdgeInsets.only(left: 15.sp, right: 10.sp),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Select an action',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 16.sp, color: Color(0xFF434141)),
                            ),
                            Spacer(),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Color(0xFF434141),
                              size: 20.sp,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                Text(
                  'Name of the Action',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF434141)),
                ),
                SizedBox(height: 13.h),
                TextFormField(
                  controller: _actionNameController,
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
                SizedBox(height: 20.h),
                Text(
                  'Type of Action',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF434141)),
                ),
                SizedBox(height: 13.h),
                ActionTypeSelector(
                  onActionTypeChange: (Action_Type? value) {
                    debugPrint('ActionTypeSelector[ActionType]: $value');
                    setState(() {
                      _selectedActionType = value;
                    });
                  },
                  onInstructionsChange: (String? value) {
                    debugPrint('ActionTypeSelector[Instructions]: $value');
                    setState(() {
                      _instructions = value;
                    });
                  },
                  onQuestionChange: (String? value) {
                    debugPrint('ActionTypeSelector[Question]: $value');
                    setState(() {
                      _question = value;
                    });
                  },
                  selectedActionType: _isEditMode
                      ? Action_Type.valueOf(widget.action!.type!)
                      : Action_Type.TEXT_INSTRUCTION,
                  instructions: _isEditMode ? widget.action!.instructions : '',
                  question: _isEditMode ? widget.action!.question : '',
                ),

                SizedBox(height: 20.h),

                // Assign action to group
                Text(
                  'Assign this Action to',
                  textAlign: TextAlign.left,
                  style: titleTextStyle,
                ),
                SizedBox(height: 13.h),
                /* Container(
                  height: 52.h,
                  width: 345.w,
                  decoration: BoxDecoration(
                      color: Color(0xFFEFEFEF),
                      borderRadius: BorderRadius.all(Radius.circular(10.sp))),
                  child: Padding(
                    padding: EdgeInsets.only(left: 15.sp, right: 10.sp),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          Text(
                            'Select option(s)',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 16.sp, color: Color(0xFF434141)),
                          ),
                          Spacer(),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Color(0xFF434141),
                            size: 20.sp,
                          )
                        ],
                      ),
                    ),
                  ),
                ),*/

                Container(
                  //height: 54.h,
                  decoration: BoxDecoration(
                      color: Color(0xFFEFEFEF),
                      borderRadius: BorderRadius.all(Radius.circular(10.sp))),
                  width: MediaQuery.of(context).size.width,
                  child: ButtonTheme(
                    alignedDropdown: true,
                    child: GFMultiSelect(
                      //hideDropdownUnderline: true,
                      items: [
                        "Me",
                        "Group Name 1",
                        "Group Name 2",
                        "Group Name 3"
                      ],
                      onSelect: (value) {
                        print('selected $value ');
                      },
                      dropdownTitleTileText: 'Select option(s)',
                      dropdownTitleTileColor: Color(0xFFEFEFEF),
                      dropdownTitleTileMargin: EdgeInsets.only(
                          top: 2.sp, left: 10.sp, right: 5.sp, bottom: 2.sp),
                      dropdownTitleTilePadding: EdgeInsets.all(10),
                      dropdownUnderlineBorder:
                          const BorderSide(color: Colors.transparent, width: 0),
                      dropdownTitleTileBorder:
                          Border.all(color: Colors.transparent, width: 0),
                      dropdownTitleTileBorderRadius: BorderRadius.circular(5),
                      expandedIcon: const Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.black54,
                      ),
                      collapsedIcon: const Icon(
                        Icons.keyboard_arrow_up,
                        color: Colors.black54,
                      ),
                      submitButton: Text('OK'),
                      dropdownTitleTileTextStyle:
                          const TextStyle(fontSize: 14, color: Colors.black54),
                      type: GFCheckboxType.circle,
                      activeBgColor: Colors.green.withOpacity(0.5),
                      inactiveBorderColor: Colors.grey[200]!,
                      padding: const EdgeInsets.all(6),
                      margin: const EdgeInsets.all(6),
                    ),
                  ),
                ),

                SizedBox(height: 20.h),
                Text(
                  'Due date',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF434141)),
                ),
                SizedBox(height: 13.h),
                InkWell(
                  onTap: () {
                    _selectDate(context);
                  },
                  child: Container(
                    height: 52.h,
                    width: 345.w,
                    decoration: BoxDecoration(
                        color: Color(0xFFEFEFEF),
                        borderRadius: BorderRadius.all(Radius.circular(10.sp))),
                    child: Padding(
                      padding: EdgeInsets.only(left: 15.sp, right: 10.sp),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            Text(
                              _dueDate != null
                                  //? '${_dueDate!.month} ${_dueDate!.day}, ${_dueDate!.year}'
                                  ? '${DateTimeUtils.formatDate(_dueDate!, 'MMM dd, yyyy')}'
                                  : 'Select due date',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 16.sp, color: Color(0xFF434141)),
                            ),
                            Spacer(),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Color(0xFF434141),
                              size: 20.sp,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 75.h,
        padding: EdgeInsets.symmetric(vertical: 18.75.h, horizontal: 30.w),
        color: AppColors.txtFieldBackground,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(Strings.cancel),
              ),
            ),
            SizedBox(width: 25.w),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  _validateAndCreateUpdateAction();
                },
                child: Text(
                  _isEditMode ? Strings.update : Strings.create,
                ),
                style: ElevatedButton.styleFrom(
                  primary: AppColors.selectedButtonBG,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _validateAndCreateUpdateAction() {
    if (_actionNameController.text.isEmpty) {
      StarfishSnackbar.showErrorMessage(context, Strings.emptyName);
    } else {
      _createUpdateAction();
    }
  }

  _createUpdateAction() {
    HiveAction? _hiveAction;

    if (_isEditMode) {
      _hiveAction = widget.action!;

      _hiveAction.isUpdated = true;
    } else {
      _hiveAction = HiveAction(
        id: UuidGenerator.uuid(),
      );
      _hiveAction.isNew = true;
    }

    _hiveAction.type = _selectedActionType!.value;
    _hiveAction.name = _actionNameController.text;
    //_hiveAction.creatorId=
    //_hiveAction.groupId=
    _hiveAction.instructions = _instructions;
    _hiveAction.question = _question;
    _hiveAction.dateDue =
        _dueDate != null ? DateTimeUtils.toHiveDate(_dueDate!) : null;

    bloc.actionBloc
        .createUpdateAction(_hiveAction)
        .then((value) => print('record(s) saved.'))
        .onError((error, stackTrace) {
      print('Error: ${error.toString()}.');
      StarfishSnackbar.showErrorMessage(
          context,
          _isEditMode
              ? Strings.updateActionFailed
              : Strings.createActionSuccess);
    }).whenComplete(() {
      // Broadcast to sync the local changes with the server
      FBroadcast.instance().broadcast(
        SyncService.kUpdateActions,
        value: _hiveAction,
      );

      Alerts.showMessageBox(
          context: context,
          title: Strings.dialogInfo,
          message: _isEditMode
              ? Strings.updateActionSuccess
              : Strings.createActionSuccess,
          callback: () {
            Navigator.of(context).pop();
          });
    });
  }
}
