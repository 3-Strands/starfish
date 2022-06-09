import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:group_list_view/group_list_view.dart';
import 'package:starfish/bloc/app_bloc.dart';
import 'package:starfish/bloc/provider.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:starfish/db/hive_current_user.dart';
import 'package:starfish/db/hive_action.dart';
import 'package:starfish/db/hive_action_user.dart';
import 'package:starfish/db/hive_group.dart';
import 'package:starfish/db/hive_material.dart';
import 'package:starfish/enums/action_filter.dart';
import 'package:starfish/enums/action_status.dart';
import 'package:starfish/modules/actions_view/my_action_list_item.dart';
import 'package:starfish/modules/dashboard/dashboard.dart';
import 'package:starfish/repository/current_user_repository.dart';
import 'package:starfish/src/generated/starfish.pb.dart';
import 'package:starfish/utils/date_time_utils.dart';
import 'package:starfish/utils/helpers/general_functions.dart';
import 'package:starfish/utils/services/local_storage_service.dart';
import 'package:starfish/utils/services/sync_service.dart';
import 'package:starfish/widgets/action_status_widget.dart';
import 'package:starfish/widgets/material_link_button.dart';
import 'package:starfish/widgets/searchbar_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:starfish/wrappers/file_system.dart';
import 'package:starfish/wrappers/platform.dart';
// ignore: implementation_imports
import 'package:template_string/src/extension.dart';

class Me extends StatefulWidget {
  const Me({Key? key}) : super(key: key);

  @override
  _MeState createState() => _MeState();
}

class _MeState extends State<Me> {
  final Key _meFocusDetectorKey = UniqueKey();

  bool _isInitialized = false;

  late AppBloc bloc;
  late AppLocalizations _appLocalizations;

  Dashboard obj = new Dashboard();

  _getActions(AppBloc bloc) async {
    bloc.actionBloc.fetchMyActionsFromDB();
  }

  void _isSyncingFirstTime() async {
    StarfishSharedPreference().isSyncingFirstTimeDone().then((status) => {
          if (!status)
            {
              SyncService().syncAll(),
            }
        });
  }

