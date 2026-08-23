import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  // ================= WEB =================

static const FirebaseOptions web = FirebaseOptions(
  apiKey: 'AIzaSyD9hvi2wPOiG2Y92PiOdowlAljJzcrPzys',
  appId: '1:588713164437:web:e212fdd17368d2ed50659c',
  messagingSenderId: '588713164437',
  projectId: 'alrmunadvertising',
  authDomain: 'alrmunadvertising.firebaseapp.com',
  storageBucket: 'alrmunadvertising.firebasestorage.app',
  measurementId: 'G-5VLJS2617R',
);

  // ================= ANDROID =================

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCMJo-ELEHoIPtOvSvZA2bJVFQ234dZiQc',
    appId: '1:588713164437:android:99e82ea537e7eec950659c',
    messagingSenderId: '588713164437',
    projectId: 'alrmunadvertising',
    storageBucket: 'alrmunadvertising.firebasestorage.app',
  );

  // ================= IOS =================

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: '',
    appId: '',
    messagingSenderId: '588713164437',
    projectId: 'alrmunadvertising',
    storageBucket: 'alrmunadvertising.firebasestorage.app',
    iosBundleId: '',
  );

  // ================= MACOS =================

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: '',
    appId: '',
    messagingSenderId: '588713164437',
    projectId: 'alrmunadvertising',
    storageBucket: 'alrmunadvertising.firebasestorage.app',
    iosBundleId: '',
  );

  // ================= WINDOWS =================

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyD9hvi2wP0iG2Y92PiOdowlAljJzcrPzys',
    appId: '1:588713164437:web:e212fdd17368d2ed50659c',
    messagingSenderId: '588713164437',
    projectId: 'alrmunadvertising',
    authDomain: 'alrmunadvertising.firebaseapp.com',
    storageBucket: 'alrmunadvertising.firebasestorage.app',
    measurementId: 'G-5VLJS2617R',
  );
}