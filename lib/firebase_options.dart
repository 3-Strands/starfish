// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDn9VMgSgy73y6Xc8RLpB8NhUkNC7nbDkE',
    appId: '1:107890862409:web:461f97cafdd146940f9298',
    messagingSenderId: '107890862409',
    projectId: 'starfish-3s',
    authDomain: 'starfish-3s.firebaseapp.com',
    databaseURL: 'https://starfish-3s-default-rtdb.firebaseio.com',
    storageBucket: 'starfish-3s.appspot.com',
    measurementId: 'G-D4D1HDB9PK',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCevqciEnoFzvvjlTLgEq4_8WFky0kTZQg',
    appId: '1:107890862409:android:f3fdaf9c310df7c40f9298',
    messagingSenderId: '107890862409',
    projectId: 'starfish-3s',
    databaseURL: 'https://starfish-3s-default-rtdb.firebaseio.com',
    storageBucket: 'starfish-3s.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBxmtSkZgYjYFi56FoK1ab0tZF_HBO40gA',
    appId: '1:107890862409:ios:d57e2b83078e7eaf0f9298',
    messagingSenderId: '107890862409',
    projectId: 'starfish-3s',
    databaseURL: 'https://starfish-3s-default-rtdb.firebaseio.com',
    storageBucket: 'starfish-3s.appspot.com',
    androidClientId: '107890862409-ecdf541pmpli7l791repnpifr104af5d.apps.googleusercontent.com',
    iosClientId: '107890862409-p7132rrtnvh119qh3f1s2s702h48nbv6.apps.googleusercontent.com',
    iosBundleId: 'com.sil.starfish',
  );
}