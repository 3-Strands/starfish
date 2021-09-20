import 'package:grpc/grpc.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:starfish/db/hive_action.dart';
import 'package:starfish/db/hive_country.dart';
import 'package:starfish/db/hive_current_user.dart';
import 'package:starfish/db/hive_database.dart';
import 'package:starfish/db/hive_group.dart';
import 'package:starfish/db/hive_language.dart';
import 'package:starfish/db/hive_last_sync_date_time.dart';
import 'package:starfish/db/hive_material.dart';
import 'package:starfish/db/hive_material_feedback.dart';
import 'package:starfish/db/hive_material_topic.dart';
import 'package:starfish/db/hive_material_type.dart';
import 'package:starfish/repository/app_data_repository.dart';
import 'package:starfish/repository/current_user_repository.dart';
import 'package:starfish/repository/materials_repository.dart';
import 'package:starfish/src/generated/starfish.pb.dart';

class SyncService {
  static syncNow() {}

  late Box<HiveLastSyncDateTime> lastSyncBox;
  late Box<HiveCountry> countryBox;
  late Box<HiveLanguage> languageBox;
  late Box<HiveCurrentUser> currentUserBox;
  late Box<HiveGroup> groupBox;
  late Box<HiveAction> actionBox;
  late Box<HiveMaterial> materialBox;
  late Box<HiveMaterialFeedback> materialFeedbackBox;
  late Box<HiveMaterialTopic> materialTopicBox;
  late Box<HiveMaterialType> materialTypeBox;

  SyncService() {
    lastSyncBox = Hive.box<HiveLastSyncDateTime>(HiveDatabase.LAST_SYNC_BOX);
    countryBox = Hive.box<HiveCountry>(HiveDatabase.COUNTRY_BOX);
    languageBox = Hive.box<HiveLanguage>(HiveDatabase.LANGUAGE_BOX);
    currentUserBox = Hive.box<HiveCurrentUser>(HiveDatabase.CURRENT_USER_BOX);
    groupBox = Hive.box<HiveGroup>(HiveDatabase.GROUPS_BOX);
    actionBox = Hive.box<HiveAction>(HiveDatabase.ACTIONS_BOX);
    materialBox = Hive.box<HiveMaterial>(HiveDatabase.MATERIAL_BOX);
    materialFeedbackBox =
        Hive.box<HiveMaterialFeedback>(HiveDatabase.MATERIAL_FEEDBACK_BOX);
    materialTopicBox =
        Hive.box<HiveMaterialTopic>(HiveDatabase.MATERIAL_TOPIC_BOX);
    materialTypeBox =
        Hive.box<HiveMaterialType>(HiveDatabase.MATERIAL_TYPE_BOX);
  }

