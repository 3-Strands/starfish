import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart' hide Material, Action;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starfish/apis/hive_api.dart';
import 'package:starfish/config/routes/routes.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:starfish/constants/assets_path.dart';
import 'package:starfish/constants/text_styles.dart';
import 'package:starfish/modules/actions_view/cubit/add_edit_action_cubit.dart';
import 'package:starfish/modules/material_view/add_edit_material_screen.dart';
import 'package:starfish/modules/material_view/enum_display.dart';
import 'package:starfish/repositories/authentication_repository.dart';
import 'package:starfish/repositories/data_repository.dart';
import 'package:starfish/select_items/multi_select.dart';
import 'package:starfish/src/grpc_extensions.dart';
import 'package:starfish/utils/date_time_utils.dart';
import 'package:starfish/utils/helpers/snackbar.dart';
import 'package:starfish/widgets/app_logo_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddEditAction extends StatelessWidget {
  const AddEditAction({Key? key, this.action}) : super(key: key);
  final Action? action;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddEditActionCubit(
        dataRepository: context.read<DataRepository>(),
        authenticationRepository: context.read<AuthenticationRepository>(),
        action: action,
      ),
      child: AddEditActionView(isEditMode: action != null),
    );
  }
}

class AddEditActionView extends StatelessWidget {
  const AddEditActionView({Key? key, required this.isEditMode})
      : super(key: key);

  final bool isEditMode;

