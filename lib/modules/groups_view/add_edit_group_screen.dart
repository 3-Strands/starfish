import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
// ignore: implementation_imports
import 'package:flutter/src/widgets/basic.dart' as widgets;
// ignore: import_of_legacy_library_into_null_safe
import 'package:fbroadcast/fbroadcast.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:starfish/bloc/app_bloc.dart';
import 'package:starfish/bloc/provider.dart';
import 'package:starfish/config/routes/routes.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:starfish/constants/assets_path.dart';
import 'package:starfish/constants/text_styles.dart';
import 'package:starfish/db/hive_current_user.dart';
import 'package:starfish/db/hive_database.dart';
import 'package:starfish/db/hive_edit.dart';
import 'package:starfish/db/hive_evaluation_category.dart';
import 'package:starfish/db/hive_group.dart';
import 'package:starfish/db/hive_group_user.dart';
import 'package:starfish/db/hive_language.dart';
import 'package:starfish/db/hive_user.dart';
import 'package:starfish/db/providers/current_user_provider.dart';
import 'package:starfish/repository/current_user_repository.dart';
import 'package:starfish/repository/group_repository.dart';
import 'package:starfish/repository/user_repository.dart';
import 'package:starfish/select_items/multi_select.dart';
import 'package:starfish/src/generated/starfish.pb.dart';
import 'package:starfish/utils/helpers/alerts.dart';
import 'package:starfish/utils/helpers/snackbar.dart';
import 'package:starfish/utils/helpers/uuid_generator.dart';
import 'package:starfish/utils/services/sync_service.dart';
import 'package:starfish/widgets/app_logo_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starfish/widgets/contact_list_item.dart';
import 'package:starfish/widgets/edit_invite_user_bottomsheet.dart';
import 'package:starfish/widgets/group_member_list_item.dart';
import 'package:starfish/widgets/history_item.dart';
import 'package:starfish/widgets/searchbar_widget.dart';
import 'package:starfish/widgets/uninvited_group_member_list_item.dart';
import 'package:starfish/widgets/uninvited_person_list_item.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:starfish/wrappers/platform.dart';
import 'package:starfish/wrappers/sms.dart';
import 'package:template_string/template_string.dart';

class AddEditGroupScreen extends StatefulWidget {
  final HiveGroup? group;
  const AddEditGroupScreen({
    Key? key,
    this.group,
  }) : super(key: key);

  @override
  _AddEditGroupScreenState createState() => _AddEditGroupScreenState();
}

class _AddEditGroupScreenState extends State<AddEditGroupScreen> {
  final ValueNotifier<List<HiveUser>?> _contactsNotifier = ValueNotifier(null);

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _personNameController = TextEditingController();

  bool _isEditMode = false;
  String _query = '';

  List<HiveLanguage> _selectedLanguages = [];
  List<HiveEvaluationCategory> _selectedEvaluationCategories = [];
  //List<InviteContact> _selectedContacts = [];
  List<HiveUser> _newInvitedUsers = [];
  List<HiveGroupUser> _newInvitedGroupUsers = [];

  //List<String> _unInvitedPersonNames = [];

  List<HiveGroupUser> _groupUsers = [];
  List<HiveGroupUser> _updatedGroupUsers = [];

  HiveGroup? _hiveGroup;

  late Box<HiveLanguage> _languageBox;
  late Box<HiveEvaluationCategory> _evaluationCategoryBox;

  late List<HiveLanguage> _languageList;
  late List<HiveEvaluationCategory> _evaluationCategoryList;

  late AppBloc bloc;
  late AppLocalizations _appLocalizations;