  void syncAll() {
    syncLocalMaterialsToRemote();

    syncCurrentUser();
    syncCountries();
    syncLanguages();
    syncMaterialTopics();
    syncMaterialTypes();
    syncMaterial();

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
      List<HiveGroup> groups = (user.groups
          .map((e) => HiveGroup(
              groupId: e.groupId, userId: e.userId, role: e.role.toString()))
          .toList());
      List<HiveAction> actions = (user.actions
          .map((e) => HiveAction(
              actionId: e.actionId,
              userId: e.userId,
              status: e.status.toString(),
              teacherResponse: e.teacherResponse))
          .toList());

      HiveCurrentUser _user = HiveCurrentUser(
          id: user.id,
          name: user.name,
          phone: user.phone,
          linkGroup: user.linkGroups,
          countryIds: user.countryIds,
          languageIds: user.languageIds,
          groups: groups,
          actions: actions,
          selectedActionsTab: user.selectedActionsTab.toString(),
          selectedResultsTab: user.selectedResultsTab.toString());

      var filterData = currentUserBox.values
          .where((currentUser) => currentUser.id == user.id)
          .toList();
      if (filterData.length == 0) {
        currentUserBox.add(_user);
      } else {
        //update record
        currentUserBox.putAt(0, _user);
      }
    });
  }

  syncCountries() async {
    await AppDataRepository()
        .getAllCountries()
        .then((ResponseStream<Country> country) {
      country.listen((value) {
        // print(value);
        var filterData = countryBox.values
            .where((countryModel) => countryModel.id == value.id)
            .toList();
        if (filterData.length == 0) {
          HiveCountry _country = HiveCountry(
              id: value.id, name: value.name, diallingCode: value.diallingCode);
          countryBox.add(_country);
        } else {
          //update record
        }
      }, onError: ((err) {
        print(err);
      }), onDone: () {
        print('Country Sync Done.');
        // for (var count in countryBox.values.toList()) {
        //   print(count.id);
        //   print(count.name);
        //   print(count.diallingCode);
        // }
      });
    });
  }

  syncLanguages() async {
    await AppDataRepository()
        .getAllLanguages()
        .then((ResponseStream<Language> language) {
      language.listen((value) {
        var filterData = languageBox.values
            .where((element) => element.id == value.id)
            .toList();
        if (filterData.length == 0) {
          HiveLanguage _language = HiveLanguage(id: value.id, name: value.name);
          languageBox.add(_language);
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
    materialBox.values.forEach((element) {
      element.delete();
    });

    await MaterialRepository()
        .getMaterials()
        .then((ResponseStream<Material> material) {
      material.listen((value) {
        HiveMaterial _material = HiveMaterial.from(value);
        materialBox.add(_material);
      }, onError: ((err) {
        print(err);
      }), onDone: () {
        print('Material Sync Done.');
        // for (var count in materialBox.values.toList()) {
        //   print(count.id);
        //   print(count.title);
        // }
      });
    });
  }

  syncMaterialTopics() async {
    /**
     * TODO: fetch only records updated after last sync and update in local DB.
     */
    materialTopicBox.values.forEach((element) {
      element.delete();
    });

    await MaterialRepository()
        .getMaterialTopics()
        .then((ResponseStream<MaterialTopic> topics) {
      topics.listen((value) {
        HiveMaterialTopic _materialTopic = HiveMaterialTopic.from(value);
        materialTopicBox.add(_materialTopic);
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
    materialTypeBox.values.forEach((element) {
      element.delete();
    });

    await MaterialRepository()
        .getMaterialTypes()
        .then((ResponseStream<MaterialType> topics) {
      topics.listen((value) {
        HiveMaterialType _materialType = HiveMaterialType.from(value);
        materialTypeBox.add(_materialType);
      }, onError: ((err) {
        print(err);
      }), onDone: () {
        print('MaterialType Sync Done.');
      });
    });
  }

  syncLocalMaterialsToRemote() async {
    final List<String> _fieldMaskPaths = [
      'title',
      'description',
      'visibility',
      'editability',
      'url',
      'files',
      'languageIds',
      'typeIds',
      'topics',
    ];
    print('============= START: Sync Local Materials to Remote =============');
    print(
        'Total Records: ${materialBox.values.where((element) => element.isNew == true).length}');
    print('============= END: Sync Local Materials to Remote ===============');

    materialBox.values.where((element) => element.isNew == true).map((e) {
      if (e.isNew) {
        _createMaterial(fieldMaskPaths: _fieldMaskPaths);
      }
    });
  }

  _createMaterial({
    String? id,
    String? creatorId,
    Material_Status? status,
    String? title,
    String? description,
    String? url,
    Material_Visibility? visibility,
    Material_Editability? editability,
    Iterable<String>? files,
    Iterable<String>? languageIds,
    Iterable<String>? typeIds,
    Iterable<String>? topics,
    required List<String> fieldMaskPaths,
  }) {
    MaterialRepository().createUpdateMaterial(
      id,
      creatorId,
      status,
      title,
      description,
      url,
      visibility,
      editability,
      files,
      languageIds,
      typeIds,
      topics,
      fieldMaskPaths,
    );
  }
}
