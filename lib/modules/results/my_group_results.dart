import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:starfish/modules/results/cubit/results_cubit.dart';
import 'package:starfish/modules/results/learner_list_with_summary_card.dart';
import 'package:starfish/src/generated/google/type/date.pb.dart';
import 'package:starfish/src/generated/starfish.pb.dart';

import 'package:starfish/utils/date_time_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:starfish/widgets/month_year_picker/dialogs.dart';

class MyGroupResults extends StatefulWidget {
  MyGroupResults({Key? key}) : super(key: key);

  @override
  _MyGroupResultsState createState() => _MyGroupResultsState();
}

class _MyGroupResultsState extends State<MyGroupResults> {
  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return Scrollbar(
      thickness: 5.w,
      thumbVisibility: false,
      child: SingleChildScrollView(
          child: Column(
        children: [
          SizedBox(
            height: 20.h,
          ),
          Container(
            height: 52.h,
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
                  child: BlocBuilder<ResultsCubit, ResultsState>(
                    buildWhen: (previous, current) =>
                        previous.filterGroup != current.filterGroup ||
                        previous.groups != current.groups,
                    builder: ((context, state) {
                      return DropdownButton2<Group>(
                          dropdownMaxHeight: 350.h,
                          offset: Offset(0, -5),
                          isExpanded: true,
                          iconSize: 35,
                          style: TextStyle(
                            color: Color(0xFF434141),
                            fontSize: 19.sp,
                            fontFamily: 'OpenSans',
                          ),
                          hint: Text(
                            state.filterGroup?.name ?? '',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Color(0xFF434141),
                              fontSize: 19.sp,
                              fontFamily: 'OpenSans',
                            ),
                            textAlign: TextAlign.left,
                          ),
                          onChanged: (Group? value) {
                            context
                                .read<ResultsCubit>()
                                .updateGroupFilter(value!);
                          },
                          items: state.groups.map((value) {
                            return DropdownMenuItem<Group>(
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
                          }).toList());
                    }),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 20.h),
          BlocBuilder<ResultsCubit, ResultsState>(builder: (context, state) {
            return InkWell(
              onTap: () async {
                DateTime? selected = await _selectMonth(state.month);

                if (selected != null) {
                  context.read<ResultsCubit>().updateMonthFilter(
                      Date(year: selected.year, month: selected.month, day: 0));
                }
              },
              child: Container(
                alignment: Alignment.centerLeft,
                height: 52.h,
                padding: EdgeInsets.fromLTRB(15.w, 0, 15.w, 0),
                margin: EdgeInsets.only(left: 15.w, right: 15.w),
                decoration: BoxDecoration(
                  color: AppColors.txtFieldBackground,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: ButtonTheme(
                  alignedDropdown: true,
                  child: Text(
                    DateTimeUtils.formatHiveDate(state.month,
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
            );
          }),
          SizedBox(height: 20.h),
          // SummaryForAllLearners(
          //     groupEvaluationGoodCount: bloc.resultsBloc
          //         .getLearnersEvaluationCountByType(
          //             GroupEvaluation_Evaluation.GOOD),
          //     groupEvaluationBadCount: bloc.resultsBloc
          //         .getLearnersEvaluationCountByType(
          //             GroupEvaluation_Evaluation.BAD),
          //     hiveGroup: bloc.resultsBloc.hiveGroup!,
          //     month: bloc.resultsBloc.hiveDate!,
          //     groupLearnerEvaluationsByCategory:
          //         bloc.resultsBloc.getGroupLearnerEvaluationsByCategory()),
          // if (bloc.resultsBloc.shouldDisplayProjectReport() &&
          //     bloc.resultsBloc.hiveGroup != null) ...[
          //   SizedBox(
          //     height: 20.h,
          //   ),
          //   ProjectReporsForGroup(
          //       hiveGroup: bloc.resultsBloc.hiveGroup!,
          //       hiveDate: bloc.resultsBloc.hiveDate!),
          // ],

          SizedBox(
            height: 20.h,
          ),
          BlocBuilder<ResultsCubit, ResultsState>(builder: (context, state) {
            final resultsToShow = state.groupWithAdminRoleResultsToShow;
            final groupUserResultsList =
                resultsToShow.groupUserResultsStatusList;

            return ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: groupUserResultsList.length,
                itemBuilder: (BuildContext context, index) {
                  final _groupUserResultStatus =
                      groupUserResultsList.elementAt(index);
                  return InkWell(
                    //onTap: () => _onLearnerSummarySelection(_hiveGroupUser),
                    child: Column(
                      children: [
                        index != 0
                            ? SizedBox(
                                height: 20.h,
                              )
                            : SizedBox(
                                height: 0.0,
                              ),
                        LearnerSummary(
                          groupUserResultStatus: _groupUserResultStatus,
                          month: state.month,
                          // leanerEvaluationForGroup:
                          //     _hiveGroupUser.getGroupEvaluationForMonth(
                          //         bloc.resultsBloc.hiveDate!),
                        ),
                      ],
                    ),
                  );
                });
          }),
          SizedBox(
            height: 20.h,
          )
        ],
      )),
    );
  }
  // @override
  // Widget build(BuildContext context) {
  //   return FocusDetector(
  //     onFocusGained: () {},
  //     onFocusLost: () {},
  //     child: Scaffold(
  //       backgroundColor: AppColors.resultsScreenBG,
  //       body: bloc.resultsBloc.hiveGroup != null
  //           ? Scrollbar(
  //               thickness: 5.w,
  //               thumbVisibility: false,
  //               child: SingleChildScrollView(
  //                   child: Column(
  //                 children: [
  //                   SizedBox(
  //                     height: 20.h,
  //                   ),
  //                   Container(
  //                     height: 52.h,
  //                     margin: EdgeInsets.only(left: 15.w, right: 15.w),
  //                     decoration: BoxDecoration(
  //                       color: AppColors.txtFieldBackground,
  //                       borderRadius: BorderRadius.all(
  //                         Radius.circular(10),
  //                       ),
  //                     ),
  //                     child: Center(
  //                       child: DropdownButtonHideUnderline(
  //                         child: ButtonTheme(
  //                           alignedDropdown: true,
  //                           child: DropdownButton2<HiveGroup>(
  //                               dropdownMaxHeight: 350.h,
  //                               offset: Offset(0, -5),
  //                               isExpanded: true,
  //                               iconSize: 35,
  //                               style: TextStyle(
  //                                 color: Color(0xFF434141),
  //                                 fontSize: 19.sp,
  //                                 fontFamily: 'OpenSans',
  //                               ),
  //                               hint: Text(
  //                                 bloc.resultsBloc.hiveGroup?.name ??
  //                                     '${AppLocalizations.of(context)!.selectGroup}',
  //                                 maxLines: 2,
  //                                 overflow: TextOverflow.ellipsis,
  //                                 style: TextStyle(
  //                                   color: Color(0xFF434141),
  //                                   fontSize: 19.sp,
  //                                   fontFamily: 'OpenSans',
  //                                 ),
  //                                 textAlign: TextAlign.left,
  //                               ),
  //                               onChanged: (HiveGroup? value) {
  //                                 debugPrint("HiveGroup: ${value!.name}");
  //                                 setState(() {
  //                                   bloc.resultsBloc.hiveGroup = value;
  //                                 });
  //                               },
  //                               items: bloc
  //                                   .resultsBloc.groupsWithAdminAndTeacherRole
  //                                   .map((value) {
  //                                 return DropdownMenuItem<HiveGroup>(
  //                                   value: value,
  //                                   child: Text(
  //                                     value.name!,
  //                                     style: TextStyle(
  //                                       color: Color(0xFF434141),
  //                                       fontSize: 17.sp,
  //                                       fontFamily: 'OpenSans',
  //                                     ),
  //                                   ),
  //                                 );
  //                               }).toList()

  //                               // return DropdownMenuItem<HiveGroup>(
  //                               //   value: value,
  //                               //   child: Text(
  //                               //     value.name!,
  //                               //     style: TextStyle(
  //                               //       color: Color(0xFF434141),
  //                               //       fontSize: 17.sp,
  //                               //       fontFamily: 'OpenSans',
  //                               //     ),
  //                               //   ),
  //                               // );
  //                               // }).toList(),

  //                               ),
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                   SizedBox(height: 20.h),
  //                   InkWell(
  //                     onTap: () async {
  //                       DateTime? selected = await _selectMonth(bloc);

  //                       if (selected != null) {
  //                         HiveDate _hiveDate =
  //                             HiveDate.create(selected.year, selected.month, 0);

  //                         setState(() {
  //                           bloc.resultsBloc.hiveDate = _hiveDate;
  //                         });
  //                       }
  //                     },
  //                     child: Container(
  //                       alignment: Alignment.centerLeft,
  //                       height: 52.h,
  //                       padding: EdgeInsets.fromLTRB(15.w, 0, 15.w, 0),
  //                       margin: EdgeInsets.only(left: 15.w, right: 15.w),
  //                       decoration: BoxDecoration(
  //                         color: AppColors.txtFieldBackground,
  //                         borderRadius: BorderRadius.all(
  //                           Radius.circular(10),
  //                         ),
  //                       ),
  //                       child: ButtonTheme(
  //                         alignedDropdown: true,
  //                         child: Text(
  //                           DateTimeUtils.formatHiveDate(
  //                               bloc.resultsBloc.hiveDate!,
  //                               requiredDateFormat: "MMMM yyyy"),
  //                           maxLines: 2,
  //                           overflow: TextOverflow.ellipsis,
  //                           style: TextStyle(
  //                             color: Color(0xFF434141),
  //                             fontSize: 19.sp,
  //                             fontFamily: 'OpenSans',
  //                           ),
  //                           textAlign: TextAlign.left,
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                   SizedBox(height: 20.h),
  //                   SummaryForAllLearners(
  //                       groupEvaluationGoodCount: bloc.resultsBloc
  //                           .getLearnersEvaluationCountByType(
  //                               GroupEvaluation_Evaluation.GOOD),
  //                       groupEvaluationBadCount: bloc.resultsBloc
  //                           .getLearnersEvaluationCountByType(
  //                               GroupEvaluation_Evaluation.BAD),
  //                       hiveGroup: bloc.resultsBloc.hiveGroup!,
  //                       month: bloc.resultsBloc.hiveDate!,
  //                       groupLearnerEvaluationsByCategory: bloc.resultsBloc
  //                           .getGroupLearnerEvaluationsByCategory()),
  //                   if (bloc.resultsBloc.shouldDisplayProjectReport() &&
  //                       bloc.resultsBloc.hiveGroup != null) ...[
  //                     SizedBox(
  //                       height: 20.h,
  //                     ),
  //                     ProjectReporsForGroup(
  //                         hiveGroup: bloc.resultsBloc.hiveGroup!,
  //                         hiveDate: bloc.resultsBloc.hiveDate!),
  //                   ],
  //                   SizedBox(
  //                     height: 20.h,
  //                   ),
  //                   ListView.builder(
  //                       shrinkWrap: true,
  //                       physics: NeverScrollableScrollPhysics(),
  //                       itemCount: bloc.resultsBloc.hiveGroup!.learners!.length,
  //                       itemBuilder: (BuildContext context, index) {
  //                         HiveGroupUser _hiveGroupUser = bloc
  //                             .resultsBloc.hiveGroup!.learners!
  //                             .elementAt(index);
  //                         return InkWell(
  //                           onTap: () =>
  //                               _onLearnerSummarySelection(_hiveGroupUser),
  //                           child: Column(
  //                             children: [
  //                               index != 0
  //                                   ? SizedBox(
  //                                       height: 20.h,
  //                                     )
  //                                   : SizedBox(
  //                                       height: 0.0,
  //                                     ),
  //                               LearnerSummary(
  //                                   hiveGroupUser: _hiveGroupUser,
  //                                   month: bloc.resultsBloc.hiveDate!,
  //                                   leanerEvaluationForGroup: _hiveGroupUser
  //                                       .getGroupEvaluationForMonth(
  //                                           bloc.resultsBloc.hiveDate!)),
  //                             ],
  //                           ),
  //                         );
  //                       }),
  //                   SizedBox(
  //                     height: 20.h,
  //                   )
  //                 ],
  //               )),
  //             )
  //           : Container(
  //               height: MediaQuery.of(context).size.height - 40.h,
  //               child: Center(
  //                 child: Padding(
  //                   padding: const EdgeInsets.all(10.0),
  //                   child: Text(
  //                     '${AppLocalizations.of(context)!.joinOrCreateGroupMessage}',
  //                     style: TextStyle(
  //                       fontSize: 16.sp,
  //                       fontFamily: "OpenSans",
  //                       fontStyle: FontStyle.italic,
  //                       color: Color(0xFF797979),
  //                     ),
  //                     textAlign: TextAlign.center,
  //                   ),
  //                 ),
  //               ),
  //             ),
  //     ),
  //   );
  // }

  // void _onLearnerSummarySelection(HiveGroupUser hiveGroupUser) {
  //   showModalBottomSheet(
  //     context: context,
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.only(
  //         topLeft: Radius.circular(34.r),
  //         topRight: Radius.circular(34.r),
  //       ),
  //     ),
  //     isScrollControlled: true,
  //     isDismissible: true,
  //     enableDrag: true,
  //     builder: (BuildContext context) {
  //       return ResultWidgetBottomSheet(
  //           bloc.resultsBloc.hiveGroup!,
  //           hiveGroupUser,
  //           hiveGroupUser
  //               .getGroupEvaluationForMonth(bloc.resultsBloc.hiveDate!));
  //     },
  //   ).whenComplete(() {
  //     setState(() {});
  //   });
  // }

  Future<DateTime?> _selectMonth(Date month) async {
    // reference for the MonthYearPickerLocalizations is add in app.dart
    return await showMonthYearPicker(
      context: context,
      initialDate: DateTimeUtils.toDateTime(
          DateTimeUtils.formatHiveDate(month,
              requiredDateFormat: "dd-MMM-yyyy"),
          "dd-MMM-yyyy"),
      firstDate: DateTime(DateTime.now().year - 10),
      lastDate: DateTime(DateTime.now().year + 10),
      hideActions: true,
    );
  }
}
