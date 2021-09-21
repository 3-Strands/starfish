import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:starfish/constants/assets_path.dart';
import 'package:starfish/constants/strings.dart';
import 'package:starfish/constants/text_styles.dart';
import 'package:starfish/db/hive_database.dart';
import 'package:starfish/db/hive_edit.dart';
import 'package:starfish/db/hive_language.dart';
import 'package:starfish/db/hive_material.dart';
import 'package:starfish/db/hive_material_topic.dart';
import 'package:starfish/db/hive_material_type.dart';
import 'package:starfish/enums/material_editability.dart';
import 'package:starfish/enums/material_visibility.dart';
import 'package:starfish/repository/materials_repository.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:starfish/smart_select/src/model/choice_item.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:starfish/smart_select/src/model/modal_config.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:starfish/smart_select/src/tile/tile.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:starfish/smart_select/src/widget.dart';
import 'package:starfish/src/generated/starfish.pb.dart';
import 'package:starfish/utils/helpers/alerts.dart';
import 'package:starfish/utils/helpers/snackbar.dart';
import 'package:starfish/widgets/app_logo_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starfish/widgets/history_item.dart';

class AddEditMaterialScreen extends StatefulWidget {
  final HiveMaterial? material;

  AddEditMaterialScreen({
    Key? key,
    this.material,
  }) : super(key: key);

  @override
  _AddEditMaterialScreenState createState() => _AddEditMaterialScreenState();
}

