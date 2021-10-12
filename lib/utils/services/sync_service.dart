import 'package:grpc/grpc.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:collection/collection.dart';
import 'package:rxdart/rxdart.dart';
import 'package:starfish/db/hive_action.dart';
import 'package:starfish/db/hive_action_user.dart';
import 'package:starfish/db/hive_country.dart';
import 'package:starfish/db/hive_current_user.dart';
import 'package:starfish/db/hive_database.dart';
import 'package:starfish/db/hive_evaluation_category.dart';
import 'package:starfish/db/hive_group.dart';
import 'package:starfish/db/hive_group_user.dart';
import 'package:starfish/db/hive_language.dart';
import 'package:starfish/db/hive_last_sync_date_time.dart';
import 'package:starfish/db/hive_material.dart';
import 'package:starfish/db/hive_material_feedback.dart';
import 'package:starfish/db/hive_material_topic.dart';
import 'package:starfish/db/hive_material_type.dart';
import 'package:starfish/db/hive_user.dart';
import 'package:starfish/repository/app_data_repository.dart';
import 'package:starfish/repository/current_user_repository.dart';
import 'package:starfish/repository/group_repository.dart';
import 'package:starfish/repository/materials_repository.dart';
import 'package:starfish/repository/user_repository.dart';
import 'package:starfish/src/generated/starfish.pb.dart';
import 'package:starfish/utils/services/field_mask.dart';
import 'package:starfish/utils/services/local_storage_service.dart';

class SyncService {
  final DEBUG = false;

  static final String kUpdateMaterial = 'updateMaterial';
  static final String kUpdateGroup = 'updateGroup';
  static final String kUpdateUsers = 'updateUsers';

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
  }

  void syncAll() async {
    await syncLocalCurrentUser(kCurrentUserFieldMask);
    await syncLocalMaterialsToRemote();
    await syncLocalUsersToRemote();
    await syncLocalGroupsToRemote();

    syncCurrentUser();
    syncUsers();
    syncCountries();
    syncLanguages();
    syncMaterialTopics();
    syncMaterialTypes();
    syncMaterial();

    syncEvaluationCategories();
    syncGroup();

    DateTime now = DateTime.now();
    print(DateFormat('HH:mm:ss').format(now));
    HiveLastSyncDateTime _lastSyncDateTime = new HiveLastSyncDateTime(
        year: now.year,
        month: now.month,
        day: now.day,
        hour: now.hour,
        minute: now.minute,
        second: now.second);
    lastSyncBox.add(_lastSyncDateTime);
  }

  syncCurrentUser() async {
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
      );

      var filterData = currentUserBox.values
          .where((currentUser) => currentUser.id == user.id)
          .toList();
      if (filterData.length == 0) {
        currentUserBox.add(_user);
      } else {
        //update record
        currentUserBox.putAt(0, _user);
      }

      StarfishSharedPreference().setAccessToken(user.phone);
    });
  }

  syncUsers() async {
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

  syncCountries() async {
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

  syncLanguages() async {
    languageBox.clear();
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

  syncMaterial() async {
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

  syncMaterialTopics() async {
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

  syncMaterialTypes() async {
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
    print(
        'Total Records: ${materialBox.values.where((element) => element.isNew == true).length}');

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

  syncGroup() async {
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
        HiveGroup _group = HiveGroup.from(group);

        int _currentIndex = -1;
        groupBox.values.toList().asMap().forEach((key, hiveGroup) {
          if (hiveGroup.id == group.id) {
            _currentIndex = key;
          }
        });

        if (_currentIndex > -1) {
          groupBox.put(_currentIndex, _group);
        } else {
          groupBox.add(_group);
        }
      }, onError: ((err) {
        print('Group Sync Error: ${err.toString()}');
      }), onDone: () {
        print('Group Sync Done.');
      });
    });
  }

  syncEvaluationCategories() async {
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
    HiveCurrentUser? _currentUser = currentUserBox.values
        .firstWhereOrNull((element) => element.isUpdated == true);

    if (_currentUser != null) {
      await CurrentUserRepository()
          .updateCurrentUser(_currentUser.toUser(), _fieldMaskPaths);
    }
  }

  syncLocalUsersToRemote() async {
    print('============= START: Sync Local User to Remote =============');
    print(
        'Total Records: ${userBox.values.where((element) => element.isNew == true).length}');

    BehaviorSubject<User> _users = BehaviorSubject<User>();

    userBox.values
        .where((HiveUser user) => (user.isNew == true))
        .forEach((HiveUser _hiveUser) {
      _users.sink.add(_hiveUser.toUser());

      UserRepository().createUsers(_users.stream).then((value) {
        // TODO: update flag(s) isNew and/or isUpdated to false
      }).whenComplete(() {
        print('============= END: Sync Local User to Remote ===============');
        _users.close();
      });
    });
  }

  syncLocalGroupsToRemote() async {
    print('============= START: Sync Local Groups to Remote =============');
    print(
        'Total Records: ${userBox.values.where((element) => element.isNew == true).length}');

    groupBox.values
        .where((HiveGroup group) => (group.isNew == true))
        .forEach((HiveGroup _hiveGroup) {
      GroupRepository()
          .createUpdateGroup(
              group: _hiveGroup.toGroup(), fieldMaskPaths: kGroupFieldMask)
          .then((value) {
        // update flag(s) isNew and/or isUpdated to false
        _hiveGroup.isNew = false;
        _hiveGroup.isUpdated = false;

        GroupRepository().addEditGroup(_hiveGroup);
      }).onError((error, stackTrace) {
        print(
            '============= syncLocalGroupsToRemote Error: ${error.toString()} ===============');
      }).whenComplete(() {
        print('============= END: Sync Local Groups to Remote ===============');
      });
    });
  }
}
