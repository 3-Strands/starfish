import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:fbroadcast/fbroadcast.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:mime/mime.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:starfish/bloc/app_bloc.dart';
import 'package:starfish/bloc/material_bloc.dart';
import 'package:starfish/bloc/profile_bloc.dart';
import 'package:starfish/bloc/provider.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:starfish/constants/assets_path.dart';
import 'package:starfish/constants/text_styles.dart';
import 'package:starfish/db/hive_database.dart';
import 'package:starfish/db/hive_edit.dart';
import 'package:starfish/db/hive_language.dart';
import 'package:starfish/db/hive_material.dart';
import 'package:starfish/db/hive_file.dart';
import 'package:starfish/db/hive_material_topic.dart';
import 'package:starfish/db/hive_material_type.dart';
import 'package:starfish/enums/material_editability.dart';
import 'package:starfish/enums/material_visibility.dart';
import 'package:starfish/modules/image_cropper/image_cropper_view.dart';
import 'package:starfish/modules/settings_view/settings_view.dart';
import 'package:starfish/select_items/select_drop_down.dart';
import 'package:starfish/src/generated/file_transfer.pbgrpc.dart';
import 'package:starfish/src/generated/starfish.pb.dart';
import 'package:starfish/utils/helpers/alerts.dart';
import 'package:starfish/utils/helpers/snackbar.dart';
import 'package:starfish/utils/helpers/uuid_generator.dart';
import 'package:starfish/utils/services/sync_service.dart';
import 'package:starfish/widgets/app_logo_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starfish/widgets/history_item.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

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

  List<HiveLanguage> _selectedLanguages = [];
  List<HiveMaterialType> _selectedTypes = [];
  List<HiveMaterialTopic> _selectedTopics = [];
  List<File> _selectedFiles = [];

  MaterialVisibility? _visibleTo;
  MaterialEditability? _editableBy;

  late Box<HiveLanguage> _languageBox;
  late Box<HiveMaterialType> _materialTypeBox;
  late Box<HiveMaterialTopic> _materialTopicBox;

  late List<HiveLanguage> _languageList;
  late List<HiveMaterialType> _typeList;
  late List<HiveMaterialTopic> _topicList;

  late String _choiceSeenByText = AppLocalizations.of(context)!.seenBy;
  late String _choiceEditedByText = AppLocalizations.of(context)!.editedBy;

  late AppBloc bloc;

  bool _isEditMode = false;

  @override
  void initState() {
    super.initState();
    _languageBox = Hive.box<HiveLanguage>(HiveDatabase.LANGUAGE_BOX);
    _materialTypeBox =
        Hive.box<HiveMaterialType>(HiveDatabase.MATERIAL_TYPE_BOX);
    _materialTopicBox =
        Hive.box<HiveMaterialTopic>(HiveDatabase.MATERIAL_TOPIC_BOX);

    _getAllLanguages();
    _getAllMaterialTypes();
    _getAllMaterialTopics();

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
              widget.material!.topics!.contains(topic.name))
          .toList();

      _choiceSeenByText = widget.material!.visibility != null
          ? MaterialVisibility.valueOf(widget.material!.visibility!)
              .displayName!
          : AppLocalizations.of(context)!.seenBy;

      _choiceEditedByText = widget.material!.editability != null
          ? MaterialEditability.valueOf(widget.material!.editability!)
              .displayName!
          : AppLocalizations.of(context)!.editedBy;
    }
  }

  void _getAllLanguages() {
    _languageList = _languageBox.values.toList();
  }

  void _getAllMaterialTypes() {
    _typeList = _materialTypeBox.values.toList();
  }

  void _getAllMaterialTopics() {
    _topicList = _materialTopicBox.values.toList();
  }

  @override
  Widget build(BuildContext context) {
    bloc = Provider.of(context);

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
                _isEditMode
                    ? AppLocalizations.of(context)!.editMaterial
                    : AppLocalizations.of(context)!.addNewMaterial,
                style: dashboardNavigationTitle,
              ),
              IconButton(
                icon: SvgPicture.asset(AssetsPath.settings),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SettingsScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Scrollbar(
          thickness: 5.sp,
          isAlwaysShown: false,
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: TextFormField(
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      controller: _titleController,
                      style: formTitleTextStyle,
                      decoration: InputDecoration(
                        hintText:
                            AppLocalizations.of(context)!.hintMaterialName,
                        hintStyle: formTitleHintStyle,
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
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 21.h),

                  // Description
                  Text(
                    AppLocalizations.of(context)!.descripton,
                    textAlign: TextAlign.left,
                    style: titleTextStyle,
                  ),
                  SizedBox(height: 11.h),
                  Container(
                    child: TextFormField(
                      maxLines: 4,
                      maxLength: 200,
                      controller: _descriptionController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
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
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 21.h),

                  // Web Link
                  Text(
                    AppLocalizations.of(context)!.addWebLink,
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
                    AppLocalizations.of(context)!.uploadAMaterial,
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
                  if (_isEditMode) _previewFiles(widget.material!),
                  SizedBox(height: 10.h),

                  // Selected files (Not uploaded)
                  _previewSelectedFiles(),

                  // Add Materials
                  DottedBorder(
                    borderType: BorderType.RRect,
                    radius: Radius.circular(30.r),
                    color: Color(0xFF3475F0),
                    child: Container(
                      width: double.infinity,
                      height: 50.h,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_selectedFiles.length == 5) {
                            Alerts.showMessageBox(
                                context: context,
                                title: AppLocalizations.of(context)!.title,
                                message: AppLocalizations.of(context)!
                                    .maxFilesSelected,
                                neutralButtonText:
                                    AppLocalizations.of(context)!.ok,
                                callback: () {});
                            return;
                          } else {
                            FilePickerResult? result = await FilePicker.platform
                                .pickFiles(allowMultiple: false);

                            if (result != null) {
                              // if single selected file is IMAGE, open image in Cropper
                              if (result.count == 1 &&
                                  ['jpg', 'jpeg', 'png'].contains(result
                                      .paths.first
                                      ?.split("/")
                                      .last
                                      .split(".")
                                      .last)) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ImageCropperScreen(
                                      sourceImage: File(result.paths.first!),
                                      onDone: (File? _newFile) {
                                        if (_newFile == null) {
                                          return;
                                        }
                                        setState(() {
                                          _selectedFiles.add(_newFile);
                                        });
                                      },
                                    ),
                                  ),
                                ).then((value) => {
                                      // Handle cropped image here
                                    });
                              } else {
                                setState(() {
                                  _selectedFiles.addAll(result.paths
                                      .map((path) => File(path!))
                                      .toList());
                                });
                              }
                            } else {
                              // User canceled the picker
                            }
                          }
                        },
                        child: Text(
                          AppLocalizations.of(context)!.addMaterials,
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
                    AppLocalizations.of(context)!.lanugages,
                    textAlign: TextAlign.left,
                    style: titleTextStyle,
                  ),
                  SizedBox(height: 11.h),
                  Container(
                    child: SelectDropDown(
                      navTitle: AppLocalizations.of(context)!.selectLanugages,
                      placeholder:
                          AppLocalizations.of(context)!.selectLanugages,
                      selectedValues: _selectedLanguages,
                      dataSource: _languageList,
                      type: SelectType.multiple,
                      dataSourceType: DataSourceType.languages,
                      onDoneClicked: <T>(languages) {
                        setState(() {
                          _selectedLanguages = List<HiveLanguage>.from(
                              languages as List<dynamic>);
                          // _selectedLanguages = languages as List<HiveLanguage>;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 21.h),

                  // Type Selection
                  Text(
                    AppLocalizations.of(context)!.type,
                    textAlign: TextAlign.left,
                    style: titleTextStyle,
                  ),
                  SizedBox(height: 11.h),
                  Container(
                    child: SelectDropDown(
                      navTitle: AppLocalizations.of(context)!.selectType,
                      placeholder: AppLocalizations.of(context)!.selectType,
                      selectedValues: _selectedTypes,
                      dataSource: _typeList,
                      type: SelectType.multiple,
                      dataSourceType: DataSourceType.types,
                      onDoneClicked: <T>(types) {
                        setState(() {
                          _selectedTypes = List<HiveMaterialType>.from(
                              types as List<dynamic>);

                          // _selectedTypes = types as List<HiveMaterialType>;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 21.h),

                  // Topic Selection
                  Text(
                    AppLocalizations.of(context)!.topics,
                    textAlign: TextAlign.left,
                    style: titleTextStyle,
                  ),
                  SizedBox(height: 11.h),
                  Container(
                    child: SelectDropDown(
                      navTitle: AppLocalizations.of(context)!.selectTopics,
                      placeholder: AppLocalizations.of(context)!.selectTopics,
                      selectedValues: _selectedTopics,
                      dataSource: _topicList,
                      type: SelectType.multiple,
                      dataSourceType: DataSourceType.topics,
                      onDoneClicked: <T>(topics) {
                        setState(() {
                          _selectedTopics = List<HiveMaterialTopic>.from(
                              topics as List<dynamic>);

                          // _selectedTopics = topics as List<HiveMaterialTopic>;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 21.h),

                  //Seen by
                  Text(
                    AppLocalizations.of(context)!.seenBy,
                    textAlign: TextAlign.left,
                    style: titleTextStyle,
                  ),
                  SizedBox(height: 11.h),
                  Container(
                    height: 52.h,
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
                          _choiceSeenByText,
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
                          setState(() {
                            _visibleTo = value;
                            _choiceSeenByText = _visibleTo!.displayName!;
                          });
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
                    AppLocalizations.of(context)!.editedBy,
                    textAlign: TextAlign.left,
                    style: titleTextStyle,
                  ),
                  SizedBox(height: 11.h),
                  Container(
                    height: 52.h,
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
                          _choiceEditedByText,
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
                          setState(() {
                            _editableBy = value;
                            _choiceEditedByText = _editableBy!.displayName!;
                          });
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

                  if (widget.material?.editHistory != null)
                    _editHistoryContainer(widget.material),

                  SizedBox(height: 11.h),
                ],
              ),
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
                child: Text(AppLocalizations.of(context)!.cancel),
              ),
            ),
            SizedBox(width: 25.w),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  _validateInfo();
                },
                child: Text(
                  _isEditMode
                      ? AppLocalizations.of(context)!.update
                      : AppLocalizations.of(context)!.add,
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

  _validateInfo() {
    if (_titleController.text == '') {
      StarfishSnackbar.showErrorMessage(
          context, AppLocalizations.of(context)!.emptyMaterialTitle);
    } else if (_descriptionController.text == '') {
      StarfishSnackbar.showErrorMessage(
          context, AppLocalizations.of(context)!.emptyDescription);
    } else if (_selectedLanguages.length == 0) {
      StarfishSnackbar.showErrorMessage(
          context, AppLocalizations.of(context)!.emptySelectLanguage);
    } else if (_selectedTypes.length == 0) {
      StarfishSnackbar.showErrorMessage(
          context, AppLocalizations.of(context)!.emptySelectType);
    } else if (_selectedTopics.length == 0) {
      StarfishSnackbar.showErrorMessage(
          context, AppLocalizations.of(context)!.emptySelectTopic);
    } else {
      _addUpdateUserProfile();
    }
  }

  _addUpdateUserProfile() {
    final bloc = Provider.of(context);

    HiveMaterial? _hiveMaterial;

    if (_isEditMode) {
      _hiveMaterial = widget.material!;

      _hiveMaterial.id = widget.material?.id;
      _hiveMaterial.creatorId = widget.material?.creatorId;
      _hiveMaterial.status = widget.material?.status;

      _hiveMaterial.isUpdated = true;
    } else {
      _hiveMaterial = HiveMaterial(
        id: UuidGenerator.uuid(),
        isNew: true,
      );
    }
    _hiveMaterial.title = _titleController.text;
    _hiveMaterial.url = _webLinkController.text;
    _hiveMaterial.description = _descriptionController.text;
    _hiveMaterial.languageIds =
        _selectedLanguages.map((HiveLanguage language) => language.id).toList();
    _hiveMaterial.typeIds =
        _selectedTypes.map((HiveMaterialType type) => type.id).toList();
    _hiveMaterial.topics =
        _selectedTopics.map((HiveMaterialTopic topic) => topic.name).toList();
    _hiveMaterial.visibility = _visibleTo != null ? _visibleTo!.value.value : 0;
    _hiveMaterial.editability =
        _editableBy != null ? _editableBy!.value.value : 0;

    // check if there is any file is added, if yes, store them in HiveFile box
    List<HiveFile>? _files;
    if (_selectedFiles.length > 0) {
      _files = _selectedFiles
          .map((file) => HiveFile(
                entityId: _hiveMaterial!.id,
                entityType: EntityType.MATERIAL.value,
                filepath: file.path,
                filename: file.path.split("/").last,
              ))
          .toList();
    }
    bloc.materialBloc
        .createUpdateMaterial(_hiveMaterial, files: _files)
        .then((value) => debugPrint('record(s) saved.'))
        .onError((error, stackTrace) {
      StarfishSnackbar.showErrorMessage(
          context,
          _isEditMode
              ? AppLocalizations.of(context)!.updateMaterialFailed
              : AppLocalizations.of(context)!.addMaterialFailed);
    }).whenComplete(() {
      // Broadcast to sync the local changes with the server
      FBroadcast.instance().broadcast(
        SyncService.kUpdateMaterial,
        value: _hiveMaterial,
      );
      Alerts.showMessageBox(
          context: context,
          title: AppLocalizations.of(context)!.dialogInfo,
          message: _isEditMode
              ? AppLocalizations.of(context)!.updateMaterialSuccess
              : AppLocalizations.of(context)!.addMaterialSuccess,
          callback: () {
            Navigator.of(context).pop();
          });
    });
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
      AppLocalizations.of(context)!.history,
      style: TextStyle(
        fontFamily: 'OpenSans',
        fontWeight: FontWeight.bold,
        fontSize: 18.sp,
        color: Color(0xFF3475F0),
      ),
    );
    _widgetList.add(header);

    for (HiveEdit edit in material.editHistory ?? []) {
      _widgetList.add(HistoryItem(
        edit: edit,
        type: 'Material',
      ));
    }

    return _widgetList;
  }

  Widget _previewFiles(HiveMaterial _hiveMaterial) {
    if (_hiveMaterial.localFiles == null) {
      return Container();
    }
    final List<Widget> _widgetList = [];

    if (_hiveMaterial.localImageFile != null) {
      final imagePreview = Card(
        margin: EdgeInsets.only(top: 10.h),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.r),
          ),
          height: 150.h,
          alignment: Alignment.center,
          child: Image.file(
            _hiveMaterial.localImageFile!,
            fit: BoxFit.fill,
          ),
        ),
        elevation: 4,
      );

      _widgetList.add(imagePreview);
      _widgetList.add(SizedBox(
        height: 10.h,
      ));
    }

    for (File file in _hiveMaterial.localFiles!) {
      _widgetList.add(Container(
        height: 30.h,
        child: RichText(
          textAlign: TextAlign.start,
          text: TextSpan(
            text: file.path.split("/").last,
            style: TextStyle(
              color: Color(0xFF3475F0),
              fontFamily: 'OpenSans',
              fontSize: 14.sp,
              decoration: TextDecoration.underline,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                if (Platform.isIOS) {
                  return;
                } else if (Platform.isAndroid) {
                  OpenFile.open(file.path);
                }
                /*_copyFileToDownloads(file).then((value) {
                  StarfishSnackbar.showSuccessMessage(
                      context, 'File downloaded successfully.');
                }, onError: (error) {
                  print('Download Error $error');
                  StarfishSnackbar.showErrorMessage(
                      context, 'File downloaded failed.');
                });*/
              },
          ),
        ),
      ));
    }

    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _widgetList,
    );
  }

  Widget _previewSelectedFiles() {
    final List<Widget> _widgetList = [];

    for (File file in _selectedFiles) {
      _widgetList.add(Container(
        height: 30.h,
        child: RichText(
          textAlign: TextAlign.start,
          text: TextSpan(
            text: file.path.split("/").last,
            style: TextStyle(
              color: Color(0xFF3475F0),
              fontFamily: 'OpenSans',
              fontSize: 14.sp,
              decoration: TextDecoration.underline,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                if (Platform.isIOS) {
                  return;
                } else if (Platform.isAndroid) {
                  OpenFile.open(file.path);
                }
              },
          ),
        ),
      ));
    }

    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _widgetList,
    );
  }

  Future<File> _copyFileToDownloads(File _sourceFile) async {
    Directory? _destination = await getDownloadsDirectory();
    String _destinationPath =
        _destination!.path + _sourceFile.path.split("/").last;
    return _sourceFile.copy(_destinationPath);
  }

  _dismissFieldFocus() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }
}
