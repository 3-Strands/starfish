import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:starfish/apis/hive_api.dart';
import 'package:starfish/config/routes/routes.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:starfish/constants/assets_path.dart';
import 'package:starfish/constants/text_styles.dart';
import 'package:starfish/modules/groups_view/contact_list/contact_list.dart';
import 'package:starfish/repositories/data_repository.dart';
import 'package:starfish/repositories/error_repository.dart';
import 'package:starfish/select_items/multi_select.dart';
import 'package:starfish/src/grpc_extensions.dart';
import 'package:starfish/utils/helpers/alerts.dart';
import 'package:starfish/utils/helpers/snackbar.dart';
import 'package:starfish/widgets/app_logo_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starfish/modules/groups_view/add_edit_group/group_member_list_item.dart';
import 'package:starfish/widgets/history_item.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:starfish/wrappers/platform.dart';

import 'cubit/add_edit_group_cubit.dart';

class AddEditGroup extends StatelessWidget {
  const AddEditGroup({Key? key, this.group}) : super(key: key);

  final Group? group;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddEditGroupCubit(
        dataRepository: context.read<DataRepository>(),
        errorRepository: context.read<ErrorRepository>(),
        group: group,
      ),
      child: AddEditGroupView(isEditMode: group != null),
    );
  }
}

class AddEditGroupView extends StatefulWidget {
  const AddEditGroupView({Key? key, this.isEditMode = false}) : super(key: key);

  final bool isEditMode;

  @override
  _AddEditGroupViewState createState() => _AddEditGroupViewState();
}

class _AddEditGroupViewState extends State<AddEditGroupView> {
  final _personNameController = TextEditingController();

