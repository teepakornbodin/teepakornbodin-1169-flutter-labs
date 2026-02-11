// @author Teepakornbodin Intasoy
// @version 1.0
// @date 2026-02-11

// An interactive profile card with star ratings app.
// Inherited/evolved from Lab 6 p1 (widgets_exercises).
// Logic: Uses StatefulWidget to manage interactive star ratings with GestureDetector.
// AI-verified for correctness based on the prompt.

import 'package:flutter/material.dart';
import 'package:teepakornbodin_interactivity_exercises/screens/profile_card_rating_responsive.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Profile Card',
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
      home: const MainInteractivityProfile(),
    ),
  );
}

class MainInteractivityProfile extends StatelessWidget {
  const MainInteractivityProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProfileCardRatingResponsive();
  }
}
