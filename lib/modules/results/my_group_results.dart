import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:starfish/bloc/app_bloc.dart';
import 'package:starfish/bloc/provider.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:starfish/constants/assets_path.dart';
import 'package:starfish/constants/text_styles.dart';
import 'package:starfish/db/hive_date.dart';
import 'package:starfish/db/hive_group.dart';
import 'package:starfish/db/hive_group_evaluation.dart';
import 'package:starfish/db/hive_group_user.dart';
import 'package:starfish/db/hive_teacher_response.dart';
import 'package:starfish/db/providers/current_user_provider.dart';
import 'package:starfish/db/providers/group_evaluation_provider.dart';
import 'package:starfish/db/providers/teacher_response_provider.dart';
import 'package:starfish/modules/results/learner_list_with_summary_card.dart';
import 'package:starfish/modules/results/project_report_for_groups.dart';
import 'package:starfish/modules/results/summary_for_learners.dart';
import 'package:starfish/modules/settings_view/settings_view.dart';
import 'package:starfish/src/generated/starfish.pb.dart';
import 'package:starfish/utils/date_time_utils.dart';
import 'package:starfish/utils/helpers/uuid_generator.dart';
import 'package:starfish/widgets/app_logo_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/src/widgets/basic.dart' as widgetsBasic;

class MyGroupResults extends StatefulWidget {
  MyGroupResults({Key? key}) : super(key: key);

  @override
  _MyGroupResultsState createState() => _MyGroupResultsState();
}

class _MyGroupResultsState extends State<MyGroupResults> {
  late AppBloc bloc;

  bool _isEditMode = false;

  TextEditingController _teacherFeedbackController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bloc = Provider.of(context);
    bloc.resultsBloc.init();

