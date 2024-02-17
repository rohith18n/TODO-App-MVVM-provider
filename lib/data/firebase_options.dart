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
    apiKey: 'AIzaSyCasjda2HK1w9XZJ62AB6e2LEttAvvLBaY',
    appId: '1:331607979176:web:93ae0710cec150a8827e9d',
    messagingSenderId: '331607979176',
    projectId: 'insta-clone-e72f8',
    authDomain: 'insta-clone-e72f8.firebaseapp.com',
    storageBucket: 'insta-clone-e72f8.appspot.com',
    measurementId: 'G-7F3NFER9BZ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCAeWqt16CUQG0_J4uDRoMYQjnQSLESfZE',
    appId: '1:331607979176:android:d278706133865473827e9d',
    messagingSenderId: '331607979176',
    projectId: 'insta-clone-e72f8',
    storageBucket: 'insta-clone-e72f8.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBRsFpGRlkKqI503ryxNG4ByV-eDUSCarU',
    appId: '1:331607979176:ios:9cb9fd0f2f5ef83f827e9d',
    messagingSenderId: '331607979176',
    projectId: 'insta-clone-e72f8',
    storageBucket: 'insta-clone-e72f8.appspot.com',
    iosBundleId: 'com.example.townerFinalRound',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBRsFpGRlkKqI503ryxNG4ByV-eDUSCarU',
    appId: '1:331607979176:ios:039c503140d6f149827e9d',
    messagingSenderId: '331607979176',
    projectId: 'insta-clone-e72f8',
    storageBucket: 'insta-clone-e72f8.appspot.com',
    iosBundleId: 'com.example.townerFinalRound.RunnerTests',
  );
}
