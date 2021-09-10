import 'dart:io';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:starfish/models/country_model.dart';

class HiveDatabase {
  static const String COUNTRY_BOX = 'country';
  static const String MATERIAL_BOX = 'materialBox';

  // static final HiveDatabase _dbHelper = HiveDatabase._internal();

  // late Box<HiveMaterial> materialBox;
  late Box<CountryModel> countryBox;

  // HiveDatabase._internal() {
  //   initHive();
  // }

  void init() async {
    Directory directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);
    Hive.registerAdapter(CountryModelAdapter());
    openBoxes();
  }

  void openBoxes() async {
    print("open boxes");
    // materialBox = await Hive.openBox<HiveMaterial>(MATERIAL_BOX);
    ////countryBox = await Hive.openBox<CountryModel>(COUNTRY_BOX);

    await Hive.openBox<CountryModel>(COUNTRY_BOX);
  }
}
