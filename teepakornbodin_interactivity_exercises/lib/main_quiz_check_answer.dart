// @author Teepakornbodin Intasoy
// @version 1.0
// @date 2026-02-11

// A quiz app with answer checking and score dialog.
// Logic: Uses StatefulWidget to track answer selection state and display color feedback.
// Shows AlertDialog with score when user taps a choice.
// Green for correct, red for incorrect. Prevents re-tapping after selection.
// Position-independent design using 'correct' boolean parameter.
// AI validates the given conditions, with usage examples such as onTap and showDialog.

import 'package:flutter/material.dart';
import 'package:teepakornbodin_interactivity_exercises/screens/question_with_choices.dart';
import 'package:teepakornbodin_interactivity_exercises/components/question_choice.dart';

void main() {
  const String appTitle = "Quiz App by 663040116-9";
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
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
      home: Builder(
        builder: (context) {
          final colorScheme = Theme.of(context).colorScheme;

          return Scaffold(
            appBar: AppBar(title: const Text(appTitle), centerTitle: true),
            body: SafeArea(
              child: QuestionWithChoices(
                title: "Where is this picture?",
                imagePath: "assets/images/kku.jpg",
                choices: [
                  QuestionChoice(
                    name: "Chiang Mai University",
                    bgColor: Colors.purpleAccent,
                    correct: false,
                  ),
                  QuestionChoice(
                    name: "Khon Kaen University",
                    bgColor: Colors.orangeAccent,
                    correct: true,
                  ),
                  QuestionChoice(
                    name: "Chulalongkorn University",
                    bgColor: Colors.pinkAccent,
                    correct: false,
                  ),
                  QuestionChoice(
                    name: "Mahidol University",
                    bgColor: Colors.blueAccent,
                    correct: false,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    ),
  );
}