  // TODO: Add this as error handling.
  // void _onEditUserInvite(HiveUser user, HiveGroupUser groupUser) {
  //   showModalBottomSheet(
  //     context: context,
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.only(
  //         topLeft: Radius.circular(34.r),
  //         topRight: Radius.circular(34.r),
  //       ),
  //     ),
  //     backgroundColor: const Color(0xFFEFEFEF),
  //     isScrollControlled: true,
  //     isDismissible: true,
  //     enableDrag: true,
  //     builder: (BuildContext context) {
  //       return SizedBox(
  //         height: MediaQuery.of(context).size.height * 0.70,
  //         child: EditInviteUserBottomSheet(
  //           user,
  //           groupUser,
  //           onDone: (String contactName, String diallingCode,
  //               String phonenumber, GroupUser_Role role) {
  //             if (contactName.isEmpty) {
  //               StarfishSnackbar.showErrorMessage(
  //                   context, AppLocalizations.of(context)!.emptyFullName);
  //               return;
  //             } else if (diallingCode.isEmpty) {
  //               StarfishSnackbar.showErrorMessage(
  //                   context, AppLocalizations.of(context)!.emptyDialingCode);
  //               return;
  //             } else if (phonenumber.isEmpty) {
  //               StarfishSnackbar.showErrorMessage(
  //                   context, AppLocalizations.of(context)!.emptyMobileNumbers);
  //               return;
  //             } else if ((user.phone != phonenumber ||
  //                     user.diallingCode != diallingCode) &&
  //                 _checkIfUserPhonenumberAlreadySelected(
  //                     diallingCode, phonenumber)) {
  //               //check if there is any change in dialling code or in phone number
  //               StarfishSnackbar.showErrorMessage(
  //                   context, appLocalizations.phonenumberAlreadyAdded);
  //               return;
  //             } else {
  //               user.name = contactName;
  //               user.diallingCode = diallingCode;
  //               user.phone = phonenumber;
  //               user.isUpdated = true;

  //               groupUser.role = role.value;
  //               groupUser.isUpdated = true;

  //               Navigator.of(context).pop();
  //             }
  //           },
  //         ),
  //       );
  //     },
  //   );
  // }

  void submitPersonName() {
    final error = context
        .read<AddEditGroupCubit>()
        .personNameSubmitted(_personNameController.text);
    _personNameController.text = '';
    if (error != null) {
      final appLocalizations = AppLocalizations.of(context)!;
      String message;
      switch (error) {
        case ContactError.nameAlreadyExists:
          message = appLocalizations.userNameAlreadyAdded;
          break;
      }
      StarfishSnackbar.showErrorMessage(context, message);
    }
  }

  @override
  void dispose() {
    _personNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final addEditGroupCubit = context.read<AddEditGroupCubit>();

    return Scaffold(
      backgroundColor: AppColors.groupScreenBG,
      appBar: AppBar(
        backgroundColor: AppColors.groupScreenBG,
        automaticallyImplyLeading: false,
        title: Container(
          height: 64.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              AppLogo(hight: 36.h, width: 37.w),
              Text(
                widget.isEditMode
                    ? appLocalizations.editGroup
                    : appLocalizations.createGroup,
                style: dashboardNavigationTitle,
              ),
              IconButton(
                icon: SvgPicture.asset(AssetsPath.settings),
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    Routes.settings,
                  );
                },
              ),
            ],
          ),
        ),
      ),
      body: BlocListener<AddEditGroupCubit, AddEditGroupState>(
        listener: (context, state) {
          final error = state.error;
          if (error != null) {
            String message;
            switch (error) {
              case GroupError.noName:
                message = appLocalizations.emptyGroupTitle;
                break;
              case GroupError.noDescription:
                message = appLocalizations.emptyDescription;
                break;
            }
            StarfishSnackbar.showErrorMessage(context, message);
          }
        },
        child: Scrollbar(
          thickness: 5.w,
          thumbVisibility: false,
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    appLocalizations.groupName,
                    textAlign: TextAlign.left,
                    style: titleTextStyle,
                  ),
                  SizedBox(height: 11.h),
                  TextFormField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    style: formTitleTextStyle,
                    initialValue: addEditGroupCubit.state.name,
                    onChanged: addEditGroupCubit.nameChanged,
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      labelText: appLocalizations.hintGroupName,
                      labelStyle: formTitleHintStyle,
                      alignLabelWithHint: true,
                      // hintText: appLocalizations.hintGroupName,
                      // hintStyle: formTitleHintStyle,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color: Colors.transparent,
                        ),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                  SizedBox(height: 21.h),

                  // Description
                  Text(
                    appLocalizations.descripton,
                    textAlign: TextAlign.left,
                    style: titleTextStyle,
                  ),
                  SizedBox(height: 11.h),
                  TextFormField(
                    maxLines: 4,
                    maxLength: 200,
                    initialValue: addEditGroupCubit.state.description,
                    onChanged: addEditGroupCubit.descriptionChanged,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      labelText: appLocalizations.hintGroupDescription,
                      labelStyle: formTitleHintStyle,
                      alignLabelWithHint: true,
                      // hintText:
                      //     appLocalizations.hintGroupDescription,
                      // hintStyle: formTitleHintStyle,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color: Colors.transparent,
                        ),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                  SizedBox(height: 21.h),

                  // Language(s) used
                  Text(
                    appLocalizations.lanugagesUsedOptional,
                    textAlign: TextAlign.left,
                    style: titleTextStyle,
                  ),
                  SizedBox(height: 11.h),
                  BlocBuilder<AddEditGroupCubit, AddEditGroupState>(
                    buildWhen: (previous, current) =>
                        previous.languages != current.languages,
                    builder: (context, state) {
                      return MultiSelect<Language>(
                        navTitle: appLocalizations.selectLanugages,
                        placeholder: appLocalizations.selectLanugages,
                        items: state.languages,
                        initialSelection: Set<Language>.from(
                          state.selectedLanguages
                              .map((languageId) =>
                                  globalHiveApi.language.get(languageId))
                              .where((language) => language != null),
                        ),
                        toDisplay: (language) => language.name,
                        onFinished: (selectedLanguages) {
                          addEditGroupCubit.selectedLanguagesChanged(
                              selectedLanguages
                                  .map((language) => language.id)
                                  .toSet());
                        },
                      );
                    },
                  ),
                  SizedBox(height: 21.h),

                  // Evaluate Progress
                  Text(
                    appLocalizations.evaluateProgressOptional,
                    textAlign: TextAlign.left,
                    style: titleTextStyle,
                  ),
                  SizedBox(height: 11.h),
                  BlocBuilder<AddEditGroupCubit, AddEditGroupState>(
                    buildWhen: (previous, current) =>
                        previous.evaluationCategories !=
                        current.evaluationCategories,
                    builder: (context, state) {
                      return MultiSelect<EvaluationCategory>(
                        maxSelectItemLimit: 3,
                        maxLimitOverAlertMessage:
                            appLocalizations.maxSelectItemLimit,
                        navTitle: appLocalizations.selectCategories,
                        placeholder: appLocalizations.selectCategories,
                        items: state.evaluationCategories,
                        initialSelection: Set<EvaluationCategory>.from(
                          state.selectedEvaluationCategories
                              .map((categoryId) => globalHiveApi
                                  .evaluationCategory
                                  .get(categoryId))
                              .where((category) => category != null),
                        ),
                        toDisplay: (category) => category.name,
                        onFinished: (selectedEvaluationCategories) {
                          addEditGroupCubit.selectedEvaluationCategoriesChanged(
                              selectedEvaluationCategories
                                  .map((c) => c.id)
                                  .toSet());
                        },
                      );
                    },
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    appLocalizations.hintEvaluateProgress,
                    textAlign: TextAlign.left,
                    style: italicDetailTextTextStyle,
                  ),
                  SizedBox(height: 40.h),

                  // Option 1.
                  Text(
                    appLocalizations.invitePeopleFromContactsList,
                    textAlign: TextAlign.left,
                    style: titleTextStyle,
                  ),
                  SizedBox(height: 20.h),
                  Platform.isWeb
                      ? Text(
                          appLocalizations.featureOnlyAvailableOnNative,
                          style: warningTextStyle,
                          textAlign: TextAlign.center,
                        )
                      : DottedBorder(
                          borderType: BorderType.RRect,
                          radius: Radius.circular(30.r),
                          color: Color(0xFF3475F0),
                          child: SizedBox(
                            width: double.infinity,
                            height: 50.h,
                            child: TextButton(
                              onPressed: () {
                                final cubit = context.read<AddEditGroupCubit>();
                                ContactList.showAsBottomSheet(
                                  context,
                                  selectedUsers: [
                                    ...cubit.state.currentMembers.map(
                                      (member) => member.user,
                                    ),
                                    ...cubit.state.newMembers.map(
                                      (userWithRole) => userWithRole.user,
                                    ),
                                  ],
                                ).then(
                                  (newUsers) {
                                    if (newUsers != null) {
                                      cubit.newUsersAddedFromContacts(newUsers);
                                    }
                                  },
                                );
                              },
                              child: Text(
                                appLocalizations.inviteFromContactsList,
                                style: TextStyle(
                                  fontFamily: 'OpenSans',
                                  fontSize: 17.sp,
                                  color: Color(0xFF3475F0),
                                ),
                              ),
                            ),
                          ),
                        ),
                  SizedBox(height: 21.h),

                  BlocBuilder<AddEditGroupCubit, AddEditGroupState>(
                    builder: (context, state) {
                      final currentMembersWithNumber =
                          state.currentMembersWithNumber;
                      final newMembersWithNumber = state.newMembersWithNumber;
                      if (currentMembersWithNumber.isEmpty &&
                          newMembersWithNumber.isEmpty) {
                        return const SizedBox();
                      }
                      return Column(
                        children: [
                          ...currentMembersWithNumber.map(
                            (member) => GroupMemberListItem(
                              key: ValueKey(member.user.id),
                              role: member.role,
                              user: member.user,
                              wasAddedPreviously: true,
                            ),
                          ),
                          ...newMembersWithNumber.map(
                            (member) => GroupMemberListItem(
                              key: ValueKey(member.user.id),
                              role: member.role,
                              user: member.user,
                              wasAddedPreviously: false,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  SizedBox(height: 40.h),
                  // Option 2.
                  Text(
                    appLocalizations.addWithoutInvite,
                    textAlign: TextAlign.left,
                    style: titleTextStyle,
                  ),
                  SizedBox(height: 20.h),
                  TextFormField(
                    controller: _personNameController,
                    keyboardType: TextInputType.text,
                    style: textFormFieldText,
                    onFieldSubmitted: (_) => submitPersonName(),
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: submitPersonName,
                        icon: SvgPicture.asset(AssetsPath.nextIcon),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      labelText: appLocalizations.hintPersonName,
                      labelStyle: formTitleHintStyle,
                      alignLabelWithHint: true,
                      // hintText:
                      //     appLocalizations.hintPersonName,
                      // hintStyle: textFormFieldText,
                      contentPadding:
                          EdgeInsets.fromLTRB(15.w, 5.0, 15.0.w, 5.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0.r),
                        borderSide: BorderSide(
                          color: Colors.transparent,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0.r),
                        borderSide: BorderSide(
                          color: Colors.transparent,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0.r),
                        borderSide: BorderSide(
                          color: Colors.transparent,
                        ),
                      ),
                      filled: true,
                      fillColor: AppColors.txtFieldBackground,
                    ),
                  ),
                  // Selection person without invite
                  BlocBuilder<AddEditGroupCubit, AddEditGroupState>(
                    builder: (context, state) {
                      final currentMembersWithoutNumber =
                          state.currentMembersWithoutNumber;
                      final newMembersWithoutNumber =
                          state.newMembersWithoutNumber;
                      if (currentMembersWithoutNumber.isEmpty &&
                          newMembersWithoutNumber.isEmpty) {
                        return const SizedBox();
                      }
                      return Column(
                        children: [
                          ...currentMembersWithoutNumber.map(
                            (member) => GroupMemberListItem(
                              key: ValueKey(member.user.id),
                              role: member.role,
                              user: member.user,
                              wasAddedPreviously: true,
                            ),
                          ),
                          ...newMembersWithoutNumber.map(
                            (member) => GroupMemberListItem(
                              key: ValueKey(member.user.id),
                              role: member.role,
                              user: member.user,
                              wasAddedPreviously: false,
                            ),
                          ),
                        ],
                      );
                    },
                  ),

                  BlocBuilder<AddEditGroupCubit, AddEditGroupState>(
                    buildWhen: (previous, current) =>
                        previous.history != current.history,
                    builder: (context, state) {
                      final history = state.history;
                      if (history.isEmpty) {
                        return const SizedBox();
                      }
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(height: 50.h),
                          Text(
                            appLocalizations.history,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontFamily: 'OpenSans',
                              fontWeight: FontWeight.bold,
                              fontSize: 21.5.sp,
                              color: Color(0xFF3475F0),
                            ),
                          ),
                          ...history.map(
                            (edit) => HistoryItem(
                              edit: edit,
                              type: appLocalizations.group,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  SizedBox(
                    height: 75.h,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: Container(
        height: 75.h,
        color: AppColors.txtFieldBackground,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 10.h),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(appLocalizations.cancel),
                ),
              ),
            ),
            SizedBox(width: 25.w),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(right: 10.h),
                child: ElevatedButton(
                  onPressed: () {
                    if (addEditGroupCubit
                        .submitRequested(appLocalizations.inviteSMS)) {
                      Alerts.showMessageBox(
                        context: context,
                        title: appLocalizations.dialogInfo,
                        message: widget.isEditMode
                            ? appLocalizations.updateGroupSuccess
                            : appLocalizations.createGroupSuccess,
                        callback: () {
                          Navigator.of(context).pop();
                        },
                      );
                    }
                  },
                  child: Text(
                    widget.isEditMode
                        ? appLocalizations.update
                        : appLocalizations.create,
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: AppColors.selectedButtonBG,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
