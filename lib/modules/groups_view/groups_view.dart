import 'package:flutter/material.dart';
import 'package:group_list_view/group_list_view.dart';
import 'package:starfish/bloc/app_bloc.dart';
import 'package:starfish/bloc/provider.dart';
import 'package:starfish/config/routes/routes.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:starfish/constants/strings.dart';
import 'package:starfish/db/hive_group.dart';
import 'package:starfish/enums/user_group_role_filter.dart';
import 'package:starfish/db/hive_group_user.dart';
import 'package:starfish/modules/groups_view/add_edit_group_screen.dart';
import 'package:starfish/src/generated/starfish.pb.dart';
import 'package:starfish/widgets/custon_icon_button.dart';
import 'package:starfish/widgets/searchbar_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starfish/widgets/seprator_line_widget.dart';

class GroupsScreen extends StatefulWidget {
  GroupsScreen({Key? key, this.title = ''}) : super(key: key);

  final String title;

  @override
  _GroupsScreenState createState() => _GroupsScreenState();
}

class _GroupsScreenState extends State<GroupsScreen> {
  bool _isSearching = false;

  late AppBloc bloc;
  //int groupTitleIndex = 0;
  //UserGroupRoleFilter _groupRoleFilter = UserGroupRoleFilter.FILTER_ALL;
  //String _query = '';
  @override
  void initState() {
    super.initState();
  }

  void _onGroupSelection(HiveGroup group) {
    print('group.users ==>>');
    print(group);
    print(group.users);
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
        return Container(
          height: MediaQuery.of(context).size.height * 0.70,
          child: SingleChildScrollView(
            child: _buildSlidingUpPanel(group),
          ),
        );
      },
    );
  }

  Widget _buildUsersList(List<HiveGroupUser> users) {
    List<Widget> _users = [];
    users.forEach((user) {
      _users.add(
        Container(
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
                      user.userId!,
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
                      GroupUser_Role.valueOf(user.role!).toString(),
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
                  '+91 1234568709',
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
        ),
      );
    });

    return Container(
      height: 200.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _users,
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
            height: 22.h,
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
            height: 40.h,
          ),
          _buildUsersList(group.users!),
          SizedBox(
            height: 200.h,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 37.5.h,
            color: Color(0xFFEFEFEF),
            child: ElevatedButton(
              onPressed: () {
                //_closeSlidingUpPanelIfOpen();
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
              child: Text(Strings.close),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bloc = Provider.of(context);
    bloc.groupBloc.fetchAllGroupsByRole();
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Container(
          width: 375.w,
          // height: 812.h,
          color: AppColors.groupScreenBG,
          child: SingleChildScrollView(
            physics: ScrollPhysics(),
            child: Column(
              children: <Widget>[
                SearchBar(
                  initialValue: bloc.groupBloc.query,
                  onValueChanged: (value) {
                    setState(() {
                      bloc.groupBloc.setQuery(value);
                    });
                  },
                  onDone: (value) {
                    setState(() {
                      bloc.groupBloc.setQuery(value);
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
                          // icon: Icon(Icons.arrow_drop_down),
                          iconSize: 35,
                          style: TextStyle(
                            color: Color(0xFF434141),
                            fontSize: 16.sp,
                            fontFamily: 'OpenSans',
                          ),
                          value: bloc.groupBloc.groupRoleFilter,
                          onChanged: (UserGroupRoleFilter? value) {
                            setState(() {
                              /*groupTitleIndex =
                                    _groupTitleList.indexOf(value);*/
                              bloc.groupBloc.groupRoleFilter = value!;
                            });
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
                        AsyncSnapshot<Map<UserGroupRoleFilter, List<HiveGroup>>>
                            snapshot) {
                      if (snapshot.hasData) {
                        return GroupListView(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: EdgeInsets.only(left: 10.0.w, right: 10.0.w),
                          sectionsCount: snapshot.data!.keys.toList().length,
                          countOfItemInSection: (int section) {
                            return snapshot.data!.values
                                .toList()[section]
                                .length;
                          },
                          itemBuilder:
                              (BuildContext context, IndexPath indexPath) {
                            return GroupListItem(
                              group: snapshot.data!.values
                                      .toList()[indexPath.section]
                                  [indexPath.index], //_groupsList[index.index],
                              onGroupTap: _onGroupSelection,
                            );
                          },
                          groupHeaderBuilder:
                              (BuildContext context, int section) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.sp, vertical: 8.sp),
                              child: Text(
                                '${snapshot.data!.keys.toList()[section].about}', //${snapshot.data!.keys.toList().elementAt(section)}',
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
                    }),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(Routes.createNewGroup);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class GroupListItem extends StatelessWidget {
  final HiveGroup group;
  final Function(HiveGroup group) onGroupTap;

  GroupListItem({required this.group, required this.onGroupTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      color: AppColors.txtFieldBackground,
      child: InkWell(
        onTap: () {
          print('Group Item Selected');
          onGroupTap(group);
        },
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 20.sp,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 200.w,
                      child: Text(
                        '${group.name}',
                        textAlign: TextAlign.left,
                        style: TextStyle(color: AppColors.txtFieldTextColor),
                      ),
                    ),
                    Spacer(),
                    if (group.currentUserRole! == GroupUser_Role.ADMIN)
                      CustomIconButton(
                        icon: Icon(
                          Icons.edit,
                          color: Colors.blue,
                          size: 18.sp,
                        ),
                        text: Strings.edit,
                        onButtonTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddEditGroupScreen(
                                group: group,
                              ),
                            ),
                          );
                        },
                      ),
                    if (group.currentUserRole! == GroupUser_Role.LEARNER)
                      ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          Strings.leaveThisGroup,
                          style: TextStyle(
                            fontFamily: 'OpenSans',
                            fontSize: 12.sp,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: AppColors.selectedButtonBG,
                        ),
                      ),
                  ],
                ),
              ),
              SizedBox(height: 10.sp),
              Text(
                '${Strings.adminNamePrifix}: ${group.adminName}',
                textAlign: TextAlign.left,
              ),
              SizedBox(height: 20.sp),
              Container(
                height: 36.h,
                width: 326.w,
                // margin: EdgeInsets.symmetric(horizontal: 10.sp),
                decoration: BoxDecoration(
                    color: Color(0xFFDDDDDD),
                    borderRadius: BorderRadius.all(Radius.circular(8.5.sp))),
                child: Center(
                  child: Text(
                    'View Teachers and Learners',
                    textAlign: TextAlign.center,
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
                        color: Color(0xFFFFBE4A),
                        borderRadius:
                            BorderRadius.all(Radius.circular(8.5.sp))),
                  ),
                  Spacer(),
                  Container(
                    height: 51.sp,
                    width: 99.sp,
                    decoration: BoxDecoration(
                        color: Color(0xFFFF5E4D),
                        borderRadius:
                            BorderRadius.all(Radius.circular(8.5.sp))),
                  ),
                  Spacer(),
                  Container(
                    height: 51.sp,
                    width: 99.sp,
                    decoration: BoxDecoration(
                        color: Color(0xFF6DE26B),
                        borderRadius:
                            BorderRadius.all(Radius.circular(8.5.sp))),
                  )
                ],
              )
            ],
          ),
        ),
      ),
      elevation: 5,
    );
  }
}
