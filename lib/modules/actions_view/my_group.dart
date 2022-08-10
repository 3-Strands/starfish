import 'package:flutter/material.dart' hide Action;
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:group_list_view/group_list_view.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:starfish/enums/action_filter.dart';
import 'package:starfish/models/file_reference.dart';
import 'package:starfish/modules/actions_view/cubit/actions_cubit.dart';
import 'package:starfish/modules/actions_view/my_group_action_list_item.dart';
import 'package:starfish/repositories/model_wrappers/action_group_user_with_status.dart';
import 'package:starfish/repositories/model_wrappers/action_with_assigned_status.dart';
import 'package:starfish/repositories/model_wrappers/user_with_action-status.dart';
import 'package:starfish/src/grpc_extensions.dart';
import 'package:starfish/utils/date_time_utils.dart';
import 'package:starfish/utils/helpers/general_functions.dart';
import 'package:starfish/widgets/material_link_button.dart';
import 'package:starfish/widgets/searchbar_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:starfish/widgets/user_action_status_widget.dart';
import 'package:template_string/template_string.dart';

class MyGroupActionsView extends StatefulWidget {
  const MyGroupActionsView({Key? key}) : super(key: key);

  @override
  _MyGroupViewState createState() => _MyGroupViewState();
}

class _MyGroupViewState extends State<MyGroupActionsView> {
  late AppLocalizations _appLocalizations;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _appLocalizations = AppLocalizations.of(context)!;

