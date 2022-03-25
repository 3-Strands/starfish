import 'package:contacts_service/contacts_service.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
// ignore: implementation_imports
import 'package:flutter/src/widgets/basic.dart' as widgets;
// ignore: import_of_legacy_library_into_null_safe
import 'package:fbroadcast/fbroadcast.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:starfish/bloc/app_bloc.dart';
import 'package:starfish/bloc/provider.dart';
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
import 'package:starfish/models/invite_contact.dart';
import 'package:starfish/modules/settings_view/settings_view.dart';
import 'package:starfish/repository/current_user_repository.dart';
import 'package:starfish/repository/user_repository.dart';
import 'package:starfish/select_items/select_drop_down.dart';
import 'package:starfish/src/generated/starfish.pb.dart';
import 'package:starfish/utils/helpers/alerts.dart';
import 'package:starfish/utils/helpers/snackbar.dart';
import 'package:starfish/utils/helpers/uuid_generator.dart';
import 'package:starfish/utils/services/sync_service.dart';
import 'package:starfish/widgets/app_logo_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starfish/widgets/contact_list_item.dart';
import 'package:starfish/widgets/group_member_list_item.dart';
import 'package:starfish/widgets/history_item.dart';
import 'package:starfish/widgets/invited_contact_list_item.dart';
import 'package:starfish/widgets/searchbar_widget.dart';
import 'package:starfish/widgets/uninvited_group_member_list_item.dart';
import 'package:starfish/widgets/uninvited_person_list_item.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:telephony/telephony.dart';
import 'package:template_string/template_string.dart';

class AddEditGroupScreen extends StatefulWidget {
  final HiveGroup? group;
  AddEditGroupScreen({
    Key? key,
    this.group,
  }) : super(key: key);

  @override
  _AddEditGroupScreenState createState() => _AddEditGroupScreenState();
}

class _AddEditGroupScreenState extends State<AddEditGroupScreen> {
  final ValueNotifier<List<InviteContact>?> _contactsNotifier =
      ValueNotifier(null);

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _personNameController = TextEditingController();

  final _telephony = Telephony.instance;

  bool _isEditMode = false;
  String _query = '';

  List<HiveLanguage> _selectedLanguages = [];
  List<HiveEvaluationCategory> _selectedEvaluationCategories = [];
  List<InviteContact> _selectedContacts = [];
  List<String> _unInvitedPersonNames = [];

  late Box<HiveLanguage> _languageBox;
  late Box<HiveEvaluationCategory> _evaluationCategoryBox;
  late Box<HiveUser> _userBox;

  late List<HiveLanguage> _languageList;
  late List<HiveEvaluationCategory> _evaluationCategoryList;

  late AppBloc bloc;

  @override
  void initState() {
    super.initState();

    _languageBox = Hive.box<HiveLanguage>(HiveDatabase.LANGUAGE_BOX);

    _evaluationCategoryBox = Hive.box<HiveEvaluationCategory>(
        HiveDatabase.EVALUATION_CATEGORIES_BOX);
    _userBox = Hive.box<HiveUser>(HiveDatabase.USER_BOX);

    _getAllLanguages();
    _getAllEvaluationCategories();

    Permission.contacts.status.then((PermissionStatus permissionStatus) {
      if (permissionStatus == PermissionStatus.granted) {
        _loadContacts();
      }
    });

    if (widget.group != null) {
      _isEditMode = true;

      _titleController.text = widget.group!.name ?? '';
      _descriptionController.text = widget.group!.description ?? '';

      _selectedLanguages = _languageBox.values
          .where((HiveLanguage language) =>
              widget.group!.languageIds!.contains(language.id))
          .toList();

      _selectedEvaluationCategories = _evaluationCategoryBox.values
          .where((HiveEvaluationCategory category) => widget.group != null
              ? widget.group!.evaluationCategoryIds!.contains(category.id)
              : false)
          .toList();
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
    PermissionStatus permissionStatus = await _getContactPermission();
    if (permissionStatus == PermissionStatus.granted) {
      _showContactList();
    } else {
      _handleInvalidPermissions(permissionStatus);
    }
  }

  Future<PermissionStatus> _getContactPermission() async {
    PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.permanentlyDenied) {
      PermissionStatus permissionStatus = await Permission.contacts.request();
      if (permissionStatus.isGranted) {
        _loadContacts();
      }
      return permissionStatus;
    } else {
      return permission;
    }
  }