  @override
  void initState() {
    super.initState();

    _languageBox = Hive.box<HiveLanguage>(HiveDatabase.LANGUAGE_BOX);

    _evaluationCategoryBox = Hive.box<HiveEvaluationCategory>(
        HiveDatabase.EVALUATION_CATEGORIES_BOX);

    _getAllLanguages();
    _getAllEvaluationCategories();

    hasContactAccess().then((hasAccess) {
      if (hasAccess) {
        _loadContacts();
      }
    });

    if (widget.group != null) {
      _hiveGroup = widget.group;

      _isEditMode = true;

      _groupUsers = List.from(widget.group?.activeUsers
              ?.where((element) =>
                  (element.isInvited || element.isActive) &&
                  element.phone.isNotEmpty)
              .toList() ??
          []);
      _titleController.text = widget.group!.name ?? '';
      _descriptionController.text = widget.group!.description ?? '';

      widget.group!.languages.forEach((key, value) {
        _selectedLanguages.add(HiveLanguage(id: key, name: value));
      });
      _selectedLanguages.sort((a, b) => a.name.compareTo(b.name));

      _selectedEvaluationCategories = _evaluationCategoryBox.values
          .where((HiveEvaluationCategory category) => widget.group != null
              ? widget.group!.evaluationCategoryIds!.contains(category.id)
              : false)
          .toList();
    } else {
      _hiveGroup = HiveGroup(id: UuidGenerator.uuid(), isNew: true);

      HiveCurrentUser _currentUser =
          CurrentUserRepository().getUserSyncFromDB();

      HiveGroupUser _hiveGroupUser = HiveGroupUser(
        groupId: _hiveGroup!.id,
        userId: _currentUser.id,
        role: GroupUser_Role.ADMIN.value,
        isNew: true,
      );

      _hiveGroup!.users = [_hiveGroupUser];
    }
  }

  void _getAllLanguages() {
    _languageList = _languageBox.values.toList();
    _languageList.sort((a, b) => a.name.compareTo(b.name));
  }

  void _getAllEvaluationCategories() {
    _evaluationCategoryList = _evaluationCategoryBox.values.toList();
  }

  Future<void> _checkPermissionsAndShowContact() async {
    if (await hasContactAccess(shouldAskIfUnknown: true)) {
      await _loadContacts();
      _showContactList();
    } else {
      _handleInvalidPermissions();
    }
  }

