import 'package:flutter/material.dart';
import 'package:grpc/grpc.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:starfish/repository/materials_repository.dart';
import 'package:starfish/widgets/title_label_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starfish/src/generated/starfish.pb.dart' as starfish;

class MaterialsScreen extends StatefulWidget {
  MaterialsScreen({Key? key, this.title = ''}) : super(key: key);

  final String title;

  @override
  _MaterialsScreenState createState() => _MaterialsScreenState();
}

class _MaterialsScreenState extends State<MaterialsScreen> {
  @override
  void initState() {
    super.initState();
    _getMaterials();
  }

  void _getMaterials() async {
    await MaterialRepository()
        .getMaterials()
        .then((ResponseStream<starfish.Material> materials) {
      materials.listen((value) {
        print(value.title);
      }, onError: ((err) {
        print(err);
      }), onDone: () {
        print('done');
      });
    });
  }

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
          color: AppColors.materialSceenBG,
          child: TitleLabel(
            title: '',
            align: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
