import 'package:flutter/material.dart';
import 'package:teepakornbodin_widgets_exercises/components/question_with_choices.dart';
import 'package:teepakornbodin_widgets_exercises/components/question_choice.dart';

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
      home: Scaffold(
        appBar: AppBar(title: const Text(appTitle), centerTitle: true),
        body: const QuestionWithChoices(
          title: "Where is the picture?",
          imagePath: "assets/images/kku.jpg",
          choices: [
            QuestionChoice(
              name: "Khon Kaen University",
              bgColor: Colors.purpleAccent,
            ),
            QuestionChoice(
              name: "Mahasarakham University",
              bgColor: Colors.orangeAccent,
            ),
            QuestionChoice(
              name: "Chulalongkorn University",
              bgColor: Colors.pinkAccent,
            ),
            QuestionChoice(
              name: "Mahidol University",
              bgColor: Colors.blueAccent,
            ),
          ],
        ),
      ),
    ),
  );
}
