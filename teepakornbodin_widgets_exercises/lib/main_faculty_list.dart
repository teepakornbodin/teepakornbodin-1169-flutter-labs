// @author Teepakornbodin Intasoy
// @version 1.0
// @date 2026-01-27

// A list of faculties with their details
// Render a dynamic list of faculties using ListView.
// Includes interactive elements allowing navigation to detailed profiles and visual assets.
// Logic: Split into 2 columns (col1: start, col2: end).
// Use AI to verify if the implementation follows best practices and fulfills all project requirements.

import 'package:flutter/material.dart';
import 'package:teepakornbodin_widgets_exercises/models/faculty_model.dart';
import 'package:teepakornbodin_widgets_exercises/screens/faculty_detail.dart';

void main() {
  runApp(const MainFacultyList());
}

class MainFacultyList extends StatelessWidget {
  const MainFacultyList({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KKU Faculty List',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
          brightness: Brightness.light,
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
          brightness: Brightness.dark,
        ),
      ),

      home: const FacultyListScreen(),
    );
  }
}

class FacultyListScreen extends StatelessWidget {
  const FacultyListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final faculties = FacultyModel.getFaculties();

    return Scaffold(
      appBar: AppBar(
        title: const Text('KKU Faculties - 663040116-9'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: faculties.length,
        itemBuilder: (context, index) {
          final faculty = faculties[index];

          return Card(
            child: ListTile(
              leading: const Icon(Icons.arrow_right_rounded),
              title: Text(faculty.name),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FacultyDetail(faculty: faculty),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