  void _handleInvalidPermissions() async {
    final snackbar = SnackBar(
      content: Text((await canRequestContactAccess())
          ? _appLocalizations.contactAccessDenied
          : _appLocalizations.contactDataNotAvailable),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

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

  bool _checkIfUserPhonenumberAlreadySelected(HiveUser contact) {
    bool _alreadySelected = _newInvitedUsers
            .where((element) =>
                element.diallingCode == contact.diallingCode &&
                element.phone == contact.phone)
            .length >
        0;

    bool _alreadyGroupMember = false;
    if (_isEditMode &&
        _hiveGroup!.activeUsers != null &&
        _hiveGroup!.activeUsers!
                .where((element) =>
                    element.diallingCode == contact.diallingCode &&
                    element.phone == contact.phone)
                .length >
            0) {
      _alreadyGroupMember = true;
    }

    return _alreadySelected || _alreadyGroupMember;
  }

  Widget _buildSlidingUpPanel() {
    return Container(
      child: ValueListenableBuilder<List<HiveUser>?>(
          valueListenable: _contactsNotifier,
          builder:
              (BuildContext context, List<HiveUser>? snapshot, Widget? child) {
            if (snapshot == null) {
              return Center(
                child: Text(_appLocalizations.loading),
              );
            }
            List<HiveUser> _listToShow = [];

            if (_query.isNotEmpty) {
              final lowerCaseQuery = _query.toLowerCase();
              _listToShow = snapshot
                  .where((data) =>
                      (data.name ?? '').toLowerCase().contains(lowerCaseQuery))
                  .toList();
            } else {
              _listToShow = snapshot;
            }
            return Scrollbar(
              thickness: 5.w,
              isAlwaysShown: false,
              child: ListView.builder(
                  itemCount: _listToShow.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ContactListItem(
                        contact: _listToShow.elementAt(index),
                        onTap: (HiveUser contact) {
                          //TODO: check if contact number already registered/selected for any other group member

                          if (_checkIfUserPhonenumberAlreadySelected(contact)) {
                            StarfishSnackbar.showErrorMessage(context,
                                _appLocalizations.phonenumberAlreadyAdded);
                            return;
                          }

                          HiveGroupUser _groupUser = HiveGroupUser(
                              groupId: _hiveGroup!.id,
                              userId: contact.id,
                              role: GroupUser_Role.LEARNER.value,
                              isNew: true);
                          setState(() {
                            if (!contact.isSelected &&
                                _newInvitedUsers.contains(contact)) {
                              _newInvitedUsers.remove(contact);
                              _newInvitedGroupUsers.remove(_groupUser);
                            } else {
                              contact.isNew = true;
                              _newInvitedUsers.add(contact);
                              _newInvitedGroupUsers.add(_groupUser);
                            }
                          });
                        });
                  }),
            );
          }),
    );
  }

  Future<void> _loadContacts() async {
    if (_contactsNotifier.value == null) {
      _contactsNotifier.value = await getAllContacts();
    }
  }

  _showContactList() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(34.r), topRight: Radius.circular(34.r)),
      ),
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: true,
      builder: (BuildContext context) {
        return widgets.StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return Container(
            margin: EdgeInsets.only(top: 40.h),
            height: MediaQuery.of(context).size.height * 0.70,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        widgets.Padding(
                          padding: EdgeInsets.only(left: 15.0.w, right: 15.0.w),
                          child: Text(
                            _appLocalizations.selectPropleToInvite,
                            textAlign: TextAlign.left,
                            style: titleTextStyle,
                          ),
                        ),
                        SizedBox(height: 11.h),
                        SearchBar(
                            initialValue: '',
                            onValueChanged: (String value) {
                              if (value.isEmpty) {
                                return;
                              }
                              setState(() {
                                _query = value;
                              });
                            },
                            onDone: (String value) {
                              setState(() {
                                _query = value;
                              });
                            }),
                        SizedBox(height: 11.h),
                        Expanded(
                          child: widgets.Padding(
                            padding:
                                EdgeInsets.only(left: 15.0.w, right: 15.0.w),
                            child: _buildSlidingUpPanel(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 75.h,
                  padding:
                      EdgeInsets.symmetric(vertical: 18.75.h, horizontal: 30.w),
                  color: AppColors.txtFieldBackground,
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(_appLocalizations.cancel),
                        ),
                      ),
                      SizedBox(width: 25.w),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            _query = '';
                            Navigator.of(context).pop();
                          },
                          style: ElevatedButton.styleFrom(
                            primary: AppColors.selectedButtonBG,
                          ),
                          child: Text(_appLocalizations.invite),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
      },
    ).whenComplete(() {
      _query = '';
      FocusScope.of(context).requestFocus(new FocusNode());
    });
  }

  void _validateAndCreateUpdateGroup() {
    if (_titleController.text.isEmpty) {
      StarfishSnackbar.showErrorMessage(
          context, _appLocalizations.emptyGroupTitle);
    } else if (_descriptionController.text.isEmpty) {
      StarfishSnackbar.showErrorMessage(
          context, _appLocalizations.emptyDescription);
    } /* else if (_selectedLanguages.length == 0) {
      StarfishSnackbar.showErrorMessage(
          context, _appLocalizations.emptySelectLanguage);
    } else if (_selectedEvaluationCategories.length == 0) {
      StarfishSnackbar.showErrorMessage(
          context, _appLocalizations.emptyEvaluateProgress);
    }*/
    else {
      _createUpdateGroup();
    }
  }

  void _createUpdateGroup() {
    // Step 1: save/update group

    if (_isEditMode) {
      _hiveGroup!.isNew = true;
    } else {
      _hiveGroup!.isUpdated = true;
    }
    _hiveGroup!.name = _titleController.text;
    _hiveGroup!.description = _descriptionController.text;
    _hiveGroup!.languageIds =
        _selectedLanguages.map((HiveLanguage language) => language.id).toList();
    _hiveGroup!.evaluationCategoryIds = _selectedEvaluationCategories
        .map((HiveEvaluationCategory category) => category.id!)
        .toList();

    bloc.groupBloc.addEditGroup(_hiveGroup!).then((value) {
      // Step 2: save/update user
      _newInvitedUsers.forEach((element) async {
        await UserRepository().createUpdateUserInDB(element);
      });

      // Step 3: createUpdate group members in the group
      _newInvitedGroupUsers.forEach((element) async {
        await GroupRepository().createUpdateGroupUserInDB(groupUser: element);
      });

      // TODO: _updatedGroupUsers to be removed
      _updatedGroupUsers.forEach((element) {
        bloc.groupBloc.createUpdateGroupUser(element);
      });

      // Step 4: send SMS
      List<HiveUser> _usersWithPhone = _newInvitedUsers
          .where(
              (element) => element.phone != null && element.phone!.isNotEmpty)
          .toList();
      if (_usersWithPhone.length > 0) {
        _sendInviteSMS(_appLocalizations.inviteSMS, _usersWithPhone);
      }

      FBroadcast.instance().broadcast(
        SyncService.kUpdateGroup,
        value: _hiveGroup,
      );

      Alerts.showMessageBox(
          context: context,
          title: _appLocalizations.dialogInfo,
          message: _isEditMode
              ? _appLocalizations.updateGroupSuccess
              : _appLocalizations.createGroupSuccess,
          callback: () {
            Navigator.of(context).pop();
          });
    }).onError((error, stackTrace) {
      StarfishSnackbar.showErrorMessage(
          context,
          _isEditMode
              ? _appLocalizations.updateGroupFailed
              : _appLocalizations.createGroupSuccess);
    }).whenComplete(() {});
  }

