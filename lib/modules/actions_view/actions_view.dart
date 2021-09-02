import 'package:flutter/material.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:starfish/widgets/title_label_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ActionsScreen extends StatefulWidget {
  ActionsScreen({Key? key, this.title = ''}) : super(key: key);

  final String title;

  @override
  _ActionsScreenState createState() => _ActionsScreenState();
}

class _ActionsScreenState extends State<ActionsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Container(
          width: 375.w,
          height: 812.h,
          color: AppColors.actionScreenBG,
          child: TitleLabel(
            title: '',
            align: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