  @override
  Widget build(BuildContext context) {
    _appLocalizations = AppLocalizations.of(context)!;
    if (!_isInitialized) {
      bloc = Provider.of(context);
      _isInitialized = true;
    }

    return FocusDetector(
      key: _meFocusDetectorKey,
      onFocusGained: () {
        _isSyncingFirstTime();
        _getActions(bloc);
      },
      onFocusLost: () {},
      child: Scrollbar(
        thickness: 5.w,
        isAlwaysShown: false,
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  height: 52.h,
                  margin: EdgeInsets.only(left: 15.w, right: 15.w),
                  decoration: BoxDecoration(
                    color: AppColors.txtFieldBackground,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.r),
                    ),
                  ),
                  child: Center(
                    child: DropdownButtonHideUnderline(
                      child: ButtonTheme(
                        alignedDropdown: true,
                        child: DropdownButton2<ActionFilter>(
                          dropdownMaxHeight: 350.h,
                          offset: Offset(0, -10),
                          isExpanded: true,
                          iconSize: 35,
                          style: TextStyle(
                            color: Color(0xFF434141),
                            fontSize: 19.sp,
                            fontFamily: 'OpenSans',
                          ),
                          hint: Text(
                            bloc.actionBloc.actionFilter.about,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Color(0xFF434141),
                              fontSize: 19.sp,
                              fontFamily: 'OpenSans',
                            ),
                            textAlign: TextAlign.left,
                          ),
                          onChanged: (ActionFilter? value) {
                            setState(() {
                              bloc.actionBloc.actionFilter = value!;
                              _getActions(bloc);
                            });
                          },
                          items: ActionFilter.values
                              .map<DropdownMenuItem<ActionFilter>>(
                                  (ActionFilter value) {
                            return DropdownMenuItem<ActionFilter>(
                              value: value,
                              child: Text(
                                value.about,
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
                SizedBox(height: 10.h),
                SearchBar(
                  initialValue: '',
                  onValueChanged: (value) {
                    setState(() {
                      bloc.actionBloc.query = value;
                      _getActions(bloc);
                    });
                  },
                  onDone: (value) {
                    setState(() {
                      bloc.actionBloc.query = value;
                      _getActions(bloc);
                    });
                  },
                ),
                SizedBox(
                  height: 10.h,
                ),
                actionsList(bloc),
                SizedBox(
                  height: 10.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onActionSelection(HiveAction action) async {
    HiveCurrentUser _currentUser = CurrentUserRepository().getUserSyncFromDB();

    HiveActionUser? hiveActionUser = action.mineAction;

    if (hiveActionUser == null) {
      hiveActionUser = new HiveActionUser();
      hiveActionUser.actionId = action.id!;
      hiveActionUser.userId = _currentUser.id;
      hiveActionUser.status = action.actionStatus.toActionUserStatus().value;
    }

    final _questionController = TextEditingController();
    _questionController.text = hiveActionUser.userResponse ?? '';

    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(34.r),
            topRight: Radius.circular(34.r),
          ),
        ),
        isScrollControlled: true,
        isDismissible: true,
        enableDrag: true,
        builder: (context) {
          final bloc = Provider.of(context);
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setModalState) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.70,
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(34.r)),
                color: Color(0xFFEFEFEF),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      color: Colors.white,
                      margin: EdgeInsets.only(
                        top: 40.h,
                      ),
                      child: Container(
                        //   margin: EdgeInsets.only(left: 15.0.w, right: 15.0.w),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                height: 10.h,
                              ),
                              Center(
                                child: Text(
                                  '${_appLocalizations.month}: ${DateTimeUtils.formatDate(DateTime.now(), 'MMM yyyy')}',
                                  style: TextStyle(
                                      fontSize: 19.sp,
                                      color: Color(0xFF3475F0),
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              SizedBox(
                                height: 40.h,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Expanded(
                                      //height: 44.h,
                                      //width: 169.w,
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          action.name ?? '',
                                          maxLines: 2,
                                          style: TextStyle(
                                              fontSize: 19.sp,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500),
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Image.asset(
                                          'assets/images/hand_right.png',
                                          height: 14.r,
                                          width: 14.r,
                                        ),
                                        SizedBox(
                                          width: 6.w,
                                        ),
                                        ActionStatusWidget(
                                          onTap: (ActionStatus newStatus) {
                                            setModalState(() {
                                              hiveActionUser!.status = newStatus
                                                  .toActionUserStatus()
                                                  .value;
                                            });
                                            setState(
                                                () {}); // To trigger the main view to redraw.
                                            bloc.actionBloc
                                                .createUpdateActionUser(
                                                    hiveActionUser!);
                                          },
                                          actionStatus: action.actionStatus,
                                          height: 36.h,
                                          width: 130.w,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),

                              Padding(
                                padding:
                                    EdgeInsets.only(left: 15.w, right: 15.w),
                                child: Text(
                                  '${_appLocalizations.instructions}: ${action.instructions}',
                                  maxLines: 5,
                                  style: TextStyle(
                                    fontSize: 17.sp,
                                    color: Color(0xFF797979),
                                    fontStyle: FontStyle.italic,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              Container(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 15.w, vertical: 15.h),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            if (action.material != null &&
                                                action.material!.url != null &&
                                                action.material!.url!
                                                    .isNotEmpty &&
                                                !action.material!.isDirty)
                                              MaterialLinkButton(
                                                icon: Icon(
                                                  Icons.open_in_new,
                                                  color: Colors.blue,
                                                  size: 18.r,
                                                ),
                                                text: AppLocalizations.of(
                                                        context)!
                                                    .clickThisLinkToStart,
                                                onButtonTap: () {
                                                  GeneralFunctions.openUrl(
                                                      action.material!.url!);
                                                },
                                              ),
                                            materialList(action)
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: 8.w,
                                      ),
                                      Text(
                                        '${_appLocalizations.due}: ${DateTimeUtils.formatHiveDate(action.dateDue!, requiredDateFormat: 'MMM dd')}',
                                        maxLines: 1,
                                        style: TextStyle(
                                            fontSize: 19.sp,
                                            color: Color(0xFF4F4F4F),
                                            fontWeight: FontWeight.w500),
                                        textAlign: TextAlign.right,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              // Record the response to the Question
                              if (action.type ==
                                      Action_Type.TEXT_RESPONSE.value ||
                                  action.type ==
                                          Action_Type.MATERIAL_RESPONSE.value &&
                                      (action.material != null &&
                                          !action.material!.isDirty))
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Align(
                                        alignment: FractionalOffset.topLeft,
                                        child: Text(
                                          _appLocalizations.question +
                                              ': ${action.question}',
                                          style: TextStyle(
                                            fontSize: 19.sp,
                                            color: Color(0xFF4F4F4F),
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                    TextField(
                                      controller: _questionController,
                                      decoration: InputDecoration(
                                        hintStyle: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 17.sp,
                                          color: Color(0xFF797979),
                                        ),
                                        border: InputBorder.none,
                                        hintText: _appLocalizations
                                            .questionTextEditHint,
                                      ),
                                      onSubmitted: (value) {
                                        hiveActionUser!.userResponse = value;
                                        bloc.actionBloc.createUpdateActionUser(
                                            hiveActionUser);
                                      },
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                          left: 15.w, right: 15.w),
                                      height: 1.0,
                                      color: Color(0xFF3475F0),
                                    ),
                                  ],
                                ),
                              Padding(
                                padding: EdgeInsets.all(15.r),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    _appLocalizations.howWasThisActionText,
                                    maxLines: 1,
                                    style: TextStyle(
                                        fontSize: 19.sp,
                                        color: Color(0xFF4F4F4F),
                                        fontWeight: FontWeight.w500),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.only(left: 15.w, right: 15.w),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      // GOOD
                                      onTap: () {
                                        setModalState(() {
                                          if (ActionUser_Evaluation.valueOf(
                                                  hiveActionUser!
                                                      .evaluation!) ==
                                              ActionUser_Evaluation.GOOD) {
                                            hiveActionUser.evaluation =
                                                ActionUser_Evaluation
                                                    .UNSPECIFIED_EVALUATION
                                                    .value;
                                          } else if (ActionUser_Evaluation
                                                      .valueOf(hiveActionUser
                                                          .evaluation!) ==
                                                  ActionUser_Evaluation
                                                      .UNSPECIFIED_EVALUATION ||
                                              ActionUser_Evaluation.valueOf(
                                                      hiveActionUser
                                                          .evaluation!) ==
                                                  ActionUser_Evaluation.BAD) {
                                            hiveActionUser.evaluation =
                                                ActionUser_Evaluation
                                                    .GOOD.value;
                                          }
                                        });

                                        bloc.actionBloc.createUpdateActionUser(
                                            hiveActionUser!);
                                      },
                                      child: Container(
                                        height: 36.h,
                                        width: 160.w,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(4.r),
                                          color: ActionUser_Evaluation.valueOf(
                                                      hiveActionUser!
                                                          .evaluation!) ==
                                                  ActionUser_Evaluation.GOOD
                                              ? Color(0xFF6DE26B)
                                              : Color(0xFFC9C9C9),
                                        ),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              //Icon(Icons.thumb_up_outlined, size: 14.sp),
                                              Image.asset(
                                                'assets/images/thumbs_up.png',
                                                height: 14.r,
                                                width: 14.r,
                                              ),
                                              SizedBox(
                                                width: 4.w,
                                              ),
                                              Text(
                                                _appLocalizations.goodText,
                                                maxLines: 1,
                                                style: TextStyle(
                                                  fontFamily: 'Rubik',
                                                  fontSize: 17.sp,
                                                  color: Color(0xFF777777),
                                                ),
                                              ),
                                            ]),
                                      ),
                                    ),
                                    InkWell(
                                      // NOT SO GOOD
                                      onTap: () {
                                        setModalState(() {
                                          if (ActionUser_Evaluation.valueOf(
                                                  hiveActionUser!
                                                      .evaluation!) ==
                                              ActionUser_Evaluation.BAD) {
                                            hiveActionUser.evaluation =
                                                ActionUser_Evaluation
                                                    .UNSPECIFIED_EVALUATION
                                                    .value;
                                          } else if (ActionUser_Evaluation
                                                      .valueOf(hiveActionUser
                                                          .evaluation!) ==
                                                  ActionUser_Evaluation
                                                      .UNSPECIFIED_EVALUATION ||
                                              ActionUser_Evaluation.valueOf(
                                                      hiveActionUser
                                                          .evaluation!) ==
                                                  ActionUser_Evaluation.GOOD) {
                                            hiveActionUser.evaluation =
                                                ActionUser_Evaluation.BAD.value;
                                          }
                                        });

                                        bloc.actionBloc.createUpdateActionUser(
                                            hiveActionUser!);
                                      },
                                      child: Container(
                                        height: 36.h,
                                        width: 160.w,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(4.r),
                                          color: ActionUser_Evaluation.valueOf(
                                                      hiveActionUser
                                                          .evaluation!) ==
                                                  ActionUser_Evaluation.BAD
                                              ? Color(0xFFFFBE4A)
                                              : Color(0xFFC9C9C9),
                                        ),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              //Icon(Icons.thumb_down_outlined, size: 14.sp),
                                              Image.asset(
                                                'assets/images/thumbs_down.png',
                                                height: 14.r,
                                                width: 14.r,
                                              ),
                                              SizedBox(
                                                width: 4.w,
                                              ),
                                              Text(
                                                _appLocalizations.notSoGoodText,
                                                maxLines: 1,
                                                style: TextStyle(
                                                  fontFamily: 'Rubik',
                                                  fontSize: 17.sp,
                                                  color: Color(0xFF777777),
                                                ),
                                              ),
                                            ]),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 39.h,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: (WidgetsBinding.instance!.window.viewInsets.bottom >
                            0.0)
                        ? 0.h
                        : 75.h,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Color(0xFFEFEFEF),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 30.w, right: 30.w, top: 19.h, bottom: 19.h),
                      child: Container(
                        height: 37.5.h,
                        color: Color(0xFFEFEFEF),
                        child: ElevatedButton(
                          onPressed: () {
                            hiveActionUser!.userResponse =
                                _questionController.text;
                            bloc.actionBloc
                                .createUpdateActionUser(hiveActionUser)
                                .whenComplete(() {
                              Navigator.pop(context);
                            });
                          },
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40.r),
                              ),
                            ),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                AppColors.selectedButtonBG),
                          ),
                          child: Text(_appLocalizations.close),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          });
        });
  }

  Widget materialList(HiveAction hiveAction) {
    if (hiveAction.material == null ||
        (hiveAction.material != null &&
                hiveAction.material!.files != null &&
                hiveAction.material!.files!.length == 0 ||
            hiveAction.material!.isDirty)) {
      return Container();
    }
    List<Widget> fileLinks = [];
    hiveAction.material!.localFiles.forEach((hiveFile) {
      fileLinks.add(
        MaterialLinkButton(
          icon: Icon(
            Icons.download,
            color: Colors.blue,
            size: 18.r,
          ),
          text: _appLocalizations.clickToDownload
              .insertTemplateValues({'file_name': hiveFile.filename}),
          onButtonTap: () {
            if (Platform.isAndroid) {
              if (hiveFile.filepath != null) {
                openFile(hiveFile.filepath!);
              }
            }
          },
        ),
      );
      fileLinks.add(SizedBox(height: 4.h));
    });

    return Column(
      children: fileLinks,
    );
  }

  Widget actionsList(AppBloc bloc) {
    return StreamBuilder(
        stream: bloc.actionBloc.actionsForMe,
        builder: (BuildContext context,
            AsyncSnapshot<Map<HiveGroup, List<HiveAction>>> snapshot) {
          if (snapshot.hasData) {
            if (!snapshot.hasData) {
              return Container();
            }

            return GroupListView(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              sectionsCount: snapshot.data!.keys.toList().length,
              countOfItemInSection: (int section) {
                return snapshot.data!.values.toList()[section].length;
              },
              itemBuilder: (BuildContext context, IndexPath indexPath) {
                return MyActionListItem(
                  index: indexPath.index,
                  action: snapshot.data!.values.toList()[indexPath.section]
                      [indexPath.index],
                  displayActions:
                      snapshot.data!.keys.elementAt(indexPath.section).id ==
                          null, // Dummy Group i.e. self actions
                  onActionTap: _onActionSelection,
                );
              },
              groupHeaderBuilder: (BuildContext context, int section) {
                return Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${snapshot.data!.keys.toList()[section].name}',
                        style: TextStyle(
                          fontSize: 19.sp,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF434141),
                        ),
                      ),
                      if (snapshot.data!.keys.toList()[section].id != null)
                        Text(
                          '${_appLocalizations.teacher}: ${snapshot.data!.keys.toList()[section].teachersName?.join(", ")}',
                          style: TextStyle(
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF797979),
                          ),
                        ),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) => SizedBox(height: 10.h),
              sectionSeparatorBuilder: (context, section) =>
                  SizedBox(height: 10.h),
            );
          } else {
            return Container(
              color: AppColors.groupScreenBG,
            );
          }
        });
  }
}

/*class MyActionListItem extends StatelessWidget {
  final int index;
  final HiveAction action;
  final bool displayActions;
  final Function(HiveAction action) onActionTap;

  MyActionListItem(
      {required this.action,
      required this.onActionTap,
      required this.index,
      this.displayActions = false});

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);
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
}*/
