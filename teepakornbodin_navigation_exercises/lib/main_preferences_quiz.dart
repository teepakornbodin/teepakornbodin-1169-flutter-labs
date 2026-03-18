// @author Teepakornbodin Intasoy
// @version 1.0
// @date 2026-03-6

// แอปควิซพร้อม Provider State Management (ต่อยอดจาก Lab 10 Problem 3)
// เพิ่มระบบ user preferences ด้วย Provider และหน้า Settings / Profile

// Logic:
// - ห่อ MaterialApp ด้วย ChangeNotifierProvider<QuizPreferencesState>
//   เพื่อให้ทุก screen เข้าถึง preferences ได้โดยไม่ต้องส่งผ่าน constructor
// - MyApp เป็น StatelessWidget ที่ใช้ context.watch<QuizPreferencesState>()
//   เพื่อให้ themeMode ของ MaterialApp เปลี่ยนตาม Provider ทันที
// - เพิ่ม named routes '/settings' และ '/profile'
// - QuizApp เพิ่ม gear icon (⚙) ใน AppBar ที่ pushNamed ไป '/settings'
// - พฤติกรรมทั้งหมดของ Lab 10 P3 ยังคงเดิม

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teepakornbodin_interactivity_exercises/models/choice.dart';
import 'package:teepakornbodin_interactivity_exercises/models/question.dart';
import 'package:teepakornbodin_navigation_exercises/screens/quiz_screen_home.dart';
import 'package:teepakornbodin_navigation_exercises/screens/quiz_result_screen.dart';
import 'package:teepakornbodin_navigation_exercises/screens/settings_screen.dart';
import 'package:teepakornbodin_navigation_exercises/screens/profile_screen.dart';
import 'package:teepakornbodin_navigation_exercises/states/quiz_preferences_state.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => QuizPreferencesState(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final prefs = context.watch<QuizPreferencesState>();

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
      themeMode: prefs.themeMode,
      initialRoute: '/',
      routes: {
        '/': (context) => const QuizCoverPage(),
        '/quiz': (context) =>
            const QuizApp(appTitle: 'Quiz App by 663040116-9'),
        '/settings': (context) => const SettingsScreen(),
        '/profile': (context) => const ProfileScreen(),
      },
    );
  }
}

// ---------------------------------------------------------------------------
// Cover Page — unchanged from Lab 10 P2
// ---------------------------------------------------------------------------
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

// ---------------------------------------------------------------------------
// Quiz App — เพิ่ม gear icon ใน AppBar
// ---------------------------------------------------------------------------
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
      appBar: AppBar(
        title: Text(widget.appTitle),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => Navigator.pushNamed(context, '/settings'),
          ),
        ],
      ),
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
