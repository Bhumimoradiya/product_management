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
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
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
    apiKey: 'AIzaSyCE2kT8eci_B-VksiPPgYAWxURsTz69DYc',
    appId: '1:854060060873:web:6eb9d8f011a84ca9a0fd18',
    messagingSenderId: '854060060873',
    projectId: 'product-inventory-96403',
    authDomain: 'product-inventory-96403.firebaseapp.com',
    storageBucket: 'product-inventory-96403.appspot.com',
    measurementId: 'G-QY6N5223RR',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCqoOrgOA9t2RYty7GAyA7SDm3TY6g9YnM',
    appId: '1:854060060873:android:fa07c167d31fe976a0fd18',
    messagingSenderId: '854060060873',
    projectId: 'product-inventory-96403',
    storageBucket: 'product-inventory-96403.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC1YOOJPyaWbJcBTpFbWKyLIaXixzwChn8',
    appId: '1:854060060873:ios:d8e00475854fcd5ba0fd18',
    messagingSenderId: '854060060873',
    projectId: 'product-inventory-96403',
    storageBucket: 'product-inventory-96403.appspot.com',
    iosBundleId: 'com.example.productManagement',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC1YOOJPyaWbJcBTpFbWKyLIaXixzwChn8',
    appId: '1:854060060873:ios:d8e00475854fcd5ba0fd18',
    messagingSenderId: '854060060873',
    projectId: 'product-inventory-96403',
    storageBucket: 'product-inventory-96403.appspot.com',
    iosBundleId: 'com.example.productManagement',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCE2kT8eci_B-VksiPPgYAWxURsTz69DYc',
    appId: '1:854060060873:web:754f92fc6e39e823a0fd18',
    messagingSenderId: '854060060873',
    projectId: 'product-inventory-96403',
    authDomain: 'product-inventory-96403.firebaseapp.com',
    storageBucket: 'product-inventory-96403.appspot.com',
    measurementId: 'G-B38GTG5ZZE',
  );
}
