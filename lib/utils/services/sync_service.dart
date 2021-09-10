import 'package:grpc/grpc.dart';
import 'package:hive/hive.dart';
import 'package:starfish/db/hive_database.dart';
import 'package:starfish/models/country_model.dart';
import 'package:starfish/repository/app_data_repository.dart';
import 'package:starfish/src/generated/starfish.pb.dart';

class SyncService {
  static syncNow() {}

  late Box<CountryModel> countryBox;

  SyncService() {
    countryBox = Hive.box<CountryModel>(HiveDatabase.COUNTRY_BOX);
  }

  void syncAll() {
    syncCountries();
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
          CountryModel con = CountryModel(
              id: value.id, name: value.name, diallingCode: value.diallingCode);
          countryBox.add(con);
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
