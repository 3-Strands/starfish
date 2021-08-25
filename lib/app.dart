import 'package:flutter/material.dart';
import 'package:starfish/config/app_config.dart';

class Starfish extends StatelessWidget {
  Starfish({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color:FlavorConfig.isDevelopment()? Colors.green : Colors.red,
    );
  }
}
