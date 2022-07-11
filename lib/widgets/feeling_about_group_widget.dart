import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starfish/constants/assets_path.dart';
import 'package:starfish/db/hive_group_evaluation.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../src/generated/starfish.pb.dart';

class FeelingAboutGroupCard extends StatefulWidget {
  HiveGroupEvaluation? leanerEvaluationForGroup;

  final saveGroupEvaluation;

  FeelingAboutGroupCard({
    Key? key,
    this.saveGroupEvaluation,
    this.leanerEvaluationForGroup,
  }) : super(key: key);

  @override
  State<FeelingAboutGroupCard> createState() => _FeelingAboutGroupCardState();
}

class _FeelingAboutGroupCardState extends State<FeelingAboutGroupCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
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
              '${AppLocalizations.of(context)!.howDoYouFeelAboutThisGroup}',
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
                      //   height: 45.h,
                      decoration: BoxDecoration(),
                      child: ElevatedButton(
                        onPressed: () {
                          print(
                              'this is the widget${widget.leanerEvaluationForGroup}');
                          widget.saveGroupEvaluation(
                              widget.leanerEvaluationForGroup,
                              GroupEvaluation_Evaluation.GOOD);
                        },
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4.r),
                              ),
                            ),
                            backgroundColor: (widget.leanerEvaluationForGroup !=
                                        null &&
                                    GroupEvaluation_Evaluation.valueOf(widget
                                            .leanerEvaluationForGroup!
                                            .evaluation!) ==
                                        GroupEvaluation_Evaluation.GOOD)
                                ? MaterialStateProperty.all<Color>(
                                    Color(0xFF6DE26B))
                                : MaterialStateProperty.all<Color>(
                                    Color(0xFFC9C9C9))),
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
                              AppLocalizations.of(context)!.goodText,
                              style: TextStyle(
                                  fontSize: 17.sp,
                                  fontFamily: "Rubik",
                                  color: Colors.black),
                            ),
                          ],
                        ),
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
                      child: ElevatedButton(
                        onPressed: () {
                          print(
                              'this is the widget${widget.leanerEvaluationForGroup}');
                          widget.saveGroupEvaluation(
                              widget.leanerEvaluationForGroup,
                              GroupEvaluation_Evaluation.BAD);
                        },
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4.r),
                              ),
                            ),
                            backgroundColor: (widget.leanerEvaluationForGroup !=
                                        null &&
                                    GroupEvaluation_Evaluation.valueOf(widget
                                            .leanerEvaluationForGroup!
                                            .evaluation!) ==
                                        GroupEvaluation_Evaluation.BAD)
                                ? MaterialStateProperty.all<Color>(
                                    Color(0xFFFFBE4A))
                                : MaterialStateProperty.all<Color>(
                                    Color(0xFFC9C9C9))),
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
                                AppLocalizations.of(context)!.notSoGoodText,
                                style: TextStyle(
                                    fontSize: 17.sp,
                                    fontFamily: "Rubik",
                                    color: Colors.black),
                              ),
                            ),
                          ],
                        ),
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
        ));
  }

  // void _saveGroupEvaluations(
  //     HiveGroupUser hiveGroupUser, HiveGroupEvaluation? _hiveGroupEvalution,
  //     {required GroupEvaluation_Evaluation evaluation}) {
  //   if (_hiveGroupEvalution == null) {
  //     _hiveGroupEvalution = HiveGroupEvaluation();
  //     _hiveGroupEvalution.id = UuidGenerator.uuid();
  //     _hiveGroupEvalution.groupId = hiveGroupUser.groupId;
  //     _hiveGroupEvalution.userId = hiveGroupUser.userId;
  //     _hiveGroupEvalution.month = bloc.resultsBloc.hiveDate!;
  //     _hiveGroupEvalution.isNew = true;
  //   } else {
  //     _hiveGroupEvalution.isUpdated = true;
  //   }

  //   _hiveGroupEvalution.evaluation = evaluation.value;

  //   GroupEvaluationProvider()
  //       .createUpdateGroupEvaluation(_hiveGroupEvalution)
  //       .then((value) {
  //     debugPrint("Evaluaitons saved.");
  //     // save files also
  //   }).onError((error, stackTrace) {
  //     debugPrint("Evaluations to save Transformation");
  //   });
  // }

  //  onUpdateCallBack: (parmas, taskId) {
  //                                 _bloc.updateChecklistItem(parmas, taskId);
  //                               },
}
