// @author Teepakornbodin Intasoy
// @version 1.0
// @date 2026-03-10

// Quiz application with a cover page and Home button (extended from Problem 1)
// Adds a QuizCoverPage as the entry point and uses named routes to manage navigation

// Logic:
// - Uses named routes '/' → QuizCoverPage and '/quiz' → QuizApp with initialRoute: '/'
// - QuizCoverPage is a StatelessWidget that displays an icon, welcome text, and a Start button
//   which uses Navigator.pushNamed(context, '/quiz') to navigate to the quiz screen
// - QuizScreenHome wraps the QuizScreen from P1 and adds a row of Previous/Home/Next buttons at the bottom
// - The Previous and Next buttons are wrapped with Visibility(maintainSize: true) to preserve layout space,
//   ensuring the Home button always stays centered regardless of the current question
// - The Home button uses Navigator.popUntil(context, (route) => route.isFirst) to always return to the cover page
// - All logic from P1 remains unchanged: state management, score tracking, ValueKey, and didUpdateWidget
// - AI was used to verify that the implementation follows the assignment requirements.

import 'package:flutter/material.dart';
import 'package:teepakornbodin_interactivity_exercises/models/choice.dart';
import 'package:teepakornbodin_interactivity_exercises/models/question.dart';
import 'package:teepakornbodin_navigation_exercises/screens/quiz_screen_home.dart';

void main() {
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
      initialRoute: '/',
      routes: {
        '/': (context) => const QuizCoverPage(),
        '/quiz': (context) =>
            const QuizApp(appTitle: 'Quiz App by 663040116-9'),
      },
    ),
  );
}

class QuizCoverPage extends StatelessWidget {
  const QuizCoverPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),

              Icon(Icons.quiz_outlined, size: 120, color: colorScheme.primary),

              const SizedBox(height: 24),

              Text(
                'Welcome to the Quiz App',
                style: textTheme.headlineSmall?.copyWith(
                  color: colorScheme.primary,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 8),

              Text(
                'By Teepakornbodin Intasoy 663040116-9',
                style: textTheme.titleMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),

              const Spacer(),

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 50,
                  vertical: 8,
                ),
                child: SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/quiz');
                    },
                    child: Text(
                      'Start',
                      style: textTheme.titleLarge?.copyWith(
                        color: colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

//  same logic as Problem 1

class QuizApp extends StatefulWidget {
  final String appTitle;

  const QuizApp({super.key, required this.appTitle});

  @override
  State<QuizApp> createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  int currentQuestionIndex = 0;
  int score = 0;
  int _resetCounter = 0;

  Map<int, int?> _selectedAnswers = {};
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

  void _handleChoiceSelected(int choiceIndex) {
    setState(() {
      final previousChoiceIndex = _selectedAnswers[currentQuestionIndex];

      if (previousChoiceIndex != null) {
        if (questions[currentQuestionIndex]
            .choices[previousChoiceIndex]
            .isCorrect) {
          score--;
        }
      }

      _selectedAnswers[currentQuestionIndex] = choiceIndex;
      _questionAnswered[currentQuestionIndex] = true;

      if (questions[currentQuestionIndex].choices[choiceIndex].isCorrect) {
        score++;
      }
    });
  }

  void _handlePrevious() {
    setState(() {
      currentQuestionIndex--;
    });
  }

  void _handleNext() {
    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
      });
    } else {
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
              child: QuizScreenHome(
                key: ValueKey('quiz_$_resetCounter'),
                question: questions[currentQuestionIndex],
                initialSelectedIndex: _selectedAnswers[currentQuestionIndex],
                isInitiallyAnswered:
                    _questionAnswered[currentQuestionIndex] ?? false,
                onChoiceSelected: _handleChoiceSelected,
                onPrevious: _handlePrevious,
                onNext: _handleNext,
                showPreviousButton: !isFirst,
                showNextButton: true,
                isLastQuestion: isLast,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
