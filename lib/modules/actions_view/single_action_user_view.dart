import 'package:flutter/material.dart' hide Action;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:starfish/enums/action_status.dart';
import 'package:starfish/modules/actions_view/cubit/user_action_cubit.dart';
import 'package:starfish/repositories/data_repository.dart';
import 'package:starfish/src/grpc_extensions.dart';
import 'package:starfish/utils/currentUser.dart';
import 'package:starfish/utils/date_time_utils.dart';
import 'package:starfish/utils/helpers/general_functions.dart';
import 'package:starfish/widgets/action_status_widget.dart';
import 'package:starfish/widgets/material_link_button.dart';
import 'package:template_string/template_string.dart';

class SingleActionUser extends StatelessWidget {
  const SingleActionUser({
    Key? key,
    required this.action,
    required this.user,
    required this.actionStatus,
    this.actionUser,
  }) : super(key: key);

  final Action action;
  final User user;
  final ActionStatus actionStatus;
  final ActionUser? actionUser;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserActionCubit(
        dataRepository: context.read<DataRepository>(),
        action: action,
        user: user,
        actionStatus: actionStatus,
        actionUser: actionUser,
      ),
      child: const SingleActionUserView(),
    );
  }
}

class SingleActionUserView extends StatelessWidget {
  const SingleActionUserView({
    Key? key,
    //required this.action,
    // required this.user,
    // required this.actionStatus,
    // this.actionUser,
  }) : super(key: key);

  //final Action action;
  // final User user;
  // final ActionStatus actionStatus;
  // final ActionUser? actionUser;

