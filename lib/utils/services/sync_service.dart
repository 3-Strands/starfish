import 'package:grpc/grpc.dart';
import 'package:hive/hive.dart';
import 'package:starfish/db/hive_action.dart';
import 'package:starfish/db/hive_country.dart';
import 'package:starfish/db/hive_current_user.dart';
import 'package:starfish/db/hive_database.dart';
import 'package:starfish/db/hive_group.dart';
import 'package:starfish/db/hive_language.dart';
import 'package:starfish/repository/app_data_repository.dart';
import 'package:starfish/repository/current_user_repository.dart';
import 'package:starfish/src/generated/starfish.pb.dart';

class SyncService {
  static syncNow() {}

  late Box<HiveCountry> countryBox;
  late Box<HiveLanguage> languageBox;
  late Box<HiveCurrentUser> currentUserBox;
  late Box<HiveGroup> groupBox;
  late Box<HiveAction> actionBox;

  SyncService() {
    countryBox = Hive.box<HiveCountry>(HiveDatabase.COUNTRY_BOX);
    languageBox = Hive.box<HiveLanguage>(HiveDatabase.LANGUAGE_BOX);
    currentUserBox = Hive.box<HiveCurrentUser>(HiveDatabase.CURRENT_USER_BOX);
    groupBox = Hive.box<HiveGroup>(HiveDatabase.GROUPS_BOX);
    actionBox = Hive.box<HiveAction>(HiveDatabase.ACTIONS_BOX);
  }

  void syncAll() {
    syncCurrentUser();
    syncCountries();
  }

  syncCurrentUser() async {
    await CurrentUserRepository().getUser().then((User user) {
      print("get current user");
      var filterData = currentUserBox.values
          .where((currentUser) => currentUser.id == user.id)
          .toList();
      if (filterData.length == 0) {
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

        currentUserBox.add(_user);
      } else {
        //update record
      }
      // setState(() {
      //   _userName = user.name;
      //   _nameController.text = user.name;
      //   _mobileNumber = user.phone;
      //   _phoneNumberController.text = user.phone;
      // });
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
        print('done');
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
        .then((ResponseStream<Language> country) {
      country.listen((value) {
        // print(value);
        var filterData = countryBox.values
            .where((countryModel) => countryModel.id == value.id)
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
        print('done');
        // for (var count in countryBox.values.toList()) {
        //   print(count.id);
        //   print(count.name);
        //   print(count.diallingCode);
        // }
      });
    });
  }

  // static syncMaterial() async {
  //   final Box<HiveMaterial> materialBox = await HiveDatabase().materialBox;

  //   await MaterialRepository()
  //       .getMaterials()
  //       .then((ResponseStream<starfish.Material> responseStream) {
  //     responseStream.listen((starfish.Material value) {
  //       HiveMaterial dbMaterialObj = HiveMaterial();

  //       dbMaterialObj.creatorId = value.creatorId;
  //       print(value.title);
  //     }, onError: ((err) {
  //       print(err);
  //     }), onDone: () {
  //       print('done');
  //     });
  //   });
  // }
}
