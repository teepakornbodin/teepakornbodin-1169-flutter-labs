// @author Teepakornbodin Intasoy
// @version 1.0
// @date 2026-03-10

// Quiz application with a result summary screen (extended from Problem 2)
// Replaces the AlertDialog after the last question with a full-screen QuizResultScreen

// Logic:
// - When Next is pressed on the last question, Navigator.push(MaterialPageRoute) is used
//   to navigate to QuizResultScreen, passing questions, selectedAnswers, score,
//   and the onRestart callback through the constructor
// - QuizResultScreen is a StatelessWidget that only displays the received data and does not store state
// - The result screen shows a score header and a ListView of all questions with green/red/orange feedback
//   based on the deferred feedback pattern (isCorrect is used for the first time at render time in P3)
// - CircleAvatar shows a color only when an answer was selected; if no answer was selected, no color is shown
// - The Restart button calls onRestart() to reset the state in the parent, then uses Navigator.pop()
//   to return to the quiz starting at Question 1 with a fresh state
// - All behavior from P2 remains unchanged
// - I used AI to ask how to implement the logic for checking the background color and index
//   when passing data to the result screen
// - AI was used to verify that the implementation follows the assignment requirements.

import 'package:flutter/material.dart';
import 'package:teepakornbodin_interactivity_exercises/models/choice.dart';
import 'package:teepakornbodin_interactivity_exercises/models/question.dart';
import 'package:teepakornbodin_navigation_exercises/screens/quiz_screen_home.dart';
import 'package:teepakornbodin_navigation_exercises/screens/quiz_result_screen.dart';

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

// ไม่เปลี่ยนจาก Problem 2

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

// จาก problem 2 logic, _showResultDialog วางทับ Navigator.push

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
    setState(() => currentQuestionIndex--);
  }

  void _handleNext() {
    if (currentQuestionIndex < questions.length - 1) {
      setState(() => currentQuestionIndex++);
    } else {
      _navigateToResult();
    }
  }

  void _navigateToResult() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QuizResultScreen(
          questions: questions,
          selectedAnswers: Map.from(_selectedAnswers),
          score: score,
          onRestart: _restartQuiz,
        ),
      ),
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
