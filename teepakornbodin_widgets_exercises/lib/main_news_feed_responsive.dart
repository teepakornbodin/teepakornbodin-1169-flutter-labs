// @author Teepakornbodin Intasoy
// @version 1.0
// @date 2026-02-02

// A responsive news feed app.
// News feed app using List<Article>.
// Features 3-tier responsiveness: isMobile, isTablet, and isDesktop.
// Logic: _buildListView for mobile; _buildGridView for tablet/desktop.
// AI utilized for teaching conditional logic in utils/responsive.dart and verifying requirements.

import 'package:flutter/material.dart';
import 'package:teepakornbodin_widgets_exercises/screens/news_feed_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News Feed',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      home: const NewsFeedScreen(),
    );
  }
}
