import 'package:flutter/material.dart';
import 'package:grpc/grpc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:smart_select/smart_select.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:starfish/constants/strings.dart';
import 'package:starfish/db/hive_country.dart';
import 'package:starfish/db/hive_database.dart';
import 'package:starfish/db/hive_language.dart';
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
  List<HiveLanguage> _selectedLanguages = [];

  late List<HiveLanguage> _languageList;
  late Box<HiveLanguage> _languageBox;

  @override
  void initState() {
    super.initState();
    _languageBox = Hive.box<HiveLanguage>(HiveDatabase.LANGUAGE_BOX);

    _getMaterials();
    _getAllLanguages();
  }

  void _getAllLanguages() {
    _languageList = _languageBox.values.toList();
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 14.h),
              _buildLanguagesContainer(),
              SizedBox(height: 10.h),
              _buildTopicsContainer(),
              SizedBox(height: 10.h),
              _buildSearchContainer(),
              SizedBox(height: 10.h),
              Container(
                height: 80.h,
                margin: EdgeInsets.only(left: 15.w, right: 15.w),
                decoration: BoxDecoration(
                  color: AppColors.txtFieldBackground,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: Center(child: Text('')),
              ),
              SizedBox(
                height: 30.h,
              ),
              ListView(
                primary: false,
                shrinkWrap: true,
                padding: EdgeInsets.only(left: 10.0.w, right: 10.0.w),
                children: _isSearching ? _buildSearchList() : _buildList(),
              ),
              SizedBox(
                height: 10.h,
              ),

            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }

  Container _buildSearchContainer() {
    return Container(
      height: 52.h,
      margin: EdgeInsets.only(left: 15.w, right: 15.w),
      decoration: BoxDecoration(
        color: AppColors.txtFieldBackground,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Center(
        child: Text('Search'),
      ),
    );
  }

  Container _buildLanguagesContainer() {
    return Container(
      height: 80.h,
      margin: EdgeInsets.only(left: 15.w, right: 15.w),
      decoration: BoxDecoration(
        color: AppColors.txtFieldBackground,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Center(
        child: SmartSelect<HiveLanguage>.multiple(
          title: Strings.selectLanugages,
          placeholder: Strings.searchLanguagesPlaceholder,
          value: _selectedLanguages,
          onChange: (selected) =>
              setState(() => _selectedLanguages = selected.value),
          choiceItems: S2Choice.listFrom<HiveLanguage, HiveLanguage>(
            source: _languageList,
            value: (index, item) => item,
            title: (index, item) => item.name,
            //  group: (index, item) => item['brand'],
          ),
          choiceGrouped: false,
          modalFilter: true,
          modalFilterAuto: true,
          modalType: S2ModalType.fullPage,
          tileBuilder: (context, state) {
            return S2Tile.fromState(
              state,
              isTwoLine: true,
              title: Text(
                Strings.selectLanugages,
                style: TextStyle(color: AppColors.appTitle, fontSize: 16.sp),
              ),
              
            );
          },
        ),
      ),
    );
  }

  Container _buildTopicsContainer() {
    return Container(
      height: 80.h,
      margin: EdgeInsets.only(left: 15.w, right: 15.w),
      decoration: BoxDecoration(
        color: AppColors.txtFieldBackground,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Center(
        child: SmartSelect<HiveLanguage>.multiple(
          title: "Select topics",
          placeholder: Strings.searchLanguagesPlaceholder,
          value: _selectedLanguages,
          onChange: (selected) =>
              setState(() => _selectedLanguages = selected.value),
          choiceItems: S2Choice.listFrom<HiveLanguage, HiveLanguage>(
            source: _languageList,
            value: (index, item) => item,
            title: (index, item) => item.name,
            //  group: (index, item) => item['brand'],
          ),
          choiceGrouped: false,
          modalFilter: true,
          modalFilterAuto: true,
          modalType: S2ModalType.fullPage,
          tileBuilder: (context, state) {
            return S2Tile.fromState(
              state,
              isTwoLine: true,
              title: Text(
                Strings.selectLanugages,
                style: TextStyle(color: AppColors.appTitle, fontSize: 16.sp),
              ),
            );
          },
        ),
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
      color: AppColors.txtFieldBackground,
      child: InkWell(
        child: Container(
          margin: EdgeInsets.only(left: 15.0.w,right: 15.0.w),
          height: 99,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Container(
                height: 22.h,
               // margin: EdgeInsets.only(left: 25.0.w, right: 25.0.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Title: ${material.title}',
                      textAlign: TextAlign.left,
                      style: TextStyle(color: AppColors.txtFieldTextColor),
                    ),
                    Spacer(),
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
        color: Colors.transparent,
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
