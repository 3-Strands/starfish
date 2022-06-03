import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dotted_border/dotted_border.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:fbroadcast/fbroadcast.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:starfish/bloc/app_bloc.dart';
import 'package:starfish/bloc/provider.dart';
import 'package:starfish/config/routes/routes.dart';
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
import 'package:starfish/db/providers/current_user_provider.dart';
import 'package:starfish/enums/material_editability.dart';
import 'package:starfish/enums/material_visibility.dart';
import 'package:starfish/modules/image_cropper/image_cropper_view.dart';
import 'package:starfish/modules/settings_view/settings_view.dart';
import 'package:starfish/select_items/multi_select.dart';
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
import 'package:starfish/wrappers/file_system.dart';
import 'package:starfish/wrappers/platform.dart';

const List<String> ALLOWED_FILE_TYPES = [
  'doc',
  'docx',
  'rtf',
  'txt',
  'jpg',
  'png',
  'mp3',
  'wav',
  'xls',
  'xlsx',
  'ppt',
  'pptx',
  'odt',
  'odp',
  'ods'
];

class AddEditMaterialScreen extends StatefulWidget {
  final HiveMaterial? material;

  const AddEditMaterialScreen({
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
  List<PlatformFile> _selectedFiles = [];

  MaterialVisibility? _visibleTo;
  MaterialEditability? _editableBy;

  late Box<HiveLanguage> _languageBox;
  late Box<HiveMaterialType> _materialTypeBox;
  late Box<HiveMaterialTopic> _materialTopicBox;

  late List<HiveLanguage> _languageList;
  late List<HiveMaterialType> _typeList;
  late List<HiveMaterialTopic> _topicList;

  late String _choiceSeenByText = AppLocalizations.of(context)!.seenBy;
  late String _choiceEditedByText =
      AppLocalizations.of(context)!.editedOrDeletedBy;

  late AppBloc bloc;
  late AppLocalizations _appLocalizations;

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

      widget.material!.languages.forEach((key, value) {
        _selectedLanguages.add(HiveLanguage(id: key, name: value));
      });
      _selectedLanguages.sort((a, b) => a.name.compareTo(b.name));

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
          : _appLocalizations.seenBy;

      _choiceEditedByText = widget.material!.editability != null
          ? MaterialEditability.valueOf(widget.material!.editability!)
              .displayName!
          : _appLocalizations.editedBy;

      _visibleTo = MaterialVisibility.valueOf(widget.material!.visibility!);
      _editableBy = MaterialEditability.valueOf(widget.material!.editability!);
    }
  }

