// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA7D9Y0tn8Kw9io3KNO9ckGtUkRZ1H06vE',
    appId: '1:135236043527:android:9dab87537dc207ca2dfba2',
    messagingSenderId: '135236043527',
    projectId: 'iot-dd416',
    databaseURL: 'https://iot-dd416-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'iot-dd416.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAYV85QdReKnpqp1S2lsI3m2T9SVKs8seY',
    appId: '1:135236043527:ios:b07004186622015d2dfba2',
    messagingSenderId: '135236043527',
    projectId: 'iot-dd416',
    databaseURL: 'https://iot-dd416-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'iot-dd416.firebasestorage.app',
    iosBundleId: 'com.nylo.ios',
  );
}
