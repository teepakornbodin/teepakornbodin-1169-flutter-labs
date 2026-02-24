// @author Teepakornbodin Intasoy
// @version 3.0
// @date 2026-02-24

// Flutter app that displays a Profile Card with an interactive star rating system.
// Interactive star rating widget that manages its own state and data persistence.
// Logic: Uses SharedPreferencesWithCache to save and load the latest star rating when the app is reopened.
// Create the prefs instance once in main() and pass it down to child widgets via constructor.
// Uses StatefulWidget to store the _rating state and GestureDetector to handle tap interactions.
// Loads the saved rating synchronously from SharedPreferences in initState().
// Saves the updated rating immediately every time the user taps a star.
// Use AI to review and recheck whether all requirements have been fully implemented.

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teepakornbodin_shared_pref_exercises/screens/profile_card_rating_responsive.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // เรียกใช้ SharedPreferencesWithCache สร้าง instance การตั้งค่าallowListของstar_rating
  final prefs = await SharedPreferencesWithCache.create(
    cacheOptions: const SharedPreferencesWithCacheOptions(
      allowList: {'star_rating'},
    ),
  );

  runApp(MyApp(prefs: prefs));
}

class MyApp extends StatelessWidget {
  final SharedPreferencesWithCache prefs;

  const MyApp({super.key, required this.prefs});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Profile Card Rating',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.orange,
          brightness: Brightness.light,
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.orange,
          brightness: Brightness.dark,
        ),
      ),
      themeMode: ThemeMode.system,
      home: ProfileCardRatingResponsive(prefs: prefs),
    );
  }
}
