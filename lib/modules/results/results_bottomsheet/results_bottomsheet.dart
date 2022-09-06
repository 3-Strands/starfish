import 'package:collection/collection.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:starfish/apis/hive_api.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:starfish/constants/assets_path.dart';
import 'package:starfish/modules/results/action_history.dart';
import 'package:starfish/modules/results/action_statuses.dart';
import 'package:starfish/modules/results/cubit/results_cubit.dart';
import 'package:starfish/modules/results/results_bottomsheet/cubit/results_bottomsheet_cubit.dart';
import 'package:starfish/modules/results/results_bottomsheet/teacher_feedback.dart';
import 'package:starfish/modules/results/user_transformation.dart';
import 'package:starfish/repositories/data_repository.dart';
import 'package:starfish/src/grpc_extensions.dart';
import 'package:starfish/utils/helpers/extensions/strings.dart';
import 'package:starfish/widgets/box_builder.dart';
import 'package:starfish/widgets/month_year_picker/dialogs.dart';

class ResultsBottomSheet extends StatelessWidget {
  const ResultsBottomSheet({
    Key? key,
    required this.group,
    required this.learner,
    required this.month,
  }) : super(key: key);

  final Group group;
  final User learner;
  final Date month;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ResultsBottomsheetCubit(
        group: group,
        initialLearner: learner,
        initialMonth: month,
        dataRepository: context.read<DataRepository>(),
      ),
      child: BlocListener<ResultsBottomsheetCubit, ResultsBottomsheetState>(
        listenWhen: (previous, current) => previous.month != current.month,
        listener: (context, state) {
          context.read<ResultsCubit>().updateMonthFilter(state.month);
        },
        child: ResultWidgetBottomSheetView(
          group: group,
        ),
      ),
    );
  }
}

class ResultWidgetBottomSheetView extends StatelessWidget {
  const ResultWidgetBottomSheetView({
    Key? key,
    required this.group,
  }) : super(key: key);

  final Group group;

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
                              group.name,
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
                      final thisYear = DateTime.now().year;
                      final cubit = context.read<ResultsBottomsheetCubit>();
                      final newDateTime = await showMonthYearPicker(
                        context: context,
                        initialDate: cubit.state.month.toDateTime(),
                        firstDate: DateTime(thisYear - 10),
                        lastDate: DateTime(thisYear + 10),
                        hideActions: true,
                      );
                      if (newDateTime != null) {
                        cubit.monthChanged(Date(
                            year: newDateTime.year, month: newDateTime.month));
                      }
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
                        child: BlocBuilder<ResultsBottomsheetCubit,
                            ResultsBottomsheetState>(
                          builder: (context, state) {
                            return Text(
                              DateFormat('MMMM yyyy')
                                  .format(state.month.toDateTime()),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Color(0xFF434141),
                                fontSize: 19.sp,
                                fontFamily: 'OpenSans',
                              ),
                              textAlign: TextAlign.left,
                            );
                          },
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
                          child: BlocBuilder<ResultsBottomsheetCubit,
                              ResultsBottomsheetState>(
                            builder: (context, state) {
                              return DropdownButton2<User>(
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
                                  "${appLocalizations.learner}: ${state.learner.name}",
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
                                  if (value != null) {
                                    context
                                        .read<ResultsBottomsheetCubit>()
                                        .learnerChanged(value);
                                  }
                                },
                                items: group.learners
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
                              );
                            },
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
                      BoxBuilder<GroupEvaluation>(
                        box: globalHiveApi.groupEvaluation,
                        builder: (context, values) {
                          return BlocBuilder<ResultsBottomsheetCubit,
                              ResultsBottomsheetState>(
                            buildWhen: (previous, current) =>
                                previous.isDifferentSnapshotFrom(current),
                            builder: (context, state) {
                              final groupEvaluation = values.firstWhereOrNull(
                                (groupEvaluation) =>
                                    groupEvaluation.month == state.month &&
                                    groupEvaluation.groupId == group.id &&
                                    groupEvaluation.userId == state.learner.id,
                              );
                              if (groupEvaluation == null) {
                                return const SizedBox();
                              }
                              return Row(
                                children: [
                                  Image.asset(
                                    groupEvaluation.evaluation ==
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
                                    groupEvaluation.evaluation.name
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
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  BlocBuilder<ResultsBottomsheetCubit, ResultsBottomsheetState>(
                    buildWhen: (previous, current) =>
                        previous.isDifferentSnapshotFrom(current),
                    builder: (context, state) {
                      return _ActionCard(
                        groupId: group.id,
                        userId: state.learner.id,
                        month: state.month,
                      );
                    },
                  ),
                  SizedBox(height: 20.h),
                  BlocBuilder<ResultsBottomsheetCubit, ResultsBottomsheetState>(
                    buildWhen: (previous, current) =>
                        previous.isDifferentSnapshotFrom(current),
                    builder: (context, state) {
                      return UserTransformation(
                        groupId: group.id,
                        userId: state.learner.id,
                        month: state.month,
                        transformation: state.transformation,
                      );
                    },
                  ),
                  SizedBox(height: 20.h),
                  TeacherFeedback(
                    group: group,
                  ),
                  SizedBox(height: 10.h),
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
}

class _ActionCard extends StatelessWidget {
  const _ActionCard({
    Key? key,
    required this.groupId,
    required this.userId,
    required this.month,
  }) : super(key: key);

  final String groupId;
  final String userId;
  final Date month;

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
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
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
            BoxItemBuilder<User>(
              boxKey: userId,
              box: globalHiveApi.user,
              builder: (context, user) {
                var complete = 0;
                var notComplete = 0;
                var overdue = 0;

                final now = DateTime.now();
                final currentDate = Date(year: now.year, month: now.month);

                for (final actionUser in user!.actions) {
                  final dateDue = actionUser.action?.dateDue;
                  if (dateDue != null && dateDue.isSameMonth(month)) {
                    if (actionUser.status == ActionUser_Status.COMPLETE) {
                      complete += 1;
                    } else if (dateDue.compareTo(currentDate) <= 0) {
                      overdue += 1;
                    } else {
                      notComplete += 1;
                    }
                  }
                }

                return ActionStatuses(
                  complete: complete,
                  notComplete: notComplete,
                  overdue: overdue,
                );
              },
            ),
            ActionHistory(
              groupId: groupId,
              userId: userId,
              month: month,
            ),
          ],
        ),
      ),
    );
  }
}
