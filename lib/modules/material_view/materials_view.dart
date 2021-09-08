import 'package:flutter/material.dart';
import 'package:grpc/grpc.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:starfish/constants/strings.dart';
import 'package:starfish/repository/materials_repository.dart';
import 'package:starfish/widgets/settings_edit_button_widget.dart';
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
  List<starfish.Material> _materialsList = [];

  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _getMaterials();
  }

  void _getMaterials() async {
    await MaterialRepository()
        .getMaterials()
        .then((ResponseStream<starfish.Material> material) {
      material.listen((value) {
        print(value.title);
        setState(() {
          _materialsList.add(value);
        });
      }, onError: ((err) {
        print(err);
      }), onDone: () {
        print('done');
      });
    });
  }

  List<MaterialList> _buildList() {
    return _materialsList
        .map((material) => new MaterialList(material, this))
        .toList();
  }

  List<MaterialList> _buildSearchList() {
    return _materialsList
        .map((material) => new MaterialList(material, this))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.materialSceenBG,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Column(
          children: [
            Container(
                width: 375.w, height: 52.h, child: Text("Search language")),
            Container(width: 375.w, height: 52.h, child: Text("Select topics")),
            Container(width: 375.w, height: 52.h, child: Text("Search")),
            Container(width: 375.w, height: 52.h, child: Text("Topics")),
            Expanded(
              child: Container(
                width: 375.w,
                child: ListView(
                  padding: EdgeInsets.only(left: 15.0.w, right: 15.0.w),
                  children: _isSearching ? _buildSearchList() : _buildList(),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}

class MaterialList extends StatelessWidget {
  final starfish.Material material;
  final _MaterialsScreenState obj;

  MaterialList(this.material, this.obj);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: InkWell(
        child: Container(
          margin: EdgeInsets.only(left: 15.0.w),
          height: 99,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Container(
                height: 22.h,
                margin: EdgeInsets.only(left: 25.0.w, right: 25.0.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Title: ${material.title}',
                    ),
                    openButton()
                  ],
                ),
              ),
              taskStatus(AppColors.completeTaskBGColor, 'complete'),
              taskStatus(AppColors.overdueTaskBGColor, 'overdueTaskBGColor'),
            ],
          ),
        ),
        onTap: () => {},
      ),
      elevation: 5,
    );
  }

  InkWell openButton() {
    return InkWell(
      onTap: () {
        print('open button tap');
      },
      child: Container(
        width: 55.w,
        height: 44.h,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.open_in_new,
              color: Colors.blue,
              size: 18.sp,
            ),
            Text(
              Strings.open,
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.blue,
              ),
            )
          ],
        ),
      ),
    );
  }

  Container taskStatus(Color color, String label) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: color,
      ),
      margin: EdgeInsets.only(left: 5.0.w, right: 15.0.w),
      height: 17.h,
      child: Center(child: Text(label)),
    );
  }
}
