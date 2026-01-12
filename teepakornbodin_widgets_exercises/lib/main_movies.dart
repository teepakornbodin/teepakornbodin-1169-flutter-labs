// @author Teepakornbodin Intasoy
// @version 1.0
// @date 2025-1-7

// This file is responsible for:
// 1. Starting the Flutter app using runApp()
// 2. Configuring the global MaterialApp
//    - Enables Material Design 3 (useMaterial3: true)
//    - Defines the app-wide ColorScheme using ColorScheme.fromSeed()
//    - Supports both Light and Dark themes automatically
// 3. Providing the main screen that displays the movie list using ListView
// 4. Handling user interaction logic such as tapping a movie item
//    and showing feedback via SnackBar using ScaffoldMessenger
import 'package:flutter/material.dart';
import 'package:teepakornbodin_widgets_exercises/screens/movie_screen.dart';

void main() {
  runApp(const MainMovies());
}

class MainMovies extends StatelessWidget {
  const MainMovies({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Movies List",

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

      home: const MovieListScreen(),
    );
  }
}
