import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:sizer/sizer.dart';
import 'package:starfish/constants/assets_path.dart';
import 'package:starfish/constants/strings.dart';
import 'package:starfish/constants/text_styles.dart';
import 'package:starfish/widgets/app_logo_widget.dart';
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
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Container(
          height: 100.0.h,
          width: 100.0.w,
          color: Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              AppLogo(hight: 4.4.h, width: 9.6.w),
              Text(
                Strings.settings,
                style: dashboardNavigationTitle,
              ),
              IconButton(
                icon: SvgPicture.asset(AssetsPath.settingsActive),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Stack(
          children: <Widget>[
            Container(
              height: 100.h,
              width: 100.h,
              color: AppColors.background,
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
