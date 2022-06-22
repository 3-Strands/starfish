import 'dart:convert';
import 'dart:html' show window;

import 'package:encrypt/encrypt.dart';
import 'platform_storage_api.dart';

const _randomKeyKey = '_starfishRandomKey';
const _randomKeyListKey = '_starfishRandomListKey';

Encrypter _makeEncryptor() {
  final randomKey = window.sessionStorage[_randomKeyKey];

  Key key;

  if (randomKey == null) {
    key = Key.fromSecureRandom(32);
    window.sessionStorage[_randomKeyKey] = key.base64;
  } else {
    key = Key.fromBase64(randomKey);
  }

  return Encrypter(AES(key, mode: AESMode.sic));
}

class PlatformStorage implements PlatformStorageApi {
  static final _encrypter = _makeEncryptor();

  @override
  Future<bool?> getBool(String key) async {
    final value = window.sessionStorage[key];
    return value == 'true' ? true : value == 'false' ? false : null;
  }

  @override
  Future<String> getEncryptedString(String key) async {
    String decrypted = '';

    /// Get encrypted value
    final encryptedValue = window.sessionStorage[key];

    if (encryptedValue != null) {
      /// Get random key list index using the encrypted value as key
      final String indexString = window.sessionStorage[encryptedValue]!;
      final int index = int.parse(indexString);

      /// Get random key from random key list using the index
      final List<String> randomKeyList = _getStringList(_randomKeyListKey)!;
      final String ivValue = randomKeyList[index];

      final IV iv = IV.fromBase64(ivValue);
      final Encrypted encrypted = Encrypted.fromBase64(encryptedValue);

      decrypted = _encrypter.decrypt(encrypted, iv: iv);
    }

    return decrypted;
  }

  @override
  Future<String?> getString(String key) async {
    return window.sessionStorage[key];
  }

  @override
  Future<bool> setBool(String key, bool value) async {
    window.sessionStorage[key] = value.toString();
    return true;
  }

  @override
  Future<bool> setEncryptedString(String key, String value) async {
    if (value.isNotEmpty) {
      /// Generate random IV
      final IV iv = IV.fromSecureRandom(16);
      final String ivValue = iv.base64;

      /// Encrypt value
      final Encrypted encrypted = _encrypter.encrypt(value, iv: iv);
      final String encryptedValue = encrypted.base64;

      /// Add generated random IV to a list
      final List<String> randomKeyList =
          _getStringList(_randomKeyListKey) ?? <String>[];
      randomKeyList.add(ivValue);
      _setStringList(_randomKeyListKey, randomKeyList);

      /// Save random key list index, We used encrypted value as key so we could use that to access it later
      final int index = randomKeyList.length - 1;
      window.sessionStorage[encryptedValue] = index.toString();

      /// Save encrypted value
      window.sessionStorage[key] = encryptedValue;
      return true;
    }

    /// Value is empty
    return false;
  }

  @override
  Future<bool> setString(String key, String value) async {
    if (value.isEmpty) {
      return false;
    }
    window.sessionStorage[key] = value;
    return true;
  }

  List<String>? _getStringList(String key) {
    final value = window.sessionStorage[key];
    if (value != null) {
      List list = jsonDecode(value);
      return List<String>.from(list);
    }
    return null;
  }

  bool _setStringList(String key, List<String> value) {
    if (value.isEmpty) {
      return false;
    }
    window.sessionStorage[key] = jsonEncode(value);
    return true;
  }
}
