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
