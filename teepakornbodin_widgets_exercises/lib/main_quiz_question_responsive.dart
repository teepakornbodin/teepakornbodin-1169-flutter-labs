// @author Teepakornbodin Intasoy
// @version 1.0
// @date 2026-01-26

// A responsive quiz question app.
// Inherited/evolved from Lab 5.
// By calling the responsive utility via \utils\responsive.dart using the isPortraitMode method,
// Logic: Uses private helper methods to toggle between Column (vertical) and Row (horizontal) layouts.
// Use AI to explain and provide examples of using if-else within Expanded widgets,
// how to implement a GridView, and how to disable scrolling using physics: const NeverScrollableScrollPhysics().

import 'package:flutter/material.dart';
import 'package:teepakornbodin_widgets_exercises/components/question_choices_responsive.dart';
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
        body: const SafeArea(
          child: QuestionWithChoicesResponsive(
            title: "Where is this picture?",
            imagePath: "assets/images/kku.jpg",
            choices: [
              QuestionChoice(
                name: "Chiang Mai University",
                bgColor: Colors.purpleAccent,
              ),
              QuestionChoice(
                name: "Khon Kaen University",
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
    ),
  );
}
