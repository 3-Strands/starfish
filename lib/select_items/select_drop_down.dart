import 'package:flutter/material.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starfish/constants/text_styles.dart';
import 'package:starfish/select_items/select_list.dart';

class MultiSelectDropDownController<T extends Named> extends SelectDropDownController<T> {
  Set<T> _selectedItems;
  int? maxSelectItemLimit;

  MultiSelectDropDownController({
    required List<T> items,
    Set<T>? selectedItems,
    this.maxSelectItemLimit,
  }) : _selectedItems = selectedItems ?? {}, super();

  bool get hasMaxLimit => maxSelectItemLimit != null;

  bool get hasSelected => _selectedItems.isNotEmpty;
  bool get isSelectionComplete => hasMaxLimit && _selectedItems.length > maxSelectItemLimit!;

  @override
  bool isSelected(T item) => _selectedItems.contains(item);

  @override
  bool isAllSelected(List<T> items) => _selectedItems.length == items.length;

  @override
  String? toggleSelected(T item, bool isSelected) {
    if (isSelected && isSelectionComplete) {
      return 'Maximum $maxSelectItemLimit items can be selected.';
    }
    if (isSelected) {
      _selectedItems.add(item);
    } else {
      _selectedItems.remove(item);
    }
    return super.toggleSelected(item, isSelected);
  }

  void setAllSelected(List<T> items, bool isSelected) {
    _selectedItems = isSelected ? items.toSet() : Set();
    super.setAllSelected(items, isSelected);
  }

  Set<T> get selectedItems => _selectedItems;
  set selectedItems(Set<T> selectedItems) {
    if (_selectedItems != selectedItems) {
      _selectedItems = selectedItems;
      notifyListeners();
    }
  }

  @override
  String? getSummary() => _selectedItems.isEmpty ? null
    : _selectedItems.map((item) => item.getName()).join(', ');
}

class SingleSelectDropDownController<T extends Named> extends SelectDropDownController<T> {
  T? _selectedItem;

  SingleSelectDropDownController({required List<T> items, T? selectedItem})
    : _selectedItem = selectedItem, super();

  bool get hasSelected => _selectedItem != null;
  bool get isSelectionComplete => hasSelected;

  @override
  bool isSelected(T item) => _selectedItem == item;

  @override
  bool isAllSelected(List<T> items) => false;

  @override
  String? toggleSelected(T item, bool isSelected) {
    _selectedItem = isSelected ? item : null;
    return super.toggleSelected(item, isSelected);
  }

  T? get selectedItem => _selectedItem;

  void setAllSelected(List<T> items, bool isSelected) => throw Exception('Cannot select all in a single select.');

  @override
  String? getSummary() => _selectedItem?.getName();
}

class SelectDropDown<T extends Named> extends StatefulWidget {
  final String navTitle;
  final String placeholder;
  final bool enableSelectAllOption;
  final bool enabled;
  final SelectDropDownController<T> controller;
  final void Function()? onDoneClicked;
  final VoidCallback? isMovingNext;

  SelectDropDown({
    Key? key,
    required this.navTitle,
    required this.placeholder,
    this.enabled = true,
    this.enableSelectAllOption = false,
    required this.controller,
    this.onDoneClicked,
    this.isMovingNext,
  }) : super(key: key);

  @override
  _SelectDropDownState createState() => _SelectDropDownState();
}

class _SelectDropDownState extends State<SelectDropDown> {
  void _rebuild() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    widget.controller.addListener(_rebuild);
    super.initState();
  }

  @override
  void dispose() {
    widget.controller.removeListener(_rebuild);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final summary = widget.controller.getSummary();

    return Container(
      height: 52.h,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.transparent,
          width: 1.0,
        ),
        color: AppColors.txtFieldBackground,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: InkWell(
        onTap: () {
          if (widget.enabled) {
            widget.isMovingNext?.call();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SelectList(
                  navTitle: widget.navTitle,
                  controller: widget.controller,
                  enableSelectAllOption: widget.enableSelectAllOption,
                ),
              ),
            ).then(
              (value) => widget.onDoneClicked?.call(),
            );
          }
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  summary ?? widget.placeholder,
                  maxLines: 1,
                  overflow: TextOverflow.fade,
                  softWrap: false,
                  style: summary == null
                      ? formTitleHintStyle
                      : textFormFieldText,
                ),
              ),
              Icon(Icons.navigate_next_sharp, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}
