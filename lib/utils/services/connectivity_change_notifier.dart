import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class ConnectivityChangeNotifier extends ChangeNotifier {
  ConnectivityChangeNotifier() {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      resultHandler(result);
    });
  }
  ConnectivityResult _connectivityResult = ConnectivityResult.none;
  String _text = 'Offline';

  ConnectivityResult get connectivity => _connectivityResult;
  String get text => _text;

  void resultHandler(ConnectivityResult result) {
    _connectivityResult = result;
    if (result == ConnectivityResult.none) {
      _text = 'Offline';
    } else if (result == ConnectivityResult.mobile ||
        result == ConnectivityResult.wifi) {
      _text = 'Online';
    }
    notifyListeners();
  }

  void initialLoad() async {
    ConnectivityResult connectivityResult =
        await (Connectivity().checkConnectivity());
    resultHandler(connectivityResult);
  }
}
