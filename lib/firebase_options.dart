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
        return macos;
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
    apiKey: 'AIzaSyA3ysVtWsgxYKox45sx-gudiuhX9y1KwBw',
    appId: '1:764910176316:web:390302af7f0cf524f45b39',
    messagingSenderId: '764910176316',
    projectId: 'whatsapp-97a3b',
    authDomain: 'whatsapp-97a3b.firebaseapp.com',
    storageBucket: 'whatsapp-97a3b.appspot.com',
    measurementId: 'G-DEZJW6VR42',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDwumerKmybxUj1T3BxqwnqLE5y4MO2Oqs',
    appId: '1:764910176316:android:77f0ec5ba283f24cf45b39',
    messagingSenderId: '764910176316',
    projectId: 'whatsapp-97a3b',
    storageBucket: 'whatsapp-97a3b.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAYwi9TPs1qjaiJ5GqFocQizCx1dUHp9p0',
    appId: '1:764910176316:ios:d106297f53114d12f45b39',
    messagingSenderId: '764910176316',
    projectId: 'whatsapp-97a3b',
    storageBucket: 'whatsapp-97a3b.appspot.com',
    iosClientId: '764910176316-t43p21037ig4tsppo631et3agqjb21kh.apps.googleusercontent.com',
    iosBundleId: 'com.example.whatsapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAYwi9TPs1qjaiJ5GqFocQizCx1dUHp9p0',
    appId: '1:764910176316:ios:d106297f53114d12f45b39',
    messagingSenderId: '764910176316',
    projectId: 'whatsapp-97a3b',
    storageBucket: 'whatsapp-97a3b.appspot.com',
    iosClientId: '764910176316-t43p21037ig4tsppo631et3agqjb21kh.apps.googleusercontent.com',
    iosBundleId: 'com.example.whatsapp',
  );
}
