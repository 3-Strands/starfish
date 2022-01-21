import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:group_list_view/group_list_view.dart';
import 'package:starfish/bloc/app_bloc.dart';
import 'package:starfish/bloc/provider.dart';
import 'package:starfish/config/routes/routes.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:starfish/constants/assets_path.dart';
import 'package:starfish/constants/text_styles.dart';
import 'package:starfish/db/hive_group.dart';
import 'package:starfish/enums/user_group_role_filter.dart';
import 'package:starfish/db/hive_group_user.dart';
import 'package:starfish/modules/groups_view/add_edit_group_screen.dart';
import 'package:starfish/modules/settings_view/settings_view.dart';
import 'package:starfish/src/generated/starfish.pb.dart';
import 'package:starfish/utils/helpers/alerts.dart';
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
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.70,
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
            height: 80.h,
            width: MediaQuery.of(context).size.width - 10.0,
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      height: 27.h,
                      width: MediaQuery.of(context).size.width - 160.0,
                      child: Text(
                        user.name,
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          color: AppColors.appTitle,
                          fontFamily: 'OpenSans',
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Spacer(),
                    Container(
                      width: 90.w,
                      margin: EdgeInsets.only(right: 0.w),
                      child: Text(
                        user.isActive
                            ? GroupUser_Role.valueOf(user.role!).toString()
                            : user.isInvited
                                ? AppLocalizations.of(context)!
                                    .userStatusInvited
                                    .toUpperCase()
                                : '',
                        textAlign: TextAlign.right,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          color: AppColors.appTitle,
                          fontFamily: 'OpenSans',
                          fontSize: 16.sp,
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
                      fontSize: 16.sp,
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
    return Container(
      margin: EdgeInsets.only(left: 15.0.w, top: 40.h, right: 15.0.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 26.h,
            child: Align(
              alignment: FractionalOffset.topLeft,
              child: Text(
                '${group.name}',
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: AppColors.selectedButtonBG,
                  fontFamily: 'OpenSans',
                  fontSize: 18.sp,
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
          Container(
            height: 75.0,
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
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Color(0xFFADADAD)),
                  ),
                  child: Text(AppLocalizations.of(context)!.close),
                ),
              ),
            ),
          ),
        ],
      ),
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
                          width: 345.w,
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
                                    fontSize: 16.sp,
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
                                          fontSize: 14.sp,
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
                                        horizontal: 10.sp, vertical: 8.sp),
                                    child: Text(
                                      '${snapshot.data!.keys.toList()[section].about}',
                                      style: TextStyle(
                                          fontSize: 16.sp,
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
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      color: AppColors.txtFieldBackground,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              height: 20.sp,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: 150.w,
                    child: Text(
                      '${group.name}',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontFamily: 'OpenSans',
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.txtFieldTextColor,
                      ),
                    ),
                  ),
                  // Spacer(),
                  if (group.currentUserRole! == GroupUser_Role.ADMIN)
                    CustomIconButton(
                      icon: Icon(
                        Icons.edit,
                        color: Colors.blue,
                        size: 18.sp,
                      ),
                      text: AppLocalizations.of(context)!.edit,
                      onButtonTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddEditGroupScreen(
                              group: group,
                            ),
                          ),
                        ).then((value) => FocusScope.of(context)
                            .requestFocus(new FocusNode()));
                      },
                    ),
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
                          fontSize: 12.sp,
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
            SizedBox(height: 10.sp),
            Text(
              '${AppLocalizations.of(context)!.adminNamePrifix}: ${group.adminName}',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.hintTextColor,
              ),
            ),
            SizedBox(height: 20.sp),
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
                      borderRadius: BorderRadius.all(Radius.circular(8.5.sp))),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                    child: Text(
                      AppLocalizations.of(context)!.viewTeachersAndLearners,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontFamily: 'Rubic',
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                ),
              ),
            SizedBox(height: 10.sp),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 51.sp,
                  width: 99.sp,
                  decoration: BoxDecoration(
                      color: Color(0xFF6DE26B),
                      borderRadius: BorderRadius.all(Radius.circular(8.5.sp))),
                  padding:
                      EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                  child: Text(
                    "${group.actionsCompleted} ${AppLocalizations.of(context)!.actionsCompleted}",
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: "Rubik",
                      fontSize: 12.sp,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Spacer(),
                Container(
                  height: 51.sp,
                  width: 99.sp,
                  decoration: BoxDecoration(
                      color: Color(0xFFFFBE4A),
                      borderRadius: BorderRadius.all(Radius.circular(8.5.sp))),
                  padding:
                      EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                  child: Text(
                    "${group.actionsNotDoneYet} ${AppLocalizations.of(context)!.actionsIncompleted}",
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: "Rubik",
                      fontSize: 12.sp,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Spacer(),
                Container(
                  height: 51.sp,
                  width: 99.sp,
                  decoration: BoxDecoration(
                      color: Color(0xFFFF5E4D),
                      borderRadius: BorderRadius.all(Radius.circular(8.5.sp))),
                  padding:
                      EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                  child: Text(
                    "${group.actionsOverdue} ${AppLocalizations.of(context)!.actionsOverdue}",
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: "Rubik",
                      fontSize: 12.sp,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      elevation: 5,
    );
  }
}