/*
  _createUpdateGroup() async {
    // String? _groupId;
    // if (_isEditMode) {
    //   _groupId = widget.group?.id;
    // } else {
    //   _groupId = UuidGenerator.uuid(); // Assign UUID
    // }
    //List<HiveUser> _newUsers = [];
    List<HiveGroupUser> _newGroupUsers = [];

    _newInvitedUsers.forEach((element) async {
      HiveUser _hiveUser = element;
      // set dialing code of the current User
      //_hiveUser.diallingCode = CurrentUserProvider().getUserSync().diallingCode;
      _hiveUser.linkGroups = true;
      _hiveUser.isNew = true;

      //_newUsers.add(_hiveUser);
      await UserRepository().createUpdateUserInDB(_hiveUser);

      _newGroupUsers.add(HiveGroupUser(
        groupId: _groupId,
        userId: _hiveUser.id,
        role: element.role.value,
        isNew: true,
      ));
    });

    _unInvitedPersonNames.forEach((element) async {
      HiveUser _hiveUser = HiveUser(
          id: UuidGenerator.uuid(),
          name: element,
          linkGroups: true,
          isNew: true);
      await UserRepository().createUpdateUserInDB(_hiveUser);

      _newGroupUsers.add(HiveGroupUser(
        groupId: _groupId,
        userId: _hiveUser.id,
        role: GroupUser_Role.LEARNER.value,
        isNew: true,
      ));
    });

    // List<HiveGroupUser> _newGroupUsers = [];
    if (false == _isEditMode) {
      // Add self as Admin, without this local added records will not be filtered
      // based on role hence will not be visible
      HiveCurrentUser _currentUser =
          await CurrentUserRepository().getUserFromDB();
      HiveGroupUser _hiveGroupUser = HiveGroupUser(
        groupId: _groupId,
        userId: _currentUser.id,
        role: GroupUser_Role.ADMIN.value,
        isNew: true,
      );
      _newGroupUsers.add(_hiveGroupUser);

      // Add self `HiveGroupUser` model to the `HiveCurrentUser` also
      _currentUser.groups.add(_hiveGroupUser);
      CurrentUserRepository().dbProvider.updateUser(_currentUser);
    }

    HiveGroup? _hiveGroup;

    if (_isEditMode) {
      _hiveGroup = widget.group!;
      //_hiveGroup.users?.addAll(_newGroupUsers);
      _updatedGroupUsers.forEach((element) {
        bloc.groupBloc.createUpdateGroupUser(element);
      });

      _hiveGroup.isUpdated = true;
    } else {
      _hiveGroup = HiveGroup(
        id: _groupId,
        isNew: true,
      );
      _hiveGroup.users = _newGroupUsers;
    }
    _hiveGroup.name = _titleController.text;
    _hiveGroup.description = _descriptionController.text;
    _hiveGroup.languageIds =
        _selectedLanguages.map((HiveLanguage language) => language.id).toList();
    _hiveGroup.evaluationCategoryIds = _selectedEvaluationCategories
        .map((HiveEvaluationCategory category) => category.id!)
        .toList();

    // Add groupUsers to 'GroupUserBox' to sync
    await bloc.groupBloc.addGroupUsers(_newGroupUsers);

    bloc.groupBloc.addEditGroup(_hiveGroup).then((value) {
      // Broadcast to sync the local changes with the server
      /*FBroadcast.instance().broadcast(
        SyncService.kUpdateUsers,
        value: _newUsers,
      );*/
      FBroadcast.instance().broadcast(
        SyncService.kUpdateGroup,
        value: _hiveGroup,
      );

      Alerts.showMessageBox(
          context: context,
          title: _appLocalizations.dialogInfo,
          message: _isEditMode
              ? _appLocalizations.updateGroupSuccess
              : _appLocalizations.createGroupSuccess,
          callback: () {
            Navigator.of(context).pop();
          });
    }).onError((error, stackTrace) {
      StarfishSnackbar.showErrorMessage(
          context,
          _isEditMode
              ? _appLocalizations.updateGroupFailed
              : _appLocalizations.createGroupSuccess);
    }).whenComplete(() {
      if (_newInvitedUsers.length > 0) {
        //_sendInviteSMS(_appLocalizations.inviteSMS, _newInvitedUsers);
      }
    });
  }
