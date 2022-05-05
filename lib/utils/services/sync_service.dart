import 'dart:async';
import 'dart:io';
import 'package:fbroadcast/fbroadcast.dart';
import 'package:flutter/cupertino.dart' as app;
import 'package:flutter/material.dart' as app;
import 'package:flutter/widgets.dart';
import 'package:grpc/grpc.dart';
import 'package:grpc/grpc_or_grpcweb.dart';
import 'package:hive/hive.dart';
import 'package:collection/collection.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:starfish/config/app_config.dart';
import 'package:starfish/db/hive_action.dart';
import 'package:starfish/db/hive_action_user.dart';
import 'package:starfish/db/hive_country.dart';
import 'package:starfish/db/hive_current_user.dart';
import 'package:starfish/db/hive_database.dart';
import 'package:starfish/db/hive_evaluation_category.dart';
import 'package:starfish/db/hive_file.dart';
import 'package:starfish/db/hive_group.dart';
import 'package:starfish/db/hive_group_evaluation.dart';
import 'package:starfish/db/hive_group_user.dart';
import 'package:starfish/db/hive_language.dart';
import 'package:starfish/db/hive_last_sync_date_time.dart';
import 'package:starfish/db/hive_learner_evaluation.dart';
import 'package:starfish/db/hive_material.dart';
import 'package:starfish/db/hive_material_feedback.dart';
import 'package:starfish/db/hive_material_topic.dart';
import 'package:starfish/db/hive_material_type.dart';
import 'package:starfish/db/hive_output.dart';
import 'package:starfish/db/hive_teacher_response.dart';
import 'package:starfish/db/hive_transformation.dart';
import 'package:starfish/db/hive_user.dart';
import 'package:starfish/db/providers/action_provider.dart';
import 'package:starfish/db/providers/group_evaluation_provider.dart';
import 'package:starfish/db/providers/group_provider.dart';
import 'package:starfish/db/providers/learner_evaluation_provider.dart';
import 'package:starfish/db/providers/material_provider.dart';
import 'package:starfish/db/providers/output_provider.dart';
import 'package:starfish/db/providers/results_provider.dart';
import 'package:starfish/db/providers/teacher_response_provider.dart';
import 'package:starfish/db/providers/transformation_provider.dart';
import 'package:starfish/db/providers/user_provider.dart';
import 'package:starfish/navigation_service.dart';
import 'package:starfish/repository/action_repository.dart';
import 'package:starfish/repository/app_data_repository.dart';
import 'package:starfish/repository/current_user_repository.dart';
import 'package:starfish/repository/group_repository.dart';
import 'package:starfish/repository/materials_repository.dart';
import 'package:starfish/repository/results_repository.dart';
import 'package:starfish/repository/user_repository.dart';
import 'package:starfish/src/generated/file_transfer.pbgrpc.dart';
import 'package:starfish/src/generated/google/protobuf/field_mask.pb.dart';
import 'package:starfish/src/generated/starfish.pb.dart';
import 'package:starfish/utils/helpers/general_functions.dart';
import 'package:starfish/utils/helpers/snackbar.dart';
import 'package:starfish/utils/services/api_provider.dart';
import 'package:starfish/utils/services/field_mask.dart';
import 'package:starfish/utils/services/local_storage_service.dart';
import 'package:synchronized/synchronized.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starfish/src/generated/starfish.pb.dart' as starfish;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SyncService {
  final DEBUG = false;
  bool _isDialogShowing = false;

  static final String kUpdateCurrentUser = 'updateCurrentUser';
  static final String kUpdateMaterial = 'updateMaterial';
  static final String kDeleteMaterial = 'deleteMaterial';
  static final String kUpdateGroup = 'updateGroup';
  static final String kUpdateUsers = 'updateUsers';
  static final String kUpdateActions = 'updateActions';
  static final String kUpdateTeacherResponse = 'updateTeacherResponse';
  static final String kUpdateTransformation = 'updateTransformation';
  static final String kUpdateLearnerEvaluation = 'updateLearnerEvaluation';

  static final String kUnauthenticated = 'unauthenticated';

  // Use this object to prevent concurrent access to data
  var lock = new Lock(reentrant: false);
  var _refreshSessionLock = new Lock();

  static syncNow() {}

  late Box<HiveLastSyncDateTime> lastSyncBox;
  late Box<HiveCountry> countryBox;
  late Box<HiveLanguage> languageBox;
  late Box<HiveCurrentUser> currentUserBox;
  late Box<HiveGroupUser> groupUserBox;
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
  late Box<HiveLearnerEvaluation> learnerEvaluationBox;
  late Box<HiveTeacherResponse> teacherResponseBox;
  late Box<HiveGroupEvaluation> groupEvaluationBox;
  late Box<HiveTransformation> transformationBox;
  late Box<HiveOutput> outputBox;

  SyncService() {
    lastSyncBox = Hive.box<HiveLastSyncDateTime>(HiveDatabase.LAST_SYNC_BOX);
    countryBox = Hive.box<HiveCountry>(HiveDatabase.COUNTRY_BOX);
    languageBox = Hive.box<HiveLanguage>(HiveDatabase.LANGUAGE_BOX);
    currentUserBox = Hive.box<HiveCurrentUser>(HiveDatabase.CURRENT_USER_BOX);
    groupUserBox = Hive.box<HiveGroupUser>(HiveDatabase.GROUP_USER_BOX);
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
    learnerEvaluationBox =
        Hive.box<HiveLearnerEvaluation>(HiveDatabase.LEARNER_EVALUATION_BOX);
    teacherResponseBox =
        Hive.box<HiveTeacherResponse>(HiveDatabase.TEACHER_RESPONSE_BOX);
    groupEvaluationBox =
        Hive.box<HiveGroupEvaluation>(HiveDatabase.GROUP_EVALUATION_BOX);
    transformationBox =
        Hive.box<HiveTransformation>(HiveDatabase.TRANSFORMATION_BOX);
    outputBox = Hive.box<HiveOutput>(HiveDatabase.OUTPUT_BOX);
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
    bool _isNetworkAvailable = await GeneralFunctions().isNetworkAvailable();
    if (!_isNetworkAvailable) {
      return;
    }

    syncCountries();

    // Check If already authenticated
    final bool isAuthenticated =
        await StarfishSharedPreference().isUserLoggedIn();
    if (!isAuthenticated) {
      return;
    }

    showAlertFirstTime();
    await lock.synchronized(() => syncLocalCurrentUser(kCurrentUserFieldMask));

    // Synchronize the syncing of users, groups and group users, sequentily to avoid failure.
    await lock.synchronized(() => syncLocalUsersAndGroups());

    await lock.synchronized(() => syncLocalActionsToRemote());

    await lock.synchronized(() => syncLocalHiveActionUserToRemote());

    // Synchronize the syncing of results elements
    await lock.synchronized(() => syncLocalTransformationsToRemote());
    await lock.synchronized(() => syncLocalTeacherResponsesToRemote());
    await lock.synchronized(() => syncLocalLearnerEvaluationsToRemote());
    await lock.synchronized(() => syncLocalOutputsToRemote());
    //await lock.synchronized(() => syncLocalGroupEvaluationsToRemote()); // Pending

    // Synchronize the syncing of material(s), sequentily to avoid failure.

    await lock.synchronized(() => syncLocalDeletedMaterialsToRemote());
    await lock.synchronized(() => syncLocalMaterialsToRemote());
    await lock.synchronized(() => syncLocalFiles());
    await lock.synchronized(() => syncMaterial()); // Upload local files
    await lock.synchronized(() => downloadFiles()); // Download remote files

    Future.wait(
      [
        syncCurrentUser(),
        syncUsers(),
        //syncCountries(),
        syncLanguages(),
        syncActions(),
        syncMaterialTopics(),
        syncMaterialTypes(),
        //syncMaterial(),
        syncEvaluationCategories(),
        syncGroup(),
        syncLearnerEvaluations(),
        //syncGroupEvaluations(), // Pending
        syncTeacherResponses(),
        syncTransformaitons(),
        syncOutputs(),
      ],
      eagerError: true,
    ).then((value) {
      updateLastSyncDateTime();
    }).onError((error, stackTrace) {
      Sentry.captureException(error, stackTrace: stackTrace);
      handleError(error);
    }).whenComplete(() {
      hideAlert();
    });
  }

  Future syncLocalUsersAndGroups() async {
    var lock1 = new Lock();
    await lock1.synchronized(() => syncLocalUsersToRemote());
    await lock1.synchronized(() => syncLocalGroupsToRemote());
    await lock1.synchronized(() => syncLocalDeletedGroupUsersToRemote());
    await lock1.synchronized(() => syncLocalGroupUsersToRemote());
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
    }, onError: ((err) {
      handleGrpcError(err);
    }));
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
        handleGrpcError(err);
      }), onDone: () {
        print('Users Sync Done.');
      });
      // ignore: invalid_return_type_for_catch_error
    }).catchError(handleError);
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
        handleGrpcError(err);
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
        handleGrpcError(err);
      }), onDone: () {
        print('Language Sync Done.');
      });
    });
  }

  void addEntityFilesToLocalDB(
      {required EntityType entityType,
      required String entityId,
      required List<String> files}) {
    files.forEach((String filename) async {
      HiveFile? _hiveFile = fileBox.values.firstWhereOrNull(
          (HiveFile element) =>
              element.entityId == entityId && element.filename == filename);

      if (_hiveFile != null) {
        // TODO: verify if files is correctly downloaded or physically exists after successful download
        return;
      }
      _hiveFile = HiveFile(
          entityId: entityId,
          filename: filename,
          entityType: entityType.value,
          isSynced: false);

      await fileBox.add(_hiveFile);
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
      stream.listen((material) async {
        HiveMaterial _hiveMaterial = HiveMaterial.from(material);

        if (_hiveMaterial.files != null && _hiveMaterial.files!.length > 0) {
          addEntityFilesToLocalDB(
              entityId: _hiveMaterial.id!,
              entityType: EntityType.MATERIAL,
              files: _hiveMaterial.files!);
        }

        int _currentIndex = -1;
        materialBox.values.toList().asMap().forEach((key, hiveMaterial) {
          if (hiveMaterial.id == material.id) {
            _currentIndex = key;
          }
        });

        if (_currentIndex > -1) {
          materialBox.putAt(_currentIndex, _hiveMaterial);
        } else {
          materialBox.add(_hiveMaterial);
        }
      }, onError: ((err) {
        handleGrpcError(err);
      }), onDone: () {
        print('Material Sync Done.');
      });
      // ignore: invalid_return_type_for_catch_error
    }).catchError(handleError);
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
        handleGrpcError(err);
      }), onDone: () {
        print('MaterialTopic Sync Done.');
      });
      // ignore: invalid_return_type_for_catch_error
    }).catchError(handleError);
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
        handleGrpcError(err);
      }), onDone: () {
        print('MaterialType Sync Done.');
      });
      // ignore: invalid_return_type_for_catch_error
    }).catchError(handleError);
  }

  Future syncLocalDeletedMaterialsToRemote() async {
    if (materialBox.values
        .where((element) => (element.isDirty == true))
        .isEmpty) {
      return;
    }

    print(
        '============= START: Sync Local Deleted Materials to Remote =============');

    StreamController<DeleteMaterialRequest> _controller = StreamController();

    try {
      ResponseStream<DeleteMaterialResponse> responseStram =
          await MaterialRepository().deleteMaterials(_controller.stream);

      materialBox.values
          .where((element) => (element.isDirty == true))
          .forEach((HiveMaterial _hiveMaterial) {
        // this is a local material not yet synced with remote, so just delete from local
        if (_hiveMaterial.isNew) {
          MaterialProvider().deleteMaterial(id: _hiveMaterial.id!);
        } else {
          var request = DeleteMaterialRequest.create();
          request.materialId = _hiveMaterial.id!;

          _controller.add(request);
        }
      });
      _controller.close();

      await responseStram.forEach((response) {
        print('Delete Material: ${response.status}');
        if (response.status == CreateUpdateGroupsResponse_Status.SUCCESS) {
          // this entry should be removed from the box
          MaterialProvider().deleteMaterial(id: response.materialId);
        }
      });
    } catch (error, stackTrace) {
      print('Delete Material: ${error}');
      Sentry.captureException(error, stackTrace: stackTrace);
      handleError(error);
    } finally {
      _controller.close();
    }
  }

  Future syncLocalMaterialsToRemote() async {
    if (materialBox.values
        .where(
            (element) => (element.isNew == true || element.isUpdated == true))
        .isEmpty) {
      return;
    }
    print('============= START: Sync Local Materials to Remote =============');

    StreamController<CreateUpdateMaterialsRequest> _controller =
        StreamController();

    try {
      ResponseStream<CreateUpdateMaterialsResponse> responseStram =
          await MaterialRepository().createUpdateMaterial(_controller.stream);

      materialBox.values
          .where((element) => (element.isNew == true ||
              element.isUpdated == true && !element.isDirty))
          .forEach((HiveMaterial _hiveMaterial) {
        var request = CreateUpdateMaterialsRequest.create();
        request.material = _hiveMaterial.toMaterial();

        if (_hiveMaterial.isUpdated) {
          FieldMask mask = FieldMask(paths: kMaterialFieldMask);
          request.updateMask = mask;
        }

        _controller.add(request);
      });
      _controller.close();

      await responseStram.forEach((response) {
        //print('Remote Material: ${response.material}');
        if (response.status == CreateUpdateGroupsResponse_Status.SUCCESS) {
          // update flag(s) isNew and/or isUpdated to false
          MaterialRepository()
              .createUpdateMaterialInDB(HiveMaterial.from(response.material));
        }
      });
    } catch (error, stackTrace) {
      Sentry.captureException(error, stackTrace: stackTrace);
      handleError(error);
    } finally {
      _controller.close();
    }
  }

  Future syncGroup() async {
    print('==>> START syncGroup');
    /**
     * TODO: fetch only records updated after last sync and update in local DB.
     */
    if (DEBUG) {
      groupBox.values.forEach((element) {
        element.delete();
      });
    }

    await GroupRepository()
        .getGroups()
        .then((ResponseStream<Group> stream) {
          stream.listen((group) {
            print('==>>syncGroup: ${group}');
            GroupRepository().addEditGroup(HiveGroup.from(group));
          }, onError: ((err) {
            print('syncGroup ERROR: $err');
            //handleGrpcError(err);
          }), onDone: () {
            print('Group Sync Done.');
          });
        })
        // ignore: invalid_return_type_for_catch_error
        .catchError(handleError)
        .whenComplete(() {
          print('==>> END SyncGroup');
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
        handleGrpcError(err);
      }), onDone: () {
        print('EvaluationCategory Sync Done.');
      });
      // ignore: invalid_return_type_for_catch_error
    }).catchError(handleError);
  }

  // Upward Sync Task
  Future syncLocalCurrentUser(List<String> _fieldMaskPaths) async {
    print(
        '============= START: Sync Local CurrentUser to Remote =============');
    HiveCurrentUser? _currentUser = currentUserBox.values
        .firstWhereOrNull((element) => element.isUpdated == true);

    if (_currentUser != null) {
      await CurrentUserRepository()
          .updateCurrentUser(_currentUser.toUser(), _fieldMaskPaths);
    }
    print('============= END: Sync Local CurrentUser to Remote =============');
  }

  Future syncLocalUsersToRemote() async {
    if (userBox.values
        .where((element) => element.isNew || element.isUpdated)
        .isEmpty) {
      return;
    }
    print('============= START: Sync Local User to Remote =============');
    StreamController<CreateUpdateUserRequest> _controller = StreamController();

    try {
      ResponseStream<CreateUpdateUserResponse> responseStream =
          await UserRepository().createUpdateUsers(_controller.stream);

      userBox.values
          .where((element) => element.isNew || element.isUpdated)
          .forEach((_hiveUser) {
        var request = CreateUpdateUserRequest.create();
        request.user = _hiveUser.createRequestUser();

        if (_hiveUser.isUpdated) {
          FieldMask mask = FieldMask(paths: kUserFieldMask);
          request.updateMask = mask;
        }
        _controller.add(request);
      });
      _controller.close();

      return await responseStream.forEach((_response) {
        print('Remote User: ${_response}');
        if (_response.status == CreateUpdateUserResponse_Status.SUCCESS) {
          // get local Id of this user/ and replace in all the groupUser
          List<HiveUser> _hiveLocalUsers = UserProvider().getLocalUserByPhone(
              _response.user.diallingCode, _response.user.phone);
          if (_hiveLocalUsers.length == 1) {
            // Delete all local entry local entry with matching user i.e. dialling code and phone
            UserProvider().deleteUser(_hiveLocalUsers.first);

            UserProvider().createUpdateUser(HiveUser.from(_response.user));

            GroupProvider()
                .updateGroupUserId(_hiveLocalUsers.first.id, _response.user.id);
          } else if (_hiveLocalUsers.length > 1) {
            /**
           * If there are multiple local (i.e. isNew = true) records with the same phonenumber and dilling code, 
           * just keep once record, and delete rest ofthe records.
           */
            UserProvider().createUpdateUser(HiveUser.from(_response.user));
            HiveUser _hiveUser = _hiveLocalUsers.first;
            GroupProvider().updateGroupUserId(_hiveUser.id, _response.user.id);

            _hiveLocalUsers.forEach((_user) async {
              // Delete all local entry local entry with matching user i.e. dialling code and phone
              await _user.delete();

              // Delete this userId from GroupUserBox except one
              GroupProvider().deleteGroupUserByUserId(_user.id!);
            });
          }
        } else {
          print('============= ERROR: syncLocalUsersToRemote =============');
        }
      });
    } catch (error, stackTrace) {
      Sentry.captureException(error, stackTrace: stackTrace);
      handleError(error);
    } finally {
      _controller.close();
    }
  }

  Future syncLocalGroupsToRemote() async {
    if (groupBox.values
        .where((element) => element.isNew || element.isUpdated)
        .isEmpty) {
      return;
    }
    print('============= START: Sync Local Groups to Remote =============');
    StreamController<CreateUpdateGroupsRequest> _controller =
        StreamController();

    try {
      ResponseStream<CreateUpdateGroupsResponse> responseStream =
          await GroupRepository().createUpdateGroup(_controller.stream);
      groupBox.values
          .where((element) => element.isNew || element.isUpdated)
          .forEach((_hiveGroup) {
        var request = CreateUpdateGroupsRequest.create();
        request.group = _hiveGroup.toGroup();

        if (_hiveGroup.isUpdated) {
          FieldMask mask = FieldMask(paths: kGroupFieldMask);
          request.updateMask = mask;
        }

        _controller.add(request);
      });
      _controller.close();

      return await responseStream.forEach((value) {
        ///print('Remote Group: ${value.group}');
        if (value.status == CreateUpdateGroupsResponse_Status.SUCCESS) {
          // update flag(s) isNew and/or isUpdated to false

          print('============= END: syncLocalGroupsToRemote =============');
          GroupRepository().addEditGroup(HiveGroup.from(value.group));
        } else {
          print("ERROR: syncLocalGroupsToRemote STATUS.FAILED");
        }
      });
    } catch (error, stackTrace) {
      Sentry.captureException(error, stackTrace: stackTrace);
      handleError(error);
    } finally {
      _controller.close();
    }
  }

  Future syncLocalGroupUsersToRemote() async {
    if (groupUserBox.values
        .where((element) => element.isNew || element.isUpdated)
        .isEmpty) {
      return;
    }
    print(
        '============= START: Sync Local Group Users to Remote =============');
    StreamController<CreateUpdateGroupUsersRequest> _controller =
        StreamController();
    try {
      ResponseStream<CreateUpdateGroupUsersResponse> responseStream =
          await GroupRepository()
              .createUpdateGroupUser(_controller.stream)
              // ignore: invalid_return_type_for_catch_error
              .catchError(handleError);
      groupUserBox.values
          .where((element) => element.isNew || element.isUpdated)
          .forEach((HiveGroupUser _hiveGroupUser) {
        //print('LOCAL GroupUSer: $_hiveGroupUser');
        var request = CreateUpdateGroupUsersRequest.create();
        request.groupUser = _hiveGroupUser.toGroupUser();

        _controller.add(request);
      });
      _controller.close();

      return await responseStream.forEach((_response) {
        //print('Remote GroupUser: ${_response}');
        if (_response.status == CreateUpdateGroupUsersResponse_Status.SUCCESS) {
          // this entry should be removed from the box
          GroupProvider()
              .deleteGroupUser(HiveGroupUser.from(_response.groupUser));
        }
      });
    } catch (error, stackTrace) {
      Sentry.captureException(error, stackTrace: stackTrace);
      handleError(error);
    } finally {
      _controller.close();
    }
  }

  // DELETE GROUP USERS
  Future syncLocalDeletedGroupUsersToRemote() async {
    if (groupUserBox.values.where((element) => element.isDirty).isEmpty) {
      return;
    }
    StreamController<GroupUser> _controller = StreamController();

    try {
      ResponseStream<DeleteGroupUsersResponse> responseStream =
          await GroupRepository().deleteGroupUsers(_controller.stream);

      groupUserBox.values
          .where((element) => element.isDirty)
          .forEach((HiveGroupUser _hiveGroupUser) {
        print('DELETE LOCAL GroupUSer: $_hiveGroupUser');

        _controller.add(_hiveGroupUser.toGroupUser());
      });
      _controller.close();

      return await responseStream.forEach((_response) {
        print('DELETEED Remote GroupUser: ${_response}');
        if (_response.status == DeleteGroupUsersResponse_Status.SUCCESS) {
          // this entry should be removed from the box
          GroupProvider().deleteGroupUser(HiveGroupUser(
              groupId: _response.groupId, userId: _response.userId));
        }
      });
    } catch (error, stackTrace) {
      Sentry.captureException(error, stackTrace: stackTrace);
      handleError(error);
    } finally {
      _controller.close();
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
        handleGrpcError(err);
      }), onDone: () {
        print('Action Sync Done.');
      });
      // ignore: invalid_return_type_for_catch_error
    }).catchError(handleError);
  }

  syncLocalActionsToRemote() async {
    if (actionBox.values
        .where((element) =>
            (element.isNew || element.isUpdated || element.isDirty))
        .isEmpty) {
      return;
    }
    print('============= START: Sync Local Actions to Remote =============');

    StreamController<CreateUpdateActionsRequest> _controller =
        StreamController();

    try {
      actionBox.values
          .where((element) =>
              (element.isNew || element.isUpdated || element.isDirty))
          .forEach((HiveAction _hiveAction) {
        if (_hiveAction.isNew ||
            _hiveAction.isUpdated && !_hiveAction.isDirty) {
          var request = CreateUpdateActionsRequest.create();
          request.action = _hiveAction.toAction();

          if (_hiveAction.isUpdated) {
            FieldMask mask = FieldMask(paths: kActionFieldMask);
            request.updateMask = mask;
          }

          _controller.add(request);

          ActionRepository()
              .createUpdateAction(_controller.stream)
              .then((onValue) {
            onValue.listen((value) {
              // update flag(s) isNew and/or isUpdated to false
              _hiveAction.isNew = false;
              _hiveAction.isUpdated = false;

              ActionRepository().createUpdateActionInDB(_hiveAction);
            });
          }).onError((error, stackTrace) {
            Sentry.captureException(error, stackTrace: stackTrace);
            // ignore: invalid_return_type_for_catch_error
            handleError(error);
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
          }).whenComplete(() {});
        }
      });
    } catch (error, stackTrace) {
      Sentry.captureException(error, stackTrace: stackTrace);
      handleError(error);
    } finally {
      _controller.close();
    }
    //_controller.close();
    print('============= END: Sync Local Actions to Remote ===============');
  }

  syncLocalFiles() async {
    print('============= START: Sync Local Files to Remote =============');
    // upload files form `File Box` excluding those which are added from remote i.e. `filepath == null`
    List<HiveFile> _localFiles = fileBox.values
        .where(
            (element) => element.filepath != null && false == element.isSynced)
        .toList();

    if (_localFiles.isEmpty) {
      return;
    }

    StreamController<FileData> _controller = StreamController();
    _localFiles.forEach((hiveFile) {
      // TODO: Check existance of the the file before upload
      uploadMaterial(hiveFile.entityId!, File(hiveFile.filepath!), _controller);
    });
    _controller.done;
    _controller.close();
    //uploadMaterial("1f21e210-a1fc-40d5-8fef-ad9d105fdbe7", File(fileBox.values.first.filepath!));
  }

  uploadMaterial(String entityId, File file,
      StreamController<FileData> _controller) async {
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
        //print("File UploadStatus: $uploadStatus");
        if (uploadStatus.status == UploadStatus_Status.OK) {
          List<HiveFile> _files = fileBox.values
              .where((element) =>
                  element.entityId == uploadStatus.fileMetaData.entityId)
              .toList();
          _files.forEach((element) {
            element.isSynced = true;
            element.save();
          });
        } else if (uploadStatus.status == UploadStatus_Status.FAILED) {
          //_controller.done;
        }
      });
    }).onError((error, stackTrace) {
      Sentry.captureException(error, stackTrace: stackTrace);
      handleError(error);
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

  downloadFiles() async {
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
          download(hiveFile); //.entityId!, file.remoteFileName!);
        });
    //downloadMaterial(materialBox.values.first);
  }

  // TODO: don't download the file again if already downloaded.
  download(HiveFile hiveFile) async {
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
            entityType: EntityType.valueOf(hiveFile.entityType!),
            filenames: [hiveFile.filename!].toList())))
        .then((responseStream) {
      responseStream.listen((DownloadResponse fileData) async {
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

          fileBox.putAt(_currentIndex, hiveFile);
        }
      }, onError: (error, stackTrace) {
        print("FILE Transfer ERROR:: $error");
      }, cancelOnError: true);
    }).onError((error, stackTrace) {
      Sentry.captureException(error, stackTrace: stackTrace);
      handleError(error);
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
    if (actionUserBox.values
        .where((element) => (element.isNew || element.isUpdated))
        .isEmpty) {
      return;
    }
    print('============= START: Sync Local ActionUser to Remote =============');
    StreamController<CreateUpdateActionUserRequest> _controller =
        StreamController();

    ActionRepository()
        .createUpdateActionUsers(_controller.stream)
        .then((response) {
      response.listen((value) {
        // delete this actionuser form `ACTION_USER_BOX`
        HiveActionUser _hiveActionUser = HiveActionUser.from(value.actionUser);

        ActionProvider().deleteActionUser(_hiveActionUser);
      });
    }).onError((error, stackTrace) {
      print('============= Error: ${error.toString()} ===============');
    }).whenComplete(() {
      _controller.close();
    });

    actionUserBox.values
        .where((element) => (element.isNew || element.isUpdated))
        .forEach((HiveActionUser _hiveActionUser) {
      if (_hiveActionUser.isNew || _hiveActionUser.isUpdated) {
        var request = CreateUpdateActionUserRequest.create();
        request.actionUser = _hiveActionUser.toActionUser();

        FieldMask mask = FieldMask(paths: kActionUserFieldMask);
        request.updateMask = mask;

        _controller.add(request);
      }
    });
    print('============= END: Sync Local ActionUser to Remote ===============');
  }

  Future syncLocalLearnerEvaluationsToRemote() async {
    if (learnerEvaluationBox.values
        .where((element) => (element.isNew || element.isUpdated))
        .isEmpty) {
      return;
    }
    print(
        '============= START: Sync LocalLearnerEvaluationsToRemote =============');
    StreamController<CreateUpdateLearnerEvaluationRequest> _controller =
        StreamController();

    try {
      ResponseStream<CreateUpdateLearnerEvaluationResponse> responseStream =
          await ResultsRepository()
              .createUpdateLearnerEvaluations(_controller.stream);
      learnerEvaluationBox.values
          .where((element) => element.isNew || element.isUpdated)
          .forEach((_hiveLearnerEvaluation) {
        var request = CreateUpdateLearnerEvaluationRequest.create();

        request.learnerEvaluation =
            _hiveLearnerEvaluation.toLearnerEvaluation();

        _controller.add(request);
      });
      _controller.close();

      return await responseStream.forEach((response) {
        print('Remote Learner Evaluation: ${response.learnerEvaluation}');
        if (response.status ==
            CreateUpdateLearnerEvaluationResponse_Status.SUCCESS) {
          // update flag(s) isNew and/or isUpdated to false
          LearnerEvaluationProvider().createUpdateLearnerEvaluation(
              HiveLearnerEvaluation.from(response.learnerEvaluation));

          print(
              '============= END: LocalLearnerEvaluationsToRemote =============');
        } else {
          print("ERROR: LocalLearnerEvaluationsToRemote STATUS.FAILED");
        }
      });
    } catch (error, stackTrace) {
      Sentry.captureException(error, stackTrace: stackTrace);
      handleError(error);
    } finally {
      _controller.close();
    }
  }

  Future syncLocalGroupEvaluationsToRemote() async {
    if (groupEvaluationBox.values
        .where((element) => (element.isNew || element.isUpdated))
        .isEmpty) {
      return;
    }
    print(
        '============= START: Sync LocalGroupEvaluationsToRemote =============');
    StreamController<CreateUpdateGroupEvaluationRequest> _controller =
        StreamController();

    try {
      ResponseStream<CreateUpdateGroupEvaluationResponse> responseStream =
          await ResultsRepository()
              .createUpdateGroupEvaluations(_controller.stream);
      groupEvaluationBox.values
          .where((element) => element.isNew || element.isUpdated)
          .forEach((_hiveGroupEvaluation) {
        var request = CreateUpdateGroupEvaluationRequest.create();

        request.groupEvaluation = _hiveGroupEvaluation.toGroupEvaluation();

        _controller.add(request);
      });
      _controller.close();

      return await responseStream.forEach((response) {
        print('Remote Group Evaluation: ${response.groupEvaluation}');
        if (response.status ==
            CreateUpdateGroupEvaluationResponse_Status.SUCCESS) {
          // update flag(s) isNew and/or isUpdated to false
          GroupEvaluationProvider().createUpdateGroupEvaluation(
              HiveGroupEvaluation.from(response.groupEvaluation));
          print(
              '============= END: LocalGroupEvaluationsToRemote =============');
        } else {
          print("ERROR: LocalGroupEvaluationsToRemote STATUS.FAILED");
        }
      });
    } catch (error, stackTrace) {
      Sentry.captureException(error, stackTrace: stackTrace);
      handleError(error);
    } finally {
      _controller.close();
    }
  }

  Future syncLocalTransformationsToRemote() async {
    if (transformationBox.values
        .where((element) => (element.isNew || element.isUpdated))
        .isEmpty) {
      return;
    }
    print(
        '============= START: Sync LocalTransformationsToRemote =============');
    StreamController<CreateUpdateTransformationRequest> _controller =
        StreamController();

    try {
      ResponseStream<CreateUpdateTransformationResponse> responseStream =
          await ResultsRepository()
              .createUpdateTransformations(_controller.stream);
      transformationBox.values
          .where((element) => element.isNew || element.isUpdated)
          .forEach((_hivetransformation) {
        var request = CreateUpdateTransformationRequest.create();

        request.transformation = _hivetransformation.toTransformation();

        if (_hivetransformation.isUpdated) {
          FieldMask mask = FieldMask(paths: kTransformationFieldMask);
          request.updateMask = mask;
        }

        _controller.add(request);
      });
      _controller.close();

      return await responseStream.forEach((response) {
        print('Remote Transformation: ${response.transformation}');
        if (response.status ==
            CreateUpdateTransformationResponse_Status.SUCCESS) {
          // update flag(s) isNew and/or isUpdated to false
          TransformationProvider().createUpdateTransformation(
              HiveTransformation.from(response.transformation));
          print(
              '============= END: LocalTransformationsToRemote =============');
        } else {
          print("ERROR: LocalTransformationsToRemote STATUS.FAILED");
        }
      });
    } catch (error, stackTrace) {
      Sentry.captureException(error, stackTrace: stackTrace);
      handleError(error);
    } finally {
      _controller.close();
    }
  }

  Future syncLocalTeacherResponsesToRemote() async {
    if (teacherResponseBox.values
        .where((element) => (element.isNew || element.isUpdated))
        .isEmpty) {
      return;
    }
    print(
        '============= START: Sync syncLocalTeacherResponsesToRemote =============');
    StreamController<CreateUpdateTeacherResponseRequest> _controller =
        StreamController();

    try {
      ResponseStream<CreateUpdateTeacherResponseResponse> responseStream =
          await ResultsRepository()
              .createUpdateTeacherResponses(_controller.stream);
      teacherResponseBox.values
          .where((element) => element.isNew || element.isUpdated)
          .forEach((_hiveTeacherResponse) {
        var request = CreateUpdateTeacherResponseRequest.create();

        request.teacherResponse = _hiveTeacherResponse.toTeacherResponse();

        _controller.add(request);
      });
      _controller.close();

      return await responseStream.forEach((response) {
        print('Remote Teacher Response: ${response.teacherResponse}');
        if (response.status ==
            CreateUpdateTeacherResponseResponse_Status.SUCCESS) {
          // update flag(s) isNew and/or isUpdated to false
          TeacherResponseProvider().createUpdateTeacherResponse(
              HiveTeacherResponse.from(response.teacherResponse));

          print(
              '============= END: syncLocalTeacherResponsesToRemote =============');
        } else {
          print("ERROR: syncLocalTeacherResponsesToRemote STATUS.FAILED");
        }
      });
    } catch (error, stackTrace) {
      Sentry.captureException(error, stackTrace: stackTrace);
      handleError(error);
    } finally {
      _controller.close();
    }
  }

  Future syncLocalOutputsToRemote() async {
    if (outputBox.values
        .where((element) => (element.isNew || element.isUpdated))
        .isEmpty) {
      return;
    }
    print('============= START: Sync syncLocalOutputsToRemote =============');
    StreamController<CreateUpdateOutputRequest> _controller =
        StreamController();

    try {
      ResponseStream<CreateUpdateOutputResponse> responseStream =
          await ResultsRepository().createUpdateOutputs(_controller.stream);
      outputBox.values
          .where((element) => element.isNew || element.isUpdated)
          .forEach((_hiveOutput) {
        var request = CreateUpdateOutputRequest.create();

        request.output = _hiveOutput.toOutput();

        _controller.add(request);
      });
      _controller.close();

      return await responseStream.forEach((response) {
        print('Remote Output Response: ${response.output}');
        if (response.status == CreateUpdateOutputResponse_Status.SUCCESS) {
          // update flag(s) isNew and/or isUpdated to false
          OutputProvider().createUpdateOutput(HiveOutput.from(response.output));

          print('============= END: syncLocalOutputsToRemote =============');
        } else {
          print("ERROR: syncLocalOutputsToRemote STATUS.FAILED");
        }
      });
    } catch (error, stackTrace) {
      Sentry.captureException(error, stackTrace: stackTrace);
      handleError(error);
    } finally {
      _controller.close();
    }
  }

  Future syncLearnerEvaluations() async {
    /**
     * TODO: fetch only records updated after last sync and update in local DB.
     */
    if (DEBUG) {
      learnerEvaluationBox.values.forEach((element) {});
    }

    await ResultsRepository()
        .listLearnerEvaluations()
        .then((ResponseStream<LearnerEvaluation> stream) {
      stream.listen((learnerEvaluation) {
        HiveLearnerEvaluation _hiveLearnerEvaluation =
            HiveLearnerEvaluation.from(learnerEvaluation);

        ResultsProvider().createUpdateLearnerEvaluation(_hiveLearnerEvaluation);
      }, onError: ((err) {
        handleGrpcError(err);
      }), onDone: () {
        print('LearnerEvaluation Sync Done.');
      });
      // ignore: invalid_return_type_for_catch_error
    }).catchError(handleError);
  }

  Future syncGroupEvaluations() async {
    /**
     * TODO: fetch only records updated after last sync and update in local DB.
     */
    if (DEBUG) {
      learnerEvaluationBox.values.forEach((element) {});
    }

    await ResultsRepository()
        .listGroupEvaluations()
        .then((ResponseStream<GroupEvaluation> stream) {
      stream.listen((groupEvaluation) {
        HiveGroupEvaluation _hiveGroupEvaluation =
            HiveGroupEvaluation.from(groupEvaluation);

        ResultsProvider().createUpdateGroupEvaluation(_hiveGroupEvaluation);
      }, onError: ((err) {
        handleGrpcError(err);
      }), onDone: () {
        print('GroupEvaluations Sync Done.');
      });
      // ignore: invalid_return_type_for_catch_error
    }).catchError(handleError);
  }

  Future syncTransformaitons() async {
    /**
     * TODO: fetch only records updated after last sync and update in local DB.
     */
    if (DEBUG) {
      transformationBox.values.forEach((element) {});
    }

    await ResultsRepository()
        .listTransformations()
        .then((ResponseStream<Transformation> stream) {
      stream.listen((transformaiton) {
        HiveTransformation _hiveTransformation =
            HiveTransformation.from(transformaiton);

        if (_hiveTransformation.files != null &&
            _hiveTransformation.files!.length > 0) {
          addEntityFilesToLocalDB(
              entityId: _hiveTransformation.id!,
              entityType: EntityType.TRANSFORMATION,
              files: _hiveTransformation.files!);
        }

        ResultsProvider().createUpdateTransformation(_hiveTransformation);
      }, onError: ((err) {
        handleGrpcError(err);
      }), onDone: () {
        print('Transformaitons Sync Done.');
      });
      // ignore: invalid_return_type_for_catch_error
    }).catchError(handleError);
  }

  Future syncTeacherResponses() async {
    /**
     * TODO: fetch only records updated after last sync and update in local DB.
     */
    if (DEBUG) {
      teacherResponseBox.values.forEach((element) {});
    }

    await ResultsRepository()
        .listTeacherResponses()
        .then((ResponseStream<TeacherResponse> stream) {
      stream.listen((teacherResponse) {
        HiveTeacherResponse _hiveTeacherResponse =
            HiveTeacherResponse.from(teacherResponse);

        ResultsProvider().createUpdateTeacherResponse(_hiveTeacherResponse);
      }, onError: ((err) {
        handleGrpcError(err);
      }), onDone: () {
        print('TeacherResponse Sync Done.');
      });
      // ignore: invalid_return_type_for_catch_error
    }).catchError(handleError);
  }

  Future syncOutputs() async {
    /**
     * TODO: fetch only records updated after last sync and update in local DB.
     */
    if (DEBUG) {
      outputBox.values.forEach((element) {});
    }

    await ResultsRepository()
        .listOutputs()
        .then((ResponseStream<Output> stream) {
      stream.listen((output) {
        HiveOutput _hiveOutput = HiveOutput.from(output);

        OutputProvider().createUpdateOutput(_hiveOutput);
      }, onError: ((err) {
        handleGrpcError(err);
      }), onDone: () {
        print('Output Sync Done.');
      });
      // ignore: invalid_return_type_for_catch_error
    }).catchError(handleError);
  }

  void handleError(error) {
    print('handleError: error');
    if (error.runtimeType == GrpcError) {
      handleGrpcError(error);
    } else {
      debugPrint('Error: $error');
    }
  }

  void handleGrpcError(GrpcError error, {Function()? callback}) async {
    debugPrint('handleGrpcError[grpcError]: $error');

    if (error.code == StatusCode.unauthenticated) {
      // StatusCode 16
      // Refresh Session
      await _refreshSessionLock.synchronized(() async {
        try {
          AuthenticateResponse authenticateResponse =
              await _refreshSession(callback: callback);

          StarfishSharedPreference().setLoginStatus(true);
          StarfishSharedPreference()
              .setAccessToken(authenticateResponse.userToken);
          StarfishSharedPreference()
              .setRefreshToken(authenticateResponse.refreshToken);
          StarfishSharedPreference()
              .setSessionUserId(authenticateResponse.userId);

          if (callback != null) {
            callback();
          }
          syncAll();
        } catch (error, stackTrace) {
          Sentry.captureMessage("ERROR Failed to refresh token");
          Sentry.captureException(error, stackTrace: stackTrace);
          debugPrint("Failed to refresh token");
          if (error.runtimeType == GrpcError) {
            if (FlavorConfig.isDevelopment()) {
              StarfishSnackbar.showErrorMessage(
                  NavigationService.navigatorKey.currentContext!,
                  '${(error as GrpcError).codeName}: ${error.message}');
            }

            FBroadcast.instance().broadcast(
              SyncService.kUnauthenticated,
            );
          }
        } finally {}
      });
    } else {
      debugPrint('${error.codeName}: ${error.message}');
      if (FlavorConfig.isDevelopment()) {
        StarfishSnackbar.showErrorMessage(
            NavigationService.navigatorKey.currentContext!,
            '${error.codeName}: ${error.message}');
      }
    }
  }

  Future<AuthenticateResponse> _refreshSession({Function()? callback}) async {
    debugPrint("refreshSession called");
    String _refreshToken = await StarfishSharedPreference().getRefreshToken();
    String _userId = await StarfishSharedPreference().getSessionUserId();
    debugPrint("REfresh Session: $_refreshToken");
    Sentry.captureMessage("REfresh Session: " + _refreshToken);
    return ApiProvider().refreshSession(_refreshToken, _userId); //
  }
}
