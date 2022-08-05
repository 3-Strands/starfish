import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:group_list_view/group_list_view.dart';
import 'package:starfish/config/routes/routes.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:starfish/constants/assets_path.dart';
import 'package:starfish/constants/text_styles.dart';
import 'package:starfish/enums/user_group_role_filter.dart';
import 'package:starfish/modules/groups_view/cubit/groups_cubit.dart';
import 'package:starfish/modules/groups_view/group_list_item.dart';
import 'package:starfish/repositories/data_repository.dart';
import 'package:starfish/src/generated/starfish.pb.dart';
import 'package:starfish/utils/helpers/alerts.dart';
import 'package:starfish/widgets/app_logo_widget.dart';
import 'package:starfish/widgets/last_sync_bottom_widget.dart';
import 'package:starfish/widgets/searchbar_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'group_users_list.dart';

class Groups extends StatelessWidget {
  const Groups({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GroupsCubit(context.read<DataRepository>()),
      child: const GroupsView(),
    );
  }
}

class GroupsView extends StatefulWidget {
  const GroupsView({Key? key}) : super(key: key);

  @override
  _GroupsViewState createState() => _GroupsViewState();
}

class _GroupsViewState extends State<GroupsView> {
  late AppLocalizations appLocalizations;

  @override
  void initState() {
    super.initState();
  }

  void _onGroupSelection(Group group) {
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
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.70,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 15.0.w, vertical: 40.h),
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
              Expanded(
                child: GroupUsersList(users: group.users),
              ),
              Container(
                height: 75.0,
                decoration: BoxDecoration(
                  color: Color(0xFFEFEFEF),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30.0, vertical: 19.0),
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
                      child: Text(appLocalizations.close),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    appLocalizations = AppLocalizations.of(context)!;
    final groupsCubit = context.read<GroupsCubit>();

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
                  Navigator.pushNamed(
                    context,
                    Routes.settings,
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
              thumbVisibility: false,
              child: ListView(
                physics: ScrollPhysics(),
                children: <Widget>[
                  SearchBar(
                    initialValue: "",
                    onValueChanged: groupsCubit.queryChanged,
                    // TODO: This is actually unnecessary, since we update the query on every change.
                    onDone: (_) {},
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
                          child: BlocBuilder<GroupsCubit, GroupsState>(
                            builder: (context, state) {
                              return DropdownButton2<UserGroupRoleFilter>(
                                offset: Offset(0, -10),
                                dropdownMaxHeight: 350.h,
                                isExpanded: true,
                                iconSize: 35,
                                style: TextStyle(
                                  color: Color(0xFF434141),
                                  fontSize: 19.sp,
                                  fontFamily: 'OpenSans',
                                ),
                                value: state.userRoleFilter,
                                onChanged: (UserGroupRoleFilter? value) {
                                  if (value != null) {
                                    context
                                        .read<GroupsCubit>()
                                        .userRoleFilterChanged(value);
                                  }
                                },
                                items: UserGroupRoleFilter.values
                                    .map<DropdownMenuItem<UserGroupRoleFilter>>(
                                        (UserGroupRoleFilter value) {
                                  return DropdownMenuItem<UserGroupRoleFilter>(
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
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  BlocBuilder<GroupsCubit, GroupsState>(
                    builder: (context, state) {
                      final map = state.groupsToShow;
                      final keys = map.keys.toList();
                      final sections = map.values.toList();

                      return GroupListView(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        padding: EdgeInsets.only(left: 10.0.w, right: 10.0.w),
                        sectionsCount: keys.length,
                        countOfItemInSection: (int section) =>
                            sections[section].length,
                        itemBuilder: (context, indexPath) {
                          return GroupListItem(
                            groupPlus: sections[indexPath.section]
                                [indexPath.index],
                            onGroupTap: _onGroupSelection,
                            onLeaveGroupTap: (Group group) {
                              Alerts.showMessageBox(
                                  context: context,
                                  title: appLocalizations.dialogAlert,
                                  message: appLocalizations.alertLeaveThisGroup,
                                  negativeButtonText: appLocalizations.cancel,
                                  positiveButtonText: appLocalizations.leave,
                                  negativeActionCallback: () {},
                                  positiveActionCallback: () {
                                    context
                                        .read<GroupsCubit>()
                                        .leaveGroupRequested(group);
                                  });
                            },
                          );
                        },
                        groupHeaderBuilder: (context, section) {
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.w, vertical: 8.h),
                            child: Text(
                              keys[section].about,
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
                    },
                  ),
                ],
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