    return Scrollbar(
      thickness: 5.w,
      thumbVisibility: false,
      child: SingleChildScrollView(
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
                  Radius.circular(10),
                ),
              ),
              child: Center(
                child: DropdownButtonHideUnderline(
                  child: ButtonTheme(
                    alignedDropdown: true,
                    child: BlocBuilder<ActionsCubit, ActionsState>(
                        buildWhen: (previous, current) =>
                            previous.actionFilter != current.actionFilter,
                        builder: (context, state) {
                          return DropdownButton2<ActionFilter>(
                            isExpanded: true,
                            offset: Offset(0, -10),
                            dropdownMaxHeight: 350.h,

                            // icon: Icon(Icons.arrow_drop_down),
                            iconSize: 35,
                            style: TextStyle(
                              color: Color(0xFF434141),
                              fontSize: 19.sp,
                              fontFamily: 'OpenSans',
                            ),
                            hint: Text(
                              //bloc.actionBloc.actionFilter.about,
                              context
                                  .read<ActionsCubit>()
                                  .state
                                  .actionFilter
                                  .about,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Color(0xFF434141),
                                fontSize: 19.sp,
                                fontFamily: 'OpenSans',
                              ),
                              textAlign: TextAlign.left,
                            ),
                            onChanged: (ActionFilter? actionFilter) {
                              if (actionFilter == null) {
                                return;
                              }
                              context
                                  .read<ActionsCubit>()
                                  .updateActionFilter(actionFilter);
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
                          );
                        }),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.h),
            SearchBar(
              initialValue: '',
              onValueChanged: (query) {
                context.read<ActionsCubit>().updateQuery(query);
              },
              // TODO: This is actually unnecessary, since we update the query on every change.
              onDone: (_) {},
            ),
            SizedBox(
              height: 10.h,
            ),
            //actionsList(bloc),
            BlocBuilder<ActionsCubit, ActionsState>(builder: (context, state) {
              final actionsToShow = state.actionsToShow;
              final groupActionsMap = actionsToShow.groupActionsMap;
              //final hasMore = actionsToShow.hasMore;
              if (groupActionsMap.isEmpty) {
                return Container(
                  margin: EdgeInsets.only(left: 15.0.w, right: 15.0.w),
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  child: Text(
                    '${_appLocalizations.noRecordFound}',
                    style: TextStyle(
                      color: Color(0xFF434141),
                      fontSize: 17.sp,
                      fontFamily: 'OpenSans',
                    ),
                  ),
                );
              }
              return GroupListView(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                sectionsCount: groupActionsMap.keys.toList().length,
                countOfItemInSection: (int section) {
                  return groupActionsMap.values.toList()[section].length;
                },
                itemBuilder: (BuildContext context, IndexPath indexPath) {
                  ActionWithAssignedStatus _actionWithAssignedStatus =
                      groupActionsMap.values.toList()[indexPath.section]
                          [indexPath.index];
                  return MyGroupActionListItem(
                    index: indexPath.index,
                    actionWithAssignedStatus: _actionWithAssignedStatus,
                    onActionTap: _usersActionList,
                    //actionStatus: materialWithStatus.status,
                  );
                },
                groupHeaderBuilder: (BuildContext context, int section) {
                  Group _group = groupActionsMap.keys.toList()[section];
                  return Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${_group.name}',
                          style: TextStyle(
                            fontSize: 19.sp,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF434141),
                          ),
                        ),
                        Text(
                          '${_appLocalizations.teacher}: ${_group.teachersName.join(", ")}',
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
            }),
            SizedBox(
              height: 10.h,
            ),
          ],
        ),
      ),
    );
  }

  void _usersActionList(
      Action action, ActionGroupUserWithStatus actionGrouUsersWithStatus) {
    print(
        "${action.name} => ${actionGrouUsersWithStatus.group.learners.length}");
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
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(34.r)),
            color: Color(0xFFEFEFEF),
          ),
          child: Container(
            color: Colors.white,
            margin: EdgeInsets.only(
              top: 40.h,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  margin: EdgeInsets.only(left: 15.w, right: 15.w),
                  child: Align(
                    alignment: FractionalOffset.topLeft,
                    child: Text(
                      action.name,
                      style: TextStyle(
                          fontSize: 19.sp,
                          color: Color(0xFF3475F0),
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  margin: EdgeInsets.only(left: 15.w, right: 15.w),
                  child: Align(
                    alignment: FractionalOffset.topLeft,
                    child: Text(
                      _appLocalizations.statusOfActionForLearner,
                      style: TextStyle(
                          fontSize: 19.sp,
                          color: Color(0xFF4F4F4F),
                          fontWeight: FontWeight.normal),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                _buildUserList(action, actionGrouUsersWithStatus),
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  height: 75.0,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Color(0xFFEFEFEF),
                  ),
                  //margin: EdgeInsets.only(left: 15.w, right: 15.w),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 30.0, right: 30.0, top: 19.0, bottom: 19.0),
                    child: Container(
                      height: 37.5.h,
                      color: Color(0xFFEFEFEF),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
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
          ),
        );
      },
    );
  }

/*  Widget actionsList(DataBloc bloc) {
    return StreamBuilder(
        stream: bloc.actionBloc.actionsForGroup,
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
                return MyGroupActionListItem(
                  action: snapshot.data!.values.toList()[indexPath.section]
                      [indexPath.index],
                  onActionTap: _usersActionList,
                  index: indexPath.index,
                );
              },
              groupHeaderBuilder: (BuildContext context, int section) {
                final _globalKey = GlobalKey();
                _groupItemKeys[snapshot.data!.keys.toList()[section].id!] =
                    _globalKey;
                return Padding(
                  key: _globalKey,
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
              separatorBuilder: (context, index) => SizedBox(height: 10),
              sectionSeparatorBuilder: (context, section) =>
                  SizedBox(height: 10),
            );
          } else {
            return Container(
              color: AppColors.groupScreenBG,
            );
          }
        });
  }
*/
  Widget _buildUserList(
      Action action, ActionGroupUserWithStatus actionGrouUsersWithStatus) {
    final List<UserWithActionStatus> _usersWithActionStatus =
        actionGrouUsersWithStatus.userWithActionStatus;
    if (_usersWithActionStatus.isEmpty) {
      return Container();
    }

    return Container(
      height: 300.h,
      child: ListView.builder(
        itemCount: _usersWithActionStatus.length,
        itemBuilder: (context, index) {
          final _userWithActionStatus = _usersWithActionStatus[index];
          return ListTile(
            title: Row(
              children: [
                Expanded(
                  child: Text(
                    _userWithActionStatus.user.name,
                    style: TextStyle(
                      color: AppColors.txtFieldTextColor,
                      fontFamily: 'OpenSans',
                      fontSize: 19.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(width: 10.w),
                UserActionStatusWidget(
                  title: _userWithActionStatus.actionStatus,
                  height: 20.h,
                  width: 100.w,
                ),
              ],
            ),
            trailing: Wrap(
              children: <Widget>[
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: AppColors.selectedButtonBG,
                ),
              ],
            ),
            onTap: () {
              Navigator.pop(context);
              _onActionSelection(action, _userWithActionStatus);
            },
          );
        },
      ),
    );
  }

  void _onActionSelection(
      Action action, UserWithActionStatus userWithActionStatus) {
    final User _user = userWithActionStatus.user;
    final ActionUser? _actionUser = userWithActionStatus.actionUser;

    final _questionController = TextEditingController();
    _questionController.text = _actionUser?.teacherResponse ?? '';

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
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setModalState) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.80,
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(34.r)),
              color: Color(0xFFEFEFEF),
            ),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Container(
                    color: Colors.white,
                    margin: EdgeInsets.only(
                      top: 40.h,
                    ),
                    child: Container(
                      // margin: EdgeInsets.only(left: 15.0.w, right: 15.0.w),
                      child: SingleChildScrollView(
                        //  physics: AlwaysScrollableScrollPhysics(),
                        child: Column(
                          //   mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
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
                              height: 10.h,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15.w, vertical: 15.h),
                              child: Text(
                                action.name,
                                style: TextStyle(
                                    fontSize: 19.sp,
                                    color: Color(0xFF3475F0),
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15.w, vertical: 15.h),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 169.w,
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        _user.name,
                                        maxLines: 2,
                                        style: TextStyle(
                                          fontSize: 24.sp,
                                          color: AppColors.appTitle,
                                          fontWeight: FontWeight.w500,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 44.h,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          'assets/images/hand_right.png',
                                          height: 14.h,
                                          width: 14.w,
                                        ),
                                        SizedBox(
                                          width: 4.w,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            // setModalState(() {
                                            //   if (user.actionStatusbyId(
                                            //               action) ==
                                            //           ActionStatus.NOT_DONE ||
                                            //       user.actionStatusbyId(
                                            //               action) ==
                                            //           ActionStatus.OVERDUE) {
                                            //     hiveActionUser!.status =
                                            //         ActionUser_Status
                                            //             .COMPLETE.value;
                                            //   } else if (user.actionStatusbyId(
                                            //           action) ==
                                            //       ActionStatus.DONE) {
                                            //     hiveActionUser!.status =
                                            //         ActionUser_Status
                                            //             .INCOMPLETE.value;
                                            //   } else {
                                            //     hiveActionUser!.status =
                                            //         ActionUser_Status
                                            //             .UNSPECIFIED_STATUS
                                            //             .value;
                                            //   }
                                            // });
                                            // setState(
                                            //     () {}); // To trigger the main view to redraw.
                                            // bloc.actionBloc
                                            //     .createUpdateActionUser(
                                            //         hiveActionUser!);

                                            // TODO: should we update the status of this action on HiveUser also????
                                          },
                                          child: UserActionStatusWidget(
                                            title: userWithActionStatus
                                                .actionStatus,
                                            height: 36.h,
                                            width: 130.w,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 15.0, right: 15.0),
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
                            /*Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        '${_appLocalizations.due}: ${DateTimeUtils.formatHiveDate(action.dateDue!, requiredDateFormat: 'MMM dd, yyyy')}',
                        maxLines: 1,
                        style: TextStyle(
                            fontSize: 19.sp,
                            color: Color(0xFF4F4F4F),
                            fontWeight: FontWeight.w500),
                        textAlign: TextAlign.right,
                      ),
                  ),
              ),*/
                            Container(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15.w, vertical: 15.h),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          if (action.material != null &&
                                              action.material!.url.isNotEmpty)
                                            MaterialLinkButton(
                                              icon: Icon(
                                                Icons.open_in_new,
                                                color: Colors.blue,
                                                size: 18.r,
                                              ),
                                              text: _appLocalizations
                                                  .clickThisLinkToStart,
                                              onButtonTap: () {
                                                GeneralFunctions.openUrl(
                                                    action.material!.url);
                                              },
                                            ),
                                          materialList(action)
                                        ],
                                      ),
                                    ),
                                    Text(
                                      '${_appLocalizations.due}: ${DateTimeUtils.formatHiveDate(action.dateDue, requiredDateFormat: 'MMM dd')}',
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
                            // Record the response to the question
                            if (action.type == Action_Type.TEXT_RESPONSE ||
                                action.type == Action_Type.MATERIAL_RESPONSE &&
                                    (action.material != null))
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                      // setModalState(() {
                                      //   hiveActionUser!.teacherResponse = value;
                                      // });
                                      // bloc.actionBloc.createUpdateActionUser(
                                      //     hiveActionUser!);
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
                              padding: const EdgeInsets.all(15.0),
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
                              padding: const EdgeInsets.only(
                                  left: 15.0, right: 15.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      // setModalState(() {
                                      //   if (ActionUser_Evaluation.valueOf(
                                      //           hiveActionUser!.evaluation!) ==
                                      //       ActionUser_Evaluation.GOOD) {
                                      //     hiveActionUser.evaluation =
                                      //         ActionUser_Evaluation
                                      //             .UNSPECIFIED_EVALUATION.value;
                                      //   } else if (ActionUser_Evaluation
                                      //               .valueOf(hiveActionUser
                                      //                   .evaluation!) ==
                                      //           ActionUser_Evaluation
                                      //               .UNSPECIFIED_EVALUATION ||
                                      //       ActionUser_Evaluation.valueOf(
                                      //               hiveActionUser
                                      //                   .evaluation!) ==
                                      //           ActionUser_Evaluation.BAD) {
                                      //     hiveActionUser.evaluation =
                                      //         ActionUser_Evaluation.GOOD.value;
                                      //   }
                                      // });

                                      // bloc.actionBloc.createUpdateActionUser(
                                      //     hiveActionUser!);
                                    },
                                    child: Container(
                                      height: 36.h,
                                      width: 160.w,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(4.r),
                                        color: _actionUser?.evaluation ==
                                                ActionUser_Evaluation.GOOD
                                            ? Color(0xFF6DE26B)
                                            : Color(0xFFC9C9C9),
                                      ),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              'assets/images/thumbs_up.png',
                                              height: 14.h,
                                              width: 14.w,
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
                                    onTap: () {
                                      // setModalState(() {
                                      //   if (ActionUser_Evaluation.valueOf(
                                      //           hiveActionUser!.evaluation!) ==
                                      //       ActionUser_Evaluation.BAD) {
                                      //     hiveActionUser.evaluation =
                                      //         ActionUser_Evaluation
                                      //             .UNSPECIFIED_EVALUATION.value;
                                      //   } else if (ActionUser_Evaluation
                                      //               .valueOf(hiveActionUser
                                      //                   .evaluation!) ==
                                      //           ActionUser_Evaluation
                                      //               .UNSPECIFIED_EVALUATION ||
                                      //       ActionUser_Evaluation.valueOf(
                                      //               hiveActionUser
                                      //                   .evaluation!) ==
                                      //           ActionUser_Evaluation.GOOD) {
                                      //     hiveActionUser.evaluation =
                                      //         ActionUser_Evaluation.BAD.value;
                                      //   }
                                      // });

                                      // bloc.actionBloc.createUpdateActionUser(
                                      //     hiveActionUser!);
                                    },
                                    child: Container(
                                      height: 36.h,
                                      width: 160.w,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(4.r),
                                        color: _actionUser?.evaluation ==
                                                ActionUser_Evaluation.BAD
                                            ? Color(0xFFFFBE4A)
                                            : Color(0xFFC9C9C9),
                                      ),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              'assets/images/thumbs_down.png',
                                              height: 14.h,
                                              width: 14.w,
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
                  height:
                      //  (WidgetsBinding.instance!.window.viewInsets.bottom >
                      //         0.0)
                      //     ? 0.h
                      // :
                      75.0,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Color(0xFFEFEFEF),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 30.0, right: 30.0, top: 19.0, bottom: 19.0),
                    child: Container(
                      height: 37.5.h,
                      color: Color(0xFFEFEFEF),
                      child: ElevatedButton(
                        onPressed: () {
                          // hiveActionUser!.teacherResponse =
                          //     _questionController.text;
                          // bloc.actionBloc
                          //     .createUpdateActionUser(hiveActionUser)
                          //     .whenComplete(() {
                          Navigator.pop(context);
                          // });
                        },
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
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
      },
    );
  }

  Widget materialList(Action action) {
    if (action.material == null ||
        (action.material != null && action.material!.fileReferences.isEmpty)) {
      return Container();
    }
    List<Widget> fileLinks = [];
    action.material!.fileReferences.forEach((fileReference) {
      fileLinks.add(
        MaterialLinkButton(
          icon: Icon(
            Icons.download,
            color: Colors.blue,
            size: 18.r,
          ),
          text: _appLocalizations.clickToDownload
              .insertTemplateValues({'file_name': fileReference.filename}),
          onButtonTap: () async {
            try {
              await GeneralFunctions.openFile(fileReference, context);
            } on NetworkUnavailableException {
              // TODO: show message to user
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
}

/*
class MyGroupActionListItem extends StatelessWidget {
  final HiveAction action;
  final index;
  final Function(HiveAction action) onActionTap;

  MyGroupActionListItem(
      {Key? key, required this.action, required this.onActionTap, this.index});

  @override
  Widget build(BuildContext context) {
    AppLocalizations _appLocalizations = AppLocalizations.of(context)!;

    int countActionStatusDone =
        action.memberCountByActionStatus(ActionStatus.DONE);
    int countActionStatusNotDone =
        action.memberCountByActionStatus(ActionStatus.NOT_DONE);
    int countActionStatusOverdue =
        action.memberCountByActionStatus(ActionStatus.OVERDUE);

    bool maintainSize = (countActionStatusDone +
            countActionStatusNotDone +
            countActionStatusOverdue) >
        0;

    int _thumbsUp = action.learnerCountByEvaluation(ActionUser_Evaluation.GOOD);
    int _thumbsDown =
        action.learnerCountByEvaluation(ActionUser_Evaluation.BAD);
    int _totalLearners =
        (action.learners != null && action.learners!.length > 0)
            ? action.learners!.length
            : 1;

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
                        padding: EdgeInsets.only(left: 8.0, right: 8),
                        child: Text(
                          action.name ?? '',
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
                      child: PopupMenuButton(
                          icon: Icon(
                            Icons.more_vert,
                            color: Color(0xFF3475F0),
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
                              ]),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      width: 8.w,
                    ),
                    Visibility(
                      child: Container(
                        width: 99.w,
                        decoration: BoxDecoration(
                          color: Color(0xFF6DE26B),
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.5.r),
                          ),
                        ),
                        padding: EdgeInsets.symmetric(
                            vertical: 10.h, horizontal: 6.w),
                        child: Text(
                          Intl.plural(countActionStatusDone,
                              zero:
                                  "$countActionStatusDone ${_appLocalizations.zeroOrOneMemberDidIt}",
                              one: "$countActionStatusDone ${_appLocalizations.zeroOrOneMemberDidIt}",
                              other: "$countActionStatusDone ${_appLocalizations.moreThenOneMembersDidIt}",
                              args: [countActionStatusDone]),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Rubik",
                            fontSize: 17.sp,
                          ),
                        ),
                      ),
                      maintainAnimation: maintainSize,
                      maintainState: maintainSize,
                      maintainSize: maintainSize,
                      visible: countActionStatusDone > 0,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Visibility(
                        child: Container(
                          width: 99.w,
                          decoration: BoxDecoration(
                            color: Color(0xFFFFBE4A),
                            borderRadius: BorderRadius.all(
                              Radius.circular(8.5.r),
                            ),
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: 10.h, horizontal: 6.w),
                          child: Text(
                            Intl.plural(countActionStatusNotDone,
                                zero:
                                    "$countActionStatusNotDone ${_appLocalizations.zeroOrOneMemberDidNotDoItYet}",
                                one: "$countActionStatusNotDone ${_appLocalizations.zeroOrOneMemberDidNotDoItYet}",
                                other: "$countActionStatusNotDone ${_appLocalizations.moreThenOneMembersDidNotDoItYet}",
                                args: [countActionStatusNotDone]),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Rubik",
                              fontSize: 17.sp,
                            ),
                          ),
                        ),
                        maintainAnimation: maintainSize,
                        maintainState: maintainSize,
                        maintainSize: maintainSize,
                        visible: countActionStatusNotDone > 0),
                    SizedBox(
                      width: 10.w,
                    ),
                    Visibility(
                      child: Container(
                        width: 99.w,
                        decoration: BoxDecoration(
                          color: Color(0xFFFF5E4D),
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.5.r),
                          ),
                        ),
                        padding: EdgeInsets.symmetric(
                            vertical: 10.h, horizontal: 6.w),
                        child: Text(
                          Intl.plural(countActionStatusOverdue,
                              zero:
                                  "$countActionStatusOverdue ${_appLocalizations.zeroOrOneMemberIsOverdue}",
                              one: "$countActionStatusOverdue ${_appLocalizations.zeroOrOneMemberIsOverdue}",
                              other: "$countActionStatusOverdue ${_appLocalizations.moreThenOneMembersIsOverdue}",
                              args: [countActionStatusOverdue]),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Rubik",
                            fontSize: 17.sp,
                          ),
                        ),
                      ),
                      maintainAnimation: maintainSize,
                      maintainState: maintainSize,
                      maintainSize: maintainSize,
                      visible: countActionStatusOverdue > 0,
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 5.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _appLocalizations.voteByLearners
                              .insertTemplateValues({
                            'votes':
                                ((_thumbsUp / _totalLearners) * 100).round()
                          }),
                          style: TextStyle(
                            fontFamily: 'OpenSans',
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF000000),
                          ),
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        SvgPicture.asset(
                          'assets/images/thumbs_up_solid.svg',
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          _appLocalizations.voteByLearners
                              .insertTemplateValues({
                            'votes':
                                ((_thumbsDown / _totalLearners) * 100).round()
                          }),
                          style: TextStyle(
                            textBaseline: TextBaseline.ideographic,
                            fontFamily: 'OpenSans',
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF000000),
                          ),
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        SvgPicture.asset(
                          'assets/images/thumbs_down_solid.svg',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                  child: Text(
                    '${_appLocalizations.due}: ${action.dateDue != null && action.hasValidDueDate ? DateTimeUtils.formatHiveDate(action.dateDue!) : "NA"}',
                    style: TextStyle(
                      color: Color(0xFF797979),
                      fontSize: 19.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
              ),
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
