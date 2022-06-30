import 'dart:async';

import 'package:flutter/material.dart';

class Countdown extends StatefulWidget {
  final int seconds;
  final Widget Function(BuildContext context, int secondsLeft) builder;
  final VoidCallback? onDone;

  const Countdown({
    Key? key,
    required this.builder,
    this.onDone,
    this.seconds = 60,
  }) : super(key: key);

  @override
  State<Countdown> createState() => _CountdownState();
}

class _CountdownState extends State<Countdown> {
  late int _secondsLeft;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _secondsLeft = widget.seconds;
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) {
        if (_secondsLeft == 0) {
          widget.onDone?.call();
        } else {
          setState(() {
            _secondsLeft--;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _secondsLeft);
  }
}