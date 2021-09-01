import 'package:flutter/material.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:sizer/sizer.dart';
import 'package:starfish/widgets/title_label_widget.dart';

class SettingsScreen extends StatefulWidget {
  SettingsScreen({Key? key, this.title = ''}) : super(key: key);

  final String title;

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Stack(
          children: <Widget>[
            Container(
              height: 100.h,
              width: 100.h,
              color: AppColors.materialSceenBG,
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.fromLTRB(4.0.w, 14.5.h, 4.0.w, 4.0.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TitleLabel(
                        title: 'settings',
                        align: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
