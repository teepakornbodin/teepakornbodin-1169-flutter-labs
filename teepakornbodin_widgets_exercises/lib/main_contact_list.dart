// @author Teepakornbodin Intasoy
// @version 1.0
// @date 2025-1-7

// This file is responsible for:
// 1. Starting the app with runApp()
// 2. Creating the root MaterialApp
//    - Sets the application title ("My Contacts")
//    - Enables Material Design 3 with a seed-based ColorScheme
// 3. Defining ContactListScreen as the home widget
//
// Important Design Note:
// - This file DOES NOT contain a Scaffold
// - The Scaffold is intentionally placed inside ContactListScreen
//   to follow the Single Scaffold Pattern and ensure
//   correct FloatingActionButton behavior

import 'package:flutter/material.dart';
import 'package:teepakornbodin_widgets_exercises/screens/contact_list_screen.dart';

void main() {
  runApp(const MainContactList());
}

class MainContactList extends StatelessWidget {
  const MainContactList({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "My Contacts",

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
      home: const ContactListScreen(),
    );
  }
}
