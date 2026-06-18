import 'package:flutter/material.dart';

import 'dashboard.dart';
import 'riwayat_page.dart';
import 'scan.dart';
import 'edit_profile_pages.dart';
import 'notification_setting_pages.dart';
import 'language_settings_page.dart';
import 'theme_page.dart';
import 'filter_preference_page.dart';
import 'privacy_polices.dart';
import 'terms.dart';
import 'login_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8F5E9),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Profil",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 16),

              /// CARD PROFIL
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  leading: const CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(
                      "https://via.placeholder.com/150",
                    ),
                  ),
                  title: const Text(
                    "Pengguna EcoScan",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: const Text(
                    "EcoScan@email.com",
                  ),
                  trailing: OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const EditProfilePage(),
                        ),
                      );
                    },
                    child: const Text("Edit"),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              /// STATISTIK
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildStatItem(
                        "47",
                        "Total Scan",
                      ),
                      _buildStatItem(
                        "8.7 kg",
                        "CO₂ Hemat",
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              /// PENGATURAN
              const Text(
                "Pengaturan",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              _buildSettingList(context),

              const SizedBox(height: 16),

              /// AKUN
              const Text(
                "Akun",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              _buildAccountOptions(context),

              const SizedBox(height: 16),

              /// LOGOUT
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  icon: const Icon(Icons.logout),
                  label: const Text("Keluar"),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text("Logout"),
                        content: const Text(
                          "Apakah Anda yakin ingin keluar dari akun?",
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("Batal"),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                            ),
                            onPressed: () {
                              Navigator.pop(context);

                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const LoginPage(),
                                ),
                                (route) => false,
                              );
                            },
                            child: const Text(
                              "Keluar",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 8),

              const Center(
                child: Text(
                  "EcoScan v1.0.0",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      /// BOTTOM NAVIGATION
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 3,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.green.shade900,

        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => DashboardPage(),
                ),
              );
              break;

            case 1:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => const RiwayatPage(),
                ),
              );
              break;

            case 2:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => const ScanPage(),
                ),
              );
              break;

            case 3:
              break;
          }
        },

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: "Riwayat",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code_scanner),
            label: "Scan",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profil",
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildSettingList(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.notifications_none),
            title: const Text("Notifikasi"),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const NotificationSettingsPage(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text("Bahasa"),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const LanguageSettingsPage(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.palette_outlined),
            title: const Text("Tema"),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const ThemeSettingsPage(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.tune),
            title: const Text("Preferensi Filter"),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const FilterSettingsPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAccountOptions(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.person_outline),
            title: const Text("Edit Profil"),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const EditProfilePage(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.lock_outline),
            title: const Text("Kebijakan Privasi"),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const PrivacyPolicyPage(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.description_outlined),
            title: const Text("Syarat & Ketentuan"),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const TermsConditionsPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}