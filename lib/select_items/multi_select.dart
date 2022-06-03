import 'package:flutter/material.dart';

import 'select_list.dart';
import 'select_list_button.dart';

class MultiSelectController<T> extends SelectListController<T, Set<T>> {
  int? maxSelectItemLimit;

  MultiSelectController({
    Set<T>? initialSelection,
    this.maxSelectItemLimit,
  }) : super(initialSelection ?? {});

  bool get hasMaxLimit => maxSelectItemLimit != null;

  bool get hasSelected => value.isNotEmpty;
  bool get isSelectionComplete => hasMaxLimit && value.length > maxSelectItemLimit!;

  @override
  bool isSelected(T item) => value.contains(item);

  @override
  bool isAllSelected(List<T> items) => value.length == items.length;

  @override
  String? toggleSelected(T item, bool isSelected) {
    if (isSelected && isSelectionComplete) {
      return 'Maximum $maxSelectItemLimit items can be selected.';
    }
    final newValue = {...value};
    if (isSelected) {
      newValue.add(item);
    } else {
      newValue.remove(item);
    }
    return null;
  }

  void setAllSelected(List<T> items, bool isSelected) {
    value = isSelected ? items.toSet() : Set();
  }
}

class MultiSelect<T extends Named> extends StatefulWidget {
  final String navTitle;
  final String placeholder;
  final int? maxSelectItemLimit;
  final Set<T>? initialSelection;
  final bool enableSelectAllOption;
  final bool enabled;
  final List<T> items;
  final void Function(Set<T> selectedItems)? onFinished;
  final VoidCallback? onMoveNext;

  MultiSelect({
    Key? key,
    required this.navTitle,
    required this.placeholder,
    required this.items,
    this.initialSelection,
    this.maxSelectItemLimit,
    this.enabled = true,
    this.enableSelectAllOption = false,
    this.onFinished,
    this.onMoveNext,
  }) : super(key: key);

  @override
  _MultiSelectState createState() => _MultiSelectState();
}

class _MultiSelectState<T extends Named> extends State<MultiSelect<T>> {
  late MultiSelectController<T> _controller;

  @override
  void initState() {
    _controller = MultiSelectController<T>(
      initialSelection: widget.initialSelection,
      maxSelectItemLimit: widget.maxSelectItemLimit,
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String? get summary => _controller.hasSelected
    ? _controller.value.map((item) => item.getName()).join(', ')
    : null;

  @override
  Widget build(BuildContext context) {
    return SelectListButton(
      enabled: widget.enabled,
      onFinished: () => widget.onFinished?.call(_controller.value),
      onMoveNext: widget.onMoveNext,
      summary: summary,
      placeholder: widget.placeholder,
      listBuilder: (BuildContext context) {
        return SelectList(
          navTitle: widget.navTitle,
          controller: _controller,
          enableSelectAllOption: widget.enableSelectAllOption,
          items: widget.items,
        );
      },
    );
  }
}
