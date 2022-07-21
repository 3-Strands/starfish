import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:starfish/constants/text_styles.dart';
import 'package:starfish/db/hive_material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starfish/modules/material_view/cubit/report_material_cubit.dart';
import 'package:starfish/repositories/authentication_repository.dart';
import 'package:starfish/utils/helpers/alerts.dart';
import 'package:starfish/widgets/seprator_line_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ReportMaterialDialogBox extends StatelessWidget {
  const ReportMaterialDialogBox({Key? key, required this.material})
      : super(key: key);

  final HiveMaterial material;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => ReportMaterialCubit(
              authenticationRepository:
                  context.read<AuthenticationRepository>(),
              material: material,
            ),
        child: BlocListener<ReportMaterialCubit, ReportMaterialState>(
          listenWhen: (previous, current) =>
              !previous.isSubmitted && current.isSubmitted,
          listener: (context, state) {
            final appLocalizations = AppLocalizations.of(context)!;
            Alerts.showMessageBox(
              context: context,
              title: appLocalizations.dialogInfo,
              message: appLocalizations.addMaterialFeedbackSuccess,
              callback: Navigator.of(context).pop,
            );
          },
          child: ReportMaterialDialogBoxView(material: material),
        ));
  }
}

class ReportMaterialDialogBoxView extends StatelessWidget {
  const ReportMaterialDialogBoxView({Key? key, required this.material})
      : super(key: key);

  final HiveMaterial material;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        //height: 264.h,
        width: 315.w,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: AppColors.popDialogBGColor,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              height: 15.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 61.w),
              child: Text(
                material.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style:
                    TextStyle(fontSize: 20.5.sp, fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Text(
              appLocalizations.reportDialogDetailText,
              style: TextStyle(fontSize: 15.5.sp),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 10.h,
            ),
            Container(
              //height: 110.h,
              width: 280.w,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                child: BlocBuilder<ReportMaterialCubit, ReportMaterialState>(
                  buildWhen: (previous, current) =>
                      previous.isValid != current.isValid,
                  builder: (context, state) {
                    final cubit = context.read<ReportMaterialCubit>();
                    return TextFormField(
                      onFieldSubmitted:
                          state.isValid ? (_) => cubit.reportSubmitted() : null,
                      onChanged: cubit.textChanged,
                      autofocus: true,
                      maxLines: 4,
                      keyboardType: TextInputType.text,
                      style: textFormFieldText,
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.fromLTRB(10.w, 10.h, 0.0, 10.h),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                          borderSide: BorderSide(
                            color: Colors.transparent,
                          ),
                        ),
                        focusedBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        filled: true,
                        fillColor: AppColors.txtFieldBackground,
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            SepratorLine(hight: 1.0, edgeInsets: EdgeInsets.zero),
            Container(
              //height: 44.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        appLocalizations.cancel,
                        style: cancelButtonTextStyle,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 1.w,
                    height: 44.h,
                    child: ColoredBox(color: AppColors.sepratorLineColor),
                  ),
                  Expanded(
                    child:
                        BlocBuilder<ReportMaterialCubit, ReportMaterialState>(
                      builder: (context, state) {
                        final cubit = context.read<ReportMaterialCubit>();
                        return TextButton(
                          onPressed:
                              state.isValid ? cubit.reportSubmitted : null,
                          child: Text(
                            appLocalizations.sendFeedback,
                            style: TextStyle(
                              fontFamily: 'OpenSans',
                              fontWeight: FontWeight.normal,
                              fontSize: 19.sp,
                              color: state.isValid
                                  ? AppColors.selectedButtonBG
                                  : Color(0xFF797979),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
