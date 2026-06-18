import 'package:flutter/material.dart';

class LanguageSettingsPage extends StatefulWidget {
  const LanguageSettingsPage({super.key});

  @override
  State<LanguageSettingsPage> createState() => _LanguageSettingsPageState();
}

class _LanguageSettingsPageState extends State<LanguageSettingsPage> {
  String selectedLanguage = 'Bahasa Indonesia';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8F5E9),
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0, leading: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.black), onPressed: () => Navigator.pop(context)), title: const Text("Bahasa", style: TextStyle(color: Colors.black))),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RadioListTile(title: const Text("Bahasa Indonesia"), value: 'Bahasa Indonesia', groupValue: selectedLanguage, onChanged: (v) => setState(() => selectedLanguage = v!)),
                RadioListTile(title: const Text("English"), value: 'English', groupValue: selectedLanguage, onChanged: (v) => setState(() => selectedLanguage = v!)),
                ListTile(title: const Text("Español", style: TextStyle(color: Colors.grey)), subtitle: const Text("Segera hadir")),
                const SizedBox(height: 20),
                SizedBox(width: double.infinity, height: 50, child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF436946)), onPressed: () => Navigator.pop(context), child: const Text("Simpan Pengaturan", style: TextStyle(color: Colors.white)))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}