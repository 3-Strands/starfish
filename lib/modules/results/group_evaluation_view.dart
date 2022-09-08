import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starfish/constants/assets_path.dart';
import 'package:starfish/modules/results/cubit/group_evaluation_cubit.dart';
import 'package:starfish/repositories/data_repository.dart';
import 'package:starfish/src/grpc_extensions.dart';

class GroupEvaluationWidget extends StatelessWidget {
  const GroupEvaluationWidget(
      {Key? key,
      required this.groupUser,
      required this.month,
      this.groupEvaluation})
      : super(key: key);

  final GroupUser groupUser;
  final Date month;
  final GroupEvaluation? groupEvaluation;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      key: ValueKey('${groupUser.id}:${month.year}-${month.month}'),
      create: (context) => GroupEvaluationCubit(
        dataRepository: context.read<DataRepository>(),
        groupUser: groupUser,
        month: month,
      ),
      child: GroupEvaluationView(),
    );
  }
}

class GroupEvaluationView extends StatelessWidget {
  const GroupEvaluationView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
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
        child: Column(children: [
          SizedBox(
            height: 5.h,
          ),
          Text(
            '${appLocalizations.howDoYouFeelAboutThisGroup}',
            style: TextStyle(
              color: Color(0xFF4F4F4F),
              fontFamily: "OpenSans",
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(),
                    child:
                        BlocBuilder<GroupEvaluationCubit, GroupEvaluationState>(
                      buildWhen: (previous, current) =>
                          previous.evaluation != current.evaluation,
                      builder: (context, state) {
                        return ElevatedButton(
                          onPressed: () {
                            context
                                .read<GroupEvaluationCubit>()
                                .updateGroupEvaluation(
                                    GroupEvaluation_Evaluation.GOOD);
                          },
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4.r),
                              ),
                            ),
                            backgroundColor: state.evaluation ==
                                    GroupEvaluation_Evaluation.GOOD
                                ? MaterialStateProperty.all<Color>(
                                    Color(0xFF6DE26B))
                                : MaterialStateProperty.all<Color>(
                                    Color(0xFFC9C9C9)),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                AssetsPath.thumbsUp,
                                width: 15.w,
                              ),
                              SizedBox(
                                width: 3.w,
                              ),
                              Text(
                                appLocalizations.goodText,
                                style: TextStyle(
                                    fontSize: 17.sp,
                                    fontFamily: "Rubik",
                                    color: Colors.black),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Expanded(
                  child: Container(
                    //   height: 45.h,
                    decoration: BoxDecoration(),
                    child:
                        BlocBuilder<GroupEvaluationCubit, GroupEvaluationState>(
                      buildWhen: (previous, current) =>
                          previous.evaluation != current.evaluation,
                      builder: ((context, state) {
                        return ElevatedButton(
                          onPressed: () {
                            context
                                .read<GroupEvaluationCubit>()
                                .updateGroupEvaluation(
                                    GroupEvaluation_Evaluation.BAD);
                          },
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4.r),
                              ),
                            ),
                            backgroundColor: state.evaluation ==
                                    GroupEvaluation_Evaluation.BAD
                                ? MaterialStateProperty.all<Color>(
                                    Color(0xFFFFBE4A))
                                : MaterialStateProperty.all<Color>(
                                    Color(0xFFC9C9C9)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                AssetsPath.thumbsDown,
                                width: 15.w,
                              ),
                              SizedBox(
                                width: 3.w,
                              ),
                              Expanded(
                                child: Text(
                                  appLocalizations.notSoGoodText,
                                  style: TextStyle(
                                      fontSize: 17.sp,
                                      fontFamily: "Rubik",
                                      color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15.h,
          ),
        ]),
      ),
    );
  }
}