// @author Teepakornbodin Intasoy
// @version 1.0
// @date 2026-02-04

// A profile button app.
// Logic: Splitting widgets into _submitButton and profileHeader, sourced from models/profile_with_button_model.dart.
// AI was used to find ways to prevent the button text and background colors from clashing or blending.

import 'package:flutter/material.dart';
import 'package:teepakornbodin_widgets_exercises/components/profile_with_button.dart';
import 'package:teepakornbodin_widgets_exercises/models/profile_with_button_model.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Profile Button',
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.orange,
          brightness: Brightness.dark,
        ),
      ),
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.orange,
          brightness: Brightness.light,
        ),
      ),
      themeMode: ThemeMode.system,
      home: MainProfileButton(),
    ),
  );
}

class MainProfileButton extends StatelessWidget {
  const MainProfileButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ProfileWithButton(
      model: const ProfileWithButtonModel(
        name: 'Teepakornbodin',
        studentId: '663040116-9',
        imagePath: 'assets/images/teepakorn.png',
        photoCredit: 'teepakornbodin',
      ),
    );
  }
}
