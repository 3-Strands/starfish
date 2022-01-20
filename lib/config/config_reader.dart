import 'dart:convert';
import 'package:flutter/services.dart';

abstract class ConfigReader {
  static Map<String, dynamic> _config = Map();

  static Future<void> initialize() async {
    final configString =
        await rootBundle.loadString('config_reader/app_config.json');
    _config = json.decode(configString) as Map<String, dynamic>;
  }

  static String getDevURL() {
    return _config['dev_url'] as String;
  }

  static String getProdURL() {
    return _config['prod_url'] as String;
  }

  static String getDevAPIKey() {
    return _config['dev_api_key'] as String;
  }

  static String getProdAPIKey() {
    return _config['prod_api_key'] as String;
  }
}
