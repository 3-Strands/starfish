import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:starfish/constants/text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:starfish/modules/settings_view/group_email/cubit/settings_cubit.dart';
import 'package:starfish/repositories/data_repository.dart';
import 'package:starfish/src/grpc_extensions.dart';
import 'package:starfish/utils/helpers/snackbar.dart';
import 'package:starfish/widgets/separator_line_widget.dart';
import 'package:starfish/widgets/settings_edit_button_widget.dart';

class EditGroupEamil extends StatelessWidget {
  const EditGroupEamil({
    Key? key,
    required this.group,
  }) : super(key: key);

  final Group group;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingsCubit(
        dataRepository: context.read<DataRepository>(),
        group: group,
      ),
      child: const EditGroupEmailView(),
    );
  }
}

class EditGroupEmailView extends StatefulWidget {
  const EditGroupEmailView({
    Key? key,
  }) : super(key: key);

  @override
  _EditGroupEmailViewState createState() => _EditGroupEmailViewState();
}

class _EditGroupEmailViewState extends State<EditGroupEmailView> {
  bool inEditMode = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final settingsCubit = context.read<SettingsCubit>();

    return BlocListener<SettingsCubit, SettingsState>(
      listener: (context, state) {
        final error = state.error;
        if (error != null) {
          String message;
          switch (error) {
            case SettingsEmailError.emailMismatch:
              message = appLocalizations.alertEmailDoNotMatch;
              break;
            case SettingsEmailError.emptyEmail:
              message = appLocalizations.emptyEmail;
              break;
            case SettingsEmailError.invalidEmailFormat:
              message = appLocalizations.alertInvalidEmaill;
              break;
          }
          StarfishSnackbar.showErrorMessage(context, message);
        }
      },
      child: Container(
        margin: EdgeInsets.only(left: 5.0, top: 10.0, right: 5.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Align(
                    alignment: FractionalOffset.topLeft,
                    child: Text(
                      settingsCubit.state.group.name,
                      style: titleTextStyle,
                    ),
                  ),
                ),
                EditButton(
                  editMode: inEditMode,
                  onButtonClicked: ((value) {
                    setState(() {
                      inEditMode = value;
                    });
                  }),
                  onCancel: () {
                    setState(() {
                      inEditMode = false;
                    });
                  },
                  onSave: () {
                    setState(() {
                      inEditMode = !settingsCubit.updateEmail();
                    });
                  },
                ),
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            Container(
              //height: 45.h,
              child: Align(
                alignment: FractionalOffset.topLeft,
                child: Text(appLocalizations.projectAdminEmailSectionTitle,
                    style: titleTextStyle),
              ),
            ),
            SizedBox(height: 10.h),
            Container(
              child: InkWell(
                onTap: () {
                  setState(() {
                    inEditMode = true;
                  });
                },
                child: TextFormField(
                  enabled: inEditMode,
                  onChanged: settingsCubit.emailChanged,
                  initialValue: settingsCubit.state.group.linkEmail,
                  keyboardType: TextInputType.emailAddress,
                  style: textFormFieldText,
                  decoration: InputDecoration(
                    labelText: appLocalizations.emailHint,
                    labelStyle: formTitleHintStyle,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    // hintText: appLocalizations.emailHint,
                    contentPadding:
                        EdgeInsets.fromLTRB(15.0.w, 0.0, 5.0.w, 0.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    filled: true,
                    fillColor: AppColors.txtFieldBackground,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Visibility(
              visible: inEditMode,
              child: Container(
                child: TextFormField(
                  enabled: inEditMode,
                  onChanged: settingsCubit.confirmEmailChanged,
                  onFieldSubmitted: (term) {},
                  keyboardType: TextInputType.emailAddress,
                  style: textFormFieldText,
                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    labelText: appLocalizations.confirmEmailHint,
                    labelStyle: formTitleHintStyle,
                    // hintText:
                    //     appLocalizations.confirmEmailHint,
                    contentPadding:
                        EdgeInsets.fromLTRB(15.0.w, 0.0, 5.0.w, 0.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    filled: true,
                    fillColor: AppColors.txtFieldBackground,
                  ),
                ),
              ),
            ),
            SizedBox(height: 15.h),
            SeparatorLine(
              height: .5.h,
              padding: EdgeInsets.only(
                left: 10.w,
                right: 10.w,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
