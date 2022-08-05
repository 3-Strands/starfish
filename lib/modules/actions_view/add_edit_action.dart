import 'dart:async';

// ignore: import_of_legacy_library_into_null_safe
import 'package:fbroadcast/fbroadcast.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:starfish/bloc/data_bloc.dart';
import 'package:starfish/bloc/provider.dart';
import 'package:starfish/config/routes/routes.dart';
import 'package:starfish/constants/app_colors.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_svg/flutter_svg.dart';
import 'package:starfish/constants/assets_path.dart';
import 'package:starfish/constants/text_styles.dart';
import 'package:starfish/db/hive_action.dart';
import 'package:starfish/db/hive_edit.dart';
import 'package:starfish/db/hive_group.dart';
import 'package:starfish/db/hive_date.dart';
import 'package:starfish/db/hive_material.dart';
import 'package:starfish/db/providers/current_user_provider.dart';
import 'package:starfish/modules/actions_view/action_type_selector.dart';
import 'package:starfish/modules/actions_view/select_action.dart';
import 'package:starfish/modules/settings_view/settings_view.dart';
import 'package:starfish/select_items/multi_select.dart';
import 'package:starfish/src/generated/starfish.pb.dart';
import 'package:starfish/utils/date_time_utils.dart';
import 'package:starfish/utils/helpers/alerts.dart';
import 'package:starfish/utils/helpers/snackbar.dart';
import 'package:starfish/utils/helpers/uuid_generator.dart';
import 'package:starfish/utils/services/sync_service.dart';
import 'package:starfish/widgets/app_logo_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starfish/widgets/history_item.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/*
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
  late DataBloc bloc;
  late HiveAction? _actionToBeReused;

  final TextEditingController _actionNameController = TextEditingController();
  //Action_Type? _selectedActionType = Action_Type.TEXT_INSTRUCTION;
  Action_Type? _selectedActionType;

  bool _isEditMode = false;

  List<HiveGroup> _selectedGroups = [];

  late List<HiveGroup> _groupList;
  late Box<HiveGroup> _groupBox;
  late AppLocalizations _appLocalizations;

  HiveMaterial? _selectedMaterial;
  String? _instructions;
  String? _question;
  DateTime? _dueDate;
  bool _shouldRedrawWidegets = false;

  void _getAllGroups() {
    final currentUserId = CurrentUserProvider().getUserSync().id;

    _groupList = [
      HiveGroup(id: currentUserId, name: 'Me', isMe: true),
      ..._groupBox.values.where((group) {
        final role = group.getMyRole(currentUserId);
        return role == GroupUser_Role.ADMIN || role == GroupUser_Role.TEACHER;
      }),
    ];
  }

  @override
  void initState() {
    super.initState();
    _groupBox = Hive.box<HiveGroup>(HiveDatabase.GROUP_BOX);
    _getAllGroups();

    if (widget.action != null) {
      _isEditMode = true;

      _instructions = widget.action!.instructions;
      _question = widget.action!.question;

      _selectedActionType = Action_Type.valueOf(widget.action!.type!) ??
          Action_Type.TEXT_INSTRUCTION;
      _actionNameController.text = widget.action!.name!;
      _selectedMaterial = widget.action!.material;

      _selectedGroups = widget.action!.group != null
          ? [widget.action!.group!]
          : [_groupList[0]];
      _dueDate = widget.action!.dateDue?.toDateTime();
    }
    _controller = AnimationController(vsync: this);
    _actionToBeReused = null;
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
    _appLocalizations = AppLocalizations.of(context)!;

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
                _isEditMode
                    ? _appLocalizations.editActionText
                    : _appLocalizations.addActionText,
                style: dashboardNavigationTitle,
              ),
              IconButton(
                icon: SvgPicture.asset(AssetsPath.settings),
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    Routes.settings,
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
        child: Scrollbar(
          thickness: 5.w,
          thumbVisibility: false,
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  (!_isEditMode)
                      ? _showReuseAnAction()
                      : _showGroupNameContainer(),
                  SizedBox(height: 20.h),
                  Text(
                    _appLocalizations.nameOfAction,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 19.sp,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF434141)),
                  ),
                  SizedBox(height: 13.h),
                  TextFormField(
                    controller: _actionNameController,
                    keyboardType: TextInputType.url,
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      labelText: _appLocalizations.hintActionName,
                      labelStyle: formTitleHintStyle,
                      // hintText: _appLocalizations.hintActionName,
                      //  hintStyle: formTitleHintStyle,
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
                    _appLocalizations.typeOfAction,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 19.sp,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF434141)),
                  ),
                  SizedBox(height: 13.h),
                  _typesOfActions(),

                  SizedBox(height: 20.h),

                  // Assign action to group
                  // List groups where current user have Admin or Teacher Role only
                  _assignToThisAction(),

                  SizedBox(height: 20.h),
                  Text(
                    _appLocalizations.dueDate,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 19.sp,
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
                      decoration: BoxDecoration(
                          color: Color(0xFFEFEFEF),
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.r))),
                      child: Padding(
                        padding: EdgeInsets.only(left: 15.w, right: 10.w),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              Text(
                                _dueDate != null
                                    //? '${_dueDate!.month} ${_dueDate!.day}, ${_dueDate!.year}'
                                    ? '${DateTimeUtils.formatDate(_dueDate!, 'MMM dd, yyyy')}'
                                    : _appLocalizations.hintDueDate,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 19.sp, color: Color(0xFF434141)),
                              ),
                              Spacer(),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Color(0xFF434141),
                                size: 20.r,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  if (widget.action?.editHistory != null)
                    _editHistoryContainer(widget.action),
                  SizedBox(height: 75.h),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: Container(
        height: 75.h,
        width: MediaQuery.of(context).size.width,
        //  padding: EdgeInsets.symmetric(vertical: 18.75.h, horizontal: 30.w),
        color: AppColors.txtFieldBackground,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 10.h),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(_appLocalizations.cancel),
                ),
              ),
            ),
            SizedBox(width: 25.w),
            Expanded(
              child: Container(
                child: Container(
                  margin: EdgeInsets.only(right: 10.h),
                  child: ElevatedButton(
                    onPressed: () {
                      _validateAndCreateUpdateAction();
                    },
                    child: Text(
                      _isEditMode
                          ? _appLocalizations.update
                          : _appLocalizations.create,
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: AppColors.selectedButtonBG,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget emptyContainer() {
    return new Container();
  }

  _receivedReuseActionBtnResponse(HiveAction action) {
    setState(() {
      _actionToBeReused = action;
      _instructions = _actionToBeReused!.instructions;
      _question = _actionToBeReused!.question;

      _selectedActionType = Action_Type.valueOf(_actionToBeReused!.type!) ??
          Action_Type.TEXT_INSTRUCTION;
      _actionNameController.text = _actionToBeReused!.name!;
      _selectedMaterial = _actionToBeReused!.material;

      _selectedGroups = [];

      // _dueDate = _actionToBeReused!.dateDue?.toDateTime();
    });
  }

  Widget _showReuseAnAction() {
    return Column(
      children: [
        Align(
          alignment: FractionalOffset.topLeft,
          child: Text(
            _appLocalizations.reuseActionText,
            textAlign: TextAlign.left,
            style: TextStyle(
                fontSize: 19.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.optionalFieldColor),
          ),
        ),
        SizedBox(height: 13.h),
        InkWell(
          onTap: () async {
            setState(() {
              _shouldRedrawWidegets = true;
            });
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => SelectActions(
                  onSelect: (action) {
                    _receivedReuseActionBtnResponse(action);
                  },
                ),
                fullscreenDialog: true,
              ),
            ).then((value) => {
                  setState(() {
                    _shouldRedrawWidegets = false;
                  })
                });
          },
          child: Container(
            height: 52.h,
            width: 345.w,
            decoration: BoxDecoration(
                color: Color(0xFFEFEFEF),
                borderRadius: BorderRadius.all(Radius.circular(10.r))),
            child: Padding(
              padding: EdgeInsets.only(left: 15.w, right: 10.w),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _actionToBeReused != null
                          ? _actionToBeReused!.name!
                          : _appLocalizations.selectAnAction,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 19.sp, color: AppColors.optionalFieldColor),
                    ),
                    Spacer(),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: AppColors.optionalFieldColor,
                      size: 20.r,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _showGroupNameContainer() {
    return Column(
      children: [
        Align(
          alignment: FractionalOffset.topLeft,
          child: Align(
            alignment: FractionalOffset.topLeft,
            child: RichText(
              text: TextSpan(
                text: _appLocalizations.actionWasAssignedTo + ' ',
                style: TextStyle(
                  fontSize: 19.sp,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF434141),
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: _getAssingToGroupName(),
                    style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontWeight: FontWeight.normal,
                      fontSize: 21.5.sp,
                      color: Color(0xFF3475F0),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 13.h),
      ],
    );
  }

  String _getAssingToGroupName() {
    List<HiveGroup> groups = List<HiveGroup>.from(_selectedGroups);
    String _value = '';
    groups.forEach((element) {
      _value += '${element.name}, ';
    });
    return _value.substring(0, _value.length - 2);
  }

  Widget _typesOfActions() {
    if (_shouldRedrawWidegets) {
      return _emptyContainer();
    } else {
      return ActionTypeSelector(
        onActionTypeChange: (Action_Type? value) {
          setState(() {
            _selectedActionType = value;
          });
        },
        onInstructionsChange: (String? value) {
          setState(() {
            _instructions = value;
          });
        },
        onQuestionChange: (String? value) {
          setState(() {
            _question = value;
          });
        },
        onMaterialChange: (HiveMaterial? material) {
          setState(() {
            _selectedMaterial = material;
          });
        },
        selectedActionType: _selectedActionType,
        instructions: _instructions ?? '',
        question: _question ?? '',
        selectedMaterial: _selectedMaterial,
      );
    }
  }

  Widget _assignToThisAction() {
    // Assign action to group
    if (_shouldRedrawWidegets || _isEditMode) {
      return _emptyContainer();
    }

    return Column(
      children: [
        Align(
          alignment: FractionalOffset.topLeft,
          child: Text(
            _appLocalizations.assignActionTo,
            textAlign: TextAlign.left,
            style: titleTextStyle,
          ),
        ),

        SizedBox(height: 13.h),

        // List groups where current user have Admin or Teacher Role only
        _selectDropDown(),
      ],
    );
  }

  Widget _emptyContainer() {
    return const SizedBox();
  }

  Widget _selectDropDown() {
    return MultiSelect<HiveGroup>(
      navTitle: _appLocalizations.assignActionTo,
      placeholder: _appLocalizations.selectOneOrMoreGroups,
      items: _groupList,
      initialSelection: _selectedGroups.toSet(),
      enableSelectAllOption: false,
      enabled: !_isEditMode,
      toDisplay: HiveGroup.toDisplay,
      onFinished: (Set<HiveGroup> selectedGroups) {
        setState(() {
          _selectedGroups = selectedGroups.toList();
        });
      },
    );
  }

  Widget _editHistoryContainer(HiveAction? action) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _historyItems(action!)!,
      ),
    );
  }

  List<Widget>? _historyItems(HiveAction action) {
    final List<Widget> _widgetList = [];
    final header = Text(
      _appLocalizations.history,
      style: TextStyle(
        fontFamily: 'OpenSans',
        fontWeight: FontWeight.bold,
        fontSize: 21.5.sp,
        color: Color(0xFF3475F0),
      ),
    );
    _widgetList.add(header);

    for (HiveEdit edit in action.editHistory ?? []) {
      _widgetList.add(HistoryItem(
        edit: edit,
        type: _appLocalizations.action,
      ));
    }

    return _widgetList;
  }

  _validateAndCreateUpdateAction() {
    if (_actionNameController.text.isEmpty) {
      StarfishSnackbar.showErrorMessage(
          context, _appLocalizations.emptyActionName);
    } else if (_instructions == null || _instructions!.isEmpty) {
      StarfishSnackbar.showErrorMessage(
          context, _appLocalizations.emptyActionInstructions);
    } else if ((_selectedActionType == Action_Type.TEXT_RESPONSE ||
            _selectedActionType == Action_Type.MATERIAL_RESPONSE) &&
        (_question == null || _question!.isEmpty)) {
      StarfishSnackbar.showErrorMessage(
          context, _appLocalizations.emptyActionQuestion);
    } else if ((_selectedActionType == Action_Type.MATERIAL_INSTRUCTION ||
            _selectedActionType == Action_Type.MATERIAL_RESPONSE) &&
        _selectedMaterial == null) {
      StarfishSnackbar.showErrorMessage(
          context, _appLocalizations.emptyActionMaterial);
    } else if (_selectedGroups.length == 0) {
      StarfishSnackbar.showErrorMessage(
          context, _appLocalizations.selectActionGroup);
    } else if (_dueDate == null) {
      StarfishSnackbar.showErrorMessage(
          context, _appLocalizations.emptyActionDueDate);
    } else {
      // create a separate request for each groups as, action creted for each
      //gorup will be considered as separate entity and therefor will have a different UUID
      _selectedGroups.forEach((element) {
        _createUpdateAction(element);
      });

      Alerts.showMessageBox(
        context: context,
        title: _appLocalizations.dialogInfo,
        message: _isEditMode
            ? _appLocalizations.updateActionSuccess
            : _appLocalizations.createActionSuccess,
        callback: () {
          Navigator.of(context).pop();
        },
      );
    }
  }

  _createUpdateAction(HiveGroup group) {
    HiveAction? _hiveAction;

    if (_isEditMode) {
      _hiveAction = widget.action!;

      _hiveAction.isUpdated = true;
    } else {
      _hiveAction = HiveAction(
        id: UuidGenerator.uuid(),
      );
      _hiveAction.createdDate = HiveDate.fromDateTime(DateTime.now());
      _hiveAction.isNew = true;
    }

    _hiveAction.type = _selectedActionType!.value;
    _hiveAction.name = _actionNameController.text;
    _hiveAction.creatorId = CurrentUserProvider().getUserSync().id;
    if (group.isMe == false) {
      _hiveAction.groupId = group.id;
    }
    _hiveAction.materialId =
        _selectedMaterial != null ? _selectedMaterial!.id : null;
    _hiveAction.instructions = _instructions;
    _hiveAction.question = _question;
    _hiveAction.dateDue =
        _dueDate != null ? HiveDate.fromDateTime(_dueDate!) : null;

    bloc.actionBloc.createUpdateAction(_hiveAction).then((value) {
      // Broadcast to sync the local changes with the server
      FBroadcast.instance().broadcast(
        SyncService.kUpdateActions,
        value: _hiveAction,
      );
    }).onError((error, stackTrace) {
      StarfishSnackbar.showErrorMessage(
          context,
          _isEditMode
              ? _appLocalizations.updateActionFailed
              : _appLocalizations.createActionSuccess);
    }).whenComplete(() {});
  }
}
*/