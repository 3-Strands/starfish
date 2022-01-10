import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart' as app;
import 'package:flutter/material.dart' as app;
import 'package:flutter/widgets.dart';
import 'package:grpc/grpc.dart';
import 'package:grpc/grpc_or_grpcweb.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:collection/collection.dart';
import 'package:path_provider/path_provider.dart';
import 'package:starfish/db/hive_action.dart';
import 'package:starfish/db/hive_action_user.dart';
import 'package:starfish/db/hive_country.dart';
import 'package:starfish/db/hive_current_user.dart';
import 'package:starfish/db/hive_database.dart';
import 'package:starfish/db/hive_evaluation_category.dart';
import 'package:starfish/db/hive_file.dart';
import 'package:starfish/db/hive_group.dart';
import 'package:starfish/db/hive_group_user.dart';
import 'package:starfish/db/hive_language.dart';
import 'package:starfish/db/hive_last_sync_date_time.dart';
import 'package:starfish/db/hive_material.dart';
import 'package:starfish/db/hive_material_feedback.dart';
import 'package:starfish/db/hive_material_topic.dart';
import 'package:starfish/db/hive_material_type.dart';
import 'package:starfish/db/hive_user.dart';
import 'package:starfish/db/providers/action_provider.dart';
import 'package:starfish/modules/dashboard/dashboard.dart';
import 'package:starfish/navigation_service.dart';
import 'package:starfish/repository/action_repository.dart';
import 'package:starfish/repository/app_data_repository.dart';
import 'package:starfish/repository/current_user_repository.dart';
import 'package:starfish/repository/group_repository.dart';
import 'package:starfish/repository/materials_repository.dart';
import 'package:starfish/repository/user_repository.dart';
import 'package:starfish/src/generated/file_transfer.pbgrpc.dart';
import 'package:starfish/src/generated/starfish.pb.dart';
import 'package:starfish/utils/services/field_mask.dart';
import 'package:starfish/utils/services/local_storage_service.dart';
import 'package:synchronized/synchronized.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starfish/src/generated/starfish.pb.dart' as starfish;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SyncService {
  final DEBUG = false;
  bool _isDialogShowing = false;

  static final String kUpdateMaterial = 'updateMaterial';
  static final String kUpdateGroup = 'updateGroup';
  static final String kUpdateUsers = 'updateUsers';
  static final String kUpdateActions = 'updateActions';

  // Use this object to prevent concurrent access to data
  var lock = new Lock(reentrant: true);
  static syncNow() {}

  late Box<HiveLastSyncDateTime> lastSyncBox;
  late Box<HiveCountry> countryBox;
  late Box<HiveLanguage> languageBox;
  late Box<HiveCurrentUser> currentUserBox;
  //late Box<HiveGroupUser> groupUserBox;
  late Box<HiveAction> actionBox;
  late Box<HiveMaterial> materialBox;
  late Box<HiveMaterialFeedback> materialFeedbackBox;
  late Box<HiveMaterialTopic> materialTopicBox;
  late Box<HiveMaterialType> materialTypeBox;
  late Box<HiveGroup> groupBox;
  late Box<HiveEvaluationCategory> evaluationCategoryBox;
  late Box<HiveUser> userBox;
  late Box<HiveFile> fileBox;
  late Box<HiveActionUser> actionUserBox;

  SyncService() {
    lastSyncBox = Hive.box<HiveLastSyncDateTime>(HiveDatabase.LAST_SYNC_BOX);
    countryBox = Hive.box<HiveCountry>(HiveDatabase.COUNTRY_BOX);
    languageBox = Hive.box<HiveLanguage>(HiveDatabase.LANGUAGE_BOX);
    currentUserBox = Hive.box<HiveCurrentUser>(HiveDatabase.CURRENT_USER_BOX);
    //groupBox = Hive.box<HiveGroupUser>(HiveDatabase.GROUPS_BOX);
    actionBox = Hive.box<HiveAction>(HiveDatabase.ACTIONS_BOX);
    materialBox = Hive.box<HiveMaterial>(HiveDatabase.MATERIAL_BOX);
    materialFeedbackBox =
        Hive.box<HiveMaterialFeedback>(HiveDatabase.MATERIAL_FEEDBACK_BOX);
    materialTopicBox =
        Hive.box<HiveMaterialTopic>(HiveDatabase.MATERIAL_TOPIC_BOX);
    materialTypeBox =
        Hive.box<HiveMaterialType>(HiveDatabase.MATERIAL_TYPE_BOX);
    groupBox = Hive.box<HiveGroup>(HiveDatabase.GROUP_BOX);
    evaluationCategoryBox = Hive.box<HiveEvaluationCategory>(
        HiveDatabase.EVALUATION_CATEGORIES_BOX);
    userBox = Hive.box<HiveUser>(HiveDatabase.USER_BOX);
    fileBox = Hive.box<HiveFile>(HiveDatabase.FILE_BOX);
    actionUserBox = Hive.box<HiveActionUser>(HiveDatabase.ACTION_USER_BOX);
  }

  void showAlert(BuildContext context) async {
    _isDialogShowing = true;
    await app
        .showDialog(
            context: context,
            builder: (context) => app.CupertinoAlertDialog(
                  title: Text(
                    AppLocalizations.of(context)!.syncAlertTitleText,
                    style: TextStyle(color: app.Color(0xFF030303)),
                  ),
                  content: app.Column(
                    children: [
                      Text(AppLocalizations.of(context)!
                          .syncAlertContentText), // app.SizedBox(height: 10.h),
                      app.SizedBox(
                          width: 20.w,
                          height: 20.h,
                          child: app.CircularProgressIndicator()),
                      // app.SizedBox(height: 5.h),
                      app.Text(
                        AppLocalizations.of(context)!.syncText,
                        style: TextStyle(
                            color: app.Color(0xFF030303), fontSize: 12.sp),
                      )
                    ],
                  ),
                  actions: <Widget>[
                    app.CupertinoDialogAction(
                      child: Text(AppLocalizations.of(context)!.close),
                      onPressed: () {
                        _isDialogShowing =
                            false; // set it `false` since dialog is closed
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ))
        .then((value) => _isDialogShowing = false);
  }

  void hideAlert() {
    if (_isDialogShowing) {
      Future.delayed(Duration(seconds: 2), () {
        _isDialogShowing = false;
        Navigator.of(NavigationService.navigatorKey.currentContext!).pop();
      });
    }
  }

  void showAlertFirstTime() {
    StarfishSharedPreference().isUserLoggedIn().then((status) => {
          if (status)
            {
              StarfishSharedPreference()
                  .isSyncingFirstTimeDone()
                  .then((value) => {
                        StarfishSharedPreference().setIsSyncingFirstTime(true),
                        if (!value)
                          {
                            showAlert(
                                NavigationService.navigatorKey.currentContext!)
                          }
                      })
            }
        });
  }

  void syncAll() async {
    showAlertFirstTime();

    // showAlert(NavigationService.navigatorKey.currentContext!);
    await syncLocalCurrentUser(kCurrentUserFieldMask);
    await syncLocalMaterialsToRemote();

    // Synchronize the syncing of users, groups and group users, sequentily to avoid failure.
    await lock.synchronized(() => syncLocalUsersToRemote());
    await lock.synchronized(() => syncLocalGroupsToRemote());
    await lock.synchronized(() => syncLocalGroupUsersToRemote());
    await lock.synchronized(() => syncLocalActionsToRemote());

    await lock.synchronized(() => syncLocalHiveActionUserToRemote());
    // navigatorKey: Application.navKey, // GlobalKey()
    //showAlert(NavigationService.navigatorKey.currentContext!);

    await lock.synchronized(() => syncLocalFiles()); // Upload local files
    await lock.synchronized(() => syncFiles()); // Download remote files

    syncCurrentUser();
    syncUsers();
    syncCountries();
    syncLanguages();
    syncActions();
    syncMaterialTopics();
    syncMaterialTypes();
    syncMaterial();

    syncEvaluationCategories();
    syncGroup();

    hideAlert();

    updateLastSyncDateTime();
  }

  void updateLastSyncDateTime() {
    DateTime now = DateTime.now();
    HiveLastSyncDateTime _lastSyncDateTime = new HiveLastSyncDateTime(
        year: now.year,
        month: now.month,
        day: now.day,
        hour: now.hour,
        minute: now.minute,
        second: now.second);
    lastSyncBox.clear().then((value) {
      lastSyncBox.add(_lastSyncDateTime);
    });
  }

  void clearAll() async {
    await lastSyncBox.clear();
    //await languageBox.clear();
    await currentUserBox.clear();
    await actionBox.clear();
    await materialBox.clear();
    await groupBox.clear();
    await materialFeedbackBox.clear();
    await materialTopicBox.clear();
    await materialTypeBox.clear();
    await evaluationCategoryBox.clear();
    await userBox.clear();
  }

  Future syncCurrentUser() async {
    await CurrentUserRepository().getUser().then((User user) {
      print("get current user");
      List<HiveGroupUser> groups = (user.groups
          .map((e) => HiveGroupUser(
              groupId: e.groupId, userId: e.userId, role: e.role.value))
          .toList());
      List<HiveActionUser> actions =
          (user.actions.map((e) => HiveActionUser.from(e)).toList());

      HiveCurrentUser _user = HiveCurrentUser(
          id: user.id,
          name: user.name,
          phone: user.phone,
          linkGroups: user.linkGroups,
          countryIds: user.countryIds,
          languageIds: user.languageIds,
          groups: groups,
          actions: actions,
          diallingCode: user.diallingCode,
          phoneCountryId: user.phoneCountryId,
          selectedActionsTab: user.selectedActionsTab.value,
          selectedResultsTab: user.selectedResultsTab.value,
          status: user.status.value,
          creatorId: user.creatorId);

      var filterData = currentUserBox.values
          .where((currentUser) => currentUser.id == user.id)
          .toList();
      if (filterData.length == 0) {
        currentUserBox.add(_user);
      } else {
        //update record
        currentUserBox.putAt(0, _user);
      }

      //StarfishSharedPreference().setAccessToken(user.phone);
    });
  }

  Future syncUsers() async {
    /**
     * TODO: fetch only records updated after last sync and update in local DB.
     */
    if (DEBUG) {
      userBox.values.forEach((element) {
        element.delete();
      });
    }

    await UserRepository().getUsers().then((ResponseStream<User> stream) {
      stream.listen((user) {
        HiveUser _hiveUser = HiveUser.from(user);

        int _currentIndex = -1;
        userBox.values.toList().asMap().forEach((key, hiveUser) {
          if (hiveUser.id == user.id) {
            _currentIndex = key;
          }
        });

        if (_currentIndex > -1) {
          userBox.put(_currentIndex, _hiveUser);
        } else {
          userBox.add(_hiveUser);
        }
      }, onError: ((err) {
        print(err);
      }), onDone: () {
        print('Users Sync Done.');
      });
    });
  }

  Future syncCountries() async {
    await AppDataRepository()
        .getAllCountries()
        .then((ResponseStream<Country> country) {
      country.listen((country) {
        int _currentIndex = -1;
        countryBox.values.toList().asMap().forEach((key, hiveCountry) {
          if (hiveCountry.id == country.id) {
            _currentIndex = key;
          }
        });

        HiveCountry _hiveCountry = HiveCountry(
            id: country.id,
            name: country.name,
            diallingCode: country.diallingCode);

        if (_currentIndex > -1) {
          countryBox.put(_currentIndex, _hiveCountry);
        } else {
          countryBox.add(_hiveCountry);
        }
      }, onError: ((err) {
        print(err);
      }), onDone: () {
        print('Country Sync Done.');
      });
    });
  }

  Future syncLanguages() async {
    await languageBox.clear();
    await AppDataRepository()
        .getAllLanguages()
        .then((ResponseStream<Language> stream) {
      stream.listen((language) {
        var filterData = languageBox.values
            .where((element) => element.id == language.id)
            .toList();
        if (filterData.length == 0) {
          HiveLanguage _language =
              HiveLanguage(id: language.id, name: language.name);

          int _currentIndex = -1;
          languageBox.values.toList().asMap().forEach((key, hiveLanguage) {
            if (hiveLanguage.id == language.id) {
              _currentIndex = key;
            }
          });

          if (_currentIndex > -1) {
            languageBox.put(_currentIndex, _language);
          } else {
            languageBox.add(_language);
          }
        } else {
          //update record
        }
      }, onError: ((err) {
        print(err);
      }), onDone: () {
        print('Language Sync Done.');
      });
    });
  }

  Future syncMaterialFiles(HiveMaterial _hiveMaterial) async {
    if (_hiveMaterial.files == null || _hiveMaterial.files!.length == 0) {
      return;
    }

    _hiveMaterial.files?.forEach((String filename) {
      HiveFile? _hiveFile = fileBox.values.firstWhereOrNull(
          (HiveFile element) =>
              element.entityId == _hiveMaterial.id &&
              element.filename == filename);

      if (_hiveFile != null) {
        // TODO: verify if files is correctly downloaded or physically exists after successful download
        return;
      }
      _hiveFile = HiveFile(
          entityId: _hiveMaterial.id,
          filename: filename,
          entityType: EntityType.MATERIAL.value,
          isSynced: false);

      fileBox.add(_hiveFile);
    });
  }

  Future syncMaterial() async {
    /**
     * TODO: fetch only records updated after last sync and update in local DB.
     */
    if (DEBUG) {
      materialBox.values.forEach((element) {
        element.delete();
      });
    }

    await MaterialRepository()
        .getMaterials()
        .then((ResponseStream<Material> stream) {
      stream.listen((material) {
        HiveMaterial _hiveMaterial = HiveMaterial.from(material);

        syncMaterialFiles(_hiveMaterial);

        int _currentIndex = -1;
        materialBox.values.toList().asMap().forEach((key, hiveMaterial) {
          if (hiveMaterial.id == material.id) {
            _currentIndex = key;
          }
        });

        if (_currentIndex > -1) {
          materialBox.put(_currentIndex, _hiveMaterial);
        } else {
          materialBox.add(_hiveMaterial);
        }
      }, onError: ((err) {
        print(err);
      }), onDone: () {
        print('Material Sync Done.');
      });
    });
  }

  Future syncMaterialTopics() async {
    /**
     * TODO: fetch only records updated after last sync and update in local DB.
     */
    if (DEBUG) {
      materialTopicBox.values.forEach((element) {
        element.delete();
      });
    }

    await MaterialRepository()
        .getMaterialTopics()
        .then((ResponseStream<MaterialTopic> stream) {
      stream.listen((topic) {
        HiveMaterialTopic _materialTopic = HiveMaterialTopic.from(topic);

        int _currentIndex = -1;
        materialTopicBox.values
            .toList()
            .asMap()
            .forEach((key, hiveMaterialTopic) {
          if (hiveMaterialTopic.id == topic.id) {
            _currentIndex = key;
          }
        });

        if (_currentIndex > -1) {
          materialTopicBox.put(_currentIndex, _materialTopic);
        } else {
          materialTopicBox.add(_materialTopic);
        }
      }, onError: ((err) {
        print(err);
      }), onDone: () {
        print('MaterialTopic Sync Done.');
      });
    });
  }

  Future syncMaterialTypes() async {
    /**
     * TODO: fetch only records updated after last sync and update in local DB.
     */
    if (DEBUG) {
      materialTypeBox.values.forEach((element) {
        element.delete();
      });
    }

    await MaterialRepository()
        .getMaterialTypes()
        .then((ResponseStream<MaterialType> topics) {
      topics.listen((materialType) {
        HiveMaterialType _materialType = HiveMaterialType.from(materialType);

        int _currentIndex = -1;
        materialTypeBox.values
            .toList()
            .asMap()
            .forEach((key, hiveMaterialType) {
          if (hiveMaterialType.id == materialType.id) {
            _currentIndex = key;
          }
        });

        if (_currentIndex > -1) {
          materialTypeBox.put(_currentIndex, _materialType);
        } else {
          materialTypeBox.add(_materialType);
        }
      }, onError: ((err) {
        print(err);
      }), onDone: () {
        print('MaterialType Sync Done.');
      });
    });
  }

  syncLocalMaterialsToRemote() async {
    print('============= START: Sync Local Materials to Remote =============');

    materialBox.values
        .where(
            (element) => (element.isNew == true || element.isUpdated == true))
        .forEach((HiveMaterial _hiveMaterial) {
      MaterialRepository()
          .createUpdateMaterial(
        material: _hiveMaterial.toMaterial(),
        fieldMaskPaths: kMaterialFieldMask,
      )
          .then((value) {
        // update flag(s) isNew and/or isUpdated to false
        _hiveMaterial.isNew = false;
        _hiveMaterial.isUpdated = false;

        MaterialRepository().createUpdateMaterialInDB(_hiveMaterial);
      }).onError((error, stackTrace) {
        print('============= Error: ${error.toString()} ===============');
      }).whenComplete(() {
        print(
            '============= END: Sync Local Materials to Remote ===============');
      });
    });
  }

  Future syncGroup() async {
    /**
     * TODO: fetch only records updated after last sync and update in local DB.
     */
    if (DEBUG) {
      groupBox.values.forEach((element) {
        element.delete();
      });
    }

    await GroupRepository().getGroups().then((ResponseStream<Group> stream) {
      stream.listen((group) {
        GroupRepository().addEditGroup(HiveGroup.from(group));
      }, onError: ((err) {
        print('Group Sync Error: ${err.toString()}');
      }), onDone: () {
        print('Group Sync Done.');
      });
    });
  }

  Future syncEvaluationCategories() async {
    /**
     * TODO: fetch only records updated after last sync and update in local DB.
     */
    if (DEBUG) {
      evaluationCategoryBox.values.forEach((element) {
        element.delete();
      });
    }

    await GroupRepository()
        .getEvaluationCategories()
        .then((ResponseStream<EvaluationCategory> stream) {
      stream.listen((evaluationCategory) {
        HiveEvaluationCategory _category =
            HiveEvaluationCategory.from(evaluationCategory);

        int _currentIndex = -1;
        evaluationCategoryBox.values.toList().asMap().forEach((key, value) {
          if (value.id == evaluationCategory.id) {
            _currentIndex = key;
          }
        });

        if (_currentIndex > -1) {
          evaluationCategoryBox.put(_currentIndex, _category);
        } else {
          evaluationCategoryBox.add(_category);
        }
      }, onError: ((err) {
        print('EvaluationCategory Sync Error: ${err.toString()}');
      }), onDone: () {
        print('EvaluationCategory Sync Done.');
      });
    });
  }

  // Upward Sync Task
  syncLocalCurrentUser(List<String> _fieldMaskPaths) async {
    print(
        '============= START: Sync Local CurrentUser to Remote =============');
    HiveCurrentUser? _currentUser = currentUserBox.values
        .firstWhereOrNull((element) => element.isUpdated == true);

    if (_currentUser != null) {
      await CurrentUserRepository()
          .updateCurrentUser(_currentUser.toUser(), _fieldMaskPaths);
    }
  }

  Future syncLocalUsersToRemote() async {
    print('============= START: Sync Local User to Remote =============');

    return Future.wait([
      for (HiveUser _hiveUser
          in userBox.values.where((HiveUser user) => (user.isNew == true)))
        addUserToSyncQueue(_hiveUser),
    ]);
  }

  Future<CreateUpdateUserResponse> addUserToSyncQueue(
      HiveUser _hiveUser) async {
    CreateUpdateUserResponse _response = await UserRepository()
        .createUpdateUsers(_hiveUser.toUser(), kUserFieldMask);
    if (_response.status == CreateUpdateUserResponse_Status.SUCCESS) {
      _hiveUser.isNew = false;
      _hiveUser.isUpdated = false;

      await UserRepository().createUpdateUserInDB(_hiveUser);
    }

    return _response;
  }

  Future syncLocalGroupsToRemote() async {
    print('============= START: Sync Local Groups to Remote =============');
    return Future.wait([
      for (HiveGroup group in groupBox.values
          .where((HiveGroup group) => (group.isNew || group.isUpdated)))
        addGroupToSyncQueue(group),
    ]);
  }

  Future<CreateUpdateGroupsResponse> addGroupToSyncQueue(
      HiveGroup _hiveGroup) async {
    CreateUpdateGroupsResponse _response = await GroupRepository()
        .createUpdateGroup(
            group: _hiveGroup.toGroup(), fieldMaskPaths: kGroupFieldMask);

    // update flag(s) isNew and/or isUpdated to false
    _hiveGroup.isNew = false;
    _hiveGroup.isUpdated = false;

    GroupRepository().addEditGroup(_hiveGroup);
    return _response;
  }

  Future syncLocalGroupUsersToRemote() async {
    print('============= START: Sync Local GroupUsers to Remote =============');

    final List<HiveGroupUser> _groupUsers = [];

    groupBox.values.forEach((HiveGroup _hiveGroup) async {
      _groupUsers.addAll(_hiveGroup.users!
          .where((element) =>
              element.isNew || element.isUpdated || element.isDirty)
          .toList());
    });

    return Future.wait([
      for (HiveGroupUser groupUser in _groupUsers)
        addGroupUserToSyncQueue(groupUser),
    ]);
  }

  Future addGroupUserToSyncQueue(HiveGroupUser groupUser) async {
    print('LOCAL GroupUser: ${groupUser.name}, ${groupUser.userId}');
    if (groupUser.isDirty) {
      return GroupRepository().deleteGroupUsers(groupUser.toGroupUser());
    } else {
      CreateUpdateGroupUsersResponse _response = await GroupRepository()
          .createUpdateGroupUser(
              groupUser: groupUser.toGroupUser(),
              fieldMaskPaths: kGroupUserFieldMask);

      print('REMOTE GroupUser[${_response.status}]: ${_response.message} ');
      if (_response.status == CreateUpdateGroupUsersResponse_Status.SUCCESS) {
        groupUser.isNew = false;
        groupUser.isUpdated = false;
      }
      /*groupUser.isNew = false;
      groupUser.isUpdated = false;

      GroupRepository()
        .createUpdateGroupUserInDB(group: _hiveGroup, groupUser: groupUser);*/
      return _response;
    }
  }

  Future syncActions() async {
    /**
     * TODO: fetch only records updated after last sync and update in local DB.
     */
    if (DEBUG) {
      actionBox.values.forEach((element) {
        // element.delete();
      });
    }

    await ActionRepository()
        .getActions()
        .then((ResponseStream<starfish.Action> stream) {
      stream.listen((action) {
        HiveAction _hiveAction = HiveAction.from(action);

        int _currentIndex = -1;
        actionBox.values.toList().asMap().forEach((key, hiveAction) {
          if (hiveAction.id == action.id) {
            _currentIndex = key;
          }
        });

        if (_currentIndex > -1) {
          actionBox.put(_currentIndex, _hiveAction);
        } else {
          actionBox.add(_hiveAction);
        }
      }, onError: ((err) {
        print(err);
      }), onDone: () {
        print('Action Sync Done.');
      });
    });
  }

  syncLocalActionsToRemote() async {
    print('============= START: Sync Local Actions to Remote =============');

    actionBox.values
        .where((element) =>
            (element.isNew || element.isUpdated || element.isDirty))
        .forEach((HiveAction _hiveAction) {
      if (_hiveAction.isNew || _hiveAction.isUpdated) {
        ActionRepository()
            .createUpdateAction(
          action: _hiveAction.toAction(),
          fieldMaskPaths: kActionFieldMask,
        )
            .then((value) {
          // update flag(s) isNew and/or isUpdated to false
          _hiveAction.isNew = false;
          _hiveAction.isUpdated = false;

          ActionRepository().createUpdateActionInDB(_hiveAction);
        }).onError((error, stackTrace) {
          print('============= Error: ${error.toString()} ===============');
        }).whenComplete(() {
          print(
              '============= END: Sync Local Actions to Remote ===============');
        });
      } else if (_hiveAction.isDirty) {
        ActionRepository().deleteAction(_hiveAction.toAction()).then((value) {
          _hiveAction.isDirty = false;

          ActionRepository().deleteActionInDB(_hiveAction);
        }).onError((error, stackTrace) {
          print('============= Error: ${error.toString()} ===============');
        }).whenComplete(() {
          print(
              '============= END: Sync Local Actions to Remote ===============');
        });
      }
    });
  }

  syncLocalFiles() async {
    print('============= START: Sync Local Files to Remote =============');
    // upload files form `File Box` excluding those which are added from remote i.e. `filepath == null`
    fileBox.values
        .where((element) => element.filepath != null)
        .forEach((hiveFile) {
      // TODO: Check existance of the the file before upload
      uploadMaterial(hiveFile.entityId!, File(hiveFile.filepath!));
    });
    //uploadMaterial("1f21e210-a1fc-40d5-8fef-ad9d105fdbe7", File(fileBox.values.first.filepath!));
  }

  uploadMaterial(String entityId, File file) async {
    print(
        '============= START: Sync Local File $entityId :: ${file.path} =============');
    StreamController<FileData> _controller = StreamController();

    FileMetaData metaData = FileMetaData(
      entityId: entityId,
      filename: file.path.split("/").last,
      entityType: EntityType.MATERIAL,
    );
    FileData fileMetaData = FileData(metaData: metaData);

    /*ResponseStream<UploadStatus> responseStream =
        client.upload(_controller.stream);*/

    MaterialRepository()
        .apiProvider
        .uploadFile(_controller.stream)
        .then((responseStream) {
      responseStream.listen((UploadStatus uploadStatus) {
        print("File UploadStatus: $uploadStatus");

        if (uploadStatus.status == UploadStatus_Status.OK ||
            uploadStatus.status == UploadStatus_Status.FAILED) {
          _controller.done;
        }
      });
    });

    _controller.add(fileMetaData);

    Stream<List<int>> inputStream = file.openRead();
    inputStream.listen((event) {
      _controller.add(FileData(chunk: event));
    }, onDone: () {
      print("DONE");
      //_controller.sink.add(fileMetaData);
      _controller.close();
    }, onError: (error) {
      print("ERROR: $error");
    });

    /*final semicolon = ';'.codeUnitAt(0);
    RandomAccessFile randomAccessFile = file.openSync(mode: FileMode.read);
    //final result = <int>[];
    while (true) {
      final byte = await randomAccessFile.readByte();
      //result.add(byte);
      _controller.sink.add(FileData(chunk: [byte].toList()));
      if (byte == semicolon) {
        //print(String.fromCharCodes(result));
        _controller.sink.add(fileMetaData);
        //_controller.sink.done;
        //_controller.close();
        await randomAccessFile.close();
        break;
      }
    }*/
  }

  syncFiles() async {
    print('============= START: SyncFiles FROM Remote =============');
    // Filter items not downloaded yet
    fileBox.values
        .where((hiveFile) {
          return false == hiveFile.isSynced && null == hiveFile.filepath;
        })
        .toList()
        .forEach((HiveFile hiveFile) {
          print(
              '=============DownloadMaterial: ${hiveFile.filename} =============');
          downloadMaterial(hiveFile); //.entityId!, file.remoteFileName!);
        });
    //downloadMaterial(materialBox.values.first);
  }

  // TODO: don't download the file again if already downloaded.
  downloadMaterial(HiveFile hiveFile) async {
    //String entityId, String remoteFilename) async {
    String? filePath = await getFilePath(hiveFile.filename!);
    if (filePath == null) {
      print("Storage NOT accessible");
      return;
    }

    File file = File(filePath);
    await file.create();
    RandomAccessFile randomAccessFile = await file.open(mode: FileMode.write);

    MaterialRepository()
        .apiProvider
        .downloadFile(Stream.value(DownloadRequest(
            entityId: hiveFile.entityId,
            entityType: EntityType.MATERIAL,
            filenames: [hiveFile.filename!].toList())))
        .then((responseStream) {
      responseStream.listen((FileData fileData) async {
        //print("DATA Received: $fileData");
        if (fileData.hasMetaData()) {
          print("META DATA: ${fileData.metaData}");
        } else if (fileData.hasChunk()) {
          //print("FILE CHUNK:");
          randomAccessFile.writeFromSync(fileData.chunk);
        }
      }, onDone: () {
        print("FILE Transfer DONE");
        randomAccessFile.closeSync();

        // Update downloaded file info in `FILE_BOX`

        int _currentIndex = -1;
        fileBox.values.toList().asMap().forEach((key, _hiveFile) {
          if (hiveFile.entityId == _hiveFile.entityId &&
              hiveFile.filename == _hiveFile.filename) {
            _currentIndex = key;
          }
        });

        if (_currentIndex > -1) {
          hiveFile.filepath = file.path;
          hiveFile.isSynced = true;

          fileBox.put(_currentIndex, hiveFile);
        }
      }, onError: (error, stackTrace) {
        print("FILE Transfer ERROR:: $error");
      }, cancelOnError: true);
    });
  }

  // TODO:
  Future<String?> getFilePath(String filename) async {
    /*List<Directory>? directories =
        await getExternalStorageDirectories(type: StorageDirectory.downloads);
    if (directories == null || directories.length == 0) {
      return null;
    }
    String appDocumentsPath = directories.first.path;

    String filePath = '$appDocumentsPath/$filename';
    */

    Directory? appDocumentsPath = await getApplicationDocumentsDirectory();
    if (appDocumentsPath == null) {
      return null;
    }
    String filePath = '${appDocumentsPath.path}/$filename';
    print("FILE PATH: $filePath");
    return filePath;
  }

  Future syncLocalHiveActionUserToRemote() async {
    print('============= START: Sync Local ActionUser to Remote =============');
    actionUserBox.values
        .where((element) => (element.isNew || element.isUpdated))
        .forEach((HiveActionUser _hiveActionUser) {
      if (_hiveActionUser.isNew || _hiveActionUser.isUpdated) {
        ActionRepository()
            .createUpdateActionUsers(
          actionUser: _hiveActionUser.toActionUser(),
          fieldMaskPaths: kActionUserFieldMask,
        )
            .then((value) {
          // delete this actionuser form `ACTION_USER_BOX`

          ActionProvider().deleteActionUser(_hiveActionUser);
        }).onError((error, stackTrace) {
          print('============= Error: ${error.toString()} ===============');
        }).whenComplete(() {
          print(
              '============= END: Sync Local ActionUser to Remote ===============');
        });
      }
    });
  }
}
