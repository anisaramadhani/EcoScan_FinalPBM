import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'services/product_service.dart';
import 'services/auth_service.dart';
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

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final ProductService _productService = ProductService();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = _auth.currentUser;
    final uid = user?.uid ?? '';
    final email = user?.email ?? 'EcoScan@email.com';

    return Scaffold(
      backgroundColor: const Color(0xFFE8F5E9),
      body: SafeArea(
        child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: uid.isNotEmpty
              ? _db.collection('users').doc(uid).snapshots()
              : const Stream.empty(),
          builder: (context, userSnapshot) {
            String name = "Pengguna EcoScan";
            if (userSnapshot.hasData && userSnapshot.data!.exists) {
              name = userSnapshot.data!.data()?['name'] ?? "Pengguna EcoScan";
            }

            return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: uid.isNotEmpty
                  ? _productService.getScanHistoryStream(uid)
                  : const Stream.empty(),
              builder: (context, historySnapshot) {
                int totalScan = 0;
                double totalCo2 = 0.0;

                if (historySnapshot.hasData) {
                  final docs = historySnapshot.data!.docs;
                  totalScan = docs.length;
                  for (var doc in docs) {
                    final co2 = doc.data()['co2Saved'];
                    if (co2 != null) {
                      totalCo2 += (co2 as num).toDouble();
                    }
                  }
                }

                return SingleChildScrollView(
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
                              "https://api.dicebear.com/7.x/bottts/png?seed=ecoscan",
                            ),
                          ),
                          title: Text(
                            name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(email),
                          trailing: OutlinedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const EditProfilePage(),
                                ),
                              ).then((_) {
                                setState(() {}); // Refresh state when coming back
                              });
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
                                "$totalScan",
                                "Total Scan",
                              ),
                              _buildStatItem(
                                "${totalCo2.toStringAsFixed(1)} kg",
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
                          icon: const Icon(Icons.logout, color: Colors.red),
                          label: const Text("Keluar", style: TextStyle(color: Colors.red)),
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
                                    onPressed: () async {
                                      Navigator.pop(context);
                                      await _authService.logout();
                                      if (mounted) {
                                        Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => const LoginPage(),
                                          ),
                                          (route) => false,
                                        );
                                      }
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
                );
              },
            );
          },
        ),
      ),
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
                  builder: (_) => const DashboardPage(),
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
              ).then((_) {
                setState(() {});
              });
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