import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:starfish/constants/assets_path.dart';
import 'package:starfish/constants/strings.dart';
import 'package:starfish/constants/text_styles.dart';
import 'package:starfish/db/hive_database.dart';
import 'package:starfish/db/hive_language.dart';
import 'package:starfish/db/hive_material_topic.dart';
import 'package:starfish/db/hive_material_type.dart';
import 'package:starfish/smart_select/src/model/choice_item.dart';
import 'package:starfish/smart_select/src/model/modal_config.dart';
import 'package:starfish/smart_select/src/tile/tile.dart';
import 'package:starfish/smart_select/src/widget.dart';
import 'package:starfish/src/generated/starfish.pb.dart';
import 'package:starfish/widgets/app_logo_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddNewMaterialScreen extends StatefulWidget {
  AddNewMaterialScreen({
    Key? key,
  }) : super(key: key);

  @override
  _AddNewMaterialScreenState createState() => _AddNewMaterialScreenState();
}

class _AddNewMaterialScreenState extends State<AddNewMaterialScreen> {
  List<HiveLanguage> _selectedLanguages = [];
  List<HiveMaterialType> _selectedTypes = [];
  List<HiveMaterialTopic> _selectedTopics = [];
  String? _editableBy;

  late Box<HiveLanguage> _languageBox;
  late Box<HiveMaterialType> _materialTypeBox;
  late Box<HiveMaterialTopic> _materialTopicBox;

  @override
  void initState() {
    super.initState();
    _languageBox = Hive.box<HiveLanguage>(HiveDatabase.LANGUAGE_BOX);
    _materialTypeBox =
        Hive.box<HiveMaterialType>(HiveDatabase.MATERIAL_TYPE_BOX);
    _materialTopicBox =
        Hive.box<HiveMaterialTopic>(HiveDatabase.MATERIAL_TOPIC_BOX);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.materialSceenBG,
      appBar: AppBar(
        backgroundColor: AppColors.materialSceenBG,
        leadingWidth: 37.w,
        leading: AppLogo(hight: 36.h, width: 37.w),
        centerTitle: true,
        title: Text(
          Strings.addNewMaterial,
          style: dashboardNavigationTitle,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                keyboardType: TextInputType.text,
                style: formTitleTextStyle,
                decoration: InputDecoration(
                  hintText: Strings.hintMaterialName,
                  hintStyle: formTitleHintStyle,
                  contentPadding: EdgeInsets.fromLTRB(0.w, 0.0, 5.0.w, 0.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0.r),
                    borderSide: BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0.r),
                    borderSide: BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0.r),
                    borderSide: BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.transparent,
                ),
              ),
              SizedBox(height: 21.h),
              Text(
                Strings.descripton,
                textAlign: TextAlign.left,
                style: titleTextStyle,
              ),
              SizedBox(height: 11.h),
              TextFormField(),
              SizedBox(height: 21.h),
              Text(
                Strings.addWebLink,
                textAlign: TextAlign.left,
                style: titleTextStyle,
              ),
              SizedBox(height: 11.h),
              TextFormField(),
              SizedBox(height: 21.h),
              Text(
                Strings.uploadAMaterial,
                textAlign: TextAlign.left,
                style: titleTextStyle,
              ),
              SizedBox(height: 11.h),
              TextFormField(),
              SizedBox(height: 10.h),

