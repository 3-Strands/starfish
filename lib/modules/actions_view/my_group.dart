import 'package:flutter/material.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:starfish/widgets/searchbar_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
        ],
      ),
    );
  }
}
