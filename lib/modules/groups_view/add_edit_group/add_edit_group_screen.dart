import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
// ignore: implementation_imports
import 'package:flutter/src/widgets/basic.dart' as widgets;
// ignore: import_of_legacy_library_into_null_safe
import 'package:fbroadcast/fbroadcast.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:starfish/apis/hive_api.dart';
import 'package:starfish/config/routes/routes.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:starfish/constants/assets_path.dart';
import 'package:starfish/constants/text_styles.dart';
import 'package:starfish/db/hive_edit.dart';
import 'package:starfish/db/hive_evaluation_category.dart';
import 'package:starfish/db/hive_group.dart';
import 'package:starfish/db/hive_group_user.dart';
import 'package:starfish/db/hive_language.dart';
import 'package:starfish/db/hive_user.dart';
import 'package:starfish/db/providers/current_user_provider.dart';
import 'package:starfish/modules/groups_view/contact_list/contact_list.dart';
import 'package:starfish/modules/groups_view/cubit/add_edit_group_cubit.dart';
import 'package:starfish/modules/groups_view/cubit/contacts_cubit.dart';
import 'package:starfish/modules/groups_view/cubit/group_navigation_cubit.dart';
import 'package:starfish/repositories/data_repository.dart';
import 'package:starfish/repository/current_user_repository.dart';
import 'package:starfish/repository/group_repository.dart';
import 'package:starfish/repository/user_repository.dart';
import 'package:starfish/select_items/multi_select.dart';
import 'package:starfish/src/grpc_extensions.dart';
import 'package:starfish/utils/currentUser.dart';
import 'package:starfish/utils/helpers/alerts.dart';
import 'package:starfish/utils/helpers/snackbar.dart';
import 'package:starfish/utils/helpers/uuid_generator.dart';
import 'package:starfish/utils/services/sync_service.dart';
import 'package:starfish/widgets/app_logo_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starfish/widgets/contact_list_item.dart';
import 'package:starfish/modules/groups_view/edit_invite_user_bottomsheet.dart';
import 'package:starfish/modules/groups_view/add_edit_group/group_member_list_item.dart';
import 'package:starfish/widgets/history_item.dart';
import 'package:starfish/widgets/searchbar_widget.dart';
import 'package:starfish/modules/groups_view/add_edit_group/uninvited_group_member_list_item.dart';
import 'package:starfish/modules/groups_view/add_edit_group/uninvited_person_list_item.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:starfish/wrappers/platform.dart';
import 'package:starfish/wrappers/sms.dart';
import 'package:template_string/template_string.dart';

class AddEditGroup extends StatelessWidget {
  const AddEditGroup({Key? key, this.group}) : super(key: key);

  final Group? group;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AddEditGroupCubit(
            dataRepository: context.read<DataRepository>(),
            group: group,
          ),
        ),
        BlocProvider(
          create: (context) => ContactsCubit(
            currentUser: context.currentUser,
            selectedUsers: group?.fullUsers,
          ),
        ),
        BlocProvider(
          create: (_) => GroupNavigationCubit(),
        ),
      ],
      child: BlocListener<GroupNavigationCubit, GroupNavigationState>(
        listener: (context, state) {
          switch (state) {
            case GroupNavigationState.mainEdit:
              Navigator.of(context).pop();
              break;
            case GroupNavigationState.addUsers:
              ContactList.showAsBottomSheet(context,
                      selectedUsers: group?.fullUsers)
                  .then(
                (newUsers) {
                  if (newUsers != null) {
                    context.read<AddEditGroupCubit>().newUsersAdded(newUsers);
                  }
                },
              );
              break;
            case GroupNavigationState.editUser:
            // TODO
          }
        },
        child: const AddEditGroupView(),
      ),
    );
  }
}

class AddEditGroupView extends StatefulWidget {
  const AddEditGroupView({Key? key}) : super(key: key);

  @override
  _AddEditGroupViewState createState() => _AddEditGroupViewState();
}

class _AddEditGroupViewState extends State<AddEditGroupView> {
  final _personNameController = TextEditingController();

  bool _isEditMode = false;
  List<HiveUser> _newInvitedUsers = [];
  List<HiveGroupUser> _newInvitedGroupUsers = [];

