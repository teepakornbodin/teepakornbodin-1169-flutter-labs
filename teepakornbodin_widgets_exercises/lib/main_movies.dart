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
