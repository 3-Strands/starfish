import 'package:flutter/material.dart';

class ConstrainCenter extends StatelessWidget {
  final Widget child;

  const ConstrainCenter({ Key? key, required this.child }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 500),
        child: child,
      ),
    );
  }
}