  //List<String> _unInvitedPersonNames = [];

  List<HiveGroupUser> _groupUsers = [];
  List<HiveGroupUser> _updatedGroupUsers = [];

  void _sendInviteSMS(String message, List<HiveUser> recipents) async {
    recipents.forEach((element) {
      SMS.send(
          message.insertTemplateValues({
            'receiver_first_name': element.name ?? '',
            'sender_name': CurrentUserProvider().user.name!
          }),
          element.phoneWithDialingCode);
    });
  }

  bool _checkIfUserPhonenumberAlreadySelected(
      String diallingCode, String phonenumber) {
    bool _alreadySelected = _newInvitedUsers
            .where((element) =>
                element.diallingCode == diallingCode &&
                element.phone == phonenumber)
            .length >
        0;

    bool _alreadyGroupMember = false;
    if (_isEditMode &&
        _hiveGroup!.activeUsers != null &&
        _hiveGroup!.activeUsers!
                .where((element) =>
                    element.diallingCode == diallingCode &&
                    element.phone == phonenumber)
                .length >
            0) {
      _alreadyGroupMember = true;
    }

    return _alreadySelected || _alreadyGroupMember;
  }

  // void _createUpdateGroup() {
  //   // Step 1: save/update group

  //   if (_isEditMode) {
  //     _hiveGroup!.isNew = true;
  //   } else {
  //     _hiveGroup!.isUpdated = true;
  //   }
  //   _hiveGroup!.name = _titleController.text;
  //   _hiveGroup!.description = _descriptionController.text;
  //   _hiveGroup!.languageIds =
  //       _selectedLanguages.map((HiveLanguage language) => language.id).toList();
  //   _hiveGroup!.evaluationCategoryIds = _selectedEvaluationCategories
  //       .map((HiveEvaluationCategory category) => category.id!)
  //       .toList();

  //   bloc.groupBloc.addEditGroup(_hiveGroup!).then((value) {
  //     // Step 2: save/update user
  //     _newInvitedUsers.forEach((element) async {
  //       await UserRepository().createUpdateUserInDB(element);
  //     });

  //     // Step 3: createUpdate group members in the group
  //     _newInvitedGroupUsers.forEach((element) async {
  //       await GroupRepository().createUpdateGroupUserInDB(groupUser: element);
  //     });

  //     // TODO: _updatedGroupUsers to be removed
  //     _updatedGroupUsers.forEach((element) async {
  //       await bloc.groupBloc.createUpdateGroupUser(element);
  //     });

  //     // Step 4: send SMS
  //     List<HiveUser> _usersWithPhone = _newInvitedUsers
  //         .where(
  //             (element) => element.phone != null && element.phone!.isNotEmpty)
  //         .toList();
  //     if (_usersWithPhone.length > 0) {
  //       _sendInviteSMS(appLocalizations.inviteSMS, _usersWithPhone);
  //     }

  //     FBroadcast.instance().broadcast(
  //       SyncService.kUpdateGroup,
  //       value: _hiveGroup,
  //     );

  //     Alerts.showMessageBox(
  //         context: context,
  //         title: appLocalizations.dialogInfo,
  //         message: _isEditMode
  //             ? appLocalizations.updateGroupSuccess
  //             : appLocalizations.createGroupSuccess,
  //         callback: () {
  //           Navigator.of(context).pop();
  //         });
  //   }).onError((error, stackTrace) {
  //     StarfishSnackbar.showErrorMessage(
  //         context,
  //         _isEditMode
  //             ? appLocalizations.updateGroupFailed
  //             : appLocalizations.createGroupSuccess);
  //   }).whenComplete(() {});
  // }

