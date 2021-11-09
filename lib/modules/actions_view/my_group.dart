import 'package:flutter/material.dart';
import 'package:group_list_view/group_list_view.dart';
import 'package:hive/hive.dart';
import 'package:starfish/bloc/app_bloc.dart';
import 'package:starfish/bloc/provider.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:starfish/constants/strings.dart';
import 'package:starfish/db/hive_action.dart';
import 'package:starfish/db/hive_action_user.dart';
import 'package:starfish/db/hive_database.dart';
import 'package:starfish/db/hive_group.dart';
import 'package:starfish/db/hive_user.dart';
import 'package:starfish/enums/action_filter.dart';
import 'package:starfish/enums/action_status.dart';
import 'package:starfish/src/generated/starfish.pb.dart';
import 'package:starfish/utils/date_time_utils.dart';
import 'package:starfish/widgets/action_status_widget.dart';
import 'package:starfish/widgets/custon_icon_button.dart';
import 'package:starfish/widgets/searchbar_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starfish/widgets/task_status.dart';
import 'package:starfish/widgets/user_action_status_widget.dart';

class MyGroup extends StatefulWidget {
  const MyGroup({Key? key}) : super(key: key);

  @override
  _MyGroupState createState() => _MyGroupState();
}

class _MyGroupState extends State<MyGroup> {
  late Box<HiveUser> _userBox;

  @override
  void initState() {
    super.initState();
    _userBox = Hive.box<HiveUser>(HiveDatabase.USER_BOX);
  }

