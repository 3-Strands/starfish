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
        child: Padding(
          padding: EdgeInsets.only(right: 2.w),
          child: Align(
            alignment: Alignment.center,
            child: TextFormField(
              maxLines: 1,
              style: TextStyle(fontSize: 16.sp, color: Color(0xFF434141)),
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                suffixIcon: Icon(Icons.search, color: Colors.blue),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                // contentPadding: EdgeInsets.only(
                //   bottom: 52.h / 2,  // HERE THE IMPORTANT PART
                // ),
                isCollapsed: true,

                hintText: Strings.searchBarHint,
              ),
              onChanged: (value) => {widget.onValueChanged(value)},
              onFieldSubmitted: (value) => {widget.onDone(value)},
            ),
          ),
        ));
  }
}