    return FocusDetector(
      onFocusGained: () {},
      onFocusLost: () {},
      child: Scaffold(
        backgroundColor: AppColors.resultsScreenBG,
        appBar: AppBar(
          title: Container(
            height: 64.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                AppLogo(hight: 36.h, width: 37.w),
                Text(
                  AppLocalizations.of(context)!.resultsTabItemText,
                  style: dashboardNavigationTitle,
                ),
                IconButton(
                  icon: SvgPicture.asset(AssetsPath.settings),
                  onPressed: () {
                    setState(
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SettingsScreen(),
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
          backgroundColor: AppColors.resultsScreenBG,
          elevation: 0.0,
        ),
        body: bloc.resultsBloc.hiveGroup != null
            ? Scrollbar(
                thickness: 5.w,
                isAlwaysShown: false,
                child: SingleChildScrollView(
                    child: Column(
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    Container(
                      height: 52.h,
                      width: 345.w,
                      margin: EdgeInsets.only(left: 15.w, right: 15.w),
                      decoration: BoxDecoration(
                        color: AppColors.txtFieldBackground,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: Center(
                        child: DropdownButtonHideUnderline(
                          child: ButtonTheme(
                            alignedDropdown: true,
                            child: DropdownButton<HiveGroup>(
                              isExpanded: true,
                              iconSize: 35,
                              style: TextStyle(
                                color: Color(0xFF434141),
                                fontSize: 19.sp,
                                fontFamily: 'OpenSans',
                              ),
                              hint: Text(
                                bloc.resultsBloc.hiveGroup?.name ??
                                    'Select Group',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Color(0xFF434141),
                                  fontSize: 19.sp,
                                  fontFamily: 'OpenSans',
                                ),
                                textAlign: TextAlign.left,
                              ),
                              onChanged: (HiveGroup? value) {
                                setState(() {
                                  bloc.resultsBloc.hiveGroup = value;
                                });
                              },
                              items: bloc.resultsBloc
                                  .fetchGroupsWtihLeaderRole()
                                  ?.map<DropdownMenuItem<HiveGroup>>(
                                      (HiveGroup value) {
                                return DropdownMenuItem<HiveGroup>(
                                  value: value,
                                  child: Text(
                                    value.name!,
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
                    SizedBox(height: 20.h),
                    Container(
                      height: 52.h,
                      width: 345.w,
                      margin: EdgeInsets.only(left: 15.w, right: 15.w),
                      decoration: BoxDecoration(
                        color: AppColors.txtFieldBackground,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: InkWell(
                        onTap: () {
                          _selectMonth(bloc);
                        },
                        child: Center(
                          child: ButtonTheme(
                            alignedDropdown: true,
                            child: Text(
                              DateTimeUtils.formatHiveDate(
                                  bloc.resultsBloc.hiveDate!,
                                  requiredDateFormat: "MMMM yyyy"),
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
                    ),
                    SizedBox(height: 20.h),
                    SummaryForAllLearners(),
                    SizedBox(
                      height: 10.h,
                    ),
                    ProjectReporsForGroup(),
                    SizedBox(
                      height: 20.h,
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: bloc.resultsBloc.hiveGroup!.learners!.length,
                        itemBuilder: (BuildContext context, index) {
                          HiveGroupUser _hiveGroupUser = bloc
                              .resultsBloc.hiveGroup!.learners!
                              .elementAt(index);
                          return InkWell(
                              onTap: () =>
                                  _onLearnerSummarySelection(_hiveGroupUser),
                              child: LearnerSummary(
                                  hiveGroupUser: _hiveGroupUser));
                        }),
                    SizedBox(
                      height: 20.h,
                    )
                  ],
                )),
              )
            : Container(
                height: MediaQuery.of(context).size.height - 40.h,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "Join a Group, or create a new Group, then you can monitor the results of the Group here.",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontFamily: "OpenSans",
                        fontStyle: FontStyle.italic,
                        color: Color(0xFF797979),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  void _onLearnerSummarySelection(HiveGroupUser hiveGroupUser) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(34.r),
          topRight: Radius.circular(34.r),
        ),
      ),
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: true,
      builder: (BuildContext context) {
        return _buildSlidingUpPanel(hiveGroupUser);
      },
    );
  }

  Widget _buildSlidingUpPanel(HiveGroupUser hiveGroupUser) {
    return widgetsBasic.StatefulBuilder(
        builder: (BuildContext context, StateSetter setModalState) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.70,
        child: Column(
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 15.0.w, top: 40.h, right: 15.0.w),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        //height: 22.h,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Expanded(
                              child: Center(
                                child: Text(
                                  '${hiveGroupUser.group!.name}',
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
                      Center(
                        child: Container(
                          decoration: BoxDecoration(
                              color: Color(0xFFEFEFEF),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.5.r))),
                          child: DropdownButtonHideUnderline(
                            child: ButtonTheme(
                              alignedDropdown: true,
                              child: DropdownButton<HiveGroupUser>(
                                isExpanded: true,
                                iconSize: 35,
                                style: TextStyle(
                                  color: Color(0xFFEFEFEF),
                                  fontSize: 19.sp,
                                  fontFamily: 'OpenSans',
                                ),
                                hint: Text(
                                  "Learner: ${bloc.resultsBloc.hiveGroupUser?.name}",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Color(0xFF434141),
                                    fontSize: 19.sp,
                                    fontFamily: 'OpenSans',
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                                onChanged: (HiveGroupUser? value) {
                                  setModalState(() {
                                    bloc.resultsBloc.hiveGroupUser = value;
                                  });
                                },
                                items: bloc.resultsBloc.hiveGroup!.learners
                                    ?.map<DropdownMenuItem<HiveGroupUser>>(
                                        (HiveGroupUser value) {
                                  return DropdownMenuItem<HiveGroupUser>(
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
                            '${AppLocalizations.of(context)!.feelingAboutTheGroup}:',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 19.sp,
                              fontFamily: "OpenSans",
                              color: Color(0xFF4F4F4F),
                            ),
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          InkWell(
                            onTap: () {
                              // TODO:  createUpdateGroupEvaluation
                              hiveGroupUser.getGroupEvaluationForMonth(
                                  bloc.resultsBloc.hiveDate!);
                            },
                            child: Icon(
                              Icons.thumb_up,
                              color: Color(0xFF707070),
                            ),
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          Text(
                            '${AppLocalizations.of(context)!.goodText}',
                            style: TextStyle(
                              //    fontWeight: FontWeight.w600,
                              fontSize: 16.sp,
                              fontFamily: "Rubik",
                              color: Color(0xFF707070),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      _buildActionCard(),
                      SizedBox(
                        height: 5.h,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      _buildTrasnformatonsCard(),
                      SizedBox(
                        height: 10.h,
                      ),
                      _buiildTeacherFeedBackCard(),
                    ],
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
                    child: Text(AppLocalizations.of(context)!.close),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buiildTeacherFeedBackCard() {
    return Card(
      color: Color(0xFFEFEFEF),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(
            10,
          ),
        ),
      ),
      child: Container(
        padding: EdgeInsets.only(left: 15.w, right: 15.w),
        child: Column(
          children: [
            SizedBox(
              height: 10.h,
            ),
            Text(
              "Teacher feedback for this person",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 19.sp,
                fontFamily: "OpenSans",
                color: Color(0xFF4F4F4F),
              ),
            ),
            Text(
              'Write in the box below, then click "Save"',
              style: TextStyle(
                // fontWeight: FontWeight.w600,
                fontStyle: FontStyle.italic,
                fontSize: 14.sp,
                fontFamily: "OpenSans",
                color: Color(0xFF797979),
              ),
            ),
            SizedBox(height: 10.h),
            Container(
              decoration: BoxDecoration(
                color: Color(0xFFFFFFFF),
                border: Border.all(
                  color: Color(0xFF979797),
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: TextFormField(
                controller: _teacherFeedbackController,
                decoration: InputDecoration(
                  hintText: "",
                  hintStyle: TextStyle(
                    fontFamily: "OpenSans",
                    fontSize: 16.sp,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                maxLines: 3,
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 19.0, bottom: 19.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 37.5.h,
                child: ElevatedButton(
                  onPressed: () {
                    //_closeSlidingUpPanelIfOpen();
                    //Navigator.pop(context);
                    _saveTeacherFeedback();
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
                  child: Text(AppLocalizations.of(context)!.save),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTrasnformatonsCard() {
    return Card(
      color: Color(0xFFEFEFEF),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(
            10,
          ),
        ),
      ),
      child: Container(
        padding: EdgeInsets.only(left: 15.w, right: 15.w),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(AssetsPath.resultsActiveIcon),
                SizedBox(
                  width: 5.w,
                ),
                Text(
                  "Transformatons",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 19.sp,
                    fontFamily: "OpenSans",
                    color: Color(0xFF4F4F4F),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Container(
              decoration: BoxDecoration(
                color: Color(0xFFFFFFFF),
                border: Border.all(
                  color: Color(0xFF979797),
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText:
                      "The impact story entered by the person is here and is editable by the leader",
                  hintStyle: TextStyle(
                      fontFamily: "OpenSans",
                      fontSize: 16.sp,
                      fontStyle: FontStyle.italic),
                ),
                maxLines: 3,
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            //  if (_isEditMode) _previewFiles(widget.material!),
            // SizedBox(height: 10.h),

            // // Selected files (Not uploaded)
            // _previewSelectedFiles(),

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
                    // if ((!_isEditMode && _selectedFiles.length >= 5) ||
                    //     (_isEditMode &&
                    //         (_selectedFiles.length +
                    //                 (widget.material!.localFiles.length)) >=
                    //             5)) {
                    //   StarfishSnackbar.showErrorMessage(context,
                    //       AppLocalizations.of(context)!.maxFilesSelected);
                    // } else {
                    //   FilePickerResult? result = await FilePicker.platform
                    //       .pickFiles(allowMultiple: false);

                    //   if (result != null) {
                    //     // if single selected file is IMAGE, open image in Cropper
                    //     if (result.count == 1 &&
                    //         ['jpg', 'jpeg', 'png'].contains(result.paths.first
                    //             ?.split("/")
                    //             .last
                    //             .split(".")
                    //             .last)) {
                    //       Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //           builder: (context) => ImageCropperScreen(
                    //             sourceImage: File(result.paths.first!),
                    //             onDone: (File? _newFile) {
                    //               if (_newFile == null) {
                    //                 return;
                    //               }
                    //               setState(() {
                    //                 _selectedFiles.add(_newFile);
                    //               });
                    //             },
                    //           ),
                    //         ),
                    //       ).then((value) => {
                    //             // Handle cropped image here
                    //           });
                    //     } else {
                    //       setState(() {
                    //         _selectedFiles.addAll(result.paths
                    //             .map((path) => File(path!))
                    //             .toList());
                    //       });
                    //     }
                    //   } else {
                    //     // User canceled the picker
                    //   }
                    // }
                  },
                  child: Text(
                    "Add Photos",
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
            SizedBox(
              height: 10.h,
            ),

            Padding(
              padding: const EdgeInsets.only(top: 19.0, bottom: 19.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 37.5.h,
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
                        AppColors.unselectedButtonBG),
                  ),
                  child: Text(AppLocalizations.of(context)!.save),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionCard() {
    return Card(
      //   margin: EdgeInsets.only(left: 15.w, right: 15.w),
      color: Color(0xFFEFEFEF),
      elevation: 4,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
        Radius.circular(
          10,
        ),
      )),
      child: Container(
        padding: EdgeInsets.only(left: 15.w, right: 15.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 10.h,
            ),
            Text(
              "${AppLocalizations.of(context)!.zeroOrOneActionCompleted}",
              style: TextStyle(
                fontSize: 19.sp,
                color: Color(0xFF4F4F4F),
                fontWeight: FontWeight.w600,
                fontFamily: "Open Sans",
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: 99.w,
                  decoration: BoxDecoration(
                      color: Color(0xFF6DE26B),
                      borderRadius: BorderRadius.all(Radius.circular(8.5.r))),
                  padding:
                      EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                  child: Text(
                    "${bloc.resultsBloc.hiveGroup!.actionsCompleted} ${AppLocalizations.of(context)!.done}",
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Rubik Medium",
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  width: 99.w,
                  decoration: BoxDecoration(
                      color: Color(0xFFFFBE4A),
                      borderRadius: BorderRadius.all(Radius.circular(8.5.r))),
                  padding:
                      EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                  child: Text(
                    "${bloc.resultsBloc.hiveGroup!.actionsNotDoneYet} ${AppLocalizations.of(context)!.pending}",
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Rubik Medium",
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  width: 99.w,
                  decoration: BoxDecoration(
                      color: Color(0xFFFF5E4D),
                      borderRadius: BorderRadius.all(Radius.circular(8.5.r))),
                  padding:
                      EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                  child: Text(
                    "${bloc.resultsBloc.hiveGroup!.actionsOverdue} ${AppLocalizations.of(context)!.overdue}",
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Rubik Medium",
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15.h,
            ),
            InkWell(
              onTap: () {},
              child: Text(
                "View History",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontFamily: "Open",
                  color: Color(0xFF3475F0),
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Visibility(
              child: Container(
                child: Column(
                  children: <Widget>[],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _selectMonth(AppBloc bloc) async {
    // reference for the MonthYearPickerLocalizations is add in app.dart
    final selected = await showMonthYearPicker(
      context: context,
      initialDate: DateTimeUtils.toDateTime(
          DateTimeUtils.formatHiveDate(bloc.resultsBloc.hiveDate!,
              requiredDateFormat: "dd-MMM-yyyy"),
          "dd-MMM-yyyy"),
      firstDate: DateTime(2011),
      lastDate: DateTime.now(),
    );
    if (selected != null) {
      HiveDate _hiveDate = HiveDate();

      _hiveDate.year = selected.year;
      _hiveDate.month = selected.month;
      _hiveDate.day = 1;

      setState(() {
        bloc.resultsBloc.hiveDate = _hiveDate;
      });
    }
  }

  void _saveGroupEvaluation(GroupEvaluation_Evaluation evaluation) {
    HiveGroupEvaluation _hiveGroupEvaluation;

    if (_isEditMode) {
      // TODO:

      _hiveGroupEvaluation = HiveGroupEvaluation();
    } else {
      _hiveGroupEvaluation = HiveGroupEvaluation();
      _hiveGroupEvaluation.userId = bloc.resultsBloc.hiveGroupUser?.userId;
      _hiveGroupEvaluation.groupId = bloc.resultsBloc.hiveGroupUser?.groupId;
      _hiveGroupEvaluation.month = bloc.resultsBloc.hiveDate;
    }
    _hiveGroupEvaluation.evaluation = evaluation.value;

    GroupEvaluationProvider().createUpdateGroupEvaluation(_hiveGroupEvaluation);
  }

  void _saveTeacherFeedback() {
    HiveTeacherResponse _teacherResponse;
    if (_isEditMode) {
      // TODO:

      _teacherResponse = HiveTeacherResponse();
    } else {
      _teacherResponse = HiveTeacherResponse();
      _teacherResponse.id = UuidGenerator.uuid();
      _teacherResponse.groupId = bloc.resultsBloc.hiveGroupUser?.groupId;
      _teacherResponse.learnerId = bloc.resultsBloc.hiveGroupUser?.userId;
      _teacherResponse.teacherId = CurrentUserProvider().getUserSync().id;
      _teacherResponse.month = bloc.resultsBloc.hiveDate;
    }

    _teacherResponse.response = _teacherFeedbackController.text;

    TeacherResponseProvider()
        .createUpdateTeacherResponse(_teacherResponse)
        .then((value) {});
  }
}
