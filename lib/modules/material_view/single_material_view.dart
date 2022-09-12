import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart' hide Material;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:starfish/enums/action_status.dart';
import 'package:starfish/modules/material_view/add_edit_material_screen.dart';
import 'package:starfish/modules/material_view/cubit/materials_cubit.dart';
import 'package:starfish/modules/material_view/enum_display.dart';
import 'package:starfish/modules/material_view/report_material_dialog_box.dart';
import 'package:starfish/repositories/data_repository.dart';
import 'package:starfish/src/grpc_extensions.dart';
import 'package:starfish/utils/currentUser.dart';
import 'package:starfish/utils/helpers/alerts.dart';
import 'package:starfish/utils/helpers/general_functions.dart';
import 'package:starfish/widgets/custon_icon_button.dart';
import 'package:starfish/widgets/task_status.dart';

class SingleMaterialView extends StatelessWidget {
  const SingleMaterialView({
    Key? key,
    required this.material,
    this.actionStatus,
    required this.isAssignedToGroupWithLeaderRole,
  }) : super(key: key);

  final Material material;
  final ActionStatus? actionStatus;
  final bool isAssignedToGroupWithLeaderRole;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final user = context.currentUser;

    return Column(
      children: [
        Expanded(
          child: Container(
            color: Colors.white,
            margin: EdgeInsets.only(
              top: 40.h,
            ),
            child: Container(
              margin: EdgeInsets.only(left: 15.0.w, right: 15.0.w),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 10.h,
                    ),
                    Container(
                      //height: 22.h,

                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              '${appLocalizations.materialTitlePrefix} ${material.title}',
                              //overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: AppColors.txtFieldTextColor,
                                fontFamily: 'OpenSans',
                                fontSize: 19.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          if (((material.editability ==
                                          Material_Editability.CREATOR_EDIT ||
                                      material.editability ==
                                          Material_Editability.GROUP_EDIT) &&
                                  material.creatorId == user.id) ||
                              (material.editability ==
                                      Material_Editability.GROUP_EDIT &&
                                  isAssignedToGroupWithLeaderRole))
                            PopupMenuButton(
                              icon: Icon(
                                Icons.more_vert,
                                color: Color(0xFF3475F0),
                                size: 30,
                              ),
                              color: Colors.white,
                              elevation: 20,
                              shape: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.white, width: 2),
                                  borderRadius: BorderRadius.circular(12.r)),
                              enabled: true,
                              onSelected: (value) {
                                switch (value) {
                                  case 0:
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => AddEditMaterial(
                                          material: material,
                                        ),
                                      ),
                                    ).whenComplete(
                                        () => Navigator.pop(context));
                                    break;
                                  case 1:
                                    Alerts.showMessageBox(
                                      context: context,
                                      title:
                                          appLocalizations.deleteMaterialTitle,
                                      message: appLocalizations
                                          .areYouSureWantToDeleteThis,
                                      positiveButtonText:
                                          appLocalizations.delete,
                                      negativeButtonText:
                                          appLocalizations.cancel,
                                      positiveActionCallback: () {
                                        context
                                            .read<MaterialsCubit>()
                                            .materialDeleted(material);
                                        Navigator.of(context).pop();
                                      },
                                      negativeActionCallback: () {
                                        // noop
                                      },
                                    );
                                    break;
                                }
                              },
                              itemBuilder: (context) => [
                                PopupMenuItem(
                                  child: Text(
                                    appLocalizations.editMaterial,
                                    style: TextStyle(
                                        color: Color(0xFF3475F0),
                                        fontSize: 19.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  value: 0,
                                ),
                                PopupMenuItem(
                                  child: Text(
                                    '${appLocalizations.delete} ${appLocalizations.material}',
                                    style: TextStyle(
                                        color: Color(0xFF3475F0),
                                        fontSize: 19.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  value: 1,
                                ),
                              ],
                            )
                        ],
                      ),
                    ),
                    if (actionStatus != null) ...[
                      SizedBox(
                        height: 30.h,
                      ),
                      TaskStatus(
                        height: 30.h,
                        color: actionStatus!.color,
                        label: actionStatus!.toLocaleString(context),
                      ),
                    ],
                    if (isAssignedToGroupWithLeaderRole) ...[
                      SizedBox(
                        height: 10.h,
                      ),
                      TaskStatus(
                        height: 30.h,
                        color: Color(0xFFCBE8FA),
                        label: appLocalizations.assignedToGroup,
                      ),
                    ],
                    if (actionStatus != null || isAssignedToGroupWithLeaderRole)
                      Divider(
                        color: Color(0xFF979797),
                        thickness: 2,
                      ),
                    SizedBox(
                      height: 30.h,
                    ),
                    if (material.url.isNotEmpty)
                      CustomIconButton(
                        icon: Icon(
                          Icons.open_in_new,
                          color: Color(0xFF3475F0),
                          size: 21.5.sp,
                        ),
                        text: appLocalizations.openExternalLink,
                        textStyle: TextStyle(
                          color: Color(0xFF3475F0),
                          fontFamily: 'OpenSans',
                          // fontSize: 17.sp,
                          fontStyle: FontStyle.italic,
                          // fontWeight: FontWeight.bold,
                        ),
                        onButtonTap: () {
                          GeneralFunctions.openUrl(material.url);
                        },
                      ),
                    if (material.url.isNotEmpty)
                      Divider(
                        color: Color(0xFF979797),
                        thickness: 2,
                      ),
                    if (material.files.isNotEmpty)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: material.fileReferences
                            .map(
                              (file) => Column(
                                children: [
                                  InkWell(
                                    onTap: () async {
                                      try {
                                        await GeneralFunctions.openFile(
                                            file, context);
                                      } on NetworkUnavailableException {
                                        // TODO: show message to user
                                      }
                                    },
                                    child: Row(
                                      children: [
                                        Icon(
                                          file.filepath != null
                                              ? Icons.file_present
                                              : Icons.download,
                                          color: Color(0xFF3475F0),
                                        ),
                                        SizedBox(
                                          width: 5.w,
                                        ),
                                        Text(
                                          appLocalizations.openAttachment +
                                              ": ",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            color: Color(0xFF3475F0),
                                            fontFamily: 'OpenSans',
                                            // fontSize: 17.sp,
                                            fontStyle: FontStyle.italic,
                                            // fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            file.filename,
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              color: Color(0xFF434141),
                                              fontFamily: 'OpenSans',
                                              //   fontSize: 17.sp,
                                              fontStyle: FontStyle.italic,
                                              //  fontWeight: FontWeight.bold,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    color: Color(0xFF979797),
                                    thickness: 2,
                                  ),
                                ],
                              ),
                            )
                            .toList(),
                      ),
                    SizedBox(
                      height: 30.h,
                    ),
                    if (material.creatorId == user.id ||
                        (material.editability ==
                                Material_Editability.GROUP_EDIT &&
                            isAssignedToGroupWithLeaderRole)) ...[
                      Text(
                        appLocalizations.thismaterialIsVisibleTo,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Color(0xFF3475F0),
                          fontFamily: 'OpenSans',
                          fontSize: 19.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.remove_red_eye,
                            color: Color(0xFF3475F0),
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          Text(
                            material.visibility.toLocaleString(context),
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              //   color: Color(0xFF3475F0),
                              fontFamily: 'OpenSans',
                              fontSize: 17.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        color: Color(0xFF979797),
                        thickness: 2,
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                    ],
                    Text(
                      appLocalizations.lanugages,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Color(0xFF3475F0),
                        fontFamily: 'OpenSans',
                        fontSize: 19.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (material.languageIds.isNotEmpty)
                      SizedBox(
                        height: 5.h,
                      ),
                    _MaterialLanguages(material: material),
                    Divider(
                      color: Color(0xFF979797),
                      thickness: 2,
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Text(
                      appLocalizations.topics,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Color(0xFF3475F0),
                        fontFamily: 'OpenSans',
                        fontSize: 19.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (material.topics.isNotEmpty)
                      SizedBox(
                        height: 5.h,
                      ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: material.topics
                          .map(
                            (topic) => Text(
                              topic,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                //   color: Color(0xFF3475F0),
                                fontFamily: 'OpenSans',
                                fontSize: 17.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          )
                          .toList(),
                    ),
                    SizedBox(
                      height: 63.h,
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: appLocalizations.inAppropriateMaterial,
                            style: TextStyle(
                                color: Color(0xFFF65A4A),
                                fontSize: 19.sp,
                                fontStyle: FontStyle.italic),
                          ),
                          TextSpan(
                            text: appLocalizations.clickHere,
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                decorationStyle: TextDecorationStyle.solid,
                                color: Color(0xFFF65A4A),
                                fontSize: 19.sp,
                                fontStyle: FontStyle.italic),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                final widget = RepositoryProvider.value(
                                  value: context.read<DataRepository>(),
                                  child: ReportMaterialDialogBox(
                                    material: material,
                                  ),
                                );
                                showDialog(
                                  context: context,
                                  builder: (_) => widget,
                                );
                              },
                          ),
                          new TextSpan(
                            text: appLocalizations.toReportIt,
                            style: new TextStyle(
                                color: Color(0xFFF65A4A),
                                fontSize: 19.sp,
                                fontStyle: FontStyle.italic),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Container(
          height: 75.0,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Color(0xFFEFEFEF),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
                left: 30.0, right: 30.0, top: 19.0, bottom: 19.0),
            child: Container(
              height: 37.5.h,
              color: Color(0xFFEFEFEF),
              child: ElevatedButton(
                onPressed: () {
                  //_closeSlidingUpPanelIfOpen();
                  Navigator.pop(context);
                },
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40.r),
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all<Color>(
                      AppColors.selectedButtonBG),
                ),
                child: Text(appLocalizations.close),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _MaterialLanguages extends StatelessWidget {
  const _MaterialLanguages({Key? key, required this.material})
      : super(key: key);

  final Material material;

  @override
  Widget build(BuildContext context) {
    if (material.languageIds.isEmpty) {
      return const SizedBox();
    }
    final languages = material.languageNames;
    languages.sort();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: languages
          .map(
            (languageName) => Text(
              languageName,
              textAlign: TextAlign.left,
              style: TextStyle(
                //  color: Color(0xFF3475F0),
                fontFamily: 'OpenSans',
                fontSize: 17.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          )
          .toList(),
    );
  }
}
