import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:starfish/constants/strings.dart';
import 'package:starfish/db/hive_action.dart';
import 'package:starfish/enums/action_status.dart';
import 'package:starfish/widgets/custon_icon_button.dart';
import 'package:starfish/widgets/searchbar_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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

  @override
  Widget build(BuildContext context) {
    return Container(
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
          Container(
            margin: EdgeInsets.only(left: 15.w, right: 15.w),
            child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
                color: AppColors.txtFieldBackground,
                child: Padding(
                  padding: EdgeInsets.only(
                      left: 5.w, right: 5.w, top: 15.h, bottom: 15.h),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 10.w,
                          ),
                          Text("#1"),
                          SizedBox(
                            width: 10.w,
                          ),
                          Text("Sample Action Name with long text"),
                          SizedBox(
                            width: 35.w,
                          ),
                          Icon(Icons.more_vert)
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ActionStatusWidget(title: ActionStatus.done),
                          SizedBox(
                            width: 10.w,
                          ),
                          Text("Due : Aug 15"),
                        ],
                      )
                    ],
                  ),
                )),
          )
        ],
      ),
    );
  }
}

class ActionStatusWidget extends StatelessWidget {
  final title;

  const ActionStatusWidget({
    Key? key,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30.h,
      width: 121.w,
      decoration: BoxDecoration(
          color: Color(0xFF6DE26B),
          borderRadius: BorderRadius.all(Radius.circular(4.sp))),
      child: Padding(
        padding: EdgeInsets.all(8.sp),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Spacer(),
              Icon(Icons.check, size: 16.sp, color: Color(0xFF393939)),
              SizedBox(width: 2.sp),
              Text(title,
                  textAlign: TextAlign.center,
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp)),
              Spacer()
            ],
          ),
        ),
      ),
    );
  }
}
