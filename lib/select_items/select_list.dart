import 'package:flutter/material.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starfish/constants/text_styles.dart';
import 'package:starfish/utils/helpers/snackbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

typedef String ToDisplay<T>(T item);

abstract class SelectListController<Item, SelectionModel>
    extends ValueNotifier<SelectionModel> {
  SelectListController(SelectionModel value) : super(value);

  bool get isSelectionComplete;
  bool get hasSelected;
  bool isSelected(Item item);
  bool isAllSelected(List<Item> items);
  String? toggleSelected(Item item, bool isSelected);
  void setAllSelected(List<Item> items, bool isSelected);
}

class SelectList<Item, SelectionModel> extends StatefulWidget {
  final String navTitle;
  final bool enableSelectAllOption;
  final bool inverseSelectAll;
  final SelectListController<Item, SelectionModel> controller;
  final List<Item> items;
  final ToDisplay<Item> toDisplay;

  SelectList({
    Key? key,
    required this.navTitle,
    required this.controller,
    required this.enableSelectAllOption,
    this.inverseSelectAll = false,
    required this.items,
    required this.toDisplay,
  }) : super(key: key);

  @override
  _SelectListState<Item, SelectionModel> createState() =>
      _SelectListState<Item, SelectionModel>();
}

class _SelectListState<Item, SelectionModel>
    extends State<SelectList<Item, SelectionModel>> {
  final _searchTextController = TextEditingController();

  bool _isSearching = false;

  late List<Item> _items;
  List<Item>? _filteredItems;

  List<Item> get currentList => _filteredItems ?? _items;

  void _rebuild() {
    setState(() {});
  }

  List<Item> _sortItemsBySelection(List<Item> items) {
    final controller = widget.controller;
    // Put the selected items on top.
    if (controller.hasSelected) {
      final selected = <Item>[];
      final unselected = <Item>[];
      items.forEach((item) {
        (controller.isSelected(item) ? selected : unselected).add(item);
      });
      return selected + unselected;
    }
    return items;
  }

  @override
  initState() {
    super.initState();
    _items = _sortItemsBySelection(widget.items);
    _searchTextController.addListener(_onSearchTextChange);
    widget.controller.addListener(_rebuild);
  }

  @override
  void didUpdateWidget(SelectList<Item, SelectionModel> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.items != widget.items) {
      _items = _sortItemsBySelection(widget.items);
    }
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller.removeListener(_onSearchTextChange);
      widget.controller.addListener(_onSearchTextChange);
    }
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
        _filteredItems = null;
      } else {
        final searchString = text.toLowerCase();
        _filteredItems = _items
            .where(
              (item) =>
                  widget.toDisplay(item).toLowerCase().contains(searchString),
            )
            .toList();
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

  Widget get _navigationSearchBar => IconButton(
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
    final isAllSelected = widget.inverseSelectAll
        ? !widget.controller.hasSelected
        : widget.controller.isAllSelected(_items);

    return Scaffold(
      //  resizeToAvoidBottomInset: false,
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
      body: Padding(
        padding: EdgeInsets.only(bottom: _bottomHeight),
        child: Column(
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
                onTap: () => widget.controller.setAllSelected(_items,
                    (widget.inverseSelectAll ? isAllSelected : !isAllSelected)),
              ),
              visible: widget.enableSelectAllOption,
            ),
            SizedBox(
              height: 5.h,
            ),
            Expanded(
              child: Scrollbar(
                thickness: 5.w,
                isAlwaysShown: false,
                child: ListView.builder(
                  itemCount: currentList.length,
                  itemBuilder: _listItemBuilder,
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Row(
        children: [
          Expanded(
            child: Container(
              height: _bottomHeight,
              padding:
                  EdgeInsets.symmetric(vertical: 18.75.h, horizontal: 30.w),
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
          ),
        ],
      ),
    );
  }

  double get _bottomHeight => 75.h;

  Widget _listItemBuilder(BuildContext context, int index) {
    final item = currentList[index];
    final isSelected = widget.controller.isSelected(item);
    return _ListItem(
      label: Text(
        widget.toDisplay(item),
        maxLines: 2,
        style: TextStyle(
          fontFamily: 'OpenSans',
          fontWeight: FontWeight.normal,
          fontSize: 17.sp,
        ),
      ),
      isSelected: isSelected,
      onTap: () {
        final errorMessage =
            widget.controller.toggleSelected(item, !isSelected);
        if (errorMessage != null) {
          StarfishSnackbar.showErrorMessage(context, errorMessage);
        } else if (widget.controller.isSelectionComplete) {
          Navigator.of(context).pop();
        }
      },
    );
  }
}

class _ListItem extends StatelessWidget {
  final VoidCallback onTap;
  final bool isSelected;
  final Widget label;

  const _ListItem(
      {Key? key,
      required this.onTap,
      required this.isSelected,
      required this.label})
      : super(key: key);

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
                  isSelected ? Icons.check_box : Icons.check_box_outline_blank,
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
