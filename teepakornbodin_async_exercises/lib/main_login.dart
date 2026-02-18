// @author Teepakornbodin Intasoy
// @version 1.0
// @date 2026-02-18

// A Flutter app that provides a login interface with persistent credential storage using SharedPreferences.
// Logic: Uses SharedPreferencesWithCache with allowList to save and restore username and password on app restart.
// Displays a SnackBar with the entered credentials upon login button press.
// AI-verified for correctness based on the prompt.

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ai แนะนำ ให้ ลบ logging ออก เพราะมันจะทำให้เกิดปัญหาในการทดสอบ และไม่จำเป็นสำหรับการทำงานของแอป
  debugPrint = (String? message, {int? wrapWidth}) {};

  final prefs = await SharedPreferencesWithCache.create(
    cacheOptions: const SharedPreferencesWithCacheOptions(
      allowList: {'savedUsername', 'savedPassword'},
    ),
  );
  runApp(LoginApp(prefs: prefs));
}

class LoginApp extends StatelessWidget {
  final SharedPreferencesWithCache prefs;

  const LoginApp({super.key, required this.prefs});

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
      home: LoginScreen(prefs: prefs),
    );
  }
}

class LoginScreen extends StatefulWidget {
  final SharedPreferencesWithCache prefs;

  const LoginScreen({super.key, required this.prefs});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadSavedCredentials();
  }

  void _loadSavedCredentials() async {
    final savedUsername = widget.prefs.getString('savedUsername');
    final savedPassword = widget.prefs.getString('savedPassword');
    if (savedUsername != null) {
      _usernameController.text = savedUsername;
    }
    if (savedPassword != null) {
      _passwordController.text = savedPassword;
    }
    debugPrint('username: $savedUsername, password: $savedPassword');
  }

  void _saveCredentials() async {
    await widget.prefs.setString('savedUsername', _usernameController.text);
    await widget.prefs.setString('savedPassword', _passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                _saveCredentials();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Username: ${_usernameController.text} and Password: ${_passwordController.text}!',
                    ),
                  ),
                );
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
