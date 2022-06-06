import 'package:flutter/material.dart';

import 'select_list.dart';
import 'select_list_button.dart';

class SingleSelectController<T> extends SelectListController<T, T?> {
  SingleSelectController({T? initialSelection})
    : super(initialSelection);

  bool get hasSelected => value != null;
  bool get isSelectionComplete => hasSelected;

  @override
  bool isSelected(T item) => value == item;

  @override
  bool isAllSelected(List<T> items) => false;

  @override
  String? toggleSelected(T item, bool isSelected) {
    value = isSelected ? item : null;
    return null;
  }

  @override
  void setAllSelected(List<T> items, bool isSelected) => throw Exception('Cannot select all in a single select.');
}

class SingleSelect<T> extends StatefulWidget {
  final String navTitle;
  final String placeholder;
  final bool enabled;
  final List<T> items;
  final T? initialSelection;
  final void Function(T? selectedItems)? onFinished;
  final VoidCallback? onMoveNext;
  final ToDisplay<T> toDisplay;

  SingleSelect({
    Key? key,
    required this.navTitle,
    required this.placeholder,
    required this.items,
    required this.toDisplay,
    this.initialSelection,
    this.enabled = true,
    this.onFinished,
    this.onMoveNext,
  }) : super(key: key);

  @override
  _SingleSelectState<T> createState() => _SingleSelectState<T>();
}

class _SingleSelectState<T> extends State<SingleSelect<T>> {
  late SingleSelectController<T> _controller;

  @override
  void initState() {
    _controller = SingleSelectController<T>(
      initialSelection: widget.initialSelection,
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String? get summary => _controller.value == null ? null : widget.toDisplay(_controller.value!);

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
          enableSelectAllOption: false,
          items: widget.items,
          toDisplay: widget.toDisplay,
        );
      },
    );
  }
}