class _AddEditMaterialScreenState extends State<AddEditMaterialScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _webLinkController = TextEditingController();

  bool _isEditMode = false;

  List<HiveLanguage> _selectedLanguages = [];
  List<HiveMaterialType> _selectedTypes = [];
  List<HiveMaterialTopic> _selectedTopics = [];
  MaterialVisibility? _visibleTo;
  MaterialEditability? _editableBy;

  late Box<HiveLanguage> _languageBox;
  late Box<HiveMaterial> _materialBox;
  late Box<HiveMaterialType> _materialTypeBox;
  late Box<HiveMaterialTopic> _materialTopicBox;

  @override
  void initState() {
    super.initState();
    _languageBox = Hive.box<HiveLanguage>(HiveDatabase.LANGUAGE_BOX);
    _materialBox = Hive.box<HiveMaterial>(HiveDatabase.MATERIAL_BOX);
    _materialTypeBox =
        Hive.box<HiveMaterialType>(HiveDatabase.MATERIAL_TYPE_BOX);
    _materialTopicBox =
        Hive.box<HiveMaterialTopic>(HiveDatabase.MATERIAL_TOPIC_BOX);

    if (widget.material != null) {
      _isEditMode = true;

      _titleController.text = widget.material!.title!;
      _descriptionController.text = widget.material!.description!;
      _webLinkController.text = widget.material!.url!;

      _selectedLanguages = _languageBox.values
          .where((HiveLanguage language) =>
              widget.material!.languageIds!.contains(language.id))
          .toList();

      _selectedTypes = _materialTypeBox.values
          .where((HiveMaterialType type) =>
              widget.material!.typeIds!.contains(type.id))
          .toList();

      _selectedTopics = _materialTopicBox.values
          .where((HiveMaterialTopic topic) =>
              widget.material!.topics!.contains(topic.id))
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.materialSceenBG,
      appBar: AppBar(
        backgroundColor: AppColors.materialSceenBG,
        automaticallyImplyLeading: false,
        title: Container(
          height: 64.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              AppLogo(hight: 36.h, width: 37.w),
              Text(
                _isEditMode ? Strings.editMaterial : Strings.addNewMaterial,
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
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _titleController,
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

                // Description
                Text(
                  Strings.descripton,
                  textAlign: TextAlign.left,
                  style: titleTextStyle,
                ),
                SizedBox(height: 11.h),
                TextFormField(
                  maxLines: 4,
                  controller: _descriptionController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.fromLTRB(15.0.w, 0.0, 5.0.w, 0.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                    filled: true,
                    fillColor: AppColors.txtFieldBackground,
                  ),
                ),
                SizedBox(height: 21.h),

                // Web Link
                Text(
                  Strings.addWebLink,
                  textAlign: TextAlign.left,
                  style: titleTextStyle,
                ),
                SizedBox(height: 11.h),
                TextFormField(
                  controller: _webLinkController,
                  keyboardType: TextInputType.url,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.fromLTRB(15.0.w, 0.0, 5.0.w, 0.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                    filled: true,
                    fillColor: AppColors.txtFieldBackground,
                  ),
                ),
                SizedBox(height: 21.h),

                // Upload Material
                Text(
                  Strings.uploadAMaterial,
                  textAlign: TextAlign.left,
                  style: titleTextStyle,
                ),
                SizedBox(height: 11.h),
                TextFormField(
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.fromLTRB(15.0.w, 0.0, 5.0.w, 0.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                    filled: true,
                    fillColor: AppColors.txtFieldBackground,
                  ),
                ),
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
                      choiceItems:
                          S2Choice.listFrom<HiveLanguage, HiveLanguage>(
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
                      choiceItems: S2Choice.listFrom<HiveMaterialTopic,
                              HiveMaterialTopic>(
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
                    child: DropdownButton<MaterialVisibility>(
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
                      onTap: () {
                        _dismissFieldFocus();
                      },
                      onChanged: (MaterialVisibility? value) {
                        _visibleTo = value;
                      },
                      items: MaterialVisibility.values()
                          .map((MaterialVisibility visibility) {
                        return DropdownMenuItem<MaterialVisibility>(
                          value: visibility,
                          child: Text(
                            visibility.displayName ?? visibility.value.name,
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
                    child: DropdownButton<MaterialEditability>(
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
                      onTap: () {
                        _dismissFieldFocus();
                      },
                      onChanged: (MaterialEditability? value) {
                        _editableBy = value;
                      },
                      items: MaterialEditability.values()
                          .map<DropdownMenuItem<MaterialEditability>>(
                              (MaterialEditability editability) {
                        return DropdownMenuItem<MaterialEditability>(
                          value: editability,
                          child: Text(
                            editability.displayName ?? editability.value.name,
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

                if (widget.material != null)
                  _editHistoryContainer(widget.material),

                SizedBox(height: 11.h),
              ],
            ),
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
                onPressed: () {
                  HiveMaterial _hiveMaterial = HiveMaterial(
                    title: _titleController.text,
                    url: _webLinkController.text,
                    description: _descriptionController.text,
                    languageIds: _selectedLanguages
                        .map((HiveLanguage language) => language.id)
                        .toList(),
                    typeIds: _selectedTypes
                        .map((HiveMaterialType type) => type.id)
                        .toList(),
                    topics: _selectedTopics
                        .map((HiveMaterialTopic topic) => topic.id)
                        .toList(),
                    visibility:
                        _visibleTo != null ? _visibleTo!.value.value : 0,
                    editability:
                        _editableBy != null ? _editableBy!.value.value : 0,
                  );

                  if (_isEditMode) {
                    _hiveMaterial.id = widget.material?.id;
                    _hiveMaterial.creatorId = widget.material?.creatorId;

                    _hiveMaterial.isUpdated = true;
                  } else {
                    _hiveMaterial.isNew = true;
                  }

                  _materialBox
                      .add(_hiveMaterial)
                      .then((value) => print('$value record(s) saved.'))
                      .onError((error, stackTrace) {
                    print('Error: ${error.toString()}.');
                    StarfishSnackbar.showErrorMessage(
                        context,
                        _isEditMode
                            ? Strings.updateMaterialFailed
                            : Strings.addMaterialFailed);
                  }).whenComplete(() {
                    Alerts.showMessageBox(
                        context: context,
                        title: Strings.dialogInfo,
                        message: _isEditMode
                            ? Strings.updateMaterialSuccess
                            : Strings.addMaterialSuccess,
                        callback: () {
                          Navigator.of(context).pop();
                        });
                  });
                  /*print('POST: ${_hiveMaterial.toString()}');
                  MaterialRepository()
                      .createUpdateMaterial(
                          material: _hiveMaterial.toMaterial(),
                          fieldMaskPaths: [
                            'title',
                            'description',
                            //'visibility',
                            //'editability',
                            //'url',
                            //'files',
                            'language_ids',
                            'type_ids',
                            //'topics',
                          ])
                      .then((response) => print('Response: $response.'))
                      .whenComplete(() {
                        Alerts.showMessageBox(
                            context: context,
                            title: Strings.dialogInfo,
                            message: _isEditMode
                                ? Strings.updateMaterialSuccess
                                : Strings.addMaterialSuccess,
                            callback: () {
                              Navigator.of(context).pop();
                            });
                      });*/
                },
                child: Text(
                  _isEditMode ? Strings.update : Strings.add,
                ),
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

  Widget _editHistoryContainer(HiveMaterial? material) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _historyItems(material!)!,
      ),
    );
  }

  List<Widget>? _historyItems(HiveMaterial material) {
    final List<Widget> _widgetList = [];
    final header = Text(
      'History',
      style: TextStyle(
        fontFamily: 'OpenSans',
        fontWeight: FontWeight.bold,
        fontSize: 18.sp,
        color: Color(0xFF3475F0),
      ),
    );
    _widgetList.add(header);

    for (HiveEdit edit in material.editHistory!) {
      _widgetList.add(HistoryItem(edit: edit));
    }

    return _widgetList;
  }

  _dismissFieldFocus() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }
}
