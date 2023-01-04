import 'package:flutter/material.dart' hide Action;
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:group_list_view/group_list_view.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:starfish/enums/action_filter.dart';
import 'package:starfish/enums/action_status.dart';
import 'package:starfish/modules/actions_view/cubit/actions_cubit.dart';
import 'package:starfish/modules/actions_view/my_action_list_item.dart';
import 'package:starfish/modules/actions_view/single_action_user_view.dart';
import 'package:starfish/repositories/model_wrappers/action_with_assigned_status.dart';
import 'package:starfish/src/grpc_extensions.dart';
import 'package:starfish/utils/currentUser.dart';
import 'package:starfish/widgets/searchbar_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyActionsView extends StatefulWidget {
  const MyActionsView({Key? key}) : super(key: key);

  @override
  _MyActionsViewState createState() => _MyActionsViewState();
}

class _MyActionsViewState extends State<MyActionsView> {
  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  child: BlocBuilder<ActionsCubit, ActionsState>(
                    buildWhen: (previous, current) =>
                        previous.actionFilter != current.actionFilter,
                    builder: (context, state) {
                      return DropdownButton2<ActionFilter>(
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
                          //bloc.actionBloc.actionFilter.about,
                          context.read<ActionsCubit>().state.actionFilter.about,
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
                    },
                  ),
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
            final actionsToShow = state.getMyActionsToShow();
            final groupActionsMap = actionsToShow.groupActionsMap;
            //final hasMore = actionsToShow.hasMore;
            if (groupActionsMap.isEmpty) {
              return Container(
                margin: EdgeInsets.only(left: 15.0.w, right: 15.0.w),
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: Text(
                  '${appLocalizations.noRecordFound}',
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
              sectionsCount: groupActionsMap.length,
              countOfItemInSection: (int section) {
                return groupActionsMap.values.toList()[section].length;
              },
              itemBuilder: (BuildContext context, IndexPath indexPath) {
                final ActionWithAssignedStatus _actionWithAssignedStatus =
                    groupActionsMap.values.toList()[indexPath.section]
                        [indexPath.index];
                return MyActionListItem(
                  index: indexPath.index,
                  actionWithAssignedStatus: _actionWithAssignedStatus,
                  onActionTap: _onActionSelection,
                  displayActions:
                      _actionWithAssignedStatus.action.groupId.isEmpty,
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
                        '${_group.name.isNotEmpty ? _group.name : appLocalizations.selfAssigned}',
                        style: TextStyle(
                          fontSize: 19.sp,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF434141),
                        ),
                      ),
                      if (_group.id.isNotEmpty)
                        Text(
                          '${appLocalizations.teacher}: ${_group.teachersName.join(", ")}',
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
    );
  }

  void _onActionSelection(
      ActionWithAssignedStatus _actionWithAssignedStatus) async {
    final Action _action = _actionWithAssignedStatus.action;
    final ActionStatus _actionStatus =
        _actionWithAssignedStatus.status ?? ActionStatus.NOT_DONE;
    final ActionUser? _actionUser = _actionWithAssignedStatus.actionUser;

    // HiveCurrentUser _currentUser = CurrentUserRepository().getUserSyncFromDB();

    // HiveActionUser? hiveActionUser = action.mineAction;

    // if (hiveActionUser == null) {
    //   hiveActionUser = new HiveActionUser();
    //   hiveActionUser.actionId = action.id!;
    //   hiveActionUser.userId = _currentUser.id;
    //   hiveActionUser.status = action.actionStatus.toActionUserStatus().value;
    // }

    // final _questionController = TextEditingController();
    // _questionController.text = _actionUser?.userResponse ?? '';

    final singleActionUserView = Container(
      height: MediaQuery.of(context).size.height * 0.70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(34.r)),
        color: Color(0xFFEFEFEF),
      ),
      child: SingleActionUser(
        action: _action,
        user: context.currentUser,
        actionStatus: _actionStatus,
        actionUser: _actionUser,
      ),
    );

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
        builder: (BuildContext context) => singleActionUserView);
  }

/*
  Widget actionsList(DataBloc bloc) {
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
                          '${appLocalizations.teacher}: ${snapshot.data!.keys.toList()[section].teachersName?.join(", ")}',
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
*/
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
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
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
                                    appLocalizations.editActionText,
                                    style: TextStyle(
                                        color: Color(0xFF3475F0),
                                        fontSize: 19.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  value: 0,
                                ),
                                PopupMenuItem(
                                  child: Text(
                                    appLocalizations.deleteActionText,
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
                    '${appLocalizations.due}: ${action.dateDue != null && action.hasValidDueDate ? DateTimeUtils.formatHiveDate(action.dateDue!) : "NA"}',
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
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    Alerts.showMessageBox(
        context: context,
        title: appLocalizations.deleteActionTitle,
        message: appLocalizations.deleteActionMessage,
        positiveButtonText: appLocalizations.delete,
        negativeButtonText: appLocalizations.cancel,
        positiveActionCallback: () {
          // Mark this action for deletion
          action.isDirty = true;
          bloc.actionBloc.createUpdateAction(action);
        },
        negativeActionCallback: () {});
  }
}*/