  void _handleInvalidPermissions(PermissionStatus permissionStatus) {
    if (permissionStatus == PermissionStatus.denied) {
      final snackBar = SnackBar(
          content: Text(AppLocalizations.of(context)!.contactAccessDenied));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if (permissionStatus == PermissionStatus.permanentlyDenied) {
      final snackBar = SnackBar(
          content: Text(AppLocalizations.of(context)!.contactDataNotAvailable));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  void _sendInviteSMS(String message, List<InviteContact> recipents) async {
    bool _permissionsGranted = await _telephony.requestSmsPermissions ?? false;
    if (!_permissionsGranted) {
      return;
    }

    recipents.forEach((element) {
      if (element.contact.phones != null) {
        sendSms(
            message.insertTemplateValues({
              'receiver_first_name': element.contact.displayName ??
                  element.contact.givenName ??
                  '',
              'sender_name': CurrentUserProvider().user.name!
            }),
            element.contact.phones!.first.value!);
      }
    });
  }

  sendSms(String message, String phoneNumber) async {
    _telephony.sendSms(
        to: phoneNumber,
        message: message,
        statusListener: (sendStatus) {
          debugPrint(
              'Status of Invitation Send to [$phoneNumber]: $sendStatus');
        },
        isMultipart: true);
  }

  Widget _buildSlidingUpPanel() {
    return Container(
      child: ValueListenableBuilder<List<InviteContact>?>(
          valueListenable: _contactsNotifier,
          builder: (BuildContext context, List<InviteContact>? snapshot,
              Widget? child) {
            if (snapshot == null) {
              return Center(
                child: Text(AppLocalizations.of(context)!.loading),
              );
            }
            List<InviteContact> _listToShow = [];

            if (_query.isNotEmpty) {
              _listToShow = snapshot
                  .where((data) =>
                      (data.contact.displayName ?? '')
                          .toLowerCase()
                          .contains(_query.toLowerCase()) ||
                      (data.contact.displayName ?? '')
                          .toLowerCase()
                          .startsWith(_query.toLowerCase()))
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
                        onTap: (InviteContact contact) {
                          setState(() {
                            if (!contact.isSelected &&
                                _selectedContacts.contains(contact)) {
                              _selectedContacts.remove(contact);
                            } else {
                              _selectedContacts.add(contact);
                            }
                          });
                        });
                  }),
            );
          }),
    );
  }

