import 'package:flutter/material.dart';
import 'package:template_string/template_string.dart';

import 'select_list.dart';
import 'select_list_button.dart';

class MultiSelectController<T> extends SelectListController<T, Set<T>> {
  int? maxSelectItemLimit;
  String? maxLimitOverAlertMessage;

  MultiSelectController({
    Set<T>? initialSelection,
    this.maxSelectItemLimit,
    this.maxLimitOverAlertMessage,
  }) : super(initialSelection ?? {});

  bool get hasMaxLimit => maxSelectItemLimit != null;

  bool get hasSelected => value.isNotEmpty;
  bool get isSelectionComplete =>
      hasMaxLimit && value.length >= maxSelectItemLimit!;

  @override
  bool isSelected(T item) => value.contains(item);

  @override
  bool isAllSelected(List<T> items) => value.length == items.length;

  @override
  String? toggleSelected(T item, bool isSelected) {
    if (isSelected && isSelectionComplete) {
      return '${maxLimitOverAlertMessage ?? "Maximum {{max_limit}} items can be selected."}'
          .insertTemplateValues({'max_limit': maxSelectItemLimit!});
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
  final String? maxLimitOverAlertMessage;
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
  final Widget Function(T item)? displayItem;

  MultiSelect({
    Key? key,
    required this.navTitle,
    required this.placeholder,
    required this.items,
    this.controller,
    this.initialSelection,
    this.maxSelectItemLimit,
    this.maxLimitOverAlertMessage,
    this.enabled = true,
    this.enableSelectAllOption = false,
    this.inverseSelectAll = false, // Inverse the behaviour of selectAll
    this.multilineSummary = false,
    this.onFinished,
    this.onMoveNext,
    required this.toDisplay,
    this.displayItem,
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

  _rebuild() {
    setState(() {});
  }

  @override
  void initState() {
    if (widget.controller == null) {
      _localController = MultiSelectController<T>(
        initialSelection: widget.initialSelection,
        maxSelectItemLimit: widget.maxSelectItemLimit,
        maxLimitOverAlertMessage: widget.maxLimitOverAlertMessage,
      );
    }
    _effectiveController.addListener(_rebuild);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant MultiSelect<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    final oldController = oldWidget.controller?..removeListener(_rebuild);
    final controller = widget.controller?..addListener(_rebuild);
    if (oldController != null && controller == null) {
      _localController = MultiSelectController<T>(
        initialSelection: widget.initialSelection,
        maxSelectItemLimit: widget.maxSelectItemLimit,
        maxLimitOverAlertMessage: widget.maxLimitOverAlertMessage,
      );
      _localController!.value = oldController.value;
    } else if (controller != null && oldController == null) {
      _localController = null;
    }
  }

  @override
  void dispose() {
    _localController?.dispose();
    _effectiveController.removeListener(_rebuild);
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
          displayItem: widget.displayItem,
        );
      },
    );
  }
}
