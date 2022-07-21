import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:fbroadcast/fbroadcast.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:starfish/apis/hive_api.dart';
import 'package:starfish/bloc/data_bloc.dart';
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
import 'package:starfish/modules/image_cropper/image_cropper_view.dart';
import 'package:starfish/modules/material_view/cubit/add_edit_material_cubit.dart';
import 'package:starfish/modules/material_view/enum_display.dart';
import 'package:starfish/modules/settings_view/settings_view.dart';
import 'package:starfish/repositories/authentication_repository.dart';
import 'package:starfish/repositories/data_repository.dart';
import 'package:starfish/select_items/multi_select.dart';
import 'package:starfish/src/generated/file_transfer.pbgrpc.dart';
import 'package:starfish/src/generated/starfish.pb.dart';
import 'package:starfish/utils/helpers/alerts.dart';
import 'package:starfish/utils/helpers/general_functions.dart';
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

class AddEditMaterial extends StatelessWidget {
  const AddEditMaterial({Key? key, this.material}) : super(key: key);

  final HiveMaterial? material;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddEditMaterialCubit(
        dataRepository: context.read<DataRepository>(),
        authenticationRepository: context.read<AuthenticationRepository>(),
        material: material,
      ),
      child: AddEditMaterialView(isEditMode: material != null),
    );
  }
}

class AddEditMaterialView extends StatelessWidget {
  const AddEditMaterialView({Key? key, required this.isEditMode})
      : super(key: key);

