import 'package:flutter/material.dart';

class QuizPreferencesState extends ChangeNotifier {
  String userName = 'Guest';
  String userBio = 'Quiz Lover';
  bool soundEnabled = true;
  bool vibrationEnabled = true;
  ThemeMode themeMode = ThemeMode.system;

  void setUserName(String name) {
    userName = name;
    notifyListeners();
  }

  void setUserBio(String bio) {
    userBio = bio;
    notifyListeners();
  }

  void setSoundEnabled(bool value) {
    soundEnabled = value;
    notifyListeners();
  }

  void setVibrationEnabled(bool value) {
    vibrationEnabled = value;
    notifyListeners();
  }

  void setThemeMode(ThemeMode mode) {
    themeMode = mode;
    notifyListeners();
  }
}