*/
  void _onEditUserInvite(HiveUser user, HiveGroupUser groupUser) {
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
        return EditInviteUserBottomSheet(user, groupUser,
            onDone: (hiveUser, hiveGroupUser) {});
      },
    ).whenComplete(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    bloc = Provider.of(context);
    _appLocalizations = AppLocalizations.of(context)!;
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
                    ? _appLocalizations.editGroup
                    : _appLocalizations.createGroup,
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
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Scrollbar(
          thickness: 5.w,
          isAlwaysShown: false,
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _appLocalizations.groupName,
                    textAlign: TextAlign.left,
                    style: titleTextStyle,
                  ),
                  SizedBox(height: 11.h),
                  Container(
                    child: TextFormField(
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      controller: _titleController,
                      style: formTitleTextStyle,
                      decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        labelText: _appLocalizations.hintGroupName,
                        labelStyle: formTitleHintStyle,
                        alignLabelWithHint: true,
                        // hintText: _appLocalizations.hintGroupName,
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
                  ),
                  SizedBox(height: 21.h),

                  // Description
                  Text(
                    _appLocalizations.descripton,
                    textAlign: TextAlign.left,
                    style: titleTextStyle,
                  ),
                  SizedBox(height: 11.h),
                  Container(
                    child: TextFormField(
                      maxLines: 4,
                      maxLength: 200,
                      controller: _descriptionController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        labelText: _appLocalizations.hintGroupDescription,
                        labelStyle: formTitleHintStyle,
                        alignLabelWithHint: true,
                        // hintText:
                        //     _appLocalizations.hintGroupDescription,
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
                  ),
                  SizedBox(height: 21.h),

                  // Language(s) used
                  Text(
                    _appLocalizations.lanugagesUsedOptional,
                    textAlign: TextAlign.left,
                    style: titleTextStyle,
                  ),
                  SizedBox(height: 11.h),
                  Container(
                    child: MultiSelect<HiveLanguage>(
                      navTitle: _appLocalizations.selectLanugages,
                      placeholder: _appLocalizations.selectLanugages,
                      items: _languageList,
                      initialSelection: _selectedLanguages.toSet(),
                      toDisplay: HiveLanguage.toDisplay,
                      onFinished: (Set<HiveLanguage> selectedLanguages) {
                        setState(() {
                          _selectedLanguages = selectedLanguages.toList();
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 21.h),

                  // Evaluate Progress
                  Text(
                    _appLocalizations.evaluateProgressOptional,
                    textAlign: TextAlign.left,
                    style: titleTextStyle,
                  ),
                  SizedBox(height: 11.h),
                  Container(
                    child: MultiSelect<HiveEvaluationCategory>(
                      maxSelectItemLimit: 3,
                      navTitle: _appLocalizations.selectCategories,
                      placeholder: _appLocalizations.selectCategories,
                      items: _evaluationCategoryList,
                      initialSelection: _selectedEvaluationCategories.toSet(),
                      toDisplay: HiveEvaluationCategory.toDisplay,
                      onFinished: (Set<HiveEvaluationCategory>
                          selectedEvaluationCategories) {
                        setState(() {
                          _selectedEvaluationCategories =
                              selectedEvaluationCategories.toList();
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    _appLocalizations.hintEvaluateProgress,
                    textAlign: TextAlign.left,
                    style: italicDetailTextTextStyle,
                  ),
                  SizedBox(height: 40.h),

                  // Option 1.
                  Text(
                    _appLocalizations.invitePeopleFromContactsList,
                    textAlign: TextAlign.left,
                    style: titleTextStyle,
                  ),
                  SizedBox(height: 20.h),
                  Platform.isWeb
                      ? Text(
                          _appLocalizations.featureOnlyAvailableOnNative,
                          style: warningTextStyle,
                          textAlign: TextAlign.center,
                        )
                      : DottedBorder(
                          borderType: BorderType.RRect,
                          radius: Radius.circular(30.r),
                          color: Color(0xFF3475F0),
                          child: Container(
                            width: double.infinity,
                            height: 50.h,
                            child: TextButton(
                              onPressed: () {
                                _checkPermissionsAndShowContact();
                              },
                              child: Text(
                                _appLocalizations.inviteFromContactsList,
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
                    _appLocalizations.addWithoutInvite,
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
                            decoration: InputDecoration(
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              labelText: _appLocalizations.hintPersonName,
                              labelStyle: formTitleHintStyle,
                              alignLabelWithHint: true,
                              // hintText:
                              //     _appLocalizations.hintPersonName,
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
                          onPressed: () {
                            if (_personNameController.text.isNotEmpty) {
                              setState(() {
                                // _unInvitedPersonNames
                                //     .add(_personNameController.text);
                                if (_newInvitedUsers
                                        .where((element) =>
                                            element.phone == null ||
                                            (element.phone != null &&
                                                element.phone!.isEmpty))
                                        .where((element) =>
                                            element.name!.toLowerCase() ==
                                            _personNameController.text)
                                        .length >
                                    0) {
                                  // TODO: user with this name already added, also check in the already added group members
                                  StarfishSnackbar.showErrorMessage(context,
                                      _appLocalizations.userNameAlreadyAdded);
                                  return;
                                }
                                HiveUser _hiveUser = HiveUser(
                                  id: UuidGenerator.uuid(),
                                  name: _personNameController.text,
                                  isNew: true,
                                );
                                HiveGroupUser _hiveGroupUser = HiveGroupUser(
                                  groupId: _hiveGroup!.id,
                                  userId: _hiveUser.id,
                                  role: GroupUser_Role.LEARNER.value,
                                  isNew: true,
                                );
                                _newInvitedUsers.add(_hiveUser);
                                _newInvitedGroupUsers.add(_hiveGroupUser);

                                _personNameController.text = '';
                              });
                            }
                          },
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
                    // Discard any change in local group user roles i.e. HiveGroupUser box
                    // _filteredContactList.clear();
                    // _loadContacts();
                    _query = '';
                    Navigator.of(context).pop();
                  },
                  child: Text(_appLocalizations.cancel),
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
                        ? _appLocalizations.update
                        : _appLocalizations.create,
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
      _appLocalizations.history,
      style: TextStyle(
        fontFamily: 'OpenSans',
        fontWeight: FontWeight.bold,
        fontSize: 21.5.sp,
        color: Color(0xFF3475F0),
      ),
    );
    _widgetList.add(header);

    for (HiveEdit edit in group.editHistory ?? []) {
      _widgetList.add(HistoryItem(edit: edit, type: _appLocalizations.group));
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
                title: _appLocalizations.dialogAlert,
                message: _appLocalizations.alertGroupCanNotBeWithoutAdmin,
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
                title: _appLocalizations.dialogAlert,
                message: _appLocalizations.alertGroupCanNotBeWithoutAdmin,
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
          onInvite: (HiveUser _user) {
            if (_checkIfUserPhonenumberAlreadySelected(_user)) {
              StarfishSnackbar.showErrorMessage(
                  context, _appLocalizations.phonenumberAlreadyAdded);
              return;
            }
            SMS.send(
                _appLocalizations.inviteSMS.insertTemplateValues({
                  'receiver_first_name': _user.name ?? '',
                  'sender_name': CurrentUserProvider().user.name!
                }),
                _user.phoneWithDialingCode);
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

  _dismissFieldFocus() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }
}
