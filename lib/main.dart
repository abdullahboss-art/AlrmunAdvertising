import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';
import 'splash_screen.dart';
import 'User/Setting.dart';

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
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: AppThemeController.themeMode,

      builder: (context, themeMode, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,

          themeMode: themeMode,

          // =====================================================
          // LIGHT THEME
          // =====================================================

          theme: ThemeData(
            useMaterial3: true,
            brightness: Brightness.light,

            scaffoldBackgroundColor:
                const Color(0xFFF3F8FA),

            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF2D6A75),
              brightness: Brightness.light,
            ),

            appBarTheme: const AppBarTheme(
              backgroundColor: Color(0xFFF3F8FA),
              foregroundColor: Color(0xFF07131B),
              elevation: 0,
            ),

            cardColor: Colors.white,
          ),

          // =====================================================
          // DARK THEME
          // =====================================================

          darkTheme: ThemeData(
            useMaterial3: true,
            brightness: Brightness.dark,

            scaffoldBackgroundColor:
                const Color(0xFF07131B),

            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF2D6A75),
              brightness: Brightness.dark,
            ),

            appBarTheme: const AppBarTheme(
              backgroundColor: Color(0xFF07131B),
              foregroundColor: Colors.white,
              elevation: 0,
            ),

            cardColor: const Color(0xFF0D1B24),
          ),

          home: const SplashScreen(),
        );
      },
    );
  }
}