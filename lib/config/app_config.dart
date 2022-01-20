import 'package:flutter/material.dart';

enum Flavor { DEV, PROD }

class FlavorValues {
  FlavorValues({required this.baseUrl, required this.apiKey});
  final String baseUrl;
  final String apiKey;

  //Add other flavor specific values, e.g database name
}

class FlavorConfig {
  final Flavor flavor;
  final FlavorValues values;
  static FlavorConfig? _instance;

  factory FlavorConfig(
      {@required Flavor? flavor, @required FlavorValues? values}) {
    _instance ??= FlavorConfig._internal(flavor!, values!);
    return _instance!;
  }
  FlavorConfig._internal(this.flavor, this.values);
  static FlavorConfig? get instance {
    return _instance;
  }

  static bool isProduction() => _instance!.flavor == Flavor.PROD;
  static bool isDevelopment() => _instance!.flavor == Flavor.DEV;
}