  _loadContacts() async {
    ContactsService.getContacts().then((List<Contact> contactList) {
      List<InviteContact> _contactList = [];
      contactList.forEach((Contact contact) {
        // Add only contacts having atleast one phone numbers added
        if (contact.phones != null && contact.phones!.length > 0) {
          _contactList.add(InviteContact(contact: contact));
        }
      });
      _contactsNotifier.value = _contactList;
    });
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
                            AppLocalizations.of(context)!.selectPropleToInvite,
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
                          child: Text(AppLocalizations.of(context)!.cancel),
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
                          child: Text(AppLocalizations.of(context)!.invite),
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

  _validateAndCreateUpdateGroup() {
    if (_titleController.text.isEmpty) {
      StarfishSnackbar.showErrorMessage(
          context, AppLocalizations.of(context)!.emptyGroupTitle);
    } else if (_descriptionController.text.isEmpty) {
      StarfishSnackbar.showErrorMessage(
          context, AppLocalizations.of(context)!.emptyDescription);
    } /* else if (_selectedLanguages.length == 0) {
      StarfishSnackbar.showErrorMessage(
          context, AppLocalizations.of(context)!.emptySelectLanguage);
    } else if (_selectedEvaluationCategories.length == 0) {
      StarfishSnackbar.showErrorMessage(
          context, AppLocalizations.of(context)!.emptyEvaluateProgress);
    }*/
    else {
      _createUpdateGroup();
    }
  }

  _createUpdateGroup() async {
    String? _groupId;
    if (_isEditMode) {
      _groupId = widget.group?.id;
    } else {
      _groupId = UuidGenerator.uuid(); // Assign UUID
    }
    List<HiveUser> _newUsers = [];
    _selectedContacts.forEach((element) {
      HiveUser _hiveUser = element.createHiveUser();
      // set dialing code of the current User
      //_hiveUser.diallingCode = CurrentUserProvider().getUserSync().diallingCode;
      _hiveUser.linkGroups = true;
      _hiveUser.isNew = true;

      _newUsers.add(_hiveUser);
    });
    _unInvitedPersonNames.forEach((element) {
      _newUsers.add(HiveUser(
          id: UuidGenerator.uuid(),
          name: element,
          linkGroups: true,
          isNew: true));
    });

    List<HiveGroupUser> _newGroupUsers = [];
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
    await Future.forEach(_newUsers, (HiveUser user) async {
      try {
        await UserRepository().createUpdateUserInDB(user);

        _newGroupUsers.add(HiveGroupUser(
          groupId: _groupId,
          userId: user.id,
          role: GroupUser_Role.LEARNER.value,
          isNew: true,
        ));
      } catch (error) {}

      if (_selectedContacts.length > 0) {
        _sendInviteSMS(
            AppLocalizations.of(context)!.inviteSMS, _selectedContacts);
      }
    });

    HiveGroup? _hiveGroup;

    if (_isEditMode) {
      _hiveGroup = widget.group!;
      //_hiveGroup.users?.addAll(_newGroupUsers);

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
          title: AppLocalizations.of(context)!.dialogInfo,
          message: _isEditMode
              ? AppLocalizations.of(context)!.updateGroupSuccess
              : AppLocalizations.of(context)!.createGroupSuccess,
          callback: () {
            Navigator.of(context).pop();
          });
    }).onError((error, stackTrace) {
      StarfishSnackbar.showErrorMessage(
          context,
          _isEditMode
              ? AppLocalizations.of(context)!.updateGroupFailed
              : AppLocalizations.of(context)!.createGroupSuccess);
    }).whenComplete(() {});
  }

  @override
  Widget build(BuildContext context) {
    bloc = Provider.of(context);
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
                    ? AppLocalizations.of(context)!.editGroup
                    : AppLocalizations.of(context)!.createGroup,
                style: dashboardNavigationTitle,
              ),
              IconButton(
                icon: SvgPicture.asset(AssetsPath.settings),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SettingsScreen(),
                    ),
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
                    AppLocalizations.of(context)!.groupName,
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
                        labelText: AppLocalizations.of(context)!.hintGroupName,
                        labelStyle: formTitleHintStyle,
                        alignLabelWithHint: true,
                        // hintText: AppLocalizations.of(context)!.hintGroupName,
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
                    AppLocalizations.of(context)!.descripton,
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
                        labelText:
                            AppLocalizations.of(context)!.hintGroupDescription,
                        labelStyle: formTitleHintStyle,
                        alignLabelWithHint: true,
                        // hintText:
                        //     AppLocalizations.of(context)!.hintGroupDescription,
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
                    _isEditMode
                        ? AppLocalizations.of(context)!.lanugagesUsed
                        : AppLocalizations.of(context)!.lanugagesUsedOptional,
                    textAlign: TextAlign.left,
                    style: titleTextStyle,
                  ),
                  SizedBox(height: 11.h),
                  Container(
                    child: SelectDropDown(
                      navTitle: AppLocalizations.of(context)!.selectLanugages,
                      placeholder:
                          AppLocalizations.of(context)!.selectLanugages,
                      selectedValues: _selectedLanguages,
                      dataSource: _languageList,
                      type: SelectType.multiple,
                      dataSourceType: DataSourceType.languages,
                      onDoneClicked: <T>(languages) {
                        setState(() {
                          _selectedLanguages = List<HiveLanguage>.from(
                              languages as List<dynamic>);
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 21.h),

                  // Evaluate Progress
                  Text(
                    _isEditMode
                        ? AppLocalizations.of(context)!.evaluateProgress
                        : AppLocalizations.of(context)!
                            .evaluateProgressOptional,
                    textAlign: TextAlign.left,
                    style: titleTextStyle,
                  ),
                  SizedBox(height: 11.h),
                  Container(
                    child: SelectDropDown(
                        navTitle:
                            AppLocalizations.of(context)!.selectCategories,
                        placeholder:
                            AppLocalizations.of(context)!.selectCategories,
                        selectedValues: _selectedEvaluationCategories,
                        dataSource: _evaluationCategoryList,
                        type: SelectType.multiple,
                        dataSourceType: DataSourceType.evaluationCategory,
                        onDoneClicked: <T>(categories) {
                          setState(() {
                            _selectedEvaluationCategories =
                                List<HiveEvaluationCategory>.from(
                                    categories as List<dynamic>);
                          });
                        },
                        maxSelectItemLimit: 3),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    AppLocalizations.of(context)!.hintEvaluateProgress,
                    textAlign: TextAlign.left,
                    style: italicDetailTextTextStyle,
                  ),
                  SizedBox(height: 40.h),

                  // Option 1.
                  Text(
                    AppLocalizations.of(context)!.invitePeopleFromContactsList,
                    textAlign: TextAlign.left,
                    style: titleTextStyle,
                  ),
                  SizedBox(height: 20.h),
                  DottedBorder(
                    borderType: BorderType.RRect,
                    radius: Radius.circular(30.r),
                    color: Color(0xFF3475F0),
                    child: Container(
                      width: double.infinity,
                      height: 50.h,
                      child: ElevatedButton(
                        onPressed: () {
                          _checkPermissionsAndShowContact();
                        },
                        child: Text(
                          AppLocalizations.of(context)!.inviteFromContactsList,
                          style: TextStyle(
                            fontFamily: 'OpenSans',
                            fontSize: 17.sp,
                            color: Color(0xFF3475F0),
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.transparent,
                          shadowColor: Colors.transparent,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 21.h),

                  _invitedGroupMembersContainer(),
                  _invitedContactsContainer(),
                  // Option 2.
                  Text(
                    AppLocalizations.of(context)!.addWithoutInvite,
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
                              labelText:
                                  AppLocalizations.of(context)!.hintPersonName,
                              labelStyle: formTitleHintStyle,
                              alignLabelWithHint: true,
                              // hintText:
                              //     AppLocalizations.of(context)!.hintPersonName,
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
                                _unInvitedPersonNames
                                    .add(_personNameController.text);

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
                    SizedBox(height: 75.h,)
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: Container(
        height: 75.h,
       // padding: EdgeInsets.symmetric(vertical: 18.75.h, horizontal: 30.w),
        color: AppColors.txtFieldBackground,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 10.h ),
                child: ElevatedButton(
                  onPressed: () {
                    // _filteredContactList.clear();
                    // _loadContacts();
                    _query = '';
                    Navigator.of(context).pop();
                  },
                  child: Text(AppLocalizations.of(context)!.cancel),
                ),
              ),
            ),
            SizedBox(width: 25.w),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(right: 10.h ),
                child: ElevatedButton(
                  onPressed: () {
                    _validateAndCreateUpdateGroup();
                  },
                  child: Text(
                    _isEditMode
                        ? AppLocalizations.of(context)!.update
                        : AppLocalizations.of(context)!.create,
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
      AppLocalizations.of(context)!.history,
      style: TextStyle(
        fontFamily: 'OpenSans',
        fontWeight: FontWeight.bold,
        fontSize: 21.5.sp,
        color: Color(0xFF3475F0),
      ),
    );
    _widgetList.add(header);

    for (HiveEdit edit in group.editHistory ?? []) {
      _widgetList.add(
          HistoryItem(edit: edit, type: AppLocalizations.of(context)!.group));
    }

    return _widgetList;
  }

  Widget _invitedContactsContainer() {
    final List<Widget> _widgetList = [];

    _selectedContacts.sort((a, b) => a.contact.displayName!
        .toLowerCase()
        .compareTo(b.contact.displayName!.toLowerCase()));
    for (InviteContact inviteContact in _selectedContacts) {
      _widgetList.add(InvitedContactListItem(contact: inviteContact));
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
    List<HiveGroupUser>? _groupUsers = widget.group?.activeUsers
        ?.where((element) =>
            (element.isInvited || element.isActive) && element.phone.isNotEmpty)
        .toList();

    if (_groupUsers == null) {
      return Container();
    }

    final List<Widget> _widgetList = [];

    _groupUsers
        .sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
    for (HiveGroupUser groupUser in _groupUsers) {
      _widgetList.add(
        GroupMemberListItem(
          groupUser: groupUser,
          onChangeUserRole: (HiveGroupUser _groupUser, _groupUserRole) {
            // Check if the removed user is the only ADMIN in the group, if so, display alert else delete it
            if (GroupUser_Role.valueOf(_groupUser.role!) ==
                    GroupUser_Role.ADMIN &&
                widget.group!.admins != null &&
                widget.group!.admins!.length == 1) {
              //show warning
              Alerts.showMessageBox(
                context: context,
                title: AppLocalizations.of(context)!.dialogAlert,
                message: AppLocalizations.of(context)!
                    .alertGroupCanNotBeWithoutAdmin,
                callback: () {
                  Navigator.of(context).pop();
                },
              );
            } else {
              _groupUser.isUpdated = true;
              _groupUser.role = _groupUserRole.value;

              bloc.groupBloc.createUpdateGroupUser(_groupUser);
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
                title: AppLocalizations.of(context)!.dialogAlert,
                message: AppLocalizations.of(context)!
                    .alertGroupCanNotBeWithoutAdmin,
                callback: () {
                  Navigator.of(context).pop();
                },
              );
            } else {
              _groupUser.isDirty = true;
              bloc.groupBloc.createUpdateGroupUser(_groupUser).then((value) {
                setState(() {});
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

  Widget _unInvitedContactsContainer() {
    final List<Widget> _widgetList = [];
    _unInvitedPersonNames
        .sort((a, b) => a.toLowerCase().compareTo(b.toLowerCase()));

    for (String person in _unInvitedPersonNames) {
      _widgetList.add(
        UnInvitedPersonListItem(
          personName: person,
          onRemove: (String person) {
            if (_unInvitedPersonNames.contains(person)) {
              setState(() {
                _unInvitedPersonNames.remove(person);
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
          onRemove: (String person) {
            if (_unInvitedPersonNames.contains(person)) {
              setState(() {
                _unInvitedPersonNames.remove(person);
              });
            }
          },
          onInvite: (HiveUser _user) {
            sendSms(
                AppLocalizations.of(context)!.inviteSMS.insertTemplateValues({
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