  @override
  Widget build(BuildContext context) {
    final userActionCubit = context.read<UserActionCubit>();
    final appLocalizations = AppLocalizations.of(context)!;
    final user = context.currentUser;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Expanded(
          child: Container(
            color: Colors.white,
            margin: EdgeInsets.only(
              top: 40.h,
            ),
            child: Container(
              //   margin: EdgeInsets.only(left: 15.0.w, right: 15.0.w),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 10.h,
                    ),
                    Center(
                      child: Text(
                        '${appLocalizations.month}: ${DateTimeUtils.formatDate(DateTime.now(), 'MMM yyyy')}',
                        style: TextStyle(
                            fontSize: 19.sp,
                            color: Color(0xFF3475F0),
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Expanded(
                            //height: 44.h,
                            //width: 169.w,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child:
                                  BlocBuilder<UserActionCubit, UserActionState>(
                                buildWhen: (previous, current) =>
                                    previous.action != current.action,
                                builder: (context, state) => Text(
                                  state.action.name,
                                  maxLines: 2,
                                  style: TextStyle(
                                      fontSize: 19.sp,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Image.asset(
                                'assets/images/hand_right.png',
                                height: 14.r,
                                width: 14.r,
                              ),
                              SizedBox(
                                width: 6.w,
                              ),
                              BlocBuilder<UserActionCubit, UserActionState>(
                                builder: (context, state) => ActionStatusWidget(
                                  onTap: (ActionUser_Status newStatus) {
                                    // setModalState(() {
                                    //   hiveActionUser!.status = newStatus
                                    //       .toActionUserStatus()
                                    //       .value;
                                    // });
                                    // setState(
                                    //     () {}); // To trigger the main view to redraw.
                                    // bloc.actionBloc
                                    //     .createUpdateActionUser(
                                    //         hiveActionUser!);

                                    userActionCubit
                                        .submitUserActonStatus(newStatus);
                                  },
                                  actionStatus:
                                      state.status == ActionUser_Status.COMPLETE
                                          ? ActionStatus.DONE
                                          : state.action.isPastDueDate
                                              ? ActionStatus.OVERDUE
                                              : ActionStatus.NOT_DONE,
                                  height: 36.h,
                                  width: 130.w,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(left: 15.w, right: 15.w),
                      child: BlocBuilder<UserActionCubit, UserActionState>(
                        buildWhen: (previous, current) =>
                            previous.action != current.action,
                        builder: (context, state) {
                          return Text(
                            '${appLocalizations.instructions}: ${state.action.instructions}',
                            maxLines: 5,
                            style: TextStyle(
                              fontSize: 17.sp,
                              color: Color(0xFF797979),
                              fontStyle: FontStyle.italic,
                            ),
                            textAlign: TextAlign.left,
                          );
                        },
                      ),
                    ),
                    Container(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.w, vertical: 15.h),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child:
                                  BlocBuilder<UserActionCubit, UserActionState>(
                                      builder: ((context, state) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (state.action.material != null &&
                                        state.action.material!.url.isNotEmpty)
                                      MaterialLinkButton(
                                        icon: Icon(
                                          Icons.open_in_new,
                                          color: Colors.blue,
                                          size: 18.r,
                                        ),
                                        text: AppLocalizations.of(context)!
                                            .clickThisLinkToStart,
                                        onButtonTap: () {
                                          GeneralFunctions.openUrl(
                                              state.action.material!.url);
                                        },
                                      ),
                                    materialList(context, state.action)
                                  ],
                                );
                              })),
                            ),
                            SizedBox(
                              width: 8.w,
                            ),
                            BlocBuilder<UserActionCubit, UserActionState>(
                              buildWhen: (previous, current) =>
                                  previous.action != current.action,
                              builder: (context, state) {
                                return Text(
                                  '${appLocalizations.due}: ${DateTimeUtils.formatHiveDate(state.action.dateDue, requiredDateFormat: 'MMM dd')}',
                                  maxLines: 1,
                                  style: TextStyle(
                                      fontSize: 19.sp,
                                      color: Color(0xFF4F4F4F),
                                      fontWeight: FontWeight.w500),
                                  textAlign: TextAlign.right,
                                );
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                    // Record the response to the Question
                    BlocBuilder<UserActionCubit, UserActionState>(
                        builder: (context, state) {
                      if (state.action.type == Action_Type.TEXT_RESPONSE ||
                          state.action.type == Action_Type.MATERIAL_RESPONSE &&
                              state.action.material != null) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Align(
                                alignment: FractionalOffset.topLeft,
                                child: Text(
                                  appLocalizations.question +
                                      ': ${state.action.question}',
                                  style: TextStyle(
                                    fontSize: 19.sp,
                                    color: Color(0xFF4F4F4F),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            TextField(
                              //controller: _questionController,
                              onChanged: (value) {
                                userActionCubit.submitUserActonResponse(value);
                              },

                              decoration: InputDecoration(
                                hintStyle: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 17.sp,
                                  color: Color(0xFF797979),
                                ),
                                border: InputBorder.none,
                                hintText: appLocalizations.questionTextEditHint,
                              ),
                              onSubmitted: (value) {},
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 15.w, right: 15.w),
                              height: 1.0,
                              color: Color(0xFF3475F0),
                            ),
                          ],
                        );
                      } else {
                        return Container();
                      }
                    }),
                    Padding(
                      padding: EdgeInsets.all(15.r),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          appLocalizations.howWasThisActionText,
                          maxLines: 1,
                          style: TextStyle(
                              fontSize: 19.sp,
                              color: Color(0xFF4F4F4F),
                              fontWeight: FontWeight.w500),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15.w, right: 15.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          BlocBuilder<UserActionCubit, UserActionState>(
                            buildWhen: (previous, current) =>
                                previous.evaluation != current.evaluation,
                            builder: (context, state) {
                              return InkWell(
                                // GOOD
                                onTap: () {
                                  ActionUser_Evaluation userEvaluation =
                                      ActionUser_Evaluation
                                          .UNSPECIFIED_EVALUATION;
                                  if (state.evaluation ==
                                          ActionUser_Evaluation
                                              .UNSPECIFIED_EVALUATION ||
                                      state.evaluation ==
                                          ActionUser_Evaluation.BAD) {
                                    userEvaluation = ActionUser_Evaluation.GOOD;
                                  }

                                  userActionCubit.toggleUserActonEvaluation(
                                      userEvaluation);
                                },
                                child: Container(
                                  height: 36.h,
                                  width: 160.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4.r),
                                    color: state.evaluation ==
                                            ActionUser_Evaluation.GOOD
                                        ? Color(0xFF6DE26B)
                                        : Color(0xFFC9C9C9),
                                  ),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        //Icon(Icons.thumb_up_outlined, size: 14.sp),
                                        Image.asset(
                                          'assets/images/thumbs_up.png',
                                          height: 14.r,
                                          width: 14.r,
                                        ),
                                        SizedBox(
                                          width: 4.w,
                                        ),
                                        Text(
                                          appLocalizations.goodText,
                                          maxLines: 1,
                                          style: TextStyle(
                                            fontFamily: 'Rubik',
                                            fontSize: 17.sp,
                                            color: Color(0xFF777777),
                                          ),
                                        ),
                                      ]),
                                ),
                              );
                            },
                          ),
                          BlocBuilder<UserActionCubit, UserActionState>(
                            buildWhen: (previous, current) =>
                                previous.evaluation != current.evaluation,
                            builder: (context, state) {
                              return InkWell(
                                onTap: () {
                                  ActionUser_Evaluation userEvaluation =
                                      ActionUser_Evaluation
                                          .UNSPECIFIED_EVALUATION;
                                  if (state.evaluation ==
                                          ActionUser_Evaluation
                                              .UNSPECIFIED_EVALUATION ||
                                      state.evaluation ==
                                          ActionUser_Evaluation.GOOD) {
                                    userEvaluation = ActionUser_Evaluation.BAD;
                                  }

                                  userActionCubit.toggleUserActonEvaluation(
                                      userEvaluation);
                                },
                                child: Container(
                                  height: 36.h,
                                  width: 160.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4.r),
                                    color: state.evaluation ==
                                            ActionUser_Evaluation.BAD
                                        ? Color(0xFFFFBE4A)
                                        : Color(0xFFC9C9C9),
                                  ),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        //Icon(Icons.thumb_down_outlined, size: 14.sp),
                                        Image.asset(
                                          'assets/images/thumbs_down.png',
                                          height: 14.r,
                                          width: 14.r,
                                        ),
                                        SizedBox(
                                          width: 4.w,
                                        ),
                                        Text(
                                          appLocalizations.notSoGoodText,
                                          maxLines: 1,
                                          style: TextStyle(
                                            fontFamily: 'Rubik',
                                            fontSize: 17.sp,
                                            color: Color(0xFF777777),
                                          ),
                                        ),
                                      ]),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 39.h,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Container(
          height: (WidgetsBinding.instance.window.viewInsets.bottom > 0.0)
              ? 0.h
              : 75.h,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Color(0xFFEFEFEF),
          ),
          child: Padding(
            padding: EdgeInsets.only(
                left: 30.w, right: 30.w, top: 19.h, bottom: 19.h),
            child: Container(
              height: 37.5.h,
              color: Color(0xFFEFEFEF),
              child: ElevatedButton(
                onPressed: () {
                  // hiveActionUser!.userResponse =
                  //     _questionController.text;
                  // bloc.actionBloc
                  //     .createUpdateActionUser(hiveActionUser)
                  //     .whenComplete(() {
                  Navigator.pop(context);
                  // });
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

  Widget materialList(BuildContext context, Action action) {
    if (action.material == null ||
        (action.material != null && action.material!.fileReferences.isEmpty)) {
      return Container();
    }
    List<Widget> fileLinks = [];
    action.material!.fileReferences.forEach((fileReference) {
      fileLinks.add(
        MaterialLinkButton(
          icon: Icon(
            Icons.download,
            color: Colors.blue,
            size: 18.r,
          ),
          text: AppLocalizations.of(context)!
              .clickToDownload
              .insertTemplateValues({'file_name': fileReference.filename}),
          onButtonTap: () async {
            try {
              await GeneralFunctions.openFile(fileReference, context);
            } on NetworkUnavailableException {
              // TODO: show message to user
            }
          },
        ),
      );
      fileLinks.add(SizedBox(height: 4.h));
    });

    return Column(
      children: fileLinks,
    );
  }
}
