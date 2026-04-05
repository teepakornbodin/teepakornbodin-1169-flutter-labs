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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 24),

              // Avatar with first letter of name
              CircleAvatar(
                radius: 48,
                backgroundColor: colorScheme.primaryContainer,
                child: Text(
                  prefs.userName.isNotEmpty
                      ? prefs.userName[0].toUpperCase()
                      : 'G',
                  style: textTheme.displaySmall?.copyWith(
                    color: colorScheme.onPrimaryContainer,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              Text(prefs.userName, style: textTheme.headlineMedium),
              const SizedBox(height: 4),
              Text(
                prefs.userBio,
                style: textTheme.titleMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),

              const SizedBox(height: 24),

              // Sound and Vibration status as chips
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton.icon(
                    onPressed: null,
                    icon: Icon(
                      prefs.soundEnabled
                          ? Icons.volume_up_outlined
                          : Icons.volume_off_outlined,
                    ),
                    label: Text(prefs.soundEnabled ? 'Sound On' : 'Sound Off'),
                  ),
                  const SizedBox(width: 12),
                  OutlinedButton.icon(
                    onPressed: null,
                    icon: Icon(
                      prefs.vibrationEnabled
                          ? Icons.vibration
                          : Icons.phone_android,
                    ),
                    label: Text(
                        prefs.vibrationEnabled ? 'Vibration On' : 'Vibration Off'),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Theme status
              Text(
                'Theme: $themeName',
                style: textTheme.bodyLarge?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),

              const SizedBox(height: 32),

              // Edit Settings button
              ElevatedButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.settings_outlined),
                label: const Text('Edit Settings'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
