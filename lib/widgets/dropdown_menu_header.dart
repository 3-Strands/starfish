import 'package:flutter/material.dart';

class DropdownMenuHeader<T> extends DropdownMenuItem<T> {
  DropdownMenuHeader({Key? key, required Widget child})
      : super(
          key: key,
          enabled: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(height: 1),
              child,
              const Divider(height: 1, thickness: 1),
            ],
          ),
        );
}
