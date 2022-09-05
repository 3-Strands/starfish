import 'package:flutter/material.dart';

class FocusableTextField extends StatefulWidget {
  final InputDecoration? decoration;
  final int? maxLines;
  final int? maxCharacters;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final Function(String)? onChange;
  final Function(String)? onFieldSubmitted;

  final String? initialValue;
  const FocusableTextField({
    this.decoration = const InputDecoration(),
    this.maxCharacters,
    this.keyboardType,
    this.textInputAction,
    this.maxLines = 1,
    this.controller,
    this.onChange,
    this.onFieldSubmitted,
    this.initialValue,
  });

  @override
  State<FocusableTextField> createState() => _FocusableTextFieldState();
}

class _FocusableTextFieldState extends State<FocusableTextField> {
  final FocusNode _focusNode = FocusNode();
  late TextEditingController _controller;

  void _onFocusChange() {
    if (!_focusNode.hasFocus) {
      widget.onFieldSubmitted?.call(_controller.text);
    }
  }

  @override
  void initState() {
    _focusNode.addListener(_onFocusChange);
    _controller =
        widget.controller ?? TextEditingController(text: widget.initialValue);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant FocusableTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      if (oldWidget.controller == null) {
        _controller.dispose();
      }
      _controller =
          widget.controller ?? TextEditingController(text: _controller.text);
    }
  }

  @override
  void dispose() {
    _focusNode
      ..removeListener(_onFocusChange)
      ..dispose();
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: Color(0xFFFFFFFF),
        border: Border.fromBorderSide(
          BorderSide(
            color: Color(0xFF979797),
          ),
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: TextFormField(
        controller: _controller,
        focusNode: _focusNode,
        keyboardType: TextInputType.text,
        decoration: widget.decoration,
        maxLines: widget.maxLines,
        maxLength: widget.maxCharacters,
        textInputAction: widget.textInputAction,
        onFieldSubmitted: widget.onFieldSubmitted,
        onChanged: widget.onChange,
      ),
    );
  }
}