  Widget _showReuseAnAction(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return Column(
      children: [
        Align(
          alignment: FractionalOffset.topLeft,
          child: Text(
            appLocalizations.reuseActionText,
            textAlign: TextAlign.left,
            style: TextStyle(
                fontSize: 19.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.optionalFieldColor),
          ),
        ),
        SizedBox(height: 13.h),
        BlocBuilder<AddEditActionCubit, AddEditActionState>(
            buildWhen: (previous, current) =>
                previous.actions != current.actions,
            builder: (context, state) {
              return MultiSelect<Action>(
                  navTitle: appLocalizations.selectAction,
                  placeholder: appLocalizations.selectAnAction,
                  items: state.actions,
                  maxSelectItemLimit: 1,
                  initialSelection: state.reuseAction != null
                      ? {state.reuseAction!}
                      : const {},
                  toDisplay: (action) => action.name,
                  onFinished: (selectedActions) {
                    context
                        .read<AddEditActionCubit>()
                        .reuseActionChanged(selectedActions.first);
                  },
                  displayItem: (Action action) {
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              action.name,
                              style: TextStyle(
                                  fontSize: 17.sp, fontWeight: FontWeight.bold),
                            ),
                            Text(
                                appLocalizations.type +
                                    ': ' +
                                    //"${Action_Type.valueOf(action.type!)!.about}",
                                    action.type.toLocaleString(context),
                                style: TextStyle(
                                    fontSize: 17.sp, color: Color(0xFF797979))),
                            Text(
                                appLocalizations.usedBy +
                                    ': ' +
                                    "${action.group != null ? action.group!.name : 'None'}",
                                style: TextStyle(
                                    fontSize: 17.sp, color: Color(0xFF797979))),
                            Row(
                              children: [
                                Text(appLocalizations.createdDate + ': ', // +
                                    //"${_getCreatedDate(action)}",
                                    style: TextStyle(
                                        fontSize: 17.sp,
                                        color: Color(0xFF797979))),
                                //action.isNew
                                true
                                    ? Text(" Not sync",
                                        style: TextStyle(
                                            fontSize: 17.sp,
                                            color: Color(0xFF797979)))
                                    : Container()
                              ],
                            ),
                          ],
                        ),
                      ),
                      margin: const EdgeInsets.all(0.0),
                      elevation: 2,
                    );
                  });
            }),
      ],
    );
  }

  // String _getCreatedDate(Action action) {
  //   if (action.editHistory.isNotEmpty) {
  //     var createdEvent = action.editHistory
  //         .where((element) => element.event == Edit_Event.CREATE)
  //         .first;
  //     return DateTimeUtils.formatDate(createdEvent.localTime!, 'dd-MMM-yyyy');
  //   } else {
  //     if (action.isNew && action.createdDate != null) {
  //       String actionCreatedDate =
  //           DateTimeUtils.formatHiveDate(action.createdDate!);
  //       return actionCreatedDate;
  //     }
  //     return "";
  //   }
  // }

  Widget _showGroupNameContainer(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return Column(
      children: [
        Align(
          alignment: FractionalOffset.topLeft,
          child: Align(
            alignment: FractionalOffset.topLeft,
            child: BlocBuilder<AddEditActionCubit, AddEditActionState>(
              buildWhen: (previous, current) =>
                  previous.groupId != current.groupId,
              builder: (context, state) => RichText(
                text: TextSpan(
                  text: appLocalizations.actionWasAssignedTo + ' ',
                  style: TextStyle(
                    fontSize: 19.sp,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF434141),
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: state.name,
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
        ),
        SizedBox(height: 13.h),
      ],
    );
  }

  _selectDate(BuildContext context, AddEditActionCubit cubit,
      AddEditActionState state) async {
    showDatePicker(
      context: context,
      currentDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
      initialDate: state.dueDate.isValidDate
          ? state.dueDate.toDateTime()
          : DateTime.now(),
    ).then((DateTime? dateTime) {
      if (dateTime == null) {
        return;
      }
      cubit.dueDateChanged(dateTime);
    });
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddEditActionCubit>();
    final appLocalizations = AppLocalizations.of(context)!;

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
                isEditMode
                    ? appLocalizations.editActionText
                    : appLocalizations.addActionText,
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
      body: BlocListener<AddEditActionCubit, AddEditActionState>(
        listenWhen: (previous, current) => current.error != null,
        listener: ((context, state) {
          String errorMessage;
          switch (state.error!) {
            case ActionError.noName:
              errorMessage = appLocalizations.emptyActionName;
              break;
            case ActionError.noInstructions:
              errorMessage = appLocalizations.emptyActionInstructions;
              break;
            case ActionError.noMaterial:
              errorMessage = appLocalizations.emptyActionMaterial;
              break;
            case ActionError.noQuestion:
              errorMessage = appLocalizations.emptyActionQuestion;
              break;
          }
          StarfishSnackbar.showErrorMessage(context, errorMessage);
        }),
        child: Scrollbar(
          thickness: 5.w,
          thumbVisibility: false,
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  (isEditMode)
                      ? _showGroupNameContainer(context)
                      : _showReuseAnAction(context),

                  SizedBox(height: 20.h),
                  Text(
                    appLocalizations.nameOfAction,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 19.sp,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF434141)),
                  ),
                  SizedBox(height: 13.h),

                  // name
                  TextFormField(
                    initialValue: cubit.state.name,
                    onChanged: cubit.nameChanged,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      labelText: appLocalizations.hintActionName,
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

                  // actionType
                  Text(
                    appLocalizations.typeOfAction,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 19.sp,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF434141)),
                  ),
                  SizedBox(height: 13.h),
                  //_typesOfActions(),
                  Container(
                    height: 52.h,
                    decoration: BoxDecoration(
                      color: AppColors.txtFieldBackground,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: DropdownButtonHideUnderline(
                      child:
                          BlocBuilder<AddEditActionCubit, AddEditActionState>(
                              builder: (context, state) {
                        return DropdownButton2<Action_Type>(
                          offset: Offset(0, -10),
                          isExpanded: true,
                          dropdownMaxHeight: 250.h,
                          scrollbarAlwaysShow: true,
                          iconSize: 35,
                          style: TextStyle(
                            color: Color(0xFF434141),
                            fontSize: 19.sp,
                            fontFamily: 'OpenSans',
                          ),
                          value: state.type,
                          // hint: Text(
                          //   // state.type != null
                          //   //     ? _selectedActionType.about
                          //   //     : AppLocalizations.of(context)!
                          //   //         .selectTheTypeOfAction,
                          //   state.type.toLocaleString(context),
                          //   maxLines: 2,
                          //   overflow: TextOverflow.ellipsis,
                          //   // style: widget.selectedActionType != null
                          //   //     ? TextStyle(
                          //   //         color: Color(0xFF434141),
                          //   //         fontSize: 19.sp,
                          //   //         fontFamily: 'OpenSans',
                          //   //       )
                          //   //     : formTitleHintStyle,
                          //   style: TextStyle(
                          //     color: Color(0xFF434141),
                          //     fontSize: 19.sp,
                          //     fontFamily: 'OpenSans',
                          //   ),
                          //   // textAlign: TextAlign.left,
                          // ),
                          onChanged: cubit.typeChanged,
                          items: ActionTypeDisplay.displayList
                              .map<DropdownMenuItem<Action_Type>>(
                                  (Action_Type value) {
                            return DropdownMenuItem<Action_Type>(
                              value: value,
                              child: Text(
                                value.toLocaleString(context),
                                style: TextStyle(
                                  color: Color(0xFF434141),
                                  fontSize: 17.sp,
                                  fontFamily: 'OpenSans',
                                ),
                              ),
                            );
                          }).toList(),
                        );
                      }),
                    ),
                  ),

                  SizedBox(height: 20.h),

                  Text(
                    AppLocalizations.of(context)!.instructions,
                    textAlign: TextAlign.left,
                    style: titleTextStyle,
                  ),

                  SizedBox(height: 13.h),

                  TextFormField(
                      maxLines: 4,
                      maxLength: 200,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        labelText:
                            AppLocalizations.of(context)!.hintInstructions,
                        labelStyle: formTitleHintStyle,
                        alignLabelWithHint: true,

                        // hintText: AppLocalizations.of(context)!.hintInstructions,
                        // hintStyle: formTitleHintStyle,
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
                        fillColor: Colors.white,
                      ),
                      initialValue: cubit.state.instructions,
                      onChanged: cubit.instuctionsChanged),

                  SizedBox(height: 20.h),

                  BlocBuilder<AddEditActionCubit, AddEditActionState>(
                    buildWhen: (previous, current) =>
                        previous.type != current.type ||
                        previous.materials != current.materials,
                    builder: (context, state) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Material
                          if (state.type == Action_Type.MATERIAL_INSTRUCTION ||
                              state.type == Action_Type.MATERIAL_RESPONSE) ...[
                            Text(
                              AppLocalizations.of(context)!.selectAMaterial,
                              textAlign: TextAlign.left,
                              style: titleTextStyle,
                            ),
                            SizedBox(height: 13.h),
                            Container(
                              child: MultiSelect<Material>(
                                navTitle: appLocalizations.selectAMaterial,
                                placeholder: appLocalizations.selectAMaterial,
                                items: state.materials,
                                maxSelectItemLimit: 1,
                                initialSelection: globalHiveApi.material
                                            .get(state.materialId) !=
                                        null
                                    ? {
                                        globalHiveApi.material
                                            .get(state.materialId)!
                                      }
                                    : const {},
                                toDisplay: (material) => material.title,
                                onFinished: (selectedMaterials) {
                                  cubit.selectedMaterialChanged(
                                      selectedMaterials.first.id);
                                },
                              ),
                            ),
                            SizedBox(height: 20.h),
                          ],

                          // question
                          if (state.type == Action_Type.TEXT_RESPONSE ||
                              state.type == Action_Type.MATERIAL_RESPONSE) ...[
                            Text(
                              AppLocalizations.of(context)!
                                  .questionToBeAnswered,
                              textAlign: TextAlign.left,
                              style: titleTextStyle,
                            ),
                            SizedBox(height: 13.h),
                            TextFormField(
                              maxLines: null,
                              keyboardType: TextInputType.multiline,
                              decoration: InputDecoration(
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
                                fillColor: Colors.white,
                              ),
                              initialValue: cubit.state.question,
                              onChanged: cubit.questionChanged,
                            ),
                          ]
                        ],
                      );
                    },
                  ),

                  SizedBox(height: 20.h),

                  // Assign action to group
                  // List groups where current user have Admin or Teacher Role only
                  if (!isEditMode) ...[
                    Text(
                      appLocalizations.assignActionTo,
                      textAlign: TextAlign.left,
                      style: titleTextStyle,
                    ),
                    SizedBox(height: 13.h),
                    //                _groupList = [
                    //   HiveGroup(id: currentUserId, name: 'Me', isMe: true),
                    //   ..._groupBox.values.where((group) {
                    //     final role = group.getMyRole(currentUserId);
                    //     return role == GroupUser_Role.ADMIN || role == GroupUser_Role.TEACHER;
                    //   }),
                    // ];

                    BlocBuilder<AddEditActionCubit, AddEditActionState>(
                      buildWhen: (previous, current) =>
                          previous.groups != current.groups,
                      builder: ((context, state) {
                        return MultiSelect<Group>(
                          navTitle: appLocalizations.assignActionTo,
                          placeholder: appLocalizations.selectOneOrMoreGroups,
                          items: [Group(id: "", name: "Me"), ...state.groups],
                          initialSelection: state.selectedGroups
                              .map((group) => group)
                              .toSet(),
                          toDisplay: (group) => group.name,
                          onFinished: (selectedGroups) {
                            cubit
                                .selectedGroupsChanged(selectedGroups.toList());
                          },
                        );
                      }),
                    ),

                    SizedBox(height: 20.h),
                  ],
                  Text(
                    appLocalizations.dueDate,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 19.sp,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF434141)),
                  ),
                  SizedBox(height: 13.h),
                  BlocBuilder<AddEditActionCubit, AddEditActionState>(
                      builder: (context, state) {
                    return InkWell(
                      onTap: () {
                        _selectDate(context, cubit, state);
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
                                  state.dueDate.isValidDate
                                      ? '${DateTimeUtils.formatDate(state.dueDate.toDateTime(), 'MMM dd, yyyy')}'
                                      : appLocalizations.hintDueDate,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 19.sp,
                                      color: Color(0xFF434141)),
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
                    );
                  }),

                  SizedBox(height: 20.h),

                  BlocBuilder<AddEditActionCubit, AddEditActionState>(
                    builder: (context, state) {
                      if (state.history.isEmpty) {
                        return const SizedBox();
                      }
                      return EditHistory(
                        history: state.history,
                      );
                    },
                  ),

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
                  child: Text(appLocalizations.cancel),
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
                      cubit.submitRequested();
                    },
                    child: Text(
                      isEditMode
                          ? appLocalizations.update
                          : appLocalizations.create,
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
}

/*
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
