import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starfish/apis/hive_api.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:starfish/constants/assets_path.dart';
import 'package:starfish/modules/results/action_history.dart';
import 'package:starfish/modules/results/action_statuses.dart';
import 'package:starfish/modules/results/teacher_feedback.dart';
import 'package:starfish/src/grpc_extensions.dart';
import 'package:starfish/utils/helpers/extensions/strings.dart';
import 'package:starfish/wrappers/file_system.dart';

class ResultWidgetBottomSheet extends StatefulWidget {
  final Group group;
  final GroupUser groupUser;
  final GroupEvaluation? leanerEvaluationForGroup;

  const ResultWidgetBottomSheet({
    Key? key,
    required this.group,
    required this.groupUser,
    this.leanerEvaluationForGroup,
  }) : super(key: key);

  @override
  State<ResultWidgetBottomSheet> createState() =>
      _ResultWidgetBottomSheetState();
}

class _ResultWidgetBottomSheetState extends State<ResultWidgetBottomSheet> {
  List<File>? imageFiles;

  Transformation? _hiveTransformation;
  TeacherResponse? _hiveTeacherResponse;

  bool _isEditMode = false;
  bool isViewActionHistory = false;
  bool isViewCategoryEvalutionHistory = false;

  //double _value = 2.0;

  TextEditingController _teacherFeedbackController = TextEditingController();
  TextEditingController _transformationController = TextEditingController();
  List<File> _selectedFiles = [];
  // List<HiveFile> _hiveFiles = [];

