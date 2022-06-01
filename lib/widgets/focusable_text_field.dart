import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class FocusableTextField extends HookWidget {
  final InputDecoration? decoration;
  final int? maxLines;
  final int? maxCharacters;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final Function(bool)? onFocusChange;
  final Function(String)? onChange;

  final String? text;
  const FocusableTextField({
    this.decoration = const InputDecoration(),
    this.maxCharacters,
    this.keyboardType,
    this.textInputAction,
    this.maxLines = 1,
    this.controller,
    this.onFocusChange,
    this.onChange,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    final FocusNode focusNode = useFocusNode();

    useEffect(() {
      focusNode.addListener(() {
        if (onFocusChange != null) {
          onFocusChange!(focusNode.hasFocus);
        }
      });
      return;
    }, [focusNode]);

    return TextField(
      focusNode: focusNode,
      controller: controller,
      keyboardType: TextInputType.text,
      decoration: decoration,
      maxLines: maxLines,
      maxLength: maxCharacters,
      textInputAction: textInputAction,
      onChanged: (value) {
        if (onChange != null) {
          onChange!(value);
        }
      },
    );
  }
}