  _getActions(AppBloc bloc) async {
    bloc.actionBloc.fetchGroupActionsFromDB();
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
                    child: DropdownButton<ActionFilter>(
                      isExpanded: true,
                      // icon: Icon(Icons.arrow_drop_down),
                      iconSize: 35,
                      style: TextStyle(
                        color: Color(0xFF434141),
                        fontSize: 16.sp,
                        fontFamily: 'OpenSans',
                      ),
                      hint: Text(
                        bloc.actionBloc.actionFilter.about,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Color(0xFF434141),
                          fontSize: 16.sp,
                          fontFamily: 'OpenSans',
                        ),
                        textAlign: TextAlign.left,
                      ),
                      onChanged: (ActionFilter? value) {
                        setState(() {
                          bloc.actionBloc.actionFilter = value!;
                        });
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
              initialValue: bloc.actionBloc.query,
              onValueChanged: (value) {
                print('searched value $value');
                setState(() {
                  bloc.actionBloc.query = value;
                });
              },
              onDone: (value) {
                print('searched value $value');
                setState(() {
                  bloc.actionBloc.query = value;
                });
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

  void _usersActionList(HiveAction action) {
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
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              height: 40.sp,
            ),
            Container(
              margin: EdgeInsets.only(left: 15.w, right: 15.w),
              child: Align(
                alignment: FractionalOffset.topLeft,
                child: Text(
                  action.name ?? '',
                  style: TextStyle(
                      fontSize: 16.sp,
                      color: Color(0xFF3475F0),
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(
              height: 20.sp,
            ),
            Container(
              margin: EdgeInsets.only(left: 15.w, right: 15.w),
              child: Align(
                alignment: FractionalOffset.topLeft,
                child: Text(
                  Strings.statusOfActionForLearner,
                  style: TextStyle(
                      fontSize: 16.sp,
                      color: Color(0xFF4F4F4F),
                      fontWeight: FontWeight.normal),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(
              height: 20.sp,
            ),
            _buildUserList(action),
            SizedBox(
              height: 20.sp,
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
              ),
            ),
          ],
        );
      },
    );
  }

  Widget actionsList(AppBloc bloc) {
    return StreamBuilder(
        stream: bloc.actionBloc.actions,
        builder: (BuildContext context,
            AsyncSnapshot<Map<HiveGroup, List<HiveAction>>> snapshot) {
          if (snapshot.hasData) {
            if (!snapshot.hasData) {
              return Container();
            }

            return GroupListView(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.only(left: 10.0.w, right: 10.0.w),
              sectionsCount: snapshot.data!.keys.toList().length,
              countOfItemInSection: (int section) {
                return snapshot.data!.values.toList()[section].length;
              },
              itemBuilder: (BuildContext context, IndexPath indexPath) {
                return MyGroupActionListItem(
                  action: snapshot.data!.values.toList()[indexPath.section]
                      [indexPath.index],
                  onActionTap: _usersActionList,
                );
              },
              groupHeaderBuilder: (BuildContext context, int section) {
                return Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.sp, vertical: 8.sp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${snapshot.data!.keys.toList()[section].name}',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF434141),
                        ),
                      ),
                      Text(
                        '${Strings.teacher}: ${snapshot.data!.keys.toList()[section].teachersName?.join(", ")}',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF797979),
                        ),
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) => SizedBox(height: 10),
              sectionSeparatorBuilder: (context, section) =>
                  SizedBox(height: 10),
            );
          } else {
            return Container(
              color: AppColors.groupScreenBG,
            );
          }
        });
  }

  Widget _buildUserList(HiveAction action) {
    if (action.learners == null) {
      return Container();
    }

    return Container(
      height: 300.h,
      child: ListView.builder(
        itemCount: action.learners!.length,
        itemBuilder: (context, index) {
          final hiveUser = action.learners![index];
          return ListTile(
            title: Row(
              children: [
                Text(
                  hiveUser.name ?? '',
                  style: TextStyle(
                    color: AppColors.txtFieldTextColor,
                    fontFamily: 'OpenSans',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 10.w),
                /*Container(
                  width: 100.w,
                  height: 20.h,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "${item.actionStatusbyId(action.id!)}",
                      style: TextStyle(
                        color: AppColors.txtFieldTextColor,
                        fontFamily: 'OpenSans',
                        fontSize: 14.sp,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),*/
                UserActionStatusWidget(
                  title: hiveUser.actionStatusbyId(action),
                  height: 20.h,
                  width: 100.w,
                ),
              ],
            ),
            trailing: Wrap(
              children: <Widget>[
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: AppColors.selectedButtonBG,
                ),
              ],
            ),
            onTap: () {
              Navigator.pop(context);
              _onActionSelection(action, hiveUser);
            },
          );
        },
      ),
    );
  }

  void _onActionSelection(HiveAction action, HiveUser user) {
    HiveActionUser hiveActionUser = new HiveActionUser();
    hiveActionUser.actionId = action.id!;
    hiveActionUser.userId = user.id!;

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
        builder: (context) {
          final bloc = Provider.of(context);
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 40.sp,
              ),
              Center(
                child: Text(
                  '${Strings.month}: ${DateTimeUtils.formatDate(DateTime.now(), 'MMM yyyy')}',
                  style: TextStyle(
                      fontSize: 16.sp,
                      color: Color(0xFF3475F0),
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
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
                        Strings.actionFollowInstructions,
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
                    InkWell(
                      onTap: () {
                        if (user.actionStatusbyId(action) ==
                            ActionStatus.NOT_DONE) {
                          hiveActionUser.status =
                              ActionUser_Status.COMPLETE.value;
                        } else if (user.actionStatusbyId(action) ==
                            ActionStatus.DONE) {
                          hiveActionUser.status =
                              ActionUser_Status.INCOMPLETE.value;
                        } else {
                          hiveActionUser.status =
                              ActionUser_Status.UNSPECIFIED_STATUS.value;
                        }

                        bloc.actionBloc.createUpdateActionUser(hiveActionUser);

                        // TODO: should we update the status of this action on HiveUser also????
                      },
                      child: UserActionStatusWidget(
                        title: user.actionStatusbyId(action),
                        height: 36.h,
                        width: 99.w,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                child: Text(
                  '${Strings.instructions}: ${action.instructions}',
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
                    '${Strings.due}: ${DateTimeUtils.formatHiveDate(action.dateDue!, requiredDateFormat: 'MMM dd, yyyy')}',
                    maxLines: 1,
                    style: TextStyle(
                        fontSize: 16.sp,
                        color: Color(0xFF4F4F4F),
                        fontWeight: FontWeight.w500),
                    textAlign: TextAlign.right,
                  ),
                ),
              ),
              // Record the response to the Question
              SizedBox(
                height: 110.h,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: (action.type == Action_Type.TEXT_RESPONSE.value)
                      ? Column(
                          children: [
                            Text('Question: ${action.question}'),
                            TextField(
                              decoration: InputDecoration(
                                  border: UnderlineInputBorder(),
                                  hintText:
                                      'Write an answer to the qustion here'),
                              onSubmitted: (value) {
                                print(value);
                                hiveActionUser.teacherResponse = value;
                                bloc.actionBloc
                                    .createUpdateActionUser(hiveActionUser);
                              },
                            ),
                          ],
                        )
                      : Container(),
                ),
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
                    InkWell(
                      onTap: () {
                        hiveActionUser.evaluation =
                            ActionUser_Evaluation.GOOD.value;

                        bloc.actionBloc.createUpdateActionUser(hiveActionUser);
                      },
                      child: Container(
                        height: 36.sp,
                        width: 160.sp,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.sp),
                          color: ActionUser_Evaluation.valueOf(
                                      hiveActionUser.evaluation!) ==
                                  ActionUser_Evaluation.GOOD
                              ? Color(0xFF6DE26B)
                              : Color(0xFFC9C9C9),
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
                    ),
                    InkWell(
                      onTap: () {
                        hiveActionUser.evaluation =
                            ActionUser_Evaluation.BAD.value;

                        bloc.actionBloc.createUpdateActionUser(hiveActionUser);
                      },
                      child: Container(
                        height: 36.sp,
                        width: 160.sp,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.sp),
                          color: ActionUser_Evaluation.valueOf(
                                      hiveActionUser.evaluation!) ==
                                  ActionUser_Evaluation.BAD
                              ? Color(0xFF6DE26B)
                              : Color(0xFFC9C9C9),
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
                  '${Strings.title}: {action.status}',
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
                        borderRadius:
                            BorderRadius.all(Radius.circular(8.5.sp))),
                  ),
                  Spacer(),
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
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