  void _onEditUserInvite(HiveUser user, HiveGroupUser groupUser) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(34.r),
          topRight: Radius.circular(34.r),
        ),
      ),
      backgroundColor: const Color(0xFFEFEFEF),
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: true,
      builder: (BuildContext context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.70,
          child: EditInviteUserBottomSheet(
            user,
            groupUser,
            onDone: (String contactName, String diallingCode,
                String phonenumber, GroupUser_Role role) {
              if (contactName.isEmpty) {
                StarfishSnackbar.showErrorMessage(
                    context, AppLocalizations.of(context)!.emptyFullName);
                return;
              } else if (diallingCode.isEmpty) {
                StarfishSnackbar.showErrorMessage(
                    context, AppLocalizations.of(context)!.emptyDialingCode);
                return;
              } else if (phonenumber.isEmpty) {
                StarfishSnackbar.showErrorMessage(
                    context, AppLocalizations.of(context)!.emptyMobileNumbers);
                return;
              } else if ((user.phone != phonenumber ||
                      user.diallingCode != diallingCode) &&
                  _checkIfUserPhonenumberAlreadySelected(
                      diallingCode, phonenumber)) {
                //check if there is any change in dialling code or in phone number
                StarfishSnackbar.showErrorMessage(
                    context, appLocalizations.phonenumberAlreadyAdded);
                return;
              } else {
                user.name = contactName;
                user.diallingCode = diallingCode;
                user.phone = phonenumber;
                user.isUpdated = true;

                groupUser.role = role.value;
                groupUser.isUpdated = true;

                Navigator.of(context).pop();
              }
            },
          ),
        );
      },
    );
  }

  void submitPersonName() {
    context
        .read<ContactsCubit>()
        .personNameSubmitted(_personNameController.text);
    _personNameController.text = '';
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
    final contactCubit = context.read<ContactsCubit>();

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
                _isEditMode
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
      body: MultiBlocListener(
        listeners: [
          BlocListener<ContactsCubit, ContactsState>(
            listener: (context, state) {
              final error = state.error;
              if (error != null) {
                String message;
                switch (error) {
                  case ContactError.nameAlreadyExists:
                    message = appLocalizations.userNameAlreadyAdded;
                    break;
                }
                StarfishSnackbar.showErrorMessage(context, message);
              }
            },
          ),
          BlocListener<AddEditGroupCubit, AddEditGroupState>(
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
          ),
        ],
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
                        initialSelection: state.selectedLanguages
                            .map((languageId) =>
                                globalHiveApi.language.get(languageId)!)
                            .toSet(),
                        toDisplay: (language) => language.name,
                        onFinished: (selectedLanguages) {
                          addEditGroupCubit.selectedLanguagesChanged(
                              selectedLanguages.map((l) => l.id).toSet());
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
                        navTitle: appLocalizations.selectCategories,
                        placeholder: appLocalizations.selectCategories,
                        items: state.evaluationCategories,
                        initialSelection: state.selectedEvaluationCategories
                            .map((categoryId) => globalHiveApi
                                .evaluationCategory
                                .get(categoryId)!)
                            .toSet(),
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
                                _checkPermissionsAndShowContact();
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

                  _invitedGroupMembersContainer(),
                  _invitedContactsContainer(),
                  // Option 2.
                  Text(
                    appLocalizations.addWithoutInvite,
                    textAlign: TextAlign.left,
                    style: titleTextStyle,
                  ),
                  SizedBox(height: 20.h),
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFEFEFEF),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    padding: EdgeInsets.only(left: 15.w),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _personNameController,
                            keyboardType: TextInputType.text,
                            style: textFormFieldText,
                            onFieldSubmitted: (_) => submitPersonName(),
                            decoration: InputDecoration(
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              labelText: appLocalizations.hintPersonName,
                              labelStyle: formTitleHintStyle,
                              alignLabelWithHint: true,
                              // hintText:
                              //     appLocalizations.hintPersonName,
                              // hintStyle: textFormFieldText,
                              contentPadding:
                                  EdgeInsets.fromLTRB(5.w, 5.0, 5.0.w, 5.0),
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
                        ),
                        IconButton(
                          onPressed: submitPersonName,
                          icon: SvgPicture.asset(AssetsPath.nextIcon),
                        ),
                      ],
                    ),
                  ),
                  // Selection person without invite
                  _unInvitedGroupMembersContainer(),
                  _unInvitedContactsContainer(),

                  if (widget.group?.editHistory != null)
                    _editHistoryContainer(widget.group),
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
        // padding: EdgeInsets.symmetric(vertical: 18.75.h, horizontal: 30.w),
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
                    _validateAndCreateUpdateGroup();
                  },
                  child: Text(
                    _isEditMode
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

  Widget _editHistoryContainer(HiveGroup? group) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _historyItems(group!)!,
      ),
    );
  }

  List<Widget>? _historyItems(HiveGroup group) {
    final List<Widget> _widgetList = [];
    final header = Text(
      appLocalizations.history,
      style: TextStyle(
        fontFamily: 'OpenSans',
        fontWeight: FontWeight.bold,
        fontSize: 21.5.sp,
        color: Color(0xFF3475F0),
      ),
    );
    _widgetList.add(header);

    for (HiveEdit edit in group.editHistory ?? []) {
      _widgetList.add(HistoryItem(edit: edit, type: appLocalizations.group));
    }

    return _widgetList;
  }

  Widget _invitedContactsContainer() {
    final List<Widget> _widgetList = [];

    List<HiveUser> _usersWithPhone = _newInvitedUsers
        .where((element) => element.phone != null && element.phone!.isNotEmpty)
        .toList();

    _usersWithPhone.sort(
        (a, b) => (a.name!.toLowerCase().compareTo((b.name!).toLowerCase())));
    for (HiveUser inviteContact in _usersWithPhone) {
      HiveGroupUser _groupUser = HiveGroupUser(
          userId: inviteContact.id,
          groupId: _hiveGroup!.id,
          role: GroupUser_Role.LEARNER.value);
      _widgetList.add(GroupMemberListItem(
          groupUser: _groupUser,
          user: inviteContact,
          onChangeUserRole: (HiveGroupUser contact, GroupUser_Role newRole) {},
          onRemoveUser: (HiveGroupUser contact) {
            setState(() {
              inviteContact.isSelected = false;
              _newInvitedUsers
                  .removeWhere((element) => element.id == inviteContact.id);
              _newInvitedGroupUsers.remove(contact);
            });
          },
          onEditUserInvite: (HiveGroupUser groupUser, HiveUser contact) {
            _onEditUserInvite(contact, groupUser);
          }));
    }
    // Additional vertical spacing
    if (_widgetList.length > 0) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _widgetList,
      );
    } else {
      return Container();
    }
  }

  // Widget for the group members invited with phone numbers
  Widget _invitedGroupMembersContainer() {
    // List<HiveGroupUser> _groupUsers = List.from(widget.group?.activeUsers
    //         ?.where((element) =>
    //             (element.isInvited || element.isActive) &&
    //             element.phone.isNotEmpty)
    //         .toList() ??
    //     []);

    if (_groupUsers.isEmpty) {
      return Container();
    }

    _updatedGroupUsers.forEach((element) {
      if (_groupUsers.contains(element)) {
        _groupUsers.remove(element);
        _groupUsers.add(element);
      } else {
        _groupUsers.add(element);
      }
    });

    final List<Widget> _widgetList = [];

    _groupUsers
        .sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
    for (HiveGroupUser groupUser in _groupUsers) {
      _widgetList.add(
        GroupMemberListItem(
          groupUser: groupUser,
          user: groupUser.user!,
          onChangeUserRole: (HiveGroupUser _groupUser, _groupUserRole) {
            // Check if the removed user is the only ADMIN in the group, if so, display alert else delete it
            if (GroupUser_Role.valueOf(_groupUser.role!) ==
                    GroupUser_Role.ADMIN &&
                widget.group!.admins != null &&
                widget.group!.admins!.length == 1) {
              //show warning
              Alerts.showMessageBox(
                context: context,
                title: appLocalizations.dialogAlert,
                message: appLocalizations.alertGroupCanNotBeWithoutAdmin,
                callback: () {
                  Navigator.of(context).pop();
                },
              );
            } else {
              // _groupUser.isUpdated = true;
              // _groupUser.role = _groupUserRole.value;

              //bloc.groupBloc.createUpdateGroupUser(_groupUser);
              HiveGroupUser _updatedGroupUser = HiveGroupUser(
                groupId: _groupUser.groupId,
                userId: _groupUser.userId,
                role: _groupUserRole.value,
                isUpdated: true,
              );
              if (_updatedGroupUsers.contains(_groupUser)) {
                _updatedGroupUsers.remove(_updatedGroupUser);
              }
              _updatedGroupUsers.add(_updatedGroupUser);
              setState(() {});
            }
          },
          onRemoveUser: (_groupUser) {
            // Check if the removed user is the only ADMIN in the group, if so, display alert else delete it
            if (GroupUser_Role.valueOf(_groupUser.role!) ==
                    GroupUser_Role.ADMIN &&
                widget.group!.admins != null &&
                widget.group!.admins!.length == 1) {
              //show warning
              Alerts.showMessageBox(
                context: context,
                title: appLocalizations.dialogAlert,
                message: appLocalizations.alertGroupCanNotBeWithoutAdmin,
                callback: () {
                  Navigator.of(context).pop();
                },
              );
            } else {
              _groupUser.isDirty = true;
              bloc.groupBloc.createUpdateGroupUser(_groupUser).then((value) {
                setState(() {
                  _groupUsers.remove(_groupUser);
                });
              });
            }
          },
          onEditUserInvite: (HiveGroupUser _groupUser, HiveUser _user) {
            _onEditUserInvite(_user, _groupUser);
          },
        ),
      );
    }
    // Additional vertical spacing
    if (_widgetList.length > 0) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _widgetList,
      );
    } else {
      return Container();
    }
  }

  Widget _unInvitedContactsContainer() {
    final List<Widget> _widgetList = [];
    List<HiveUser> _usersWithoutPhone = _newInvitedUsers
        .where((element) =>
            element.phone == null ||
            (element.phone != null && element.phone!.isEmpty))
        .toList();
    _usersWithoutPhone
        .sort((a, b) => a.name!.toLowerCase().compareTo(b.name!.toLowerCase()));

    for (HiveUser person in _usersWithoutPhone) {
      _widgetList.add(
        UnInvitedPersonListItem(
          personName: person,
          onRemove: (HiveUser person) {
            if (_newInvitedUsers.contains(person)) {
              setState(() {
                _newInvitedUsers.remove(person);
              });
            }
          },
        ),
      );
    }
    // Additional vertical spacing
    if (_widgetList.length > 0) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _widgetList,
      );
    } else {
      return Container();
    }
  }

  Widget _unInvitedGroupMembersContainer() {
    List<HiveGroupUser>? _groupUsers = widget.group?.activeUsers
        ?.where((element) => element.phone.isEmpty)
        .toList();

    if (_groupUsers == null) {
      return Container();
    }

    final List<Widget> _widgetList = [];
    _groupUsers
        .sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));

    for (HiveGroupUser groupUser in _groupUsers) {
      _widgetList.add(
        UnInvitedGroupMemberListItem(
          groupUser: groupUser,
          onRemove: (HiveGroupUser hiveGroupUser) {
            if (_groupUsers.contains(hiveGroupUser)) {
              setState(() {
                _groupUsers.remove(hiveGroupUser);
              });
            }
          },
          onInvite: (HiveUser _user, String diallingCode, String phonenumber) {
            if (diallingCode.isEmpty) {
              StarfishSnackbar.showErrorMessage(
                  context, AppLocalizations.of(context)!.emptyDialingCode);
              return;
            } else if (phonenumber.isEmpty) {
              StarfishSnackbar.showErrorMessage(
                  context, AppLocalizations.of(context)!.emptyMobileNumbers);
              return;
            } else if (_checkIfUserPhonenumberAlreadySelected(
                diallingCode, phonenumber)) {
              StarfishSnackbar.showErrorMessage(
                  context, appLocalizations.phonenumberAlreadyAdded);
              return;
            } else {
              _user.phone = phonenumber;
              _user.diallingCode = diallingCode;
              _user.isUpdated = true;
              bloc.userBloc.createUpdateUser(_user).then((value) {
                setState(() {});
                SMS.send(
                    appLocalizations.inviteSMS.insertTemplateValues({
                      'receiver_first_name': _user.name ?? '',
                      'sender_name': CurrentUserProvider().user.name!
                    }),
                    _user.phoneWithDialingCode);
              });
            }
          },
        ),
      );
    }

    // Additional vertical spacing
    if (_widgetList.length > 0) {
      return Column(
        children: _widgetList,
      );
    } else {
      return Container();
    }
  }
}
