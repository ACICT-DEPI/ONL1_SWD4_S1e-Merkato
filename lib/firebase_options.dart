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
    apiKey: 'AIzaSyAOdJbEIJv5M2ejd3UPy4IgyaXhQ63Q5UA',
    appId: '1:947477928890:web:9a764a36caf262151fdb83',
    messagingSenderId: '947477928890',
    projectId: 'beto-s-firebase',
    authDomain: 'beto-s-firebase.firebaseapp.com',
    storageBucket: 'beto-s-firebase.appspot.com',
    measurementId: 'G-P1CS2GRVEV',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC5ZGtJuU-1AO_5hmfZuMUtYTIDhgsQECI',
    appId: '1:947477928890:android:cd5be8152388d5ef1fdb83',
    messagingSenderId: '947477928890',
    projectId: 'beto-s-firebase',
    storageBucket: 'beto-s-firebase.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC1koTk2azGo5tyCciMCpiEIww8UD6SHeU',
    appId: '1:947477928890:ios:fe373ebbb88427fa1fdb83',
    messagingSenderId: '947477928890',
    projectId: 'beto-s-firebase',
    storageBucket: 'beto-s-firebase.appspot.com',
    iosBundleId: 'com.example.marwanBe2',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC1koTk2azGo5tyCciMCpiEIww8UD6SHeU',
    appId: '1:947477928890:ios:fe373ebbb88427fa1fdb83',
    messagingSenderId: '947477928890',
    projectId: 'beto-s-firebase',
    storageBucket: 'beto-s-firebase.appspot.com',
    iosBundleId: 'com.example.marwanBe2',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAOdJbEIJv5M2ejd3UPy4IgyaXhQ63Q5UA',
    appId: '1:947477928890:web:6844d1dfcaad11871fdb83',
    messagingSenderId: '947477928890',
    projectId: 'beto-s-firebase',
    authDomain: 'beto-s-firebase.firebaseapp.com',
    storageBucket: 'beto-s-firebase.appspot.com',
    measurementId: 'G-K3K22T7SF6',
  );
}