  final bool isEditMode;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final cubit = context.read<AddEditMaterialCubit>();

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
                isEditMode
                    ? appLocalizations.editMaterial
                    : appLocalizations.addNewMaterial,
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
      body: BlocListener<AddEditMaterialCubit, AddEditMaterialState>(
        listenWhen: (previous, current) => current.error != null,
        listener: (context, state) {
          String errorMessage;
          switch (state.error!) {
            case MaterialError.noTitle:
              errorMessage = appLocalizations.emptyMaterialTitle;
              break;
            case MaterialError.noDescription:
              errorMessage = appLocalizations.emptyDescription;
              break;
            case MaterialError.noWebLinkOrFile:
              errorMessage = appLocalizations.alertEmptyWebLinkWithNoFile;
              break;
            case MaterialError.noLanguage:
              errorMessage = appLocalizations.emptySelectLanguage;
              break;
          }
          StarfishSnackbar.showErrorMessage(context, errorMessage);
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
                    appLocalizations.materialName,
                    textAlign: TextAlign.left,
                    style: titleTextStyle,
                  ),
                  SizedBox(height: 11.h),
                  Container(
                    child: TextFormField(
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      style: formTitleTextStyle,
                      onChanged: cubit.setTitle,
                      decoration: InputDecoration(
                        // hintText:
                        //     appLocalizations.hintMaterialName,
                        // hintStyle: formTitleHintStyle,
                        labelText: appLocalizations.hintMaterialName,
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
                    appLocalizations.descripton,
                    textAlign: TextAlign.left,
                    style: titleTextStyle,
                  ),
                  SizedBox(height: 11.h),
                  Container(
                    child: TextFormField(
                      maxLines: 4,
                      maxLength: 200,
                      onChanged: cubit.setDescription,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        labelText: appLocalizations.hintMaterialDescription,
                        labelStyle: formTitleHintStyle,
                        alignLabelWithHint: true,
                        // hintText: appLocalizations
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
                    appLocalizations.addWebLink,
                    textAlign: TextAlign.left,
                    style: titleTextStyle,
                  ),
                  SizedBox(height: 11.h),
                  TextFormField(
                    onChanged: cubit.setUrl,
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
                    appLocalizations.uploadAMaterial,
                    textAlign: TextAlign.left,
                    style: titleTextStyle,
                  ),
                  SizedBox(height: 11.h),

                  BlocBuilder<AddEditMaterialCubit, AddEditMaterialState>(
                    buildWhen: (previous, current) =>
                        previous.previouslySelectedFiles !=
                        current.previouslySelectedFiles,
                    builder: (context, state) =>
                        _PreviewOldFiles(files: state.previouslySelectedFiles),
                  ),

                  SizedBox(height: 10.h),

                  BlocBuilder<AddEditMaterialCubit, AddEditMaterialState>(
                    buildWhen: (previous, current) =>
                        previous.newlySelectedFiles !=
                        current.newlySelectedFiles,
                    builder: (context, state) =>
                        _PreviewNewFiles(files: state.newlySelectedFiles),
                  ),

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
                          final cubit = context.read<AddEditMaterialCubit>();

                          if (cubit.state.hasMaxFilesSelected) {
                            StarfishSnackbar.showErrorMessage(
                                context, appLocalizations.maxFilesSelected);
                          } else {
                            final file = await getPickerFileWithCrop(
                              context,
                              type: FileType.custom,
                              allowedExtensions: ALLOWED_FILE_TYPES,
                            );

                            if (file != null) {
                              cubit.addFile(file);
                            }
                          }
                        },
                        child: Text(
                          appLocalizations.addMaterials,
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
                    appLocalizations.lanugages,
                    textAlign: TextAlign.left,
                    style: titleTextStyle,
                  ),
                  SizedBox(height: 11.h),
                  Container(
                    child:
                        BlocBuilder<AddEditMaterialCubit, AddEditMaterialState>(
                      builder: (context, state) {
                        return MultiSelect<HiveLanguage>(
                          navTitle: appLocalizations.selectLanugages,
                          placeholder: appLocalizations.selectLanugages,
                          items: state.languages,
                          initialSelection: state.selectedLanguages
                              .map((languageId) =>
                                  globalHiveApi.language.get(languageId)!)
                              .toSet(),
                          toDisplay: HiveLanguage.toDisplay,
                          onFinished: (selectedLanguages) {
                            context
                                .read<AddEditMaterialCubit>()
                                .setSelectedLanguages(
                                    selectedLanguages.map((l) => l.id).toSet());
                          },
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 21.h),

                  // Type Selection
                  Text(
                    appLocalizations.type,
                    textAlign: TextAlign.left,
                    style: titleTextStyle,
                  ),
                  SizedBox(height: 11.h),
                  Container(
                    child:
                        BlocBuilder<AddEditMaterialCubit, AddEditMaterialState>(
                      builder: (context, state) {
                        return MultiSelect<HiveMaterialType>(
                          navTitle: appLocalizations.selectType,
                          placeholder: appLocalizations.selectType,
                          items: state.types,
                          initialSelection: state.selectedTypes
                              .map((id) => globalHiveApi.materialType.get(id)!)
                              .toSet(),
                          toDisplay: HiveMaterialType.toDisplay,
                          onFinished: (selectedTypes) {
                            context
                                .read<AddEditMaterialCubit>()
                                .setSelectedTypes(
                                    selectedTypes.map((l) => l.id).toSet());
                          },
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 21.h),

                  // Topic Selection
                  Text(
                    appLocalizations.topics,
                    textAlign: TextAlign.left,
                    style: titleTextStyle,
                  ),
                  SizedBox(height: 11.h),
                  Container(
                    child:
                        BlocBuilder<AddEditMaterialCubit, AddEditMaterialState>(
                      builder: (context, state) {
                        return MultiSelect<HiveMaterialTopic>(
                          navTitle: appLocalizations.selectTopics,
                          placeholder: appLocalizations.selectTopics,
                          items: state.topics,
                          initialSelection: state.selectedTopics
                              .map((id) => globalHiveApi.materialTopic.get(id)!)
                              .toSet(),
                          toDisplay: HiveMaterialTopic.toDisplay,
                          onFinished: (selectedTopics) {
                            context
                                .read<AddEditMaterialCubit>()
                                .setSelectedTopics(
                                    selectedTopics.map((l) => l.id).toSet());
                          },
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 21.h),

                  //Seen by
                  Text(
                    appLocalizations.seenBy,
                    textAlign: TextAlign.left,
                    style: titleTextStyle,
                  ),
                  SizedBox(height: 11.h),
                  Container(
                    height: 52.h,
                    width: double.infinity,
                    //  padding: EdgeInsets.only(left: 15.w, right: 15.w),
                    decoration: BoxDecoration(
                      color: AppColors.txtFieldBackground,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: BlocBuilder<AddEditMaterialCubit,
                          AddEditMaterialState>(
                        builder: (context, state) {
                          return DropdownButton2<Material_Visibility>(
                            //   dropdownMaxHeight: 350.h,
                            isExpanded: true,
                            offset: Offset(0, -5),
                            style: TextStyle(
                              color: Color(0xFF434141),
                              fontSize: 19.sp,
                              fontFamily: 'OpenSans',
                            ),
                            value: state.visibility ==
                                    Material_Visibility.UNSPECIFIED_VISIBILITY
                                ? null
                                : state.visibility,
                            hint: Padding(
                              padding: EdgeInsets.only(left: 15.w, right: 15.w),
                              child: Text(
                                appLocalizations.seenBy,
                                style: TextStyle(
                                  color: Color(0xFF434141),
                                  fontSize: 19.sp,
                                  fontFamily: 'OpenSans',
                                ),
                              ),
                            ),
                            onChanged: cubit.setVisibility,
                            items: VisibilityDisplay.displayList
                                .map(
                                  (visibility) =>
                                      DropdownMenuItem<Material_Visibility>(
                                    value: visibility,
                                    child: Text(
                                      visibility.toLocaleString(context),
                                      style: TextStyle(
                                        color: Color(0xFF434141),
                                        fontSize: 17.sp,
                                        fontFamily: 'OpenSans',
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 21.h),

                  //Edited by
                  Text(
                    appLocalizations.editedOrDeletedBy,
                    textAlign: TextAlign.left,
                    style: titleTextStyle,
                  ),
                  SizedBox(height: 11.h),
                  Container(
                    height: 52.h,
                    width: double.infinity,
                    //  padding: EdgeInsets.only(left: 15.w, right: 15.w),
                    decoration: BoxDecoration(
                      color: AppColors.txtFieldBackground,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: BlocBuilder<AddEditMaterialCubit,
                          AddEditMaterialState>(
                        builder: (context, state) {
                          return DropdownButton2<Material_Editability>(
                            offset: Offset(0, -10),
                            dropdownMaxHeight: 90.h,
                            scrollbarAlwaysShow: true,
                            style: TextStyle(
                              color: Color(0xFF434141),
                              fontSize: 19.sp,
                              fontFamily: 'OpenSans',
                            ),
                            hint: Padding(
                              padding: EdgeInsets.only(left: 15.w, right: 15.w),
                              child: Text(
                                appLocalizations.editedOrDeletedBy,
                                style: TextStyle(
                                  color: Color(0xFF434141),
                                  fontSize: 19.sp,
                                  fontFamily: 'OpenSans',
                                ),
                              ),
                            ),
                            value: state.editability ==
                                    Material_Editability.UNSPECIFIED_EDITABILITY
                                ? null
                                : state.editability,
                            // onTap: () {
                            //   _dismissFieldFocus();
                            // },
                            onChanged: cubit.setEditability,
                            items: EditabilityDisplay.displayList
                                .map((editability) {
                              return DropdownMenuItem<Material_Editability>(
                                value: editability,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    editability.toLocaleString(context),
                                    style: TextStyle(
                                      color: Color(0xFF434141),
                                      fontSize: 17.sp,
                                      fontFamily: 'OpenSans',
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          );
                        },
                      ),
                    ),
                  ),

                  SizedBox(height: 21.h),

                  BlocBuilder<AddEditMaterialCubit, AddEditMaterialState>(
                    builder: (context, state) {
                      if (state.history.isEmpty) {
                        return const SizedBox();
                      }
                      return EditHistory(
                        history: state.history,
                      );
                    },
                  ),

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
                  child: Text(appLocalizations.cancel),
                ),
              ),
            ),
            SizedBox(width: 25.w),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(right: 10.h),
                child: ElevatedButton(
                  onPressed: cubit.submitRequested,
                  child: Text(
                    isEditMode ? appLocalizations.update : appLocalizations.add,
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
}

class _PreviewOldFiles extends StatelessWidget {
  const _PreviewOldFiles({Key? key, required this.files}) : super(key: key);

  final List<HiveFile> files;

  @override
  Widget build(BuildContext context) {
    if (files.isEmpty) {
      return const SizedBox();
    }

    final imagePaths = <String>[];

    final widgetList = files.map<Widget>((hiveFile) {
      final filepath = hiveFile.filepath;
      if (filepath != null &&
          const {'jpg', 'png'}
              .contains(filepath.split("/").last.split(".").last)) {
        imagePaths.add(filepath);
      }
      return Container(
        height: 30.h,
        child: RichText(
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
              ..onTap = () async {
                try {
                  await GeneralFunctions.openFile(hiveFile, context);
                } on NetworkUnavailableException {
                  // TODO: show message to user
                }
              },
          ),
        ),
      );
    }).toList();

    if (imagePaths.isNotEmpty) {
      // Right now we only add the first image preview
      widgetList
        ..add(Card(
          margin: EdgeInsets.only(top: 10.h),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.r),
            ),
            height: 150.h,
            alignment: Alignment.center,
            child: File(imagePaths[0]).getImagePreview(
              fit: BoxFit.fill,
            ),
          ),
          elevation: 4,
        ))
        ..add(SizedBox(
          height: 10.h,
        ));
    }

    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgetList,
    );
  }
}

class _PreviewNewFiles extends StatelessWidget {
  const _PreviewNewFiles({Key? key, required this.files}) : super(key: key);

  final List<File> files;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: files
          .map((file) => Container(
                height: 30.h,
                child: RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                    text: file.path.split("/").last,
                    style: TextStyle(
                      color: Color(0xFF3475F0),
                      fontFamily: 'OpenSans',
                      fontSize: 17.sp,
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        openFile(file.path);
                      },
                  ),
                ),
              ))
          .toList(),
    );
  }
}

class EditHistory extends StatelessWidget {
  const EditHistory({Key? key, required this.history}) : super(key: key);

  final List<HiveEdit> history;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            appLocalizations.history,
            style: TextStyle(
              fontFamily: 'OpenSans',
              fontWeight: FontWeight.bold,
              fontSize: 21.5.sp,
              color: Color(0xFF3475F0),
            ),
          ),
          ...history.map((edit) => HistoryItem(
                edit: edit,
                type: appLocalizations.material,
              )),
        ],
      ),
    );
  }
}
