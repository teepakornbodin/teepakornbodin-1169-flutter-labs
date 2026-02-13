// @author Teepakornbodin Intasoy
// @version 1.0
// @date 2026-02-13

// A Dart console program that calls IP address API and parses JSON response.
// Logic: Uses async/await to make HTTP GET request and jsonDecode to parse JSON data.
// AI-verified for correctness based on the prompt.

// A Flutter app that calls user API, parses JSON into data model, and displays styled text.
// Logic: Uses StatefulWidget with setState() to fetch API data and RichText for multi-style display.
// AI-verified for correctness based on the prompt.

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:teepakornbodin_async_exercises/models/user.dart';

void main() {
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
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
      ),

      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
      ),

      themeMode: ThemeMode.system,

      home: const UserDisplay(),
    );
  }
}

class UserDisplay extends StatefulWidget {
  const UserDisplay({super.key});

  @override
  State<UserDisplay> createState() => _UserDisplayState();
}

class _UserDisplayState extends State<UserDisplay> {
  User? user;

  @override
  void initState() {
    super.initState();
    fetchUser();
  }

  Future<void> fetchUser() async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/users/1'),
      headers: {
        'User-Agent': 'Mozilla/5.0',
        'Accept': 'application/json, text/plain, */*',
        'Accept-Language': 'en-US,en;q=0.9',
        'Connection': 'keep-alive',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        user = User.fromJson(data);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Call API By Teepakornbodin 1169'),
        centerTitle: true,
      ),
      body: Center(
        child: user == null
            ? const CircularProgressIndicator()
            : Padding(
                padding: const EdgeInsets.all(12),
                child: RichText(
                  text: TextSpan(
                    style: textTheme.bodyMedium,
                    children: [
                      TextSpan(
                        text: user!.name,
                        style: textTheme.titleLarge?.copyWith(
                          color: colorScheme.primary,
                        ),
                      ),
                      TextSpan(
                        text: ' works at ',
                        style: textTheme.titleLarge?.copyWith(
                          color: colorScheme.secondary,
                        ),
                      ),
                      TextSpan(
                        text: user!.company,
                        style: textTheme.titleLarge?.copyWith(
                          color: colorScheme.secondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
