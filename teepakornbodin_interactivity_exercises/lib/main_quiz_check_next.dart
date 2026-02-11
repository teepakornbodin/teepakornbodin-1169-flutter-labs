// @author Teepakornbodin Intasoy
// @version 1.0
// @date 2026-02-11

// Quiz Application with interactive answer selection and scoring.
// An interactive quiz app that allows users to select answers,
// validates correctness, tracks score, and shows final results.
// Built using StatefulWidget for dynamic state updates and UI feedback.

// Logic:
// - Uses StatefulWidget to manage question state and score.
// - Displays questions with multiple choices using QuestionChoiceCard.
// - Changes choice card colors based on correctness after selection.
// - Shows result dialog when quiz is completed.
// - Supports responsive layout for different screen orientations.
// - Position-independent design using 'isCorrect' boolean parameter.
// - Example interactions include onTap selection and showDialog result display.
// - NextButton logic improved and corrected with AI assistance (func: _handleNext).
// - AI-verified for correctness based on the given prompt.

import 'package:flutter/material.dart';
import 'package:teepakornbodin_interactivity_exercises/models/choice.dart';
import 'package:teepakornbodin_interactivity_exercises/models/question.dart';
import 'package:teepakornbodin_interactivity_exercises/screens/quiz_screen.dart';

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
      home: const QuizApp(appTitle: appTitle),
    ),
  );
}

class QuizApp extends StatefulWidget {
  final String appTitle;

  const QuizApp({super.key, required this.appTitle});

  @override
  State<QuizApp> createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  int currentQuestionIndex = 0;
  int score = 0;
  bool questionAnswered = false;
  int _resetCounter = 0;

  // Define quiz questions
  final List<Question> questions = const [
    Question(
      title: "Where is this picture?",
      imagePath: "assets/images/kku.jpg",
      choices: [
        Choice(
          name: "Chiang Mai University",
          isCorrect: false,
          displayColor: Colors.purpleAccent,
        ),
        Choice(
          name: "Khon Kaen University",
          isCorrect: true,
          displayColor: Colors.orangeAccent,
        ),
        Choice(
          name: "Chulalongkorn University",
          isCorrect: false,
          displayColor: Colors.pinkAccent,
        ),
        Choice(
          name: "Mahidol University",
          isCorrect: false,
          displayColor: Colors.blueAccent,
        ),
      ],
    ),
  ];

  void _handleAnswer(bool isCorrect) {
    setState(() {
      if (isCorrect) {
        score++;
      }
      questionAnswered = true;
    });
  }

  void _handleNext() {
    if (currentQuestionIndex < questions.length - 1) {
      // Move to next question
      setState(() {
        currentQuestionIndex++;
        questionAnswered = false;
      });
    } else {
      // Show result dialog
      _showResultDialog();
    }
  }

  void _showResultDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Quiz Complete!'),
          content: Text(
            'Your score: $score / ${questions.length}',
            style: const TextStyle(fontSize: 18),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _restartQuiz();
              },
              child: const Text('Restart Quiz'),
            ),
          ],
        );
      },
    );
  }

  void _restartQuiz() {
    setState(() {
      currentQuestionIndex = 0;
      score = 0;
      questionAnswered = false;
      _resetCounter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.appTitle), centerTitle: true),
      body: SafeArea(
        child: QuizScreen(
          key: ValueKey('${currentQuestionIndex}_$_resetCounter'),
          question: questions[currentQuestionIndex],
          onAnswer: _handleAnswer,
          showNextButton: questionAnswered,
          onNext: _handleNext,
        ),
      ),
    );
  }
}
