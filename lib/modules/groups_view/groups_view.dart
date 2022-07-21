// ignore: implementation_imports
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/src/widgets/basic.dart' as widgetsBasic;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:group_list_view/group_list_view.dart';
import 'package:starfish/bloc/data_bloc.dart';
import 'package:starfish/bloc/provider.dart';
import 'package:starfish/config/routes/routes.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:starfish/constants/assets_path.dart';
import 'package:starfish/constants/text_styles.dart';
import 'package:starfish/db/hive_group.dart';
import 'package:starfish/enums/group_user_role.dart';
import 'package:starfish/enums/user_group_role_filter.dart';
import 'package:starfish/db/hive_group_user.dart';
import 'package:starfish/modules/groups_view/group_list_item.dart';
import 'package:starfish/modules/settings_view/settings_view.dart';
import 'package:starfish/src/generated/starfish.pb.dart';
import 'package:starfish/utils/helpers/alerts.dart';
import 'package:starfish/widgets/app_logo_widget.dart';
import 'package:starfish/widgets/last_sync_bottom_widget.dart';
import 'package:starfish/widgets/searchbar_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starfish/widgets/seprator_line_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'group_users_list.dart';

class GroupsScreen extends StatefulWidget {
  GroupsScreen({Key? key, this.title = ''}) : super(key: key);

  final String title;

  @override
  _GroupsScreenState createState() => _GroupsScreenState();
}

class _GroupsScreenState extends State<GroupsScreen> {
  late AppLocalizations appLocalizations;

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
                  Expanded(
                    child: GroupUsersList(users: group.activeUsers!),
                  ),
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
                child: Text(appLocalizations.close),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    appLocalizations = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.groupScreenBG,
      appBar: AppBar(
        title: Container(
          height: 64.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              AppLogo(hight: 36.h, width: 37.w),
              Text(
                appLocalizations.groupsTabItemText,
                style: dashboardNavigationTitle,
              ),
              IconButton(
                icon: SvgPicture.asset(AssetsPath.settings),
                onPressed: () {
                  setState(
                    () {
                      Navigator.pushNamed(
                        context,
                        Routes.settings,
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
      body: Column(
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
                            child: DropdownButton2<UserGroupRoleFilter>(
                              offset: Offset(0, -10),
                              dropdownMaxHeight: 350.h,
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
                                      title: appLocalizations.dialogAlert,
                                      message: appLocalizations
                                          .alertLeaveThisGroup,
                                      negativeButtonText:
                                          appLocalizations.cancel,
                                      positiveButtonText:
                                          appLocalizations.leave,
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
          const LastSyncBottomWidget(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(Routes.createNewGroup);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
