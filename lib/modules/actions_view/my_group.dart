import 'package:flutter/material.dart';
import 'package:starfish/bloc/app_bloc.dart';
import 'package:starfish/bloc/provider.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:starfish/constants/strings.dart';
import 'package:starfish/db/hive_action.dart';
import 'package:starfish/enums/action_status.dart';
import 'package:starfish/widgets/action_status_widget.dart';
import 'package:starfish/widgets/custon_icon_button.dart';
import 'package:starfish/widgets/searchbar_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starfish/widgets/task_status.dart';

class MyGroup extends StatefulWidget {
  const MyGroup({Key? key}) : super(key: key);

  @override
  _MyGroupState createState() => _MyGroupState();
}

class _MyGroupState extends State<MyGroup> {
  var _dropdownTitleList = <String>[
    'This month',
    'Next month',
    'Last month',
    'Last 3 month',
    'All time'
  ];
  late String _choiceText = 'This month';

  _getActions(AppBloc bloc) async {
    bloc.actionBloc.fetchActionsFromDB();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);
    _getActions(bloc);

    return Scrollbar(
      thickness: 5.sp,
      isAlwaysShown: false,
      child: SingleChildScrollView(
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
            // Card(
            //     margin: EdgeInsets.only(left: 15.w, right: 15.w),
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.all(
            //         Radius.circular(15),
            //       ),
            //     ),
            //     color: AppColors.txtFieldBackground,
            //     child: Padding(
            //       padding: EdgeInsets.only(
            //           left: 5.w, right: 5.w, top: 5.h, bottom: 15.h),
            //       child: Column(
            //         children: [
            //           Padding(
            //             padding: EdgeInsets.only(left: 10.sp),
            //             child: Row(
            //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //               children: [
            //                 Text(
            //                   "#1",
            //                   style: TextStyle(
            //                       color: Color(0xFF797979),
            //                       fontSize: 16.sp,
            //                       fontWeight: FontWeight.bold),
            //                 ),
            //                 Expanded(
            //                   child: Padding(
            //                     padding: EdgeInsets.only(left: 8.0, right: 8.sp),
            //                     child: Text(
            //                       "Sample Action Name with long",
            //                       maxLines: 1,
            //                       overflow: TextOverflow.ellipsis,
            //                       softWrap: false,
            //                       style: TextStyle(
            //                           color: Colors.black,
            //                           fontSize: 16.sp,
            //                           fontWeight: FontWeight.w500),
            //                     ),
            //                   ),
            //                 ),
            //                 SizedBox(
            //                   width: 30.sp,
            //                   child: PopupMenuButton(
            //                       icon: Icon(
            //                         Icons.more_vert,
            //                         color: Color(0xFF3475F0),
            //                       ),
            //                       color: Colors.white,
            //                       elevation: 20,
            //                       shape: OutlineInputBorder(
            //                           borderSide: BorderSide(
            //                               color: Colors.white, width: 2),
            //                           borderRadius: BorderRadius.circular(12.sp)),
            //                       enabled: true,
            //                       onSelected: (value) {
            //                         setState(() {
            //                           // _value = value;
            //                         });
            //                       },
            //                       itemBuilder: (context) => [
            //                             PopupMenuItem(
            //                               child: Text(
            //                                 "Edit Action",
            //                                 style: TextStyle(
            //                                     color: Color(0xFF3475F0),
            //                                     fontSize: 16.sp,
            //                                     fontWeight: FontWeight.bold),
            //                               ),
            //                               value: "",
            //                             ),
            //                             PopupMenuItem(
            //                               child: Text(
            //                                 "Delete Action",
            //                                 style: TextStyle(
            //                                     color: Color(0xFF3475F0),
            //                                     fontSize: 16.sp,
            //                                     fontWeight: FontWeight.bold),
            //                               ),
            //                               value: "",
            //                             ),
            //                           ]),
            //                 ),
            //               ],
            //             ),
            //           ),
            //           SizedBox(
            //             height: 15.h,
            //           ),
            //           Row(
            //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //             children: [
            //               Spacer(),
            //               Container(
            //                 height: 51.sp,
            //                 width: 99.sp,
            //                 decoration: BoxDecoration(
            //                     color: Color(0xFF6DE26B),
            //                     borderRadius:
            //                         BorderRadius.all(Radius.circular(8.5.sp))),
            //               ),
            //               Spacer(),
            //               Container(
            //                 height: 51.sp,
            //                 width: 99.sp,
            //                 decoration: BoxDecoration(
            //                     color: Color(0xFFFFBE4A),
            //                     borderRadius:
            //                         BorderRadius.all(Radius.circular(8.5.sp))),
            //               ),
            //               Spacer(),
            //               Container(
            //                 height: 51.sp,
            //                 width: 99.sp,
            //                 decoration: BoxDecoration(
            //                     color: Color(0xFFFF5E4D),
            //                     borderRadius:
            //                         BorderRadius.all(Radius.circular(8.5.sp))),
            //               ),
            //               Spacer(),
            //             ],
            //           )
            //         ],
            //       ),
            //     )),
            actionsList(bloc),
            SizedBox(
              height: 10.h,
            ),
          ],
        ),
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
              physics: NeverScrollableScrollPhysics(),
              itemCount: _listToShow.length,
              itemBuilder: (BuildContext ctxt, int index) {
                return MyGroupActionListItem(
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
}

class MyGroupActionListItem extends StatelessWidget {
  final HiveAction action;
  final Function(HiveAction action) onActionTap;

  MyGroupActionListItem({required this.action, required this.onActionTap});

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
      child: Padding(
        padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 5.h, bottom: 15.h),
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
                        onSelected: (value) {},
                        itemBuilder: (context) => [
                              PopupMenuItem(
                                child: Text(
                                  "Edit Action",
                                  style: TextStyle(
                                      color: Color(0xFF3475F0),
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                                value: "",
                              ),
                              PopupMenuItem(
                                child: Text(
                                  "Delete Action",
                                  style: TextStyle(
                                      color: Color(0xFF3475F0),
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                                value: "",
                              ),
                            ]),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Spacer(),
                Container(
                  height: 51.sp,
                  width: 99.sp,
                  decoration: BoxDecoration(
                      color: Color(0xFF6DE26B),
                      borderRadius: BorderRadius.all(Radius.circular(8.5.sp))),
                ),
                Spacer(),
                Container(
                  height: 51.sp,
                  width: 99.sp,
                  decoration: BoxDecoration(
                      color: Color(0xFFFFBE4A),
                      borderRadius: BorderRadius.all(Radius.circular(8.5.sp))),
                ),
                Spacer(),
                Container(
                  height: 51.sp,
                  width: 99.sp,
                  decoration: BoxDecoration(
                      color: Color(0xFFFF5E4D),
                      borderRadius: BorderRadius.all(Radius.circular(8.5.sp))),
                ),
                Spacer(),
              ],
            )
          ],
        ),
      ),
    );
  }
}
