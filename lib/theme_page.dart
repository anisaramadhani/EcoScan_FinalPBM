import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme_provider.dart';

class ThemeSettingsPage extends StatefulWidget {
  const ThemeSettingsPage({super.key});

  @override
  State<ThemeSettingsPage> createState() => _ThemeSettingsPageState();
}

class _ThemeSettingsPageState extends State<ThemeSettingsPage> {
  String selectedTheme = 'Terang';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8F5E9),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Tema",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RadioListTile<String>(
                  title: const Text("Terang"),
                  subtitle:
                      const Text("Tampilan terang untuk siang hari"),
                  value: 'Terang',
                  groupValue: selectedTheme,
                  onChanged: (value) {
                    setState(() {
                      selectedTheme = value!;
                    });
                  },
                ),

                RadioListTile<String>(
                  title: const Text("Gelap"),
                  subtitle:
                      const Text("Tampilan gelap untuk malam hari"),
                  value: 'Gelap',
                  groupValue: selectedTheme,
                  onChanged: (value) {
                    setState(() {
                      selectedTheme = value!;
                    });
                  },
                ),

                RadioListTile<String>(
                  title: const Text("Otomatis"),
                  subtitle:
                      const Text("Mengikuti tema sistem perangkat"),
                  value: 'Otomatis',
                  groupValue: selectedTheme,
                  onChanged: (value) {
                    setState(() {
                      selectedTheme = value!;
                    });
                  },
                ),

                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF436946),
                    ),
                    onPressed: () {
                      Provider.of<ThemeProvider>(
                        context,
                        listen: false,
                      ).setTheme(selectedTheme);

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            "Tema berhasil diperbarui",
                          ),
                        ),
                      );

                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Simpan Pengaturan",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
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