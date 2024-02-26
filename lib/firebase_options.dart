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
    apiKey: 'AIzaSyDH2CdHxG7oYbjOoSl5ycLuYiArJbkA9UA',
    appId: '1:303138469439:web:64020075f5e15f2f5b6a8a',
    messagingSenderId: '303138469439',
    projectId: 'amin-519f2',
    authDomain: 'amin-519f2.firebaseapp.com',
    databaseURL: 'https://amin-519f2-default-rtdb.firebaseio.com',
    storageBucket: 'amin-519f2.appspot.com',
    measurementId: 'G-82Z9ZTD8DX',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCnOQt2WCfOuT-w92A1GDJODSky5igqGL4',
    appId: '1:303138469439:android:a62355d851a385815b6a8a',
    messagingSenderId: '303138469439',
    projectId: 'amin-519f2',
    databaseURL: 'https://amin-519f2-default-rtdb.firebaseio.com',
    storageBucket: 'amin-519f2.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB2M3rzSFCqMY9qmVb3tK6X_fS3zpBWFw4',
    appId: '1:303138469439:ios:672cd551435a38565b6a8a',
    messagingSenderId: '303138469439',
    projectId: 'amin-519f2',
    databaseURL: 'https://amin-519f2-default-rtdb.firebaseio.com',
    storageBucket: 'amin-519f2.appspot.com',
    iosBundleId: 'com.example.ameen',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB2M3rzSFCqMY9qmVb3tK6X_fS3zpBWFw4',
    appId: '1:303138469439:ios:8816d8e3fc6e4c745b6a8a',
    messagingSenderId: '303138469439',
    projectId: 'amin-519f2',
    databaseURL: 'https://amin-519f2-default-rtdb.firebaseio.com',
    storageBucket: 'amin-519f2.appspot.com',
    iosBundleId: 'com.example.ameen.RunnerTests',
  );
}
