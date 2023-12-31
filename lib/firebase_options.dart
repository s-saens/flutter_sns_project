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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAioSDOdTGeAYwo6KX1DP75WpvvOWB7MW4',
    appId: '1:274841748258:android:df67610d59807e33f59b7b',
    messagingSenderId: '274841748258',
    projectId: 'flutter-sns-practice',
    storageBucket: 'flutter-sns-practice.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAyoL1P_4IqP60MiZh18WXpBk-FuXHIRHk',
    appId: '1:274841748258:ios:bc0d1f14a1d9719ff59b7b',
    messagingSenderId: '274841748258',
    projectId: 'flutter-sns-practice',
    storageBucket: 'flutter-sns-practice.appspot.com',
    iosClientId: '274841748258-p0srn9vu4rpeii8e39pbebf8dvhjkkq3.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterSnsPractice',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAyoL1P_4IqP60MiZh18WXpBk-FuXHIRHk',
    appId: '1:274841748258:ios:e4b0e11c28d952c6f59b7b',
    messagingSenderId: '274841748258',
    projectId: 'flutter-sns-practice',
    storageBucket: 'flutter-sns-practice.appspot.com',
    iosClientId: '274841748258-tk076g0q02gh797tolfmr361e00non1r.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterSnsPractice.RunnerTests',
  );
}
