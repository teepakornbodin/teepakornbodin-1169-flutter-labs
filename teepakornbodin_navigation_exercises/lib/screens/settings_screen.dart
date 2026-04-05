import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teepakornbodin_navigation_exercises/states/quiz_preferences_state.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  void _showNameDialog(BuildContext context, String field, String current) {
    final controller = TextEditingController(text: current);
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Edit $field'),
        content: TextField(controller: controller),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (field == 'Name') {
                context
                    .read<QuizPreferencesState>()
                    .setUserName(controller.text.trim());
              } else {
                context
                    .read<QuizPreferencesState>()
                    .setUserBio(controller.text.trim());
              }
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings'), centerTitle: true),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.pushNamed(context, '/profile'),
        icon: const Icon(Icons.person_outlined),
        label: const Text('View Profile'),
      ),
      body: Consumer<QuizPreferencesState>(
        builder: (context, prefs, _) => ListView(
          children: [
            // User Profile
            _SectionHeader(title: 'User Profile'),
            ListTile(
              leading: const Icon(Icons.person_outlined),
              title: const Text('Name'),
              subtitle: Text(prefs.userName),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => _showNameDialog(context, 'Name', prefs.userName),
            ),
            ListTile(
              leading: const Icon(Icons.info_outlined),
              title: const Text('Bio'),
              subtitle: Text(prefs.userBio),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => _showNameDialog(context, 'Bio', prefs.userBio),
            ),

            // Preferences
            _SectionHeader(title: 'Preferences'),
            SwitchListTile(
              secondary: const Icon(Icons.volume_up_outlined),
              title: const Text('Sound Effects'),
              subtitle: const Text('Play sounds when answering'),
              value: prefs.soundEnabled,
              onChanged: (v) => prefs.setSoundEnabled(v),
            ),
            SwitchListTile(
              secondary: const Icon(Icons.vibration),
              title: const Text('Vibration'),
              subtitle: const Text('Vibrate on correct/wrong answers'),
              value: prefs.vibrationEnabled,
              onChanged: (v) => prefs.setVibrationEnabled(v),
            ),

            // Theme
            _SectionHeader(title: 'Theme'),
            RadioListTile<ThemeMode>(
              title: const Text('System Default'),
              value: ThemeMode.system,
              groupValue: prefs.themeMode,
              onChanged: (v) => prefs.setThemeMode(v!),
            ),
            RadioListTile<ThemeMode>(
              title: const Text('Light Mode'),
              value: ThemeMode.light,
              groupValue: prefs.themeMode,
              onChanged: (v) => prefs.setThemeMode(v!),
            ),
            RadioListTile<ThemeMode>(
              title: const Text('Dark Mode'),
              value: ThemeMode.dark,
              groupValue: prefs.themeMode,
              onChanged: (v) => prefs.setThemeMode(v!),
            ),

            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
      child: Text(
        title,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}
