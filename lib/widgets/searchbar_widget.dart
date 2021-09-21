import 'package:flutter/material.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:starfish/constants/strings.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchBar extends StatefulWidget {
  final Function(String searchedText) onDone;
  final Function(String searchedText) onValueChanged;

  SearchBar({Key? key, required this.onValueChanged, required this.onDone})
      : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  onDone() {}

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52.h,
      margin: EdgeInsets.only(left: 15.w, right: 15.w),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.transparent,
          width: 1.0,
        ),
        color: AppColors.txtFieldBackground,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        children: [
          Container(
            height: 52.h,
            width: MediaQuery.of(context).size.width - 80.w,
            margin: EdgeInsets.only(right: 5.w),
            child: TextFormField(
              decoration: new InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(10.w, 0.0, 0.0, 0.0),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  hintText: Strings.searchBarHint),
              onChanged: (value) => {widget.onValueChanged(value)},
              onFieldSubmitted: (value) => {widget.onDone(value)},
            ),
          ),
          Spacer(),
          Container(
            height: 25.w,
            width: 25.w,
            margin: EdgeInsets.only(right: 10.w),
            child: Icon(
              Icons.search,
              color: Colors.blue,
              size: 22.sp,
            ),
          ),
        ],
      ),
    );
  }
}
