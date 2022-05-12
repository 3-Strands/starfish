import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class FocusableTextField extends HookWidget {
  InputDecoration? decoration = InputDecoration();
  int? maxLines = 1;
  int? maxCharacters = 1;
  TextInputAction? textInputAction;
  TextInputType? keyboardType;
  TextEditingController? controller;
  Function(bool)? onFocusChange;

  String? text;
  FocusableTextField({
    this.decoration,
    this.maxCharacters,
    this.keyboardType,
    this.textInputAction,
    this.maxLines,
    this.controller,
    this.onFocusChange,
  });

  @override
  Widget build(BuildContext context) {
    final FocusNode focusNode = useFocusNode();

    useEffect(() {
      focusNode.addListener(() {
        // print("Has focus: ${focusNode.hasFocus}");
        if (onFocusChange != null) {
          onFocusChange!(focusNode.hasFocus);
        }
      });
      return; // You need this return if you have missing_return lint
    }, [focusNode]);

    return TextField(
      focusNode: focusNode,
      controller: controller,
      keyboardType: TextInputType.text,
      decoration: decoration,
      maxLines: maxLines,
      maxLength: maxCharacters,
      textInputAction: textInputAction,
      onChanged: (value) {},
    );
  }
}
