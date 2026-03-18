import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teepakornbodin_navigation_exercises/states/quiz_preferences_state.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final prefs = context.watch<QuizPreferencesState>();
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final themeName = switch (prefs.themeMode) {
      ThemeMode.light => 'Light',
      ThemeMode.dark => 'Dark',
      ThemeMode.system => 'System',
    };

    return Scaffold(
      appBar: AppBar(title: const Text('Profile'), centerTitle: true),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(prefs.userName, style: textTheme.headlineMedium),
              const SizedBox(height: 8),
              Text(
                prefs.userBio,
                style: textTheme.titleMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 24),
              ListTile(
                leading: Icon(
                  prefs.soundEnabled ? Icons.volume_up : Icons.volume_off,
                ),
                title: const Text('Sound'),
                subtitle: Text(prefs.soundEnabled ? 'Enabled' : 'Disabled'),
              ),
              ListTile(
                leading: Icon(
                  prefs.vibrationEnabled
                      ? Icons.vibration
                      : Icons.phone_android,
                ),
                title: const Text('Vibration'),
                subtitle: Text(prefs.vibrationEnabled ? 'Enabled' : 'Disabled'),
              ),
              ListTile(
                leading: const Icon(Icons.brightness_6_outlined),
                title: const Text('Theme'),
                subtitle: Text(themeName),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Edit Settings'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
