import 'package:flutter/material.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starfish/constants/text_styles.dart';
import 'package:starfish/select_items/select_drop_down.dart';
import 'package:starfish/utils/helpers/snackbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MultiSelect<T extends Named> extends StatefulWidget {
  final String navTitle;
  final bool enableSelectAllOption;
  final SelectDropDownController<T> controller;

  MultiSelect({
    Key? key,
    required this.navTitle,
    required this.controller,
    required this.enableSelectAllOption,
  }) : super(key: key);

  @override
  _MultiSelectState createState() => _MultiSelectState();
}

class _MultiSelectState<T extends Named> extends State<MultiSelect<T>> {
  // final Key _focusDetectorKey = UniqueKey();

  // final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _searchTextController = TextEditingController();

  bool _isSearching = false;

  late List<T> _list;
  List<T>? _filteredList;

  List<T> get currentList => _filteredList ?? _list;

  void _rebuild() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  initState() {
    super.initState();
    final controller = widget.controller;
    _list = controller.items;
    // At the beginning, put the selected items on top.
    if (controller.hasSelected) {
      final selected = <T>[];
      final unselected = <T>[];
      _list.forEach((item) {
        (controller.isSelected(item) ? selected : unselected).add(item);
      });
      _list = selected + unselected;
    }
    _searchTextController.addListener(_onSearchTextChange);
    widget.controller.addListener(_rebuild);
  }

  @override
  void dispose() {
    _searchTextController
      ..removeListener(_onSearchTextChange)
      ..dispose();
    widget.controller.removeListener(_rebuild);
    super.dispose();
  }

  void _onSearchTextChange() {
    final text = _searchTextController.text;

    setState(() {
      if (text.isEmpty) {
        _filteredList = null;
      } else {
        final searchString = text.toLowerCase();
        _filteredList = widget.controller.items.where(
          (item) => item.getName().toLowerCase().contains(searchString),
        ).toList();
      }
    });
  }

  Widget get _appBarTitle => _isSearching
    ? TextField(
      controller: _searchTextController,
      cursorColor: Colors.white,
      autofocus: true,
      style: TextStyle(
        color: Colors.white,
        fontSize: 19.sp,
      ),
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.search, color: Colors.white),
        hintText: AppLocalizations.of(context)!.searchBarHint,
        hintStyle: TextStyle(color: Colors.white),
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
      ),
    )
    : Text(
      widget.navTitle,
      style: TextStyle(color: Colors.white, fontSize: 19.sp),
    );

  Widget get _navigationSearchBar =>
    IconButton(
      icon: _isSearching ? const Icon(Icons.close) : const Icon(Icons.search),
      onPressed: () {
        setState(() {
          _isSearching = !_isSearching;
          if (!_isSearching) {
            _searchTextController.clear();
          }
        });
      },
    );

  @override
  Widget build(BuildContext context) {
    final isAllSelected = widget.controller.isAllSelected();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      // key: _scaffoldKey,
      appBar: AppBar(
        title: _appBarTitle,
        automaticallyImplyLeading: false,
        actions: [
          _navigationSearchBar,
        ],
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios_rounded, size: 32.r),
        ),
      ),
      body: Column(
        children: [
          Visibility(
            child: _ListItem(
              label: Text(
                AppLocalizations.of(context)!.selectAll,
                style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.bold,
                  fontSize: 21.5.sp,
                ),
              ),
              isSelected: isAllSelected,
              onTap: () => widget.controller.setAllSelected(!isAllSelected)
            ),
            // child: Card(
            //   child: InkWell(
            //     child: Container(
            //       height: 40,
            //       margin: EdgeInsets.only(left: 15.w, top: 5.h),
            //       color: Colors.white,
            //       child: Row(
            //         children: [
            //           Expanded(
            //             child: Column(
            //               mainAxisAlignment:
            //                   MainAxisAlignment.spaceAround,
            //               crossAxisAlignment: CrossAxisAlignment.start,
            //               children: <Widget>[
                            
            //               ],
            //             ),
            //           ),
            //           Icon(
            //             isAllSelected
            //                 ? Icons.check_box
            //                 : Icons.check_box_outline_blank,
            //             color: AppColors.selectedButtonBG,
            //           ),
            //         ],
            //       ),
            //     ),
            //     onTap: () => widget.controller.setAllSelected(!isAllSelected),
            //   ),
            // ),
            visible: widget.enableSelectAllOption,
          ),
          SizedBox(
            height: 5.h,
          ),
          Expanded(
            child: _listBuilder(),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 75.h,
        padding: EdgeInsets.symmetric(vertical: 18.75.h, horizontal: 30.w),
        color: AppColors.txtFieldBackground,
        child: ElevatedButton(
          child: Text(
            AppLocalizations.of(context)!.back,
            textAlign: TextAlign.start,
            style: buttonTextStyle,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            primary: AppColors.unselectedButtonBG,
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(20.0),
            ),
          ),
        ),
      ),
    );
  }

  Widget _listBuilder() {
    final list = currentList;

    return Container(
      child: Scrollbar(
        thickness: 5.w,
        isAlwaysShown: false,
        child: ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) {
            final item = list[index];
            final isSelected = widget.controller.isSelected(item);
            return _ListItem(
              label: Text(
                item.getName(),
                maxLines: 2,
                style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.normal,
                  fontSize: 17.sp,
                ),
              ),
              isSelected: isSelected,
              onTap: () {
                final errorMessage = widget.controller.toggleSelected(item, !isSelected);
                if (errorMessage != null) {
                  StarfishSnackbar.showErrorMessage(context, errorMessage);
                } else if (widget.controller.isSelectionComplete) {
                  Navigator.of(context).pop();
                }
              },
            );
          },
        ),
      ),
    );
  }
}

class _ListItem extends StatelessWidget {
  final VoidCallback onTap;
  final bool isSelected;
  final Widget label;

  const _ListItem({ Key? key, required this.onTap,
      required this.isSelected, required this.label }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: InkWell(
        child: SizedBox(
          height: 60.h,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(child: label),
                Icon(
                  isSelected
                      ? Icons.check_box
                      : Icons.check_box_outline_blank,
                  color: AppColors.selectedButtonBG,
                ),
              ],
            ),
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
