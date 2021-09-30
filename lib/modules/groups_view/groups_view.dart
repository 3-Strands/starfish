import 'package:flutter/material.dart';
import 'package:starfish/bloc/app_bloc.dart';
import 'package:starfish/bloc/provider.dart';
import 'package:starfish/config/routes/routes.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:starfish/constants/strings.dart';
import 'package:starfish/db/hive_group.dart';
import 'package:starfish/db/hive_group_user.dart';
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
  var _groupTitleList = <String>[
    'Groups: All of my groups',
    'Groups: Group I teach or co-lead',
    'Groups: Groups I\'m a learner in',
  ];
  //List<HiveGroup> _groupsList = [];
  //List<HiveGroup> _groupSearchList = [];

  late AppBloc bloc;
  //late Box<HiveGroup> _groupBox;
  late String _choiceText = 'All of my groups';
  late Map<String, List<HiveGroup>> _groups;
  int groupTitleIndex = 0;
  String _query = '';
  //List<HiveGroup> _teacherList = [];
  //List<HiveGroup> _lernerList = [];
  @override
  void initState() {
    super.initState();

    //_groupBox = Hive.box<HiveGroup>(HiveDatabase.GROUP_BOX);

    //_getGroups();
  }

  /*void _getGroups() async {
    _groupsList = _groupBox.values.toList();
    print('_groupsList: ${_groupsList.length}');

    _filterGroups(groupTitleIndex);
    if (_query.isNotEmpty)
      _groupSearchList = _groupsList
          .where((item) =>
              item.name!.toLowerCase().contains(_query.toLowerCase()) &&
              item.name!.toLowerCase().startsWith(_query.toLowerCase()))
          .toList();
    else
      _groupsList = _groupsList;
  }

  void _filterGroups(int index) {
    if (_query.isNotEmpty)
      _groupSearchList = _groupsList
          .where((item) =>
              item.name!.toLowerCase().contains(_query.toLowerCase()) &&
              item.name!.toLowerCase().startsWith(_query.toLowerCase()))
          .toList();
    else
      _groupsList = _groupsList;
    _teacherList = _query.isNotEmpty
        ? _groupSearchList
        : _groupsList; // _teacherList filter will perform here
    _lernerList = _query.isNotEmpty
        ? _groupSearchList
        : _groupsList; // _lernerList filter will perform here
    if (index == 0) {
      _groups = {
        'Groups: Group I teach or co-lead': _teacherList,
        'Groups: Groups I\'m a learner in': _lernerList,
      };
    } else if (index == 1) {
      _groups = {
        'Groups: Group I teach or co-lead': _teacherList,
      };
    } else if (index == 2) {
      _groups = {
        'Groups: Groups I\'m a learner in': _lernerList,
      };
    }
  }*/

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

  // List<GroupListItem> _buildList() {
  //   return _groupsList
  //       .map((group) => new GroupListItem(
  //             group: group,
  //             onGroupTap: _onGroupSelection,
  //           ))
  //       .toList();
  // }

  // List<GroupListItem> _buildSearchList() {
  //   return _groupsList
  //       .map((group) => new GroupListItem(
  //             group: group,
  //             onGroupTap: _onGroupSelection,
  //           ))
  //       .toList();
  // }

  @override
  Widget build(BuildContext context) {
    bloc = Provider.of(context);
    bloc.groupBloc.fetchGroupsFromDB(_query, groupTitleIndex);
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
                  onValueChanged: (value) {
                    print('searched value $value');
                    setState(() {
                      _query = value;
                      //_filterGroups(groupTitleIndex);
                    });
                  },
                  onDone: (value) {
                    print('searched value $value');
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
                        child: DropdownButton<String>(
                          isExpanded: true,
                          // icon: Icon(Icons.arrow_drop_down),
                          iconSize: 35,
                          style: TextStyle(
                            color: Color(0xFF434141),
                            fontSize: 16.sp,
                            fontFamily: 'OpenSans',
                          ),
                          hint: Text(
                            'Groups: ' + _choiceText,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Color(0xFF434141),
                              fontSize: 16.sp,
                              fontFamily: 'OpenSans',
                            ),
                            textAlign: TextAlign.left,
                          ),
                          onChanged: (String? value) {
                            setState(() {
                              _choiceText = value!;
                              groupTitleIndex = _groupTitleList.indexOf(value);
                              //_filterGroups(groupTitleIndex);
                              setState(() {
                                groupTitleIndex =
                                    _groupTitleList.indexOf(value);
                              });
                            });
                          },
                          items: _groupTitleList
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
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
                        AsyncSnapshot<List<HiveGroup>> snapshot) {
                      if (snapshot.hasData) {
                        /*return GroupListView(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: EdgeInsets.only(left: 10.0.w, right: 10.0.w),
                          sectionsCount: _groups.keys.toList().length,
                          countOfItemInSection: (int section) {
                            return snapshot.values.toList()[section].length;
                          },
                          itemBuilder: (BuildContext context, IndexPath index) {
                            return GroupListItem(
                              group: _groups.values.toList()[index.section]
                                  [index.index], //_groupsList[index.index],
                              onGroupTap: _onGroupSelection,
                            );
                          },
                          groupHeaderBuilder:
                              (BuildContext context, int section) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.sp, vertical: 8.sp),
                              child: Text(
                                _groups.keys.toList()[section],
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
                        );*/
                        return ListView(
                          primary: false,
                          shrinkWrap: true,
                          padding: EdgeInsets.only(left: 10.0.w, right: 10.0.w),
                          children: snapshot.data!
                              .map((group) => GroupListItem(
                                  group: group, onGroupTap: _onGroupSelection))
                              .toList(),
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
          //     // ListView(
          //     //   primary: false,
          //     //   shrinkWrap: true,
          //     //   padding: EdgeInsets.only(left: 10.0.w, right: 10.0.w),
          //     //   children: _isSearching ? _buildSearchList() : _buildList(),
          //     // ),
          //     // SizedBox(
          //     //   height: 10.h,
          //     // ),
          //   ],
          // ),
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
                    CustomIconButton(
                      icon: Icon(
                        Icons.edit,
                        color: Colors.blue,
                        size: 18.sp,
                      ),
                      text: Strings.edit,
                      onButtonTap: () {},
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.sp),
              Text(
                'Admin: ${group.admin != null ? group.admin!.userId : 'NA'}',
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
