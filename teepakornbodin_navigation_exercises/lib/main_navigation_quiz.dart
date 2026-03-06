// @author Teepakornbodin Intasoy
// @version 1.0
// @date 2026-03-6

// Quiz Application with Navigation and State-based Architecture.
// A quiz application with question navigation using an index-driven architecture,
// where the parent widget manages all state and passes it down to child widgets.

// Logic:
// - Uses a StatefulWidget (QuizApp) as the parent to store all states including
//   currentQuestionIndex, score, _selectedAnswers, _questionAnswered, and _resetCounter.
// - Passes data and callbacks to QuizScreen via the constructor (dependency injection).
// - Recalculates the score every time an answer is selected by removing the previous score and adding the new one.
// - The Previous button is hidden on the first question, the Next button appears on every question,
//   and the last question shows a Finish button that opens a dialog.
// - Uses ValueKey together with _resetCounter to force Flutter to create a new State when restarting.
// - Supports both light and dark themes based on the system setting.
// - AI was used to verify that the implementation follows the assignment requirements.

import 'package:flutter/material.dart';
import 'package:teepakornbodin_interactivity_exercises/models/choice.dart';
import 'package:teepakornbodin_interactivity_exercises/models/question.dart';
import 'package:teepakornbodin_navigation_exercises/screens/quiz_screen.dart';

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
  // lab เดิม
  int currentQuestionIndex = 0;
  int score = 0;
  int _resetCounter = 0;

  // null = ยังไม่ตอบ
  Map<int, int?> _selectedAnswers = {};
  // ตอบแล้วหรือยัง
  Map<int, bool> _questionAnswered = {};

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
    Question(
      title: "What province is this?",
      imagePath: "assets/images/bangkok.jpg",
      choices: [
        Choice(
          name: "Khon Kaen",
          isCorrect: false,
          displayColor: Colors.purpleAccent,
        ),
        Choice(
          name: "Bangkok",
          isCorrect: true,
          displayColor: Colors.orangeAccent,
        ),
        Choice(
          name: "Chiang Mai",
          isCorrect: false,
          displayColor: Colors.pinkAccent,
        ),
        Choice(
          name: "Phuket",
          isCorrect: false,
          displayColor: Colors.blueAccent,
        ),
      ],
    ),
    Question(
      title: "Who is this?",
      imagePath: "assets/images/1mill.jpg",
      choices: [
        Choice(
          name: "1MILL",
          isCorrect: true,
          displayColor: Colors.purpleAccent,
        ),
        Choice(
          name: "YOUNGOHM",
          isCorrect: false,
          displayColor: Colors.orangeAccent,
        ),
        Choice(
          name: "YOUNGJ",
          isCorrect: false,
          displayColor: Colors.pinkAccent,
        ),
        Choice(
          name: "DIAMOND",
          isCorrect: false,
          displayColor: Colors.blueAccent,
        ),
      ],
    ),
  ];

  // เลือกคำตอบแล้วคิด score ใหม่ทุกครั้ง
  void _handleChoiceSelected(int choiceIndex) {
    setState(() {
      final previousChoiceIndex = _selectedAnswers[currentQuestionIndex];

      // ลบคะแนนเก่าออกถ้าตอบแล้ว
      if (previousChoiceIndex != null) {
        if (questions[currentQuestionIndex]
            .choices[previousChoiceIndex]
            .isCorrect) {
          score--;
        }
      }

      // บันทึกคำตอบใหม่
      _selectedAnswers[currentQuestionIndex] = choiceIndex;
      _questionAnswered[currentQuestionIndex] = true;

      // เพิ่มคะแนนถ้าคำตอบใหม่ถูก
      if (questions[currentQuestionIndex].choices[choiceIndex].isCorrect) {
        score++;
      }
    });
  }

  //Previous
  void _handlePrevious() {
    setState(() {
      currentQuestionIndex--;
    });
  }

  //
  void _handleNext() {
    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
      });
    } else {
      _showResultDialog();
    }
  }

  //
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
      _selectedAnswers = {};
      _questionAnswered = {};
      _resetCounter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isFirst = currentQuestionIndex == 0;
    final bool isLast = currentQuestionIndex == questions.length - 1;

    return Scaffold(
      appBar: AppBar(title: Text(widget.appTitle), centerTitle: true),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: QuizScreen(
                // ValueKey รวม resetCounter เมื่อ restart
                key: ValueKey('${currentQuestionIndex}_$_resetCounter'),
                question: questions[currentQuestionIndex],
                initialSelectedIndex: _selectedAnswers[currentQuestionIndex],
                isInitiallyAnswered:
                    _questionAnswered[currentQuestionIndex] ?? false,
                onChoiceSelected: _handleChoiceSelected,
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Previousซ่อนที่คำถามแรก
                  if (!isFirst)
                    ElevatedButton(
                      onPressed: _handlePrevious,
                      child: const Text('Previous'),
                    )
                  else
                    const SizedBox.shrink(),

                  ElevatedButton(
                    onPressed: _handleNext,
                    child: Text(isLast ? 'Finish' : 'Next'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
