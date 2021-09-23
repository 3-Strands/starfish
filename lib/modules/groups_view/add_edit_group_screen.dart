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
import 'package:starfish/db/hive_evaluation_category.dart';
import 'package:starfish/db/hive_group.dart';
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

class AddEditGroupScreen extends StatefulWidget {
  final HiveGroup? group;

  AddEditGroupScreen({
    Key? key,
    this.group,
  }) : super(key: key);

  @override
  _AddEditGroupScreenState createState() => _AddEditGroupScreenState();
}

class _AddEditGroupScreenState extends State<AddEditGroupScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  bool _isEditMode = false;

  List<HiveLanguage> _selectedLanguages = [];
  List<HiveEvaluationCategory> _selectedEvaluationCategories = [];

  late Box<HiveLanguage> _languageBox;
  late Box<HiveGroup> _groupBox;
  late Box<HiveEvaluationCategory> _evaluationCategoryBox;

  @override
  void initState() {
    super.initState();
    _languageBox = Hive.box<HiveLanguage>(HiveDatabase.LANGUAGE_BOX);
    _groupBox = Hive.box<HiveGroup>(HiveDatabase.GROUP_BOX);
    _evaluationCategoryBox = Hive.box<HiveEvaluationCategory>(
        HiveDatabase.EVALUATION_CATEGORIES_BOX);

    if (widget.group != null) {
      _isEditMode = true;

      _titleController.text = widget.group!.name!;
      //_descriptionController.text = widget.group!.description!;

      _selectedLanguages = _languageBox.values
          .where((HiveLanguage language) =>
              widget.group!.languageIds!.contains(language.id))
          .toList();

      _selectedEvaluationCategories = _evaluationCategoryBox.values
          .where((HiveEvaluationCategory category) => widget.group != null
              ? widget.group!.evaluationCategoryIds!.contains(category.id)
              : false)
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.groupScreenBG,
      appBar: AppBar(
        backgroundColor: AppColors.groupScreenBG,
        automaticallyImplyLeading: false,
        title: Container(
          height: 64.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              AppLogo(hight: 36.h, width: 37.w),
              Text(
                _isEditMode ? Strings.editGroup : Strings.createGroup,
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
                    hintText: Strings.hintGroupName,
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

                // Language(s) used
                Text(
                  Strings.lanugagesUsed,
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

                // Evaluate Progress
                Text(
                  Strings.evaluateProgress,
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
                    child: SmartSelect<HiveEvaluationCategory>.multiple(
                      title: Strings.selectCategories,
                      placeholder: Strings.selectCategories,
                      selectedValue: _selectedEvaluationCategories,
                      onChange: (selected) {
                        setState(() =>
                            _selectedEvaluationCategories = selected.value);
                      },
                      choiceItems: S2Choice.listFrom<HiveEvaluationCategory,
                              HiveEvaluationCategory>(
                          source: _evaluationCategoryBox.values.toList(),
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
                SizedBox(height: 10.h),
                Text(
                  Strings.hintEvaluateProgress,
                  textAlign: TextAlign.left,
                  style: italicDetailTextTextStyle,
                ),
                SizedBox(height: 11.h),

                // Option 1.
                Text(
                  Strings.invitePeopleFromContactsList,
                  textAlign: TextAlign.left,
                  style: titleTextStyle,
                ),
                SizedBox(height: 11.h),
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
                        Strings.inviteFromContactsList,
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

                // Option 2.
                Text(
                  Strings.addWithoutInvite,
                  textAlign: TextAlign.left,
                  style: titleTextStyle,
                ),
                SizedBox(height: 11.h),
                TextFormField(
                  keyboardType: TextInputType.text,
                  style: textFormFieldText,
                  decoration: InputDecoration(
                    hintText: Strings.hintPersonName,
                    hintStyle: textFormFieldText,
                    contentPadding: EdgeInsets.fromLTRB(5.w, 5.0, 5.0.w, 5.0),
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
                    fillColor: AppColors.txtFieldBackground,
                  ),
                ),
                if (widget.group != null) _editHistoryContainer(widget.group),

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
                  HiveGroup _hiveGroup = HiveGroup(
                    name: _titleController.text,
                    //description: _descriptionController.text,
                    languageIds: _selectedLanguages
                        .map((HiveLanguage language) => language.id)
                        .toList(),
                    evaluationCategoryIds: _selectedEvaluationCategories
                        .map((HiveEvaluationCategory category) => category.id!)
                        .toList(),
                  );

                  if (_isEditMode) {
                    _hiveGroup.id = widget.group?.id;

                    _hiveGroup.isUpdated = true;
                  } else {
                    _hiveGroup.isNew = true;
                  }

                  _groupBox
                      .add(_hiveGroup)
                      .then((value) => print('$value record(s) saved.'))
                      .onError((error, stackTrace) {
                    print('Error: ${error.toString()}.');
                    StarfishSnackbar.showErrorMessage(
                        context,
                        _isEditMode
                            ? Strings.updateGroupFailed
                            : Strings.createGroupSuccess);
                  }).whenComplete(() {
                    Alerts.showMessageBox(
                        context: context,
                        title: Strings.dialogInfo,
                        message: _isEditMode
                            ? Strings.updateGroupSuccess
                            : Strings.createGroupSuccess,
                        callback: () {
                          Navigator.of(context).pop();
                        });
                  });
                },
                child: Text(
                  _isEditMode ? Strings.update : Strings.create,
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

  Widget _editHistoryContainer(HiveGroup? group) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _historyItems(group!)!,
      ),
    );
  }

  List<Widget>? _historyItems(HiveGroup group) {
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

    for (HiveEdit edit in group.editHistory!) {
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
