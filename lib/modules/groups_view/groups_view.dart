// ignore: import_of_legacy_library_into_null_safe
import 'package:fbroadcast/fbroadcast.dart';
// ignore: implementation_imports
import 'package:flutter/src/widgets/basic.dart' as widgetsBasic;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:group_list_view/group_list_view.dart';
import 'package:intl/intl.dart';
import 'package:starfish/bloc/app_bloc.dart';
import 'package:starfish/bloc/provider.dart';
import 'package:starfish/config/routes/routes.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:starfish/constants/assets_path.dart';
import 'package:starfish/constants/text_styles.dart';
import 'package:starfish/db/hive_group.dart';
import 'package:starfish/enums/group_user_role.dart';
import 'package:starfish/enums/user_group_role_filter.dart';
import 'package:starfish/db/hive_group_user.dart';
import 'package:starfish/modules/groups_view/add_edit_group_screen.dart';
import 'package:starfish/modules/settings_view/settings_view.dart';
import 'package:starfish/src/generated/starfish.pb.dart';
import 'package:starfish/utils/helpers/alerts.dart';
import 'package:starfish/utils/services/sync_service.dart';
import 'package:starfish/widgets/app_logo_widget.dart';
import 'package:starfish/widgets/custon_icon_button.dart';
import 'package:starfish/widgets/last_sync_bottom_widget.dart';
import 'package:starfish/widgets/searchbar_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starfish/widgets/seprator_line_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GroupsScreen extends StatefulWidget {
  GroupsScreen({Key? key, this.title = ''}) : super(key: key);

  final String title;

  @override
  _GroupsScreenState createState() => _GroupsScreenState();
}

class _GroupsScreenState extends State<GroupsScreen> {
  late AppBloc bloc;

  final Key _groupFocusDetectorKey = UniqueKey();

  @override
  void initState() {
    super.initState();
  }

