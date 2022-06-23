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
  bool get isSelectionComplete =>
      hasMaxLimit && value.length > maxSelectItemLimit!;

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
    value = newValue;
    return null;
  }

  void setAllSelected(List<T> items, bool isSelected) {
    value = isSelected ? items.toSet() : Set();
  }
}

class MultiSelect<T> extends StatefulWidget {
  final String navTitle;
  final String placeholder;
  final int? maxSelectItemLimit;
  final Set<T>? initialSelection;
  final bool enableSelectAllOption;
  final bool inverseSelectAll;
  final bool enabled;
  final bool multilineSummary;
  final List<T> items;
  final MultiSelectController<T>? controller;
  final void Function(Set<T> selectedItems)? onFinished;
  final VoidCallback? onMoveNext;
  final ToDisplay<T> toDisplay;

  MultiSelect({
    Key? key,
    required this.navTitle,
    required this.placeholder,
    required this.items,
    this.controller,
    this.initialSelection,
    this.maxSelectItemLimit,
    this.enabled = true,
    this.enableSelectAllOption = false,
    this.inverseSelectAll = false, // Inverse the behaviour of selectAll
    this.multilineSummary = false,
    this.onFinished,
    this.onMoveNext,
    required this.toDisplay,
  })  : assert(controller == null ||
            (maxSelectItemLimit == null && initialSelection == null)),
        super(key: key);

  @override
  MultiSelectState<T> createState() => MultiSelectState<T>();
}

class MultiSelectState<T> extends State<MultiSelect<T>> {
  MultiSelectController<T>? _localController;

  MultiSelectController<T> get _effectiveController =>
      widget.controller ?? _localController!;

  @override
  void initState() {
    if (widget.controller == null) {
      _localController = MultiSelectController<T>(
        initialSelection: widget.initialSelection,
        maxSelectItemLimit: widget.maxSelectItemLimit,
      );
    }
    super.initState();
  }

  @override
  void didUpdateWidget(covariant MultiSelect<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    final oldController = oldWidget.controller;
    final controller = widget.controller;
    if (oldController != null && controller == null) {
      _localController = MultiSelectController<T>(
        initialSelection: widget.initialSelection,
        maxSelectItemLimit: widget.maxSelectItemLimit,
      );
      _localController!.value = oldController.value;
    } else if (controller != null && oldController == null) {
      _localController = null;
    }
  }

  @override
  void dispose() {
    _localController?.dispose();
    super.dispose();
  }

  String? get summary => _effectiveController.hasSelected
      ? _effectiveController.value
          .map((item) => widget.toDisplay(item))
          .join(', ')
      : null;

  @override
  Widget build(BuildContext context) {
    return SelectListButton(
      enabled: widget.enabled,
      multilineSummary: widget.multilineSummary,
      onFinished: () => widget.onFinished?.call(_effectiveController.value),
      onMoveNext: widget.onMoveNext,
      summary: summary,
      placeholder: widget.placeholder,
      listBuilder: (BuildContext context) {
        return SelectList(
          navTitle: widget.navTitle,
          controller: _effectiveController,
          enableSelectAllOption: widget.enableSelectAllOption,
          inverseSelectAll: widget.inverseSelectAll,
          items: widget.items,
          toDisplay: widget.toDisplay,
        );
      },
    );
  }
}
