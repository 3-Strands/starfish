import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:starfish/constants/strings.dart';
import 'package:starfish/db/hive_current_user.dart';
import 'package:starfish/db/hive_database.dart';
import 'package:starfish/db/hive_group.dart';
import 'package:starfish/widgets/custon_icon_button.dart';
import 'package:starfish/widgets/searchbar_widget.dart';
import 'package:starfish/widgets/title_label_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GroupsScreen extends StatefulWidget {
  GroupsScreen({Key? key, this.title = ''}) : super(key: key);

  final String title;

  @override
  _GroupsScreenState createState() => _GroupsScreenState();
}

class _GroupsScreenState extends State<GroupsScreen> {
  bool _isSearching = false;

  List<HiveGroup> _groupsList = [];

  late Box<HiveCurrentUser> _userBox;

  @override
  void initState() {
    super.initState();

    _userBox = Hive.box<HiveCurrentUser>(HiveDatabase.CURRENT_USER_BOX);

    _getGroups();
  }

  void _getGroups() async {
    /*
    Temprory get the groups of the current users
    */
    _groupsList = _userBox.values.toList()[0].groups;
  }

  void _onGroupSelection(HiveGroup material) {
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
            child: _buildSlidingUpPanel(material),
          ),
        );
      },
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  '${group.groupId}',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: AppColors.txtFieldTextColor,
                    fontFamily: 'OpenSans',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 200.h,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
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
              child: Text('Close'),
            ),
          ),
        ],
      ),
    );
  }

  List<GroupListItem> _buildList() {
    return _groupsList
        .map((group) => new GroupListItem(
              group: group,
              onGroupTap: _onGroupSelection,
            ))
        .toList();
  }

  List<GroupListItem> _buildSearchList() {
    return _groupsList
        .map((group) => new GroupListItem(
              group: group,
              onGroupTap: _onGroupSelection,
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Container(
          width: 375.w,
          height: 812.h,
          color: AppColors.groupScreenBG,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SearchBar(
                  onValueChanged: (value) {
                    print('searched value $value');
                  },
                  onDone: (value) {
                    print('searched value $value');
                  },
                ),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  height: 50.h,
                  width: MediaQuery.of(context).size.width - 40,
                  padding: EdgeInsets.only(left: 15.w, right: 15.w),
                  decoration: BoxDecoration(
                    color: AppColors.txtFieldBackground,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      style: TextStyle(
                        color: Color(0xFF434141),
                        fontSize: 16.sp,
                        fontFamily: 'OpenSans',
                      ),
                      hint: Text(
                        'Groups: All of my Groups',
                        style: TextStyle(
                          color: Color(0xFF434141),
                          fontSize: 16.sp,
                          fontFamily: 'OpenSans',
                        ),
                      ),
                      onChanged: (String? value) {},
                      items: <String>[
                        'Groups: Group I teach or co-lead',
                        'Groups: Groups I\'m a learner in',
                      ].map<DropdownMenuItem<String>>((String value) {
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
                SizedBox(
                  height: 20.h,
                ),
                ListView(
                  primary: false,
                  shrinkWrap: true,
                  padding: EdgeInsets.only(left: 10.0.w, right: 10.0.w),
                  children: _isSearching ? _buildSearchList() : _buildList(),
                ),
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
        child: Container(
          margin: EdgeInsets.only(left: 15.0.w, right: 15.0.w),
          height: 183,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Container(
                height: 22.h,
                // margin: EdgeInsets.only(left: 25.0.w, right: 25.0.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '${group.groupId}',
                      textAlign: TextAlign.left,
                      style: TextStyle(color: AppColors.txtFieldTextColor),
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
            ],
          ),
        ),
      ),
      elevation: 5,
    );
  }
}