  void _onGroupSelection(HiveGroup group) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(34.r), topRight: Radius.circular(34.r)),
      ),
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: true,
      builder: (BuildContext context) {
        return widgetsBasic.StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(34.r)),
              color: Color(0xFFEFEFEF),
            ),
            child: _buildSlidingUpPanel(group),
          );
        });
      },
    );
  }

  Widget _buildUsersList(List<HiveGroupUser> users) {
    return Expanded(
      child: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return Container(
            height: 96.h,
            width: MediaQuery.of(context).size.width - 10.0,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Text(
                        user.name,
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          color: AppColors.appTitle,
                          fontFamily: 'OpenSans',
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 10.w),
                      child: Text(
                        user.isActive
                            ? GroupUser_Role.valueOf(user.role!)!.about
                            : user.isInvited
                                ? "${GroupUser_Role.valueOf(user.role!)!.about} " +
                                    AppLocalizations.of(context)!
                                        .userStatusInvited
                                        .toUpperCase()
                                : '',
                        textAlign: TextAlign.right,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          color: AppColors.appTitle,
                          fontFamily: 'OpenSans',
                          fontSize: 19.sp,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Align(
                  alignment: FractionalOffset.topLeft,
                  child: Text(
                    '${user.phoneWithDialingCode}',
                    maxLines: 1,
                    style: TextStyle(
                      color: AppColors.appTitle,
                      fontFamily: 'OpenSans',
                      fontSize: 19.sp,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                SepratorLine(
                  hight: 1.h,
                  edgeInsets: EdgeInsets.only(left: 0.w, right: 0.w),
                ),
                SizedBox(
                  height: 10.h,
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSlidingUpPanel(HiveGroup group) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Container(
            color: Colors.white,
            margin: EdgeInsets.only(
              top: 40.h,
            ),
            child: Container(
              margin: EdgeInsets.only(left: 15.0.w, right: 15.0.w),
              child: Column(
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  Align(
                    alignment: FractionalOffset.topLeft,
                    child: Container(
                      child: Text(
                        '${group.name}',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: AppColors.selectedButtonBG,
                          fontFamily: 'OpenSans',
                          fontSize: 21.5.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 36.h,
                  ),
                  _buildUsersList(group.activeUsers!),
                  SizedBox(
                    height: 20.h,
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          height: 75.0,
          decoration: BoxDecoration(
            color: Color(0xFFEFEFEF),
          ),
          width: MediaQuery.of(context).size.width,
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
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40.r),
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all<Color>(
                      AppColors.selectedButtonBG),
                ),
                child: Text(AppLocalizations.of(context)!.close),
              ),
            ),
          ),
        ),
      ],
    );
  }

  _fetchAllGroupsByRole(AppBloc bloc) async {
    bloc.groupBloc.fetchAllGroupsByRole();
  }

  @override
  Widget build(BuildContext context) {
    bloc = Provider.of(context);

    return FocusDetector(
      key: _groupFocusDetectorKey,
      onFocusGained: () {
        _fetchAllGroupsByRole(bloc);
      },
      onFocusLost: () {},
      child: Scaffold(
        backgroundColor: AppColors.groupScreenBG,
        appBar: AppBar(
          title: Container(
            height: 64.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                AppLogo(hight: 36.h, width: 37.w),
                Text(
                  AppLocalizations.of(context)!.groupsTabItemText,
                  style: dashboardNavigationTitle,
                ),
                IconButton(
                  icon: SvgPicture.asset(AssetsPath.settings),
                  onPressed: () {
                    setState(
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SettingsScreen(),
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
          backgroundColor: AppColors.groupScreenBG,
          elevation: 0.0,
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Column(
            children: [
              Expanded(
                child: Scrollbar(
                  thickness: 5.sp,
                  isAlwaysShown: false,
                  child: SingleChildScrollView(
                    physics: ScrollPhysics(),
                    child: Column(
                      children: <Widget>[
                        SearchBar(
                          initialValue: bloc.groupBloc.query,
                          onValueChanged: (value) {
                            setState(() {
                              bloc.groupBloc.query = value;
                              _fetchAllGroupsByRole(bloc);
                            });
                          },
                          onDone: (value) {
                            setState(() {
                              bloc.groupBloc.query = value;
                              _fetchAllGroupsByRole(bloc);
                            });
                          },
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Container(
                          height: 60.h,
                          // width: 345.w,
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
                                child: DropdownButton<UserGroupRoleFilter>(
                                  isExpanded: true,
                                  iconSize: 35,
                                  style: TextStyle(
                                    color: Color(0xFF434141),
                                    fontSize: 19.sp,
                                    fontFamily: 'OpenSans',
                                  ),
                                  value: bloc.groupBloc.groupRoleFilter,
                                  onChanged: (UserGroupRoleFilter? value) {
                                    setState(() {
                                      bloc.groupBloc.groupRoleFilter = value!;
                                      _fetchAllGroupsByRole(bloc);
                                    });
                                  },
                                  items: UserGroupRoleFilter.values.map<
                                          DropdownMenuItem<
                                              UserGroupRoleFilter>>(
                                      (UserGroupRoleFilter value) {
                                    return DropdownMenuItem<
                                        UserGroupRoleFilter>(
                                      value: value,
                                      child: Text(
                                        value.filterLabel,
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
                          height: 20.h,
                        ),
                        StreamBuilder(
                          stream: bloc.groupBloc.groups,
                          builder: (BuildContext context,
                              AsyncSnapshot<
                                      Map<UserGroupRoleFilter, List<HiveGroup>>>
                                  snapshot) {
                            if (snapshot.hasData) {
                              return GroupListView(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                padding: EdgeInsets.only(
                                    left: 10.0.w, right: 10.0.w),
                                sectionsCount:
                                    snapshot.data!.keys.toList().length,
                                countOfItemInSection: (int section) {
                                  return snapshot.data!.values
                                      .toList()[section]
                                      .length;
                                },
                                itemBuilder: (BuildContext context,
                                    IndexPath indexPath) {
                                  return GroupListItem(
                                    group: snapshot.data!.values
                                            .toList()[indexPath.section]
                                        [indexPath.index],
                                    onGroupTap: _onGroupSelection,
                                    onLeaveGroupTap: (HiveGroup group) {
                                      Alerts.showMessageBox(
                                          context: context,
                                          title: AppLocalizations.of(context)!
                                              .dialogAlert,
                                          message: AppLocalizations.of(context)!
                                              .alertLeaveThisGroup,
                                          negativeButtonText:
                                              AppLocalizations.of(context)!
                                                  .cancel,
                                          positiveButtonText:
                                              AppLocalizations.of(context)!
                                                  .leave,
                                          negativeActionCallback: () {},
                                          positiveActionCallback: () {
                                            bloc.groupBloc.leaveGroup(
                                              group,
                                            );
                                          });
                                    },
                                  );
                                },
                                groupHeaderBuilder:
                                    (BuildContext context, int section) {
                                  return Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10.w, vertical: 8.h),
                                    child: Text(
                                      '${snapshot.data!.keys.toList()[section].about}',
                                      style: TextStyle(
                                          fontSize: 19.sp,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF434141)),
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) =>
                                    SizedBox(height: 10),
                                sectionSeparatorBuilder: (context, section) =>
                                    SizedBox(height: 10),
                              );
                            } else {
                              return Container(
                                color: AppColors.groupScreenBG,
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              LastSyncBottomWidget()
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed(Routes.createNewGroup).then(
                (value) =>
                    FocusScope.of(context).requestFocus(new FocusNode()));
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}

class GroupListItem extends StatelessWidget {
  final HiveGroup group;
  final Function(HiveGroup group) onGroupTap;
  final Function(HiveGroup group) onLeaveGroupTap;

  GroupListItem(
      {required this.group,
      required this.onGroupTap,
      required this.onLeaveGroupTap});

  @override
  Widget build(BuildContext context) {
    int countActionsCompleted = group.actionsCompleted;
    int countActionsNotDoneYet = group.actionsNotDoneYet;
    int countActionsOverdue = group.actionsOverdue;
    bool maintainSize =
        (countActionsCompleted + countActionsNotDoneYet + countActionsOverdue) >
            0;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      color: AppColors.txtFieldBackground,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            IntrinsicHeight(
              //height: 20.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            right: 8.w,
                          ),
                          child: Text(
                            '${group.name}',
                            //overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontFamily: 'OpenSans',
                              fontSize: 17.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.txtFieldTextColor,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Text(
                          '${AppLocalizations.of(context)!.adminNamePrifix}: ${group.adminName}',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontFamily: 'OpenSans',
                            fontSize: 14.5.sp,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF797979),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Spacer(),
                  if (group.currentUserRole! == GroupUser_Role.ADMIN)
                    PopupMenuButton(
                      icon: Icon(
                        Icons.more_vert,
                        color: Color(0xFF3475F0),
                        size: 30,
                      ),
                      color: Colors.white,
                      elevation: 20,
                      shape: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white, width: 2),
                          borderRadius: BorderRadius.circular(12.r)),
                      enabled: true,
                      onSelected: (value) {
                        switch (value) {
                          case 0:
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddEditGroupScreen(
                                  group: group,
                                ),
                              ),
                            ).then((value) => FocusScope.of(context)
                                .requestFocus(new FocusNode()));
                            break;
                          case 1:
                            _deleteGroup(context, group);

                            break;
                        }
                      },
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          child: Text(
                            AppLocalizations.of(context)!.editGroup,
                            style: TextStyle(
                                color: Color(0xFF3475F0),
                                fontSize: 19.sp,
                                fontWeight: FontWeight.bold),
                          ),
                          value: 0,
                        ),
                        PopupMenuItem(
                          child: Text(
                            AppLocalizations.of(context)!.deleteGroup,
                            style: TextStyle(
                                color: Color(0xFF3475F0),
                                fontSize: 19.sp,
                                fontWeight: FontWeight.bold),
                          ),
                          value: 1,
                        ),
                      ],
                    ),

                  // CustomIconButton(
                  //   icon: Icon(
                  //     Icons.edit,
                  //     color: Colors.blue,
                  //     size: 18.r,
                  //   ),
                  //   text: AppLocalizations.of(context)!.edit,
                  //   onButtonTap: () {
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //         builder: (context) => AddEditGroupScreen(
                  //           group: group,
                  //         ),
                  //       ),
                  //     ).then((value) => FocusScope.of(context)
                  //         .requestFocus(new FocusNode()));
                  //   },
                  // ),
                  if (group.currentUserRole! == GroupUser_Role.LEARNER ||
                      group.currentUserRole! == GroupUser_Role.TEACHER)
                    ElevatedButton(
                      onPressed: () {
                        this.onLeaveGroupTap(group);
                      },
                      child: Text(
                        AppLocalizations.of(context)!.leaveThisGroup,
                        style: TextStyle(
                          fontFamily: 'OpenSans',
                          fontSize: 14.5.sp,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      style: ElevatedButton.styleFrom(
                          primary: AppColors.selectedButtonBG,
                          fixedSize: Size(130.w, 20.h)),
                    ),
                ],
              ),
            ),
            SizedBox(height: 10.h),
            // Text(
            //   '${AppLocalizations.of(context)!.adminNamePrifix}: ${group.adminName}',
            //   textAlign: TextAlign.left,
            //   style: TextStyle(
            //     fontFamily: 'OpenSans',
            //     fontSize: 14.5.sp,
            //     fontWeight: FontWeight.w500,
            //     color: Color(0xFF797979),
            //   ),
            // ),
            SizedBox(height: 20.h),
            if (group.currentUserRole == GroupUser_Role.ADMIN ||
                group.currentUserRole == GroupUser_Role.TEACHER)
              InkWell(
                onTap: () {
                  onGroupTap(group);
                },
                child: Container(
                  height: 36.h,
                  width: 326.w,
                  decoration: BoxDecoration(
                      color: Color(0xFFDDDDDD),
                      borderRadius: BorderRadius.all(Radius.circular(8.5.r))),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                    child: Text(
                      AppLocalizations.of(context)!.viewTeachersAndLearners,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontFamily: 'Rubic',
                        fontSize: 14.5.sp,
                      ),
                    ),
                  ),
                ),
              ),
            SizedBox(height: 10.h),
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Visibility(
                    child: InkWell(
                      onTap: () {
                        _navigateToAction(group);
                      },
                      child: Container(
                        width: 99.w,
                        decoration: BoxDecoration(
                            color: Color(0xFF6DE26B),
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.5.r))),
                        padding: EdgeInsets.symmetric(
                            vertical: 10.h, horizontal: 10.w),
                        child: Text(
                          //"${group.actionsCompleted} ${AppLocalizations.of(context)!.actionsCompleted}",
                          Intl.plural(countActionsCompleted,
                              zero:
                                  "$countActionsCompleted ${AppLocalizations.of(context)!.zeroOrOneActionCompleted}",
                              one: "$countActionsCompleted ${AppLocalizations.of(context)!.zeroOrOneActionCompleted}",
                              other: "$countActionsCompleted ${AppLocalizations.of(context)!.moreThenOneActionCompleted}",
                              args: [countActionsCompleted]),
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Rubik",
                            fontSize: 17.sp,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    maintainAnimation: maintainSize,
                    maintainState: maintainSize,
                    maintainSize: maintainSize,
                    visible: countActionsCompleted > 0,
                  ),
                  Spacer(),
                  Visibility(
                    child: InkWell(
                      onTap: () {
                        _navigateToAction(group);
                      },
                      child: Container(
                        width: 99.w,
                        decoration: BoxDecoration(
                            color: Color(0xFFFFBE4A),
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.5.r))),
                        padding: EdgeInsets.symmetric(
                            vertical: 10.h, horizontal: 10.w),
                        child: Text(
                          //"${group.actionsNotDoneYet} ${AppLocalizations.of(context)!.actionsIncompleted}",
                          Intl.plural(countActionsNotDoneYet,
                              zero:
                                  "$countActionsNotDoneYet ${AppLocalizations.of(context)!.zeroOrOneActionsIncompleted}",
                              one: "$countActionsNotDoneYet ${AppLocalizations.of(context)!.zeroOrOneActionsIncompleted}",
                              other: "$countActionsNotDoneYet ${AppLocalizations.of(context)!.moreThenOneActionsIncompleted}",
                              args: [countActionsNotDoneYet]),
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Rubik",
                            fontSize: 17.sp,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    maintainAnimation: maintainSize,
                    maintainState: maintainSize,
                    maintainSize: maintainSize,
                    visible: countActionsNotDoneYet > 0,
                  ),
                  Spacer(),
                  Visibility(
                    child: InkWell(
                      onTap: () {
                        _navigateToAction(group);
                      },
                      child: Container(
                        width: 99.w,
                        decoration: BoxDecoration(
                            color: Color(0xFFFF5E4D),
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.5.r))),
                        padding: EdgeInsets.symmetric(
                            vertical: 10.h, horizontal: 10.w),
                        child: Text(
                          //"${group.actionsOverdue} ${AppLocalizations.of(context)!.actionsOverdue}",
                          Intl.plural(countActionsOverdue,
                              zero:
                                  "$countActionsOverdue ${AppLocalizations.of(context)!.zeroOrOneActionsOverdue}",
                              one: "$countActionsOverdue ${AppLocalizations.of(context)!.zeroOrOneActionsOverdue}",
                              other: "$countActionsOverdue ${AppLocalizations.of(context)!.moreThenOneActionsOverdue}",
                              args: [countActionsOverdue]),
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Rubik",
                            fontSize: 17.sp,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    maintainAnimation: maintainSize,
                    maintainState: maintainSize,
                    maintainSize: maintainSize,
                    visible: countActionsOverdue > 0,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      elevation: 5,
    );
  }

  _deleteGroup(BuildContext context, HiveGroup group) {
    final bloc = Provider.of(context);
    Alerts.showMessageBox(
        context: context,
        title: AppLocalizations.of(context)!.deleteGroupTitle,
        message: AppLocalizations.of(context)!.deleteGroupMessage,
        positiveButtonText: AppLocalizations.of(context)!.delete,
        negativeButtonText: AppLocalizations.of(context)!.cancel,
        positiveActionCallback: () {
          // Mark this group for deletion
          group.status = Group_Status.INACTIVE.value;
          group.isUpdated = true;
          bloc.groupBloc.addEditGroup(group).then((_) {
            // Broadcast to sync the delete Group with the server
            FBroadcast.instance().broadcast(
              SyncService.kUpdateGroup,
            );
          });
        },
        negativeActionCallback: () {});
  }

  _navigateToAction(HiveGroup group) {
    FBroadcast.instance().broadcast(
      "switchToActionTab",
      value: group,
    );
  }
}
