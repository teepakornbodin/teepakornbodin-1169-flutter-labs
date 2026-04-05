// @author Teepakornbodin Intasoy
// @version 1.0
// @date 2026-03-18

// แอปควิซพร้อม Cloud Firestore (ต่อยอดจาก Lab 10 Problem 3)
// บันทึกคะแนนแต่ละรอบไปยัง Firestore และแสดงคะแนนล่าสุดและสูงสุดในหน้าผล

// Logic:
// - เรียก Firebase.initializeApp() ก่อน runApp() เพื่อเชื่อมต่อ Firebase
// - QuizFirebaseResultScreen รับ questions, selectedAnswers, score, onRestart
//   และเรียก FirestoreService.saveScore() ใน initState() ทันทีที่เข้าหน้าผล
// - FutureBuilder แสดง recent scores (เรียงตาม timestamp desc) และ
//   top scores (เรียงตาม score desc) แต่ละอัน limit 3
// - ระหว่างโหลดแสดง SizedBox.shrink() เพื่อไม่ให้ layout กระตุก
// - FirestoreService แยก Firestore logic ออกจาก UI code

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:teepakornbodin_interactivity_exercises/models/choice.dart';
import 'package:teepakornbodin_interactivity_exercises/models/question.dart';
import 'package:teepakornbodin_navigation_exercises/screens/quiz_screen_home.dart';
import 'package:teepakornbodin_navigation_exercises/screens/quiz_firebase_result_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
    );
  }
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
            children: [
              const Spacer(),
              Icon(Icons.quiz_outlined, size: 120, color: colorScheme.primary),
              const SizedBox(height: 24),
              Text(
                'Welcome to the Quiz App TB',
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
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, '/quiz'),
                  child: const Text('Start'),
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
            displayColor: Colors.purpleAccent),
        Choice(
            name: "Khon Kaen University",
            isCorrect: true,
            displayColor: Colors.orangeAccent),
        Choice(
            name: "Chulalongkorn University",
            isCorrect: false,
            displayColor: Colors.pinkAccent),
        Choice(
            name: "Mahidol University",
            isCorrect: false,
            displayColor: Colors.blueAccent),
      ],
    ),
    Question(
      title: "What province is this?",
      imagePath: "assets/images/bangkok.jpg",
      choices: [
        Choice(
            name: "Khon Kaen",
            isCorrect: false,
            displayColor: Colors.purpleAccent),
        Choice(
            name: "Bangkok",
            isCorrect: true,
            displayColor: Colors.orangeAccent),
        Choice(
            name: "Chiang Mai",
            isCorrect: false,
            displayColor: Colors.pinkAccent),
        Choice(
            name: "Phuket",
            isCorrect: false,
            displayColor: Colors.blueAccent),
      ],
    ),
    Question(
      title: "Who is this?",
      imagePath: "assets/images/1mill.jpg",
      choices: [
        Choice(
            name: "1MILL",
            isCorrect: true,
            displayColor: Colors.purpleAccent),
        Choice(
            name: "YOUNGOHM",
            isCorrect: false,
            displayColor: Colors.orangeAccent),
        Choice(
            name: "YOUNGJ",
            isCorrect: false,
            displayColor: Colors.pinkAccent),
        Choice(
            name: "DIAMOND",
            isCorrect: false,
            displayColor: Colors.blueAccent),
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

  void _handlePrevious() => setState(() => currentQuestionIndex--);

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
        builder: (context) => QuizFirebaseResultScreen(
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
