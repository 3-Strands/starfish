import 'package:contacts_service/contacts_service.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
// ignore: implementation_imports
import 'package:flutter/src/widgets/basic.dart' as widgets;
import 'package:fbroadcast/fbroadcast.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:starfish/bloc/app_bloc.dart';
import 'package:starfish/bloc/provider.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:starfish/constants/assets_path.dart';
import 'package:starfish/constants/strings.dart';
import 'package:starfish/constants/text_styles.dart';
import 'package:starfish/db/hive_current_user.dart';
import 'package:starfish/db/hive_database.dart';
import 'package:starfish/db/hive_edit.dart';
import 'package:starfish/db/hive_evaluation_category.dart';
import 'package:starfish/db/hive_group.dart';
import 'package:starfish/db/hive_group_user.dart';
import 'package:starfish/db/hive_language.dart';
import 'package:starfish/db/hive_user.dart';
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

  bool _isEditMode = false;
  String _query = '';

  List<HiveLanguage> _selectedLanguages = [];
  List<HiveEvaluationCategory> _selectedEvaluationCategories = [];
  List<InviteContact> _selectedContacts = [];
  List<String> _unInvitedPersonNames = [];
  //List<InviteContact> _contactList = [];
  List<InviteContact> _filteredContactList = [];

  late Box<HiveLanguage> _languageBox;
  //late Box<HiveGroup> _groupBox;
  late Box<HiveEvaluationCategory> _evaluationCategoryBox;
  late Box<HiveUser> _userBox;

  late List<HiveLanguage> _languageList;
  late List<HiveEvaluationCategory> _evaluationCategoryList;

  late AppBloc bloc;

  @override
  void initState() {
    super.initState();
    _languageBox = Hive.box<HiveLanguage>(HiveDatabase.LANGUAGE_BOX);
    //_groupBox = Hive.box<HiveGroup>(HiveDatabase.GROUP_BOX);

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
      final snackBar = SnackBar(content: Text('Access to contact data denied'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if (permissionStatus == PermissionStatus.permanentlyDenied) {
      final snackBar =
          SnackBar(content: Text('Contact data not available on device'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  _createUserAndSendInvite(List<InviteContact> _contacts) {
    List<HiveUser> _users = [];
    _contacts.forEach((element) {
      _users.add(HiveUser(
          id: UuidGenerator.uuid(),
          name: element.contact.displayName,
          phone: element.contact.phones!.first.value!));
    });
    _userBox.addAll(_users).then((value) {
      // TODO: add these users to the group being created.
      _sendInviteSMS(Strings.inviteSMS, _contacts);
    });
  }

  void _sendInviteSMS(String message, List<InviteContact> recipents) async {
    List<String> _recipentsList = [];
    recipents.forEach((element) {
      if (element.contact.phones != null) {
        _recipentsList.add(element.contact.phones!.first.value!);
      }
    });
    if (_recipentsList.length == 0) {
      return;
    }
    sendSms(message, _recipentsList);
  }

  sendSms(String message, List<String> phoneNumbers) async {
    String _result = await sendSMS(message: message, recipients: phoneNumbers)
        .catchError((onError) {
      print('Send SMS Error');
    });
    print('Send SMS Result: $_result');
  }

  Widget _buildSlidingUpPanel() {
    return Container(
      //margin: EdgeInsets.only(left: 15.0.w, top: 40.h, right: 15.0.w),

      child: ValueListenableBuilder<List<InviteContact>?>(
          valueListenable: _contactsNotifier,
          builder: (BuildContext context, List<InviteContact>? snapshot,
              Widget? child) {
            if (snapshot == null) {
              return Center(
                child: Text(Strings.loading),
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
              thickness: 5.sp,
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
        if (contact.phones != null) {
          _contactList.add(InviteContact(contact: contact));
          // _filteredContactList.add(InviteContact(contact: contact));
        }
      });
      _contactsNotifier.value = _contactList;
    });

    //return _filteredContactList ?;
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
                    // margin: EdgeInsets.only(left: 15.0.w, right: 15.0.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        widgets.Padding(
                          padding: EdgeInsets.only(left: 15.0.w, right: 15.0.w),
                          child: Text(
                            Strings.selectPropleToInvite,
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
                            onDone: (String value) {}),
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
                            // _filteredContactList.clear();
                            // _loadContacts();
                            Navigator.pop(context);
                          },
                          child: Text(Strings.cancel),
                        ),
                      ),
                      SizedBox(width: 25.w),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            //_createUserAndSendInvite(_selectedContacts);
                            _query = '';
                            Navigator.of(context).pop();
                          },
                          style: ElevatedButton.styleFrom(
                            primary: AppColors.selectedButtonBG,
                          ),
                          child: Text(Strings.invite),
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
      print('Hey there, I\'m calling after hide bottomSheet');
      _query = '';
      FocusScope.of(context).requestFocus(new FocusNode());
    });
  }

  _validateAndCreateUpdateGroup() {
    if (_titleController.text.isEmpty) {
      StarfishSnackbar.showErrorMessage(context, Strings.emptyGroupTitle);
    } else if (_descriptionController.text.isEmpty) {
      StarfishSnackbar.showErrorMessage(context, Strings.emptyDescription);
    } else if (_selectedLanguages.length == 0) {
      StarfishSnackbar.showErrorMessage(context, Strings.emptySelectLanguage);
    } else if (_selectedEvaluationCategories.length == 0) {
      StarfishSnackbar.showErrorMessage(context, Strings.emptyEvaluateProgress);
    } else {
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
    // Add self as Admin, without this local added records will not be filtered
    // based on role hence will not be visible
    HiveCurrentUser _currentUser =
        await CurrentUserRepository().getUserFromDB();
    _newGroupUsers.add(HiveGroupUser(
      groupId: _groupId,
      userId: _currentUser.id,
      role: GroupUser_Role.ADMIN.value,
      isNew: true,
    ));
    _newUsers.forEach((HiveUser user) async {
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
        _sendInviteSMS(Strings.inviteSMS, _selectedContacts);
      }
    });

    HiveGroup? _hiveGroup;

    if (_isEditMode) {
      _hiveGroup = widget.group!;
      _hiveGroup.users?.addAll(_newGroupUsers);

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
    _hiveGroup
      ..evaluationCategoryIds = _selectedEvaluationCategories
          .map((HiveEvaluationCategory category) => category.id!)
          .toList();

    bloc.groupBloc
        .addEditGroup(_hiveGroup)
        .then((value) => print('record(s) saved.'))
        .onError((error, stackTrace) {
      print('Error: ${error.toString()}.');
      StarfishSnackbar.showErrorMessage(context,
          _isEditMode ? Strings.updateGroupFailed : Strings.createGroupSuccess);
    }).whenComplete(() {
      // Broadcast to sync the local changes with the server
      FBroadcast.instance().broadcast(
        SyncService.kUpdateUsers,
        value: _newUsers,
      );
      FBroadcast.instance().broadcast(
        SyncService.kUpdateGroup,
        value: _hiveGroup,
      );
      Alerts.showMessageBox(
          context: context,
          title: Strings.dialogInfo,
          message: _isEditMode
              ? Strings.updateGroupSuccess
              : Strings.createGroupSuccess,
          callback: () {
            Navigator.of(context).pop();
          });
    });
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
                _isEditMode ? Strings.editGroup : Strings.createGroup,
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
          thickness: 5.sp,
          isAlwaysShown: false,
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: TextFormField(
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      controller: _titleController,
                      style: formTitleTextStyle,
                      decoration: InputDecoration(
                        hintText: Strings.hintGroupName,
                        hintStyle: formTitleHintStyle,
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
                    Strings.descripton,
                    textAlign: TextAlign.left,
                    style: titleTextStyle,
                  ),
                  SizedBox(height: 11.h),
                  Container(
                    child: TextFormField(
                      maxLines: 4,
                      controller: _descriptionController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
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
                    Strings.lanugagesUsed,
                    textAlign: TextAlign.left,
                    style: titleTextStyle,
                  ),
                  SizedBox(height: 11.h),
                  Container(
                    child: SelectDropDown(
                      navTitle: Strings.selectLanugages,
                      placeholder: Strings.selectLanugages,
                      selectedValues: _selectedLanguages,
                      dataSource: _languageList,
                      type: SelectType.multiple,
                      dataSourceType: DataSourceType.languages,
                      onDoneClicked: <T>(languages) {
                        setState(() {
                          _selectedLanguages = List<HiveLanguage>.from(
                              languages as List<dynamic>);

                          // _selectedLanguages = languages as List<HiveLanguage>;
                          // print("Selected languages ==>> $_selectedLanguages");
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 21.h),

                  // Evaluate Progress
                  Text(
                    Strings.evaluateProgress,
                    textAlign: TextAlign.left,
                    style: titleTextStyle,
                  ),
                  SizedBox(height: 11.h),
                  Container(
                    child: SelectDropDown(
                        navTitle: Strings.selectCategories,
                        placeholder: Strings.selectCategories,
                        selectedValues: _selectedEvaluationCategories,
                        dataSource: _evaluationCategoryList,
                        type: SelectType.multiple,
                        dataSourceType: DataSourceType.evaluationCategory,
                        onDoneClicked: <T>(categories) {
                          setState(() {
                            _selectedEvaluationCategories =
                                List<HiveEvaluationCategory>.from(
                                    categories as List<dynamic>);

                            // _selectedEvaluationCategories =
                            //     categories as List<HiveEvaluationCategory>;
                            // print("Selected types ==>> $types");
                          });
                        },
                        maxSelectItemLimit: 3),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    Strings.hintEvaluateProgress,
                    maxLines: 3,
                    textAlign: TextAlign.left,
                    style: italicDetailTextTextStyle,
                  ),
                  SizedBox(height: 40.h),

                  // Option 1.
                  Text(
                    Strings.invitePeopleFromContactsList,
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
                          print('Show Contact List');
                          _checkPermissionsAndShowContact();
                        },
                        child: Text(
                          Strings.inviteFromContactsList,
                          style: TextStyle(
                            fontFamily: 'OpenSans',
                            fontSize: 14.sp,
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

                  // Selected Contacts
                  Visibility(
                    child: Column(
                      children: _invitedContactsContainer(_selectedContacts),
                    ),
                    visible: _selectedContacts.toList().length > 0,
                  ),

                  if (_isEditMode &&
                      widget.group!.activeUsers
                              ?.where((element) => !element.isInvited)
                              .toList() !=
                          null)
                    Column(
                      children: _invitedGroupMembersContainer(widget
                          .group!.activeUsers!
                          .where((element) => !element.isInvited)
                          .toList()),
                    ),

                  // Option 2.
                  Text(
                    Strings.addWithoutInvite,
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
                              hintText: Strings.hintPersonName,
                              hintStyle: textFormFieldText,
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
                  // Selection persion without invite
                  Visibility(
                    child: Column(
                      children:
                          _unInvitedContactsContainer(_unInvitedPersonNames),
                    ),
                    visible: _unInvitedPersonNames.toList().length > 0,
                  ),

                  if (_isEditMode &&
                      widget.group!.activeUsers
                              ?.where((element) => element.isInvited)
                              .toList() !=
                          null)
                    Column(
                      children: _unInvitedGroupMembersContainer(widget
                          .group!.activeUsers!
                          .where((element) => element.isInvited)
                          .toList()),
                    ),
                  if (widget.group?.editHistory != null)
                    _editHistoryContainer(widget.group),

                  SizedBox(height: 59.h),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 75.h,
        padding: EdgeInsets.symmetric(vertical: 18.75.h, horizontal: 30.w),
        color: AppColors.txtFieldBackground,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  // _filteredContactList.clear();
                  // _loadContacts();
                  _query = '';
                  Navigator.of(context).pop();
                },
                child: Text(Strings.cancel),
              ),
            ),
            SizedBox(width: 25.w),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  _validateAndCreateUpdateGroup();
                },
                child: Text(
                  _isEditMode ? Strings.update : Strings.create,
                ),
                style: ElevatedButton.styleFrom(
                  primary: AppColors.selectedButtonBG,
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
      Strings.history,
      style: TextStyle(
        fontFamily: 'OpenSans',
        fontWeight: FontWeight.bold,
        fontSize: 18.sp,
        color: Color(0xFF3475F0),
      ),
    );
    _widgetList.add(header);

    for (HiveEdit edit in group.editHistory ?? []) {
      _widgetList.add(HistoryItem(edit: edit));
    }

    return _widgetList;
  }

  List<Widget> _invitedContactsContainer(List<InviteContact> invitedContacts) {
    final List<Widget> _widgetList = [];

    invitedContacts.sort((a, b) => a.contact.displayName!
        .toLowerCase()
        .compareTo(b.contact.displayName!.toLowerCase()));
    for (InviteContact inviteContact in invitedContacts) {
      _widgetList.add(InvitedContactListItem(contact: inviteContact));
    }
    // Additional vertical spacing
    if (_widgetList.length > 0) {
      _widgetList.add(SizedBox(
        height: 21.h,
      ));
    }

    return _widgetList;
  }

  List<Widget> _invitedGroupMembersContainer(List<HiveGroupUser> groupUsers) {
    final List<Widget> _widgetList = [];

    groupUsers
        .sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
    for (HiveGroupUser groupUser in groupUsers) {
      _widgetList.add(GroupMemberListItem(groupUser: groupUser));
    }
    // Additional vertical spacing
    if (_widgetList.length > 0) {
      _widgetList.add(SizedBox(
        height: 21.h,
      ));
    }

    return _widgetList;
  }

  List<Widget> _unInvitedContactsContainer(List<String> unInvitedPersons) {
    final List<Widget> _widgetList = [];
    unInvitedPersons.sort((a, b) => a.toLowerCase().compareTo(b.toLowerCase()));

    for (String person in unInvitedPersons) {
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
      _widgetList.add(SizedBox(
        height: 21.h,
      ));
    } else {
      _widgetList.add(Container());
    }

    return _widgetList;
  }

  List<Widget> _unInvitedGroupMembersContainer(List<HiveGroupUser> groupUsers) {
    final List<Widget> _widgetList = [];
    groupUsers.sort((a, b) => a.name.compareTo(b.name));

    for (HiveGroupUser groupUser in groupUsers) {
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
            sendSms(Strings.inviteSMS, [_user.phoneWithDialingCode]);
          },
        ),
      );
    }
    // Additional vertical spacing
    if (_widgetList.length > 0) {
      _widgetList.add(SizedBox(
        height: 21.h,
      ));
    } else {
      _widgetList.add(Container());
    }

    return _widgetList;
  }

  _dismissFieldFocus() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }
}
