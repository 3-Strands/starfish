import 'package:contacts_service/contacts_service.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
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
import 'package:starfish/db/hive_database.dart';
import 'package:starfish/db/hive_edit.dart';
import 'package:starfish/db/hive_evaluation_category.dart';
import 'package:starfish/db/hive_group.dart';
import 'package:starfish/db/hive_language.dart';
import 'package:starfish/models/invite_contact.dart';
import 'package:starfish/select_items/select_drop_down.dart';
import 'package:starfish/utils/helpers/alerts.dart';
import 'package:starfish/utils/helpers/snackbar.dart';
import 'package:starfish/widgets/app_logo_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starfish/widgets/contact_list_item.dart';
import 'package:starfish/widgets/history_item.dart';
import 'package:starfish/widgets/searchbar_widget.dart';

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

  bool _isEditMode = false;

  List<HiveLanguage> _selectedLanguages = [];
  List<HiveEvaluationCategory> _selectedEvaluationCategories = [];
  List<InviteContact> _selectedContacts = [];
  //List<InviteContact> _contactList = [];
  List<InviteContact> _filteredContactList = [];

  late Box<HiveLanguage> _languageBox;
  //late Box<HiveGroup> _groupBox;
  late Box<HiveEvaluationCategory> _evaluationCategoryBox;

  late AppBloc bloc;

  Future<void> _checkPermissionsAndShowContact() async {
    PermissionStatus permissionStatus = await _getContactPermission();
    if (permissionStatus == PermissionStatus.granted) {
      print('Show Contact List');
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
    String _result = await sendSMS(message: message, recipients: _recipentsList)
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
          return ListView.builder(
            itemCount: _filteredContactList.length,
            itemBuilder: (BuildContext context, int index) {
              return ContactListItem(
                contact: _filteredContactList.elementAt(index),
                onTap: (InviteContact contact) {
                  setState(() {
                    if (!contact.isSelected &&
                        _selectedContacts.contains(contact)) {
                      _selectedContacts.remove(contact);
                    } else {
                      _selectedContacts.add(contact);
                    }
                  });
                },
              );
            },
          );
        },
      ),
    );
  }

  Future<List<InviteContact>> _loadContacts() async {
    ContactsService.getContacts().then((List<Contact> contactList) {
      List<InviteContact> _contactList = [];
      contactList.forEach((Contact contact) {
        _contactList.add(InviteContact(contact: contact));
        _filteredContactList.add(InviteContact(contact: contact));
      });
      _contactsNotifier.value = _contactList;
    });

    return _filteredContactList;
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
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return Container(
            margin: EdgeInsets.only(top: 40.h),
            height: MediaQuery.of(context).size.height * 0.70,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 15.0.w, right: 15.0.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          Strings.selectPropleToInvite,
                          textAlign: TextAlign.left,
                          style: titleTextStyle,
                        ),
                        SizedBox(height: 11.h),
                        SearchBar(
                            onValueChanged: (String value) {
                              if (value.isEmpty) {
                                return;
                              }
                              setState(() {
                                _filteredContactList = _contactsNotifier.value!
                                    .where((InviteContact inviteContact) {
                                  return inviteContact.contact.displayName !=
                                          null
                                      ? inviteContact.contact.displayName!
                                          .toLowerCase()
                                          .contains(value.toLowerCase())
                                      : false;
                                }).toList();
                              });
                            },
                            onDone: (String value) {}),
                        SizedBox(height: 11.h),
                        Expanded(
                          child: _buildSlidingUpPanel(),
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
                          child: Text(Strings.cancel),
                        ),
                      ),
                      SizedBox(width: 25.w),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            _sendInviteSMS(
                                Strings.inviteSMS, _selectedContacts);
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
    );
  }

  @override
  void initState() {
    super.initState();
    _languageBox = Hive.box<HiveLanguage>(HiveDatabase.LANGUAGE_BOX);
    //_groupBox = Hive.box<HiveGroup>(HiveDatabase.GROUP_BOX);
    _evaluationCategoryBox = Hive.box<HiveEvaluationCategory>(
        HiveDatabase.EVALUATION_CATEGORIES_BOX);

    Permission.contacts.status.then((PermissionStatus permissionStatus) {
      if (permissionStatus == PermissionStatus.granted) {
        _loadContacts();
      }
    });

    if (widget.group != null) {
      _isEditMode = true;

      _titleController.text = widget.group!.name!;
      //_descriptionController.text = widget.group!.description!;

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
                icon: SvgPicture.asset(AssetsPath.settingsActive),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _titleController,
                  keyboardType: TextInputType.text,
                  style: formTitleTextStyle,
                  decoration: InputDecoration(
                    hintText: Strings.hintGroupName,
                    hintStyle: formTitleHintStyle,
                    contentPadding: EdgeInsets.fromLTRB(0.w, 0.0, 5.0.w, 0.0),
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
                    fillColor: Colors.transparent,
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
                TextFormField(
                  maxLines: 4,
                  controller: _descriptionController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.fromLTRB(15.0.w, 0.0, 5.0.w, 0.0),
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
                    fillColor: AppColors.txtFieldBackground,
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
                    choice: SelectType.multiple,
                    dataSource: DataSourceType.languages,
                    onDoneClicked: <T>(languages) {
                      setState(() {
                        _selectedLanguages = languages as List<HiveLanguage>;
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
                    choice: SelectType.multiple,
                    dataSource: DataSourceType.evaluationCategory,
                    onDoneClicked: <T>(categories) {
                      setState(() {
                        _selectedEvaluationCategories =
                            categories as List<HiveEvaluationCategory>;
                        // print("Selected types ==>> $types");
                      });
                    },
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  Strings.hintEvaluateProgress,
                  textAlign: TextAlign.left,
                  style: italicDetailTextTextStyle,
                ),
                SizedBox(height: 11.h),

                // Option 1.
                Text(
                  Strings.invitePeopleFromContactsList,
                  textAlign: TextAlign.left,
                  style: titleTextStyle,
                ),
                SizedBox(height: 11.h),
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

                // Option 2.
                Text(
                  Strings.addWithoutInvite,
                  textAlign: TextAlign.left,
                  style: titleTextStyle,
                ),
                SizedBox(height: 11.h),
                TextFormField(
                  keyboardType: TextInputType.text,
                  style: textFormFieldText,
                  decoration: InputDecoration(
                    hintText: Strings.hintPersonName,
                    hintStyle: textFormFieldText,
                    contentPadding: EdgeInsets.fromLTRB(5.w, 5.0, 5.0.w, 5.0),
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
                if (widget.group != null) _editHistoryContainer(widget.group),

                SizedBox(height: 11.h),
              ],
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
                  Navigator.of(context).pop();
                },
                child: Text(Strings.cancel),
              ),
            ),
            SizedBox(width: 25.w),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  HiveGroup _hiveGroup = HiveGroup(
                    name: _titleController.text,
                    //description: _descriptionController.text,
                    languageIds: _selectedLanguages
                        .map((HiveLanguage language) => language.id)
                        .toList(),
                    evaluationCategoryIds: _selectedEvaluationCategories
                        .map((HiveEvaluationCategory category) => category.id!)
                        .toList(),
                  );

                  if (_isEditMode) {
                    _hiveGroup.id = widget.group?.id;

                    _hiveGroup.isUpdated = true;
                  } else {
                    _hiveGroup.isNew = true;
                  }

                  bloc.groupBloc
                      .addEditMaterial(_hiveGroup)
                      .then((value) => print('$value record(s) saved.'))
                      .onError((error, stackTrace) {
                    print('Error: ${error.toString()}.');
                    StarfishSnackbar.showErrorMessage(
                        context,
                        _isEditMode
                            ? Strings.updateGroupFailed
                            : Strings.createGroupSuccess);
                  }).whenComplete(() {
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
      'History',
      style: TextStyle(
        fontFamily: 'OpenSans',
        fontWeight: FontWeight.bold,
        fontSize: 18.sp,
        color: Color(0xFF3475F0),
      ),
    );
    _widgetList.add(header);

    for (HiveEdit edit in group.editHistory!) {
      _widgetList.add(HistoryItem(edit: edit));
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
