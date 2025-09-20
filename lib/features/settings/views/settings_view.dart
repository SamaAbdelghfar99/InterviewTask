import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Settings Page Features",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Language Switching section
            const Text("Language Switching:"),
            const SizedBox(height: 8),
            DropdownButton<String>(
              value: context.locale.languageCode,
              items:  [
                DropdownMenuItem(
                  value: "en",
                  child: Text("English"),
                ),
                DropdownMenuItem(
                  value: "ar",
                  child: Text("العربية"),
                ),
              ],
              onChanged: (value) {
                if (value != null) {
                  context.setLocale(Locale(value));
                }
              },
            ),

            const SizedBox(height: 20),

            // UI Translation section
            const Text("UI Translation:"),
            const SizedBox(height: 8),
            const Text(
              "All text elements should be properly translated",
            ),
          ],
        ),
      ),
    );
  }
}