  void _getAllLanguages() {
    _languageList = _languageBox.values.toList();
    _languageList.sort((a, b) => a.name.compareTo(b.name));
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
    _appLocalizations = AppLocalizations.of(context)!;

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
                    ? _appLocalizations.editMaterial
                    : _appLocalizations.addNewMaterial,
                style: dashboardNavigationTitle,
              ),
              IconButton(
                icon: SvgPicture.asset(AssetsPath.settings),
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    Routes.settings,
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
          thickness: 5.w,
          isAlwaysShown: false,
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _appLocalizations.materialName,
                    textAlign: TextAlign.left,
                    style: titleTextStyle,
                  ),
                  SizedBox(height: 11.h),
                  Container(
                    child: TextFormField(
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      controller: _titleController,
                      style: formTitleTextStyle,
                      decoration: InputDecoration(
                        // hintText:
                        //     _appLocalizations.hintMaterialName,
                        // hintStyle: formTitleHintStyle,
                        labelText: _appLocalizations.hintMaterialName,
                        labelStyle: formTitleHintStyle,
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        alignLabelWithHint: true,
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
                    _appLocalizations.descripton,
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
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        labelText: _appLocalizations.hintMaterialDescription,
                        labelStyle: formTitleHintStyle,
                        alignLabelWithHint: true,
                        // hintText: _appLocalizations
                        //     .hintMaterialDescription,
                        // hintStyle: formTitleHintStyle,
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
                    _appLocalizations.addWebLink,
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
                    _appLocalizations.uploadAMaterial,
                    textAlign: TextAlign.left,
                    style: titleTextStyle,
                  ),
                  SizedBox(height: 11.h),

                  // (widget.material?.localFiles == null)
                  //     ? TextFormField(
                  //         decoration: InputDecoration(
                  //           contentPadding:
                  //               EdgeInsets.fromLTRB(15.0.w, 0.0, 5.0.w, 0.0),
                  //           border: OutlineInputBorder(
                  //             borderRadius: BorderRadius.circular(10.0),
                  //           ),
                  //           enabledBorder: OutlineInputBorder(
                  //             borderRadius: BorderRadius.circular(10.0),
                  //             borderSide: BorderSide(
                  //               color: Colors.transparent,
                  //             ),
                  //           ),
                  //           filled: true,
                  //           fillColor: AppColors.txtFieldBackground,
                  //         ),
                  //       )
                  //     : Container(),
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
                          if ((!_isEditMode && _selectedFiles.length >= 5) ||
                              (_isEditMode &&
                                  (_selectedFiles.length +
                                          (widget
                                              .material!.localFiles.length)) >=
                                      5)) {
                            StarfishSnackbar.showErrorMessage(
                                context, _appLocalizations.maxFilesSelected);
                          } else {
                            final result =
                                await getPickerFileWithCrop(context,
                              type: FileType.custom,
                              allowedExtensions: ALLOWED_FILE_TYPES,
                            );

                            if (result != null) {
                              setState(() => _selectedFiles.add(result));
                            }
                          }
                        },
                        child: Text(
                          _appLocalizations.addMaterials,
                          style: TextStyle(
                            fontFamily: 'OpenSans',
                            fontSize: 17.sp,
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
                    _appLocalizations.lanugages,
                    textAlign: TextAlign.left,
                    style: titleTextStyle,
                  ),
                  SizedBox(height: 11.h),
                  Container(
                    child: MultiSelect(
                      navTitle: _appLocalizations.selectLanugages,
                      placeholder: _appLocalizations.selectLanugages,
                      items: _languageList,
                      initialSelection: _selectedLanguages.toSet(),
                      onFinished: (Set<HiveLanguage> selectedLanguages) {
                        setState(() {
                          _selectedLanguages = selectedLanguages.toList();
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 21.h),

                  // Type Selection
                  Text(
                    _appLocalizations.type,
                    textAlign: TextAlign.left,
                    style: titleTextStyle,
                  ),
                  SizedBox(height: 11.h),
                  Container(
                    child: MultiSelect(
                      navTitle: _appLocalizations.selectType,
                      placeholder: _appLocalizations.selectType,
                      items: _typeList,
                      initialSelection: _selectedTypes.toSet(),
                      onFinished: (Set<HiveMaterialType> selectedTypes) {
                        setState(() {
                          _selectedTypes = selectedTypes.toList();
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 21.h),

                  // Topic Selection
                  Text(
                    _appLocalizations.topics,
                    textAlign: TextAlign.left,
                    style: titleTextStyle,
                  ),
                  SizedBox(height: 11.h),
                  Container(
                    child: MultiSelect(
                      navTitle: _appLocalizations.selectTopics,
                      placeholder: _appLocalizations.selectTopics,
                      items: _topicList,
                      initialSelection: _selectedTopics.toSet(),
                      onFinished: (Set<HiveMaterialTopic> selectedTopics) {
                        setState(() {
                          _selectedTopics = selectedTopics.toList();
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 21.h),

                  //Seen by
                  Text(
                    _appLocalizations.seenBy,
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
                          fontSize: 19.sp,
                          fontFamily: 'OpenSans',
                        ),
                        hint: Text(
                          _choiceSeenByText,
                          style: TextStyle(
                            color: Color(0xFF434141),
                            fontSize: 19.sp,
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
                                fontSize: 17.sp,
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
                    _appLocalizations.editedOrDeletedBy,
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
                          fontSize: 19.sp,
                          fontFamily: 'OpenSans',
                        ),
                        hint: Text(
                          _choiceEditedByText,
                          style: TextStyle(
                            color: Color(0xFF434141),
                            fontSize: 19.sp,
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
                                fontSize: 17.sp,
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

                  SizedBox(height: 75.h),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: Container(
        height: 75.h,
        padding: EdgeInsets.symmetric(vertical: 18.75.h, horizontal: 30.w),
        color: AppColors.txtFieldBackground,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 10.h),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(_appLocalizations.cancel),
                ),
              ),
            ),
            SizedBox(width: 25.w),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(right: 10.h),
                child: ElevatedButton(
                  onPressed: () {
                    _validateInfo();
                  },
                  child: Text(
                    _isEditMode
                        ? _appLocalizations.update
                        : _appLocalizations.add,
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: AppColors.selectedButtonBG,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _validateInfo() async {
    if (_titleController.text == '') {
      StarfishSnackbar.showErrorMessage(
          context, _appLocalizations.emptyMaterialTitle);
    } else if (_descriptionController.text == '') {
      StarfishSnackbar.showErrorMessage(
          context, _appLocalizations.emptyDescription);
    } else if (_webLinkController.text.isEmpty &&
        ((!_isEditMode && _selectedFiles.length == 0) ||
            (_isEditMode &&
                (_selectedFiles.length + widget.material!.localFiles.length ==
                    0)))) {
      StarfishSnackbar.showErrorMessage(
          context, _appLocalizations.alertEmptyWebLinkWithNoFile);
    } else if (_selectedLanguages.length == 0) {
      StarfishSnackbar.showErrorMessage(
          context, _appLocalizations.emptySelectLanguage);
    } else if (Platform.isWeb && _selectedFiles.isNotEmpty && !(await _isConnected())) {
      StarfishSnackbar.showErrorMessage(
          context, _appLocalizations.youAreOfflineCannotUpload);
    } /* else if (_selectedTypes.length == 0) {
      StarfishSnackbar.showErrorMessage(
          context, _appLocalizations.emptySelectType);
    } else if (_selectedTopics.length == 0) {
       StarfishSnackbar.showErrorMessage(
           context, _appLocalizations.emptySelectTopic);
     } */
    else {
      _addUpdateMaterial();
    }
  }

  Future<bool> _isConnected() async {
    final connectivity = await Connectivity().checkConnectivity();
    return connectivity == ConnectivityResult.wifi || connectivity == ConnectivityResult.mobile;
  }

  _addUpdateMaterial() async {
    final bloc = Provider.of(context);

    HiveMaterial _hiveMaterial;

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
        creatorId: CurrentUserProvider().user.id,
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
    _hiveMaterial.visibility = _visibleTo != null
        ? _visibleTo!.value.value
        : Material_Visibility.GROUP_VIEW.value;
    _hiveMaterial.editability = _editableBy != null
        ? _editableBy!.value.value
        : Material_Editability.CREATOR_EDIT.value;

    // check if there is any file is added, if yes, store them in HiveFile box
    List<HiveFile>? _files;
    if (_selectedFiles.isNotEmpty) {
      _files = _selectedFiles
          .map((file) => HiveFile(
                entityId: _hiveMaterial.id,
                entityType: EntityType.MATERIAL.value,
                filepath: Platform.isWeb ? null : file.path,
                filename: file.name,
                content: Platform.isWeb ? List<int>.from(file.bytes!) : null,
              ))
          .toList();
    }
    try {
      await bloc.materialBloc
          .createUpdateMaterial(_hiveMaterial, files: _files);
      // Broadcast to sync the local changes with the server
      FBroadcast.instance().broadcast(
        SyncService.kUpdateMaterial,
        value: _hiveMaterial,
      );

      bloc.materialBloc
          .checkAndUpdateUserfollowedLangguages(_hiveMaterial.languageIds);
      Alerts.showMessageBox(
          context: context,
          title: _appLocalizations.dialogInfo,
          message: _isEditMode
              ? _appLocalizations.updateMaterialSuccess
              : _appLocalizations.addMaterialSuccess,
          callback: () {
            Navigator.of(context).pop();
          });
    } catch (error) {
      print(error);
      StarfishSnackbar.showErrorMessage(
          context,
          _isEditMode
              ? _appLocalizations.updateMaterialFailed
              : _appLocalizations.addMaterialFailed);
    }
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
      _appLocalizations.history,
      style: TextStyle(
        fontFamily: 'OpenSans',
        fontWeight: FontWeight.bold,
        fontSize: 21.5.sp,
        color: Color(0xFF3475F0),
      ),
    );
    _widgetList.add(header);

    for (HiveEdit edit in material.editHistory ?? []) {
      _widgetList.add(HistoryItem(
        edit: edit,
        type: _appLocalizations.material,
      ));
    }

    return _widgetList;
  }

  Widget _previewFiles(HiveMaterial _hiveMaterial) {
    if (_hiveMaterial.localFiles.length == 0) {
      return Container();
    }

    final List<Widget> _widgetList = [];

    for (HiveFile hiveFile in _hiveMaterial.localFiles) {
      _widgetList.add(Container(
        height: 30.h,
        child: (hiveFile.filepath != null)
            ? RichText(
                textAlign: TextAlign.start,
                text: TextSpan(
                  //text: file.path.split("/").last,
                  text: hiveFile.filename,
                  style: TextStyle(
                    color: AppColors.appTitle,
                    fontFamily: 'OpenSans',
                    fontSize: 19.sp,
                    decoration: TextDecoration.underline,
                  ),
                ),
              )
            : RichText(
                textAlign: TextAlign.start,
                text: TextSpan(
                  //text: file.path.split("/").last,
                  text: hiveFile.filename,
                  style: TextStyle(
                    color: AppColors.appTitle,
                    fontFamily: 'OpenSans',
                    fontSize: 19.sp,
                    decoration: TextDecoration.underline,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      if (Platform.isAndroid) {
                        if (hiveFile.filepath != null) {
                          openFile(hiveFile.filepath!);
                        }
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
    final filepath = _hiveMaterial.localImageFilepath;
    if (filepath != null) {
      final imagePreview = Card(
        margin: EdgeInsets.only(top: 10.h),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.r),
          ),
          height: 150.h,
          alignment: Alignment.center,
          child: File(filepath).getImagePreview(
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

    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _widgetList,
    );
  }

  Widget _previewSelectedFiles() {
    final List<Widget> _widgetList = [];

    for (final file in _selectedFiles) {
      _widgetList.add(Container(
        height: 30.h,
        child: RichText(
          textAlign: TextAlign.start,
          text: TextSpan(
            text: file.name,
            style: TextStyle(
              color: Color(0xFF3475F0),
              fontFamily: 'OpenSans',
              fontSize: 17.sp,
              decoration: TextDecoration.underline,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                if (Platform.isAndroid) {
                  openFile(file.path!);
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

  /*Future<File> _copyFileToDownloads(File _sourceFile) async {
    Directory? _destination = await getDownloadsDirectory();
    String _destinationPath =
        _destination!.path + _sourceFile.path.split("/").last;
    return _sourceFile.copy(_destinationPath);
  }*/

  _dismissFieldFocus() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }
}