  String _impactStory = '';
  String _teacherFeedback = '';
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   _hiveTransformation = widget.hiveGroupUser
  //       .getTransformationForMonth(bloc.resultsBloc.hiveDate!);
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return Container(
      height: MediaQuery.of(context).size.height * 0.80,
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom, top: 40.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(34.r)),
        color: Color(0xFFEFEFEF),
      ),
      child: Column(
        children: [
          Expanded(
            child: DecoratedBox(
              decoration: BoxDecoration(color: Colors.white),
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 15.0.w),
                children: [
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
                          child: Center(
                            child: Text(
                              widget.group.name,
                              //overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFF3475F0),
                                fontFamily: 'OpenSans',
                                fontSize: 19.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  SizedBox(height: 20.h),
                  InkWell(
                    onTap: () async {
                      // TODO
                      // final selected = await _selectMonth(bloc);
                      // if (selected != null) {
                      //   HiveDate _hiveDate = HiveDate.create(
                      //       selected.year, selected.month, 0);

                      //   setState(() {
                      //     bloc.resultsBloc.hiveDate = _hiveDate;
                      //     leanerEvaluationForGroup =
                      //         hiveGroupUser.getGroupEvaluationForMonth(
                      //             bloc.resultsBloc.hiveDate!);
                      //   });

                      //   //_updateLearnerSummary();
                      // }
                    },
                    child: Container(
                      alignment: Alignment.centerLeft,

                      height: 52.h,
                      //width: 345.w,
                      padding: EdgeInsets.only(left: 15.w, right: 15.w),
                      //   margin: EdgeInsets.only(left: 15.w, right: 15.w),
                      decoration: BoxDecoration(
                        color: AppColors.txtFieldBackground,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: ButtonTheme(
                        alignedDropdown: true,
                        child: Text(
                          // TODO
                          'TODO',
                          // DateTimeUtils.formatHiveDate(
                          //     bloc.resultsBloc.hiveDate!,
                          //     requiredDateFormat: "MMMM yyyy"),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Color(0xFF434141),
                            fontSize: 19.sp,
                            fontFamily: 'OpenSans',
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color(0xFFEFEFEF),
                          borderRadius:
                              BorderRadius.all(Radius.circular(8.5.r))),
                      child: DropdownButtonHideUnderline(
                        child: ButtonTheme(
                          alignedDropdown: true,
                          child: DropdownButton2<User>(
                            offset: Offset(0, -10),
                            dropdownMaxHeight: 200.h,
                            scrollbarAlwaysShow: true,
                            isExpanded: true,
                            iconSize: 35,
                            style: TextStyle(
                              color: Color(0xFFEFEFEF),
                              fontSize: 19.sp,
                              fontFamily: 'OpenSans',
                            ),
                            hint: Text(
                              "${appLocalizations.learner}: ${widget.groupUser.group?.name ?? ''}",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Color(0xFF434141),
                                fontSize: 19.sp,
                                fontFamily: 'OpenSans',
                              ),
                              textAlign: TextAlign.left,
                            ),
                            onChanged: (User? value) {
                              // TODO
                            },
                            items: widget.group.learners
                                .map<DropdownMenuItem<User>>((User value) {
                              return DropdownMenuItem<User>(
                                value: value,
                                child: Text(
                                  value.name,
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
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    children: [
                      Text(
                        "${appLocalizations.feelingAboutTheGroup}: ",
                        style: TextStyle(
                          fontSize: 17.sp,
                          fontFamily: "OpenSans",
                          fontStyle: FontStyle.normal,
                          color: Color(0xFF4F4F4F),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (widget.leanerEvaluationForGroup != null) ...[
                        Image.asset(
                          widget.leanerEvaluationForGroup!.evaluation ==
                                  GroupEvaluation_Evaluation.GOOD
                              ? AssetsPath.thumbsUp
                              : AssetsPath.thumbsDown,
                          color: const Color(0xFF797979),
                          height: 15.sp,
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        Text(
                          widget.leanerEvaluationForGroup!.evaluation.name
                              .toCapitalized(),
                          style: TextStyle(
                            fontFamily: "Rubik",
                            fontSize: 15.sp,
                            color: Color(0xFF797979),
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ],
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  _ActionCard(groupUser: widget.groupUser),
                  SizedBox(
                    height: 5.h,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  //_buildTrasnformatonsCard(),
                  // _buildTransformationWidget(),

                  SizedBox(
                    height: 10.h,
                  ),
                  TeacherFeedback(
                    evaluationCategories: widget.group.evaluationCategoryIds
                        .map((id) => globalHiveApi.evaluationCategory.get(id)!)
                        .toList(),
                    groupUser: widget.groupUser,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                ],
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
                    //  _saveTransformation(userImpactStory, imageFiles ?? []);
                    Navigator.pop(context);
                  },
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40.r),
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.all<Color>(
                        AppColors.unselectedButtonBG),
                  ),
                  child: Text(appLocalizations.close),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget _buildMonthWiseEvaluation(
  //     int count, String categoryName, int changeInCount, Color textColor) {
  //   return Expanded(
  //     child: Container(
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.center,
  //         children: [
  //           Text("$count",
  //               style: TextStyle(
  //                 fontFeatures: [FontFeature.subscripts()],
  //                 color: Color(0xFF434141),
  //                 fontFamily: "OpenSans",
  //                 fontSize: 30.sp,
  //                 fontWeight: FontWeight.bold,
  //               ),
  //               textAlign: TextAlign.center),
  //           Text(
  //             "$categoryName",
  //             style: TextStyle(
  //               fontSize: 17.sp,
  //               fontFamily: "OpenSans",
  //               color: Color(0x99434141),
  //             ),
  //             textAlign: TextAlign.center,
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // Widget _buildMonthlyEvaluationWidget(
  //     Map<HiveEvaluationCategory, Map<String, int>> _learnersEvaluations) {
  //   List<Widget> _currentEvaluationWidget = [];
  //   _learnersEvaluations.forEach(
  //       (HiveEvaluationCategory category, Map<String, int> countByMonth) {
  //     _currentEvaluationWidget.add(_buildMonthWiseEvaluation(
  //         countByMonth["this-month"] ?? 0,
  //         category.name!,
  //         ((countByMonth["this-month"] ?? 0) -
  //             (countByMonth["last-month"] ?? 0)),
  //         Color(0xFFFFFFFF)));
  //   });
  //   return Row(
  //     children: _currentEvaluationWidget,
  //   );
  // }

  // Widget _buildGroupEvaluationWidget() {
  //   if (bloc.resultsBloc.getGroupEvaluation() ==
  //       GroupEvaluation_Evaluation.GOOD) {
  //     return Row(children: [
  //       Icon(
  //         Icons.thumb_up,
  //         color: Color(0xFF707070),
  //       ),
  //       SizedBox(
  //         width: 5.w,
  //       ),
  //       Text(
  //         '${appLocalizations.goodText}',
  //         style: TextStyle(
  //           //    fontWeight: FontWeight.w600,
  //           fontSize: 16.sp,
  //           fontFamily: "Rubik",
  //           color: Color(0xFF707070),
  //         ),
  //       ),
  //     ]);
  //   } else if (bloc.resultsBloc.getGroupEvaluation() ==
  //       GroupEvaluation_Evaluation.BAD) {
  //     return Row(children: [
  //       Icon(
  //         Icons.thumb_down,
  //         color: Color(0xFF707070),
  //       ),
  //       SizedBox(
  //         width: 5.w,
  //       ),
  //       Text(
  //         '${appLocalizations.notSoGoodText}',
  //         style: TextStyle(
  //           //    fontWeight: FontWeight.w600,
  //           fontSize: 16.sp,
  //           fontFamily: "Rubik",
  //           color: Color(0xFF707070),
  //         ),
  //       ),
  //     ]);
  //   } else {
  //     //if (bloc.resultsBloc.getGroupEvaluation() == GroupEvaluation_Evaluation.EVAL_UNSPECIFIED) {
  //     return Container();
  //   }
  // }

  // Future<DateTime?> _selectMonth(DataBloc bloc) async {
  //   // reference for the MonthYearPickerLocalizations is add in app.dart
  //   return await showMonthYearPicker(
  //     context: context,
  //     initialDate: DateTimeUtils.toDateTime(
  //         DateTimeUtils.formatHiveDate(bloc.resultsBloc.hiveDate!,
  //             requiredDateFormat: "dd-MMM-yyyy"),
  //         "dd-MMM-yyyy"),
  //     firstDate: DateTime(DateTime.now().year - 10),
  //     lastDate: DateTime(DateTime.now().year + 10),
  //     hideActions: true,
  //   );
  // }

  // void _updateLearnerSummary() {
  //   _teacherFeedbackController.text = bloc.resultsBloc.hiveGroupUser
  //           ?.getTeacherResponseForMonth(bloc.resultsBloc.hiveDate!)
  //           ?.response ??
  //       '';
  // }

  // void _saveGroupEvaluation(GroupEvaluation_Evaluation evaluation) {
  //   HiveGroupEvaluation _hiveGroupEvaluation;

  //   if (_isEditMode) {
  //     // TODO:

  //     _hiveGroupEvaluation = HiveGroupEvaluation();
  //   } else {
  //     _hiveGroupEvaluation = HiveGroupEvaluation();
  //     _hiveGroupEvaluation.userId = bloc.resultsBloc.hiveGroupUser?.userId;
  //     _hiveGroupEvaluation.groupId = bloc.resultsBloc.hiveGroupUser?.groupId;
  //     _hiveGroupEvaluation.month = bloc.resultsBloc.hiveDate!.toMonth;
  //   }
  //   _hiveGroupEvaluation.evaluation = evaluation.value;

  //   GroupEvaluationProvider().createUpdateGroupEvaluation(_hiveGroupEvaluation);
  // }

  // void _saveTeacherFeedback(String feedback) {
  //   // HiveTeacherResponse? _teacherResponse = hiveGroupUser
  //   //     .getTeacherResponseForMonth(bloc.resultsBloc.hiveDate!);

  //   if (_hiveTeacherResponse == null) {
  //     _hiveTeacherResponse = HiveTeacherResponse();
  //     _hiveTeacherResponse!.id = UuidGenerator.uuid();
  //     _hiveTeacherResponse!.groupId = hiveGroupUser.groupId;
  //     _hiveTeacherResponse!.learnerId = hiveGroupUser.userId;
  //     _hiveTeacherResponse!.teacherId = CurrentUserProvider().getUserSync().id;
  //     _hiveTeacherResponse!.month = bloc.resultsBloc.hiveDate!.toMonth;
  //     _hiveTeacherResponse!.isNew = true;
  //   } else {
  //     _hiveTeacherResponse!.isUpdated = true;
  //   }

  //   _hiveTeacherResponse!.response = feedback;

  //   TeacherResponseProvider()
  //       .createUpdateTeacherResponse(_hiveTeacherResponse!)
  //       .then((value) {
  //     setState(() {});
  //     debugPrint("Feedback saved.");
  //     FBroadcast.instance().broadcast(
  //       SyncService.kUpdateTeacherResponse,
  //       value: _hiveTeacherResponse,
  //     );
  //   }).onError((error, stackTrace) {
  //     debugPrint("Failed to save Feedback.");
  //   });
  // }

  // void _saveTransformation(String? _impactStory, List<File> _files) {
  //   // _hiveTransformation = widget.hiveGroupUser
  //   //     .getTransformationForMonth(bloc.resultsBloc.hiveDate!);
  //   if (_impactStory != null) {
  //     if (_hiveTransformation == null) {
  //       _hiveTransformation = HiveTransformation();
  //       _hiveTransformation!.id = UuidGenerator.uuid();
  //       _hiveTransformation!.groupId = hiveGroupUser.groupId;
  //       _hiveTransformation!.userId = hiveGroupUser.userId;
  //       _hiveTransformation!.month = bloc.resultsBloc.hiveDate!;
  //       _hiveTransformation!.isNew = true;
  //     } else {
  //       _hiveTransformation!.isUpdated = true;
  //     }

  //     _hiveTransformation!.impactStory = _impactStory;
  //   }

  //   List<HiveFile> _transformationFiles = [];

  //   _files.forEach((file) {
  //     _transformationFiles.add(HiveFile(
  //       entityId: _hiveTransformation!.id,
  //       entityType: EntityType.TRANSFORMATION.value,
  //       filepath: file.path,
  //       filename: file.path.split("/").last,
  //     ));
  //   });

  //   TransformationProvider()
  //       .createUpdateTransformation(_hiveTransformation!,
  //           transformationFiles: _transformationFiles)
  //       .then((value) {
  //     debugPrint("Transformation saved.");
  //     setState(() {});
  //     // save files also
  //   }).onError((error, stackTrace) {
  //     debugPrint("Failed to save Transformation");
  //   });
  // }

  // void _saveLearnerEvaluation(String categoryId, int value) {
  //   String evaluatorId = CurrentUserProvider().getUserSync().id;

  //   debugPrint(
  //       "LearnerEvaluation saved for Month: ${bloc.resultsBloc.hiveDate}");
  //   debugPrint(
  //       "LearnerEvaluation saved for PreviousDate: ${bloc.resultsBloc.hivePreviousDate}");
  //   HiveLearnerEvaluation? _learnerEvaluation =
  //       hiveGroupUser.getLearnerEvaluation(
  //           bloc.resultsBloc.hiveDate!, categoryId, evaluatorId);

  //   if (_learnerEvaluation == null) {
  //     _learnerEvaluation = HiveLearnerEvaluation();
  //     _learnerEvaluation.id = UuidGenerator.uuid();
  //     _learnerEvaluation.learnerId = hiveGroupUser.userId;
  //     _learnerEvaluation.groupId = hiveGroupUser.groupId;
  //     _learnerEvaluation.evaluatorId = evaluatorId;
  //     _learnerEvaluation.month = bloc.resultsBloc.hiveDate!.toMonth;
  //     _learnerEvaluation.categoryId = categoryId;
  //     _learnerEvaluation.isNew = true;
  //   } else {
  //     _learnerEvaluation.isUpdated = true;
  //   }
  //   _learnerEvaluation.evaluation = value;

  //   LearnerEvaluationProvider()
  //       .createUpdateLearnerEvaluation(_learnerEvaluation)
  //       .then((value) {
  //     debugPrint("LearnerEvaluation saved.");
  //     FBroadcast.instance().broadcast(
  //       SyncService.kUpdateLearnerEvaluation,
  //       value: _learnerEvaluation,
  //     );
  //   }).onError((error, stackTrace) {
  //     debugPrint("Failed to save LearnerEvaluation");
  //   });
  // }

  // Widget _buildTransformationWidget() {
  //   return Card(
  //     color: Color(0xE6EFEFEF),
  //     elevation: 4,
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.all(
  //         Radius.circular(
  //           10,
  //         ),
  //       ),
  //     ),
  //     child: Container(
  //       padding: EdgeInsets.only(left: 15.w, right: 15.w),
  //       child: Column(
  //         children: [
  //           SizedBox(
  //             height: 10.h,
  //           ),
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               SvgPicture.asset(
  //                 AssetsPath.resultsActiveIcon,
  //                 color: Colors.green,
  //               ),
  //               SizedBox(
  //                 width: 5.w,
  //               ),
  //               Text(
  //                 '${appLocalizations.transformations}',
  //                 style: TextStyle(
  //                   fontWeight: FontWeight.w600,
  //                   fontSize: 19.sp,
  //                   fontFamily: "OpenSans",
  //                   color: Color(0xFF4F4F4F),
  //                 ),
  //               ),
  //             ],
  //           ),
  //           SizedBox(height: 10.h),
  //           Container(
  //             decoration: BoxDecoration(
  //               color: Color(0xFFFFFFFF),
  //               border: Border.all(
  //                 color: Color(0xFF979797),
  //               ),
  //               borderRadius: BorderRadius.all(
  //                 Radius.circular(10),
  //               ),
  //             ),
  //             child: FocusableTextField(
  //               controller: _transformationController,
  //               keyboardType: TextInputType.text,
  //               decoration: InputDecoration(
  //                 hintText:
  //                     '${appLocalizations.hintTextTransformationsTextField}',
  //                 hintStyle: TextStyle(
  //                   fontFamily: "OpenSans",
  //                   fontSize: 16.sp,
  //                   fontStyle: FontStyle.italic,
  //                 ),
  //               ),
  //               maxLines: 3,
  //               textInputAction: TextInputAction.done,
  //               onFocusChange: (isFocused) {
  //                 if (isFocused) {
  //                   return;
  //                 }
  //                 _saveTransformation(
  //                     _transformationController.text.trim(), _selectedFiles);
  //               },
  //               onChange: (value) {
  //                 _impactStory = value;
  //               },
  //             ),
  //           ),
  //           SizedBox(
  //             height: 10.h,
  //           ),
  //           //  if (_isEditMode) _previewFiles(widget.material!),
  //           // SizedBox(height: 10.h),

  //           // _previewSelectedFiles(),

  //           // Add Materials

  //           if (_selectedFiles.isNotEmpty ||
  //               (_hiveTransformation != null &&
  //                   _hiveTransformation!.localFiles.isNotEmpty &&
  //                   _hiveFiles != null &&
  //                   _hiveFiles.isNotEmpty))
  //             _previewSelectedFiles(),
  //           SizedBox(height: 10.h),
  //           DottedBorder(
  //             borderType: BorderType.RRect,
  //             radius: Radius.circular(30.r),
  //             color: Color(0xFF3475F0),
  //             child: Container(
  //                 width: double.infinity,
  //                 height: 50.h,
  //                 child: ElevatedButton(
  //                   onPressed: () async {
  //                     if ((_selectedFiles.length + (_hiveFiles.length)) >= 5) {
  //                       Fluttertoast.showToast(
  //                           msg:
  //                               appLocalizations.maxFilesSelected);
  //                     } else {
  //                       final result = await getPickerFileWithCrop(
  //                         context,
  //                         type: FileType.image,
  //                       );

  //                       if (result != null) {
  //                         var fileSize = result.size;
  //                         if (fileSize > 5 * 1024 * 1024) {
  //                           Fluttertoast.showToast(
  //                               msg: appLocalizations
  //                                   .imageSizeValidation);
  //                         } else {
  //                           setState(() {
  //                             _selectedFiles.add(result);
  //                             _saveTransformation(
  //                                 _transformationController.text,
  //                                 _selectedFiles);
  //                             _selectedFiles.clear();
  //                           });
  //                         }
  //                       } else {
  //                         // User canceled the picker
  //                       }
  //                     }
  //                   },
  //                   child: Text(
  //                     '${appLocalizations.addPhotos}',
  //                     style: TextStyle(
  //                       fontFamily: 'OpenSans',
  //                       fontSize: 17.sp,
  //                       color: Color(0xFF3475F0),
  //                     ),
  //                   ),
  //                   style: ElevatedButton.styleFrom(
  //                     primary: Colors.transparent,
  //                     shadowColor: Colors.transparent,
  //                   ),
  //                 )),
  //           ),

  //           SizedBox(
  //             height: 20.h,
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // Widget _imagePreview({required File file, required Function onDelete}) {
  //   return Stack(
  //     alignment: AlignmentDirectional.topEnd,
  //     children: [
  //       Container(
  //         width: MediaQuery.of(context).size.width,
  //         padding: const EdgeInsets.only(top: 10.0, right: 10.0),
  //         child: Container(
  //           child: InkWell(
  //             onTap: () => Navigator.of(context).push(
  //                 MaterialPageRoute(builder: (context) => ImagePreview(file))),
  //             child: Hero(
  //               tag: file,
  //               child: Card(
  //                 margin: const EdgeInsets.only(top: 12.0, right: 12.0),
  //                 shape: BeveledRectangleBorder(
  //                   borderRadius: BorderRadius.circular(10.0),
  //                 ),
  //                 child: ClipRRect(
  //                   borderRadius: BorderRadius.circular(10),
  //                   child: file.getImagePreview(
  //                     fit: BoxFit.scaleDown,
  //                     //  height: 130.h,
  //                   ),
  //                 ),
  //               ),
  //               flightShuttleBuilder: (flightContext, animation, direction,
  //                   fromContext, toContext) {
  //                 return Center(
  //                   child: CircularProgressIndicator(),
  //                 );
  //               },
  //             ),
  //           ),
  //         ),
  //       ),
  //       IconButton(
  //         onPressed: () {
  //           // setState(() {
  //           //   _selectedFiles.remove(file);
  //           // });
  //           onDelete();
  //         },
  //         icon: Icon(
  //           Icons.delete,
  //           color: Colors.red,
  //         ),
  //       ),
  //     ],
  //   );
  // }

  // Widget _previewSelectedFiles() {
  //   final List<Widget> _widgetList = [];

  //   for (final file in _selectedFiles) {
  //     _widgetList.add(_imagePreview(
  //         file: File(file.path),
  //         onDelete: () {
  //           setState(() {
  //             _selectedFiles.remove(file);
  //           });
  //         }));
  //   }

  //   if (_hiveTransformation != null &&
  //       _hiveTransformation!.localFiles.isNotEmpty &&
  //       _hiveFiles.isNotEmpty &&
  //       _hiveFiles != null) {
  //     for (HiveFile _hiveFile in _hiveFiles) {
  //       File file = File(_hiveFile.filepath!);
  //       _widgetList.add(_imagePreview(
  //           file: file,
  //           onDelete: () {
  //             setState(() {
  //               _hiveFile.delete();
  //             });
  //           }));
  //     }
  //   }

  //   return GridView.count(
  //     shrinkWrap: true,
  //     physics: NeverScrollableScrollPhysics(),
  //     crossAxisCount: (_selectedFiles.length == 1 && _hiveFiles.length == 0) ||
  //             (_hiveFiles.length == 1 && _selectedFiles.length == 0)
  //         ? 1
  //         : 2,
  //     childAspectRatio: 1,
  //     children: _widgetList,
  //   );
  // }
}

class _ActionCard extends StatelessWidget {
  const _ActionCard({Key? key, required this.groupUser}) : super(key: key);

  final GroupUser groupUser;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return Card(
      //   margin: EdgeInsets.only(left: 15.w, right: 15.w),
      color: Color(0xFFEFEFEF),
      elevation: 4,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
        Radius.circular(10),
      )),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 10.h,
            ),
            Text(
              appLocalizations.resultMoreThenOneActionCompleted,
              style: TextStyle(
                fontSize: 19.sp,
                color: Color(0xFF4F4F4F),
                fontWeight: FontWeight.w600,
                fontFamily: "OpenSans",
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            // TODO: Actual numbers
            ActionStatuses(
              complete: 0,
              notComplete: 0,
              overdue: 0,
            ),
            SizedBox(
              height: 20.h,
            ),
            // TODO: If history is available
            if (true)
              Padding(
                padding: EdgeInsets.only(bottom: 10.h),
                child: ActionHistory(groupUser: groupUser),
              ),
          ],
        ),
      ),
    );
  }
}
