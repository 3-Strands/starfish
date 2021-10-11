import 'package:flutter/material.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:starfish/enums/action_status.dart';
import 'package:starfish/widgets/action_status_widget.dart';
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
          SizedBox(
            height: 10.h,
          ),
          Card(
              margin: EdgeInsets.only(left: 15.w, right: 15.w),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              color: AppColors.txtFieldBackground,
              child: Padding(
                padding: EdgeInsets.only(
                    left: 5.w, right: 5.w, top: 5.h, bottom: 15.h),
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
                                "Sample Action Name with long texthsdjdlkwjdlkwjdlwjld;",
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
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 2),
                                    borderRadius: BorderRadius.circular(12.sp)),
                                enabled: true,
                                onSelected: (value) {
                                  setState(() {
                                    // _value = value;
                                  });
                                },
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
              ))
        ],
      ),
    );
  }
}
