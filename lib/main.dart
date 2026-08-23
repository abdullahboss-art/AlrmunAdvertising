// // import 'package:adverting_app/User/GetQuote.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';

// import 'firebase_options.dart';
// import 'splash_screen.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );

//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//        routes: {
//     '/subscriptions': (context) => const SubscriptionsPage(),
//   },
//       debugShowCheckedModeBanner: false,
//       // home: SplashScreen(),

//       home: SplashScreen(),
//     );
//   }
// }

import 'package:adverting_app/User/subscriptions_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';
import 'splash_screen.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      routes: {
        '/subscriptions': (context) =>  SubscriptionsPage(),
      },

      home: const SplashScreen(),
    );
  }
}