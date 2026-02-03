// @author Teepakornbodin Intasoy
// @version 1.0
// @date 2026-01-16

// A responsive profile card rating app.
// Inherited/evolved from Lab 5.
// Logic: Uses private helper methods to toggle between Column (vertical) and Row (horizontal) layouts.
// AI-verified for correctness based on the prompt.

library;

import 'package:flutter/material.dart';
import 'package:teepakornbodin_widgets_exercises/screens/profile_card_rating_responsive.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Profile Card',
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.orange,
          brightness: Brightness.dark,
        ),
      ),
      themeMode: ThemeMode.system,
      home: ProfileCardRatingResponsive(),
    ),
  );
}
