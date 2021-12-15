import 'package:flutter/material.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starfish/constants/text_styles.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SearchBar extends StatefulWidget {
  final String initialValue;
  final Function(String searchedText) onDone;
  final Function(String searchedText) onValueChanged;

  SearchBar(
      {Key? key,
      required this.initialValue,
      required this.onValueChanged,
      required this.onDone})
      : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    searchController.text = widget.initialValue;
  }

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
          padding: EdgeInsets.only(left: 14.w, right: 2.w),
          child: Align(
            alignment: Alignment.center,
            child: TextFormField(
              maxLines: 1,
              style: textFormFieldText,
              controller: searchController,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: Icon(
                      searchController.text.isNotEmpty
                          ? Icons.close
                          : Icons.search,
                      color: Colors.blue),
                  iconSize: 25.sp,
                  color: Colors.green,
                  splashColor: Colors.purple,
                  onPressed: () {
                    searchController.text = '';
                    widget.onDone('');
                  },
                ),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                isCollapsed: true,
                hintText: AppLocalizations.of(context)!.searchBarHint,
                hintStyle: textFormFieldText,
              ),
              onChanged: (value) => {widget.onValueChanged(value)},
              onFieldSubmitted: (value) => {widget.onDone(value)},
            ),
          ),
        ));
  }
}