              // Add Materials
              DottedBorder(
                borderType: BorderType.RRect,
                radius: Radius.circular(30.r),
                color: Color(0xFF3475F0),
                child: Container(
                  width: double.infinity,
                  height: 50.h,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      Strings.addNewMaterial,
                      style: TextStyle(
                        fontFamily: 'OpenSans',
                        fontSize: 14.sp,
                        color: Color(0xFF3475F0),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.transparent,
                      shadowColor: Colors.transparent,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 21.h),

              // Language Selection
              Text(
                Strings.lanugages,
                textAlign: TextAlign.left,
                style: titleTextStyle,
              ),
              SizedBox(height: 11.h),
              Container(
                height: 80.h,
                //margin: EdgeInsets.only(left: 15.w, right: 15.w),
                decoration: BoxDecoration(
                  color: AppColors.txtFieldBackground,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: Center(
                  child: SmartSelect<HiveLanguage>.multiple(
                    title: Strings.lanugages,
                    placeholder: Strings.selectLanugages,
                    selectedValue: _selectedLanguages,
                    onChange: (selected) {
                      setState(() => _selectedLanguages = selected.value);
                    },
                    choiceItems: S2Choice.listFrom<HiveLanguage, HiveLanguage>(
                        source: _languageBox.values.toList(),
                        value: (index, item) => item,
                        title: (index, item) => item.name,
                        group: (index, item) {
                          return '';
                        }),
                    choiceGrouped: true,
                    modalType: S2ModalType.fullPage,
                    modalFilter: true,
                    modalFilterAuto: true,
                    tileBuilder: (context, state) {
                      return S2Tile.fromState(
                        state,
                        isTwoLine: true,
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: 21.h),

              // Type Selection
              Text(
                Strings.type,
                textAlign: TextAlign.left,
                style: titleTextStyle,
              ),
              SizedBox(height: 11.h),
              Container(
                height: 80.h,
                //margin: EdgeInsets.only(left: 15.w, right: 15.w),
                decoration: BoxDecoration(
                  color: AppColors.txtFieldBackground,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: Center(
                  child: SmartSelect<HiveMaterialType>.multiple(
                    title: Strings.selectType,
                    placeholder: Strings.selectType,
                    selectedValue: _selectedTypes,
                    onChange: (selected) {
                      setState(() => _selectedTypes = selected.value);
                    },
                    choiceItems:
                        S2Choice.listFrom<HiveMaterialType, HiveMaterialType>(
                            source: _materialTypeBox.values.toList(),
                            value: (index, item) => item,
                            title: (index, item) => item.name,
                            group: (index, item) {
                              return '';
                            }),
                    choiceGrouped: true,
                    modalType: S2ModalType.fullPage,
                    modalFilter: true,
                    modalFilterAuto: true,
                    tileBuilder: (context, state) {
                      return S2Tile.fromState(
                        state,
                        isTwoLine: true,
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: 21.h),

              // Topic Selection
              Text(
                Strings.topics,
                textAlign: TextAlign.left,
                style: titleTextStyle,
              ),
              SizedBox(height: 11.h),
              Container(
                height: 80.h,
                //margin: EdgeInsets.only(left: 15.w, right: 15.w),
                decoration: BoxDecoration(
                  color: AppColors.txtFieldBackground,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: Center(
                  child: SmartSelect<HiveMaterialTopic>.multiple(
                    title: Strings.topics,
                    placeholder: Strings.selectTopics,
                    selectedValue: _selectedTopics,
                    onChange: (selected) {
                      setState(() => _selectedTopics = selected.value);
                    },
                    choiceItems:
                        S2Choice.listFrom<HiveMaterialTopic, HiveMaterialTopic>(
                            source: _materialTopicBox.values.toList(),
                            value: (index, item) => item,
                            title: (index, item) => item.name,
                            group: (index, item) {
                              return '';
                            }),
                    choiceGrouped: true,
                    modalType: S2ModalType.fullPage,
                    modalFilter: true,
                    modalFilterAuto: true,
                    tileBuilder: (context, state) {
                      return S2Tile.fromState(
                        state,
                        isTwoLine: true,
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: 21.h),

              //Seen by
              Text(
                Strings.seenBy,
                textAlign: TextAlign.left,
                style: titleTextStyle,
              ),
              SizedBox(height: 11.h),
              Container(
                height: 80.h,
                width: double.infinity,
                padding: EdgeInsets.only(left: 15.w, right: 15.w),
                decoration: BoxDecoration(
                  color: AppColors.txtFieldBackground,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    style: TextStyle(
                      color: Color(0xFF434141),
                      fontSize: 16.sp,
                      fontFamily: 'OpenSans',
                    ),
                    hint: Text(
                      Strings.seenBy,
                      style: TextStyle(
                        color: Color(0xFF434141),
                        fontSize: 16.sp,
                        fontFamily: 'OpenSans',
                      ),
                    ),
                    onChanged: (String? value) {
                      _editableBy = value;
                    },
                    items: <String>[
                      'Group I teach or administer',
                      'Anyone at all',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(
                            color: Color(0xFF434141),
                            fontSize: 14.sp,
                            fontFamily: 'OpenSans',
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              SizedBox(height: 21.h),

              //Edited by
              Text(
                Strings.editedBy,
                textAlign: TextAlign.left,
                style: titleTextStyle,
              ),
              SizedBox(height: 11.h),
              Container(
                height: 80.h,
                width: double.infinity,
                padding: EdgeInsets.only(left: 15.w, right: 15.w),
                decoration: BoxDecoration(
                  color: AppColors.txtFieldBackground,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    style: TextStyle(
                      color: Color(0xFF434141),
                      fontSize: 16.sp,
                      fontFamily: 'OpenSans',
                    ),
                    hint: Text(
                      Strings.editedBy,
                      style: TextStyle(
                        color: Color(0xFF434141),
                        fontSize: 16.sp,
                        fontFamily: 'OpenSans',
                      ),
                    ),
                    onChanged: (String? value) {
                      _editableBy = value;
                    },
                    items: <String>[
                      'Only me',
                      'Other Teacher of my Groups',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(
                            color: Color(0xFF434141),
                            fontSize: 14.sp,
                            fontFamily: 'OpenSans',
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 75.h,
        padding: EdgeInsets.symmetric(vertical: 18.75.h, horizontal: 30.w),
        color: AppColors.txtFieldBackground,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(Strings.cancel),
              ),
            ),
            SizedBox(width: 25.w),
            Expanded(
              child: ElevatedButton(
                onPressed: () {},
                child: Text(Strings.add),
                style: ElevatedButton.styleFrom(
                  primary: AppColors.selectedButtonBG,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
