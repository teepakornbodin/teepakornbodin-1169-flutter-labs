// @author Teepakornbodin Intasoy
// @version 1.0
// @date 2026-1-12
// A custom widget ProfileCardRating wrapped in MaterialApp
// This code show actor's profile card and contracts.
// Implemented image stack and listTile for contracts.
// Use AI to explain the correct principles of row division and use it to verify if all requirements of the prompt have been met.

import 'package:flutter/material.dart';
import 'package:teepakornbodin_widgets_exercises/screens/profile_card_rating.dart';

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

      home: ProfileCardRating(),
    ),
  );
}
