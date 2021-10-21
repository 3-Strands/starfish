import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:starfish/bloc/app_bloc.dart';
import 'package:starfish/bloc/provider.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:starfish/constants/strings.dart';
import 'package:starfish/db/hive_action.dart';
import 'package:starfish/enums/action_status.dart';
import 'package:starfish/modules/actions_view/add_edit_action.dart';
import 'package:starfish/modules/dashboard/dashboard.dart';
import 'package:starfish/widgets/action_status_widget.dart';
import 'package:starfish/widgets/custon_icon_button.dart';
import 'package:starfish/widgets/searchbar_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starfish/widgets/task_status.dart';

class Me extends StatefulWidget {
  const Me({Key? key}) : super(key: key);

  @override
  _MeState createState() => _MeState();
}

class _MeState extends State<Me> {
  var _dropdownTitleList = <String>[
    'This month',
    'Next month',
    'Last month',
    'Last 3 month',
    'All time'
  ];
  late String _choiceText = 'This month';

  Dashboard obj = new Dashboard();
  _getActions(AppBloc bloc) async {
    bloc.actionBloc.fetchActionsFromDB();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);
    _getActions(bloc);

    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            SizedBox(
              height: 20.h,
            ),
            Container(
              height: 52.h,
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
                        _choiceText,
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
                        });
                      },
                      items: _dropdownTitleList
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
            SizedBox(height: 10.h),
            SearchBar(
              initialValue: '',
              onValueChanged: (value) {
                print('searched value $value');
                setState(() {});
              },
              onDone: (value) {
                print('searched value $value');
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
    );
  }

  void _onActionSelection(HiveAction action) {
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
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (BuildContext context,
            StateSetter setState /*You can rename this!*/) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.70,
            child: SingleChildScrollView(
              child: _buildSlidingUpPanel(action),
            ),
          );
        });
      },
    );
  }

  Future<dynamic> _onMeActionSheet(BuildContext context) {
    return showModalBottomSheet(
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
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                height: 40.sp,
              ),
              Text(
                'Month: Jul 2021',
                style: TextStyle(
                    fontSize: 16.sp,
                    color: Color(0xFF3475F0),
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 40.sp,
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 44.h,
                      width: 169.w,
                      child: Text(
                        'Action Follow a set of instructions',
                        maxLines: 2,
                        style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w500),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    SizedBox(
                      width: 53.sp,
                    ),
                    Icon(
                      Icons.thumb_up_alt_outlined,
                      size: 14.sp,
                    ),
                    SizedBox(
                      width: 4.sp,
                    ),
                    ActionStatusWidget(
                        title: ActionStatus.done, height: 36.h, width: 99.w)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                child: Text(
                  'Instructions: Instructions up to 200 characters are shown hereLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam.',
                  maxLines: 5,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Color(0xFF797979),
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Due: Jul 15',
                    maxLines: 1,
                    style: TextStyle(
                        fontSize: 16.sp,
                        color: Color(0xFF4F4F4F),
                        fontWeight: FontWeight.w500),
                    textAlign: TextAlign.right,
                  ),
                ),
              ),
              SizedBox(
                height: 100.h,
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    Strings.howWasThisActionText,
                    maxLines: 1,
                    style: TextStyle(
                        fontSize: 16.sp,
                        color: Color(0xFF4F4F4F),
                        fontWeight: FontWeight.w500),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 36.sp,
                      width: 160.sp,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.sp),
                        color: Color(0xFFC9C9C9),
                      ),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.thumb_up_outlined, size: 14.sp),
                            SizedBox(
                              width: 4.sp,
                            ),
                            Text(
                              Strings.goodText,
                              maxLines: 1,
                              style: TextStyle(
                                fontFamily: 'Rubik',
                                fontSize: 14.sp,
                                color: Color(0xFF777777),
                              ),
                            ),
                          ]),
                    ),
                    Container(
                      height: 36.sp,
                      width: 160.sp,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.sp),
                        color: Color(0xFFC9C9C9),
                      ),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.thumb_down_outlined, size: 14.sp),
                            SizedBox(
                              width: 4.sp,
                            ),
                            Text(
                              Strings.notSoGoodText,
                              maxLines: 1,
                              style: TextStyle(
                                fontFamily: 'Rubik',
                                fontSize: 14.sp,
                                color: Color(0xFF777777),
                              ),
                            ),
                          ]),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 39.h,
              ),
              Container(
                height: 75.h,
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
                        //_closeSlidingUpPanelIfOpen();
                        Navigator.pop(context);
                      },
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
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
                ),
              ),
            ],
          );
        });
  }

  Widget _buildSlidingUpPanel(HiveAction action) {
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
                  'Title: {action.status}',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: AppColors.txtFieldTextColor,
                    fontFamily: 'OpenSans',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                CustomIconButton(
                  icon: Icon(
                    Icons.open_in_new,
                    color: Colors.blue,
                    size: 18.sp,
                  ),
                  text: Strings.open,
                  onButtonTap: () {},
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          TaskStatus(
            height: 30.h,
            color: AppColors.completeTaskBGColor,
            label: 'complete',
            textStyle: TextStyle(
              fontSize: 14.sp,
              fontFamily: 'OpenSans',
              color: Colors.black,
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          TaskStatus(
            height: 30.h,
            color: AppColors.overdueTaskBGColor,
            label: 'overdueTaskBGColor',
          ),
          SizedBox(
            height: 30.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                Strings.lanugages,
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Color(0xFF3475F0),
                  fontFamily: 'OpenSans',
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
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
          Text(
            Strings.topics,
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Color(0xFF3475F0),
              fontFamily: 'OpenSans',
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 63.h,
          ),
          TextButton(
            onPressed: () {},
            child: Text(
              Strings.reportInappropriateMaterial,
              style: TextStyle(
                color: Color(0xFFF65A4A),
                fontFamily: 'OpenSans',
                fontSize: 16.sp,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          SizedBox(
            height: 20.h,
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

  Widget actionsList(AppBloc bloc) {
    return StreamBuilder<List<HiveAction>>(
      stream: bloc.actionBloc.actions,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<HiveAction> _listToShow;

          if (bloc.actionBloc.query.isNotEmpty) {
            String _query = bloc.actionBloc.query;
            _listToShow = snapshot.data!
                .where((item) =>
                    item.name!.toLowerCase().contains(_query.toLowerCase()) ||
                    item.name!.toLowerCase().startsWith(_query.toLowerCase()))
                .toList();
          } else {
            _listToShow = snapshot.data!;
          }
          return ListView.builder(
              shrinkWrap: true,
              // padding: EdgeInsets.only(left: 10.0.w, right: 10.0.w),
              physics: NeverScrollableScrollPhysics(),
              itemCount: _listToShow.length,
              itemBuilder: (BuildContext ctxt, int index) {
                return MyActionListItem(
                  action: _listToShow[index],
                  onActionTap: _onActionSelection,
                );
              });
        } else {
          return Container();
        }
      },
    );
  }
}

class MyActionListItem extends StatelessWidget {
  final HiveAction action;
  final Function(HiveAction action) onActionTap;

  MyActionListItem({required this.action, required this.onActionTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(left: 15.w, right: 15.w, top: 10.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      color: AppColors.txtFieldBackground,
      child: InkWell(
        onTap: () {
          // _onMeActionSheet(context);
        },
        child: Padding(
          padding:
              EdgeInsets.only(left: 5.w, right: 5.w, top: 5.h, bottom: 15.h),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 10.sp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "#1",
                      style: TextStyle(
                          color: Color(0xFF797979),
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 8.0, right: 8.sp),
                        child: Text(
                          action.name ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 30.sp,
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
                            borderRadius: BorderRadius.circular(12.sp)),
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
                              //TODO: delete action

                              break;
                          }
                        },
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            child: Text(
                              Strings.editActionText,
                              style: TextStyle(
                                  color: Color(0xFF3475F0),
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                            value: 0,
                          ),
                          PopupMenuItem(
                            child: Text(
                              Strings.deleteActionText,
                              style: TextStyle(
                                  color: Color(0xFF3475F0),
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                            value: 1,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ActionStatusWidget(
                    title: ActionStatus.overdue,
                    height: 30.h,
                    width: 130.w,
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Text(
                    "Due : Aug 15",
                    style: TextStyle(
                      color: Color(0xFF797979),
                      fontSize: 16.sp,
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
}
