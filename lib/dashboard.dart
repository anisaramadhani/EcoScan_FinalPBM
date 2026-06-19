import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'services/product_service.dart';
import 'riwayat_page.dart';
import 'scan.dart';
import 'profile_page.dart';
import 'edubit_pages.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final ProductService _productService = ProductService();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  static const Color primaryGreen = Color(0xFF7D9E7A);
  static const Color lightGreen = Color(0xFFE7F0E1);

  String _getDayName(int day) {
    switch (day) {
      case 1: return "Senin";
      case 2: return "Selasa";
      case 3: return "Rabu";
      case 4: return "Kamis";
      case 5: return "Jumat";
      case 6: return "Sabtu";
      case 7: return "Minggu";
      default: return "";
    }
  }

  String _getMonthName(int month) {
    switch (month) {
      case 1: return "Januari";
      case 2: return "Februari";
      case 3: return "Maret";
      case 4: return "April";
      case 5: return "Mei";
      case 6: return "Juni";
      case 7: return "Juli";
      case 8: return "Agustus";
      case 9: return "September";
      case 10: return "Oktober";
      case 11: return "November";
      case 12: return "Desember";
      default: return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = _auth.currentUser;
    final uid = user?.uid ?? '';

    final String dateStr = "${_getDayName(DateTime.now().weekday)}, ${DateTime.now().day} ${_getMonthName(DateTime.now().month)} ${DateTime.now().year}";

    return Scaffold(
      backgroundColor: const Color(0xFFEAF1E3),
      body: SafeArea(
        child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: uid.isNotEmpty
              ? _db.collection('users').doc(uid).snapshots()
              : const Stream.empty(),
          builder: (context, userSnapshot) {
            String displayName = "Pengguna";
            if (userSnapshot.hasData && userSnapshot.data!.exists) {
              displayName = userSnapshot.data!.data()?['name'] ?? "Pengguna EcoScan";
            }

            return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: uid.isNotEmpty
                  ? _productService.getScanHistoryStream(uid)
                  : const Stream.empty(),
              builder: (context, historySnapshot) {
                int totalScanned = 0;
                double totalCo2 = 0.0;
                List<QueryDocumentSnapshot<Map<String, dynamic>>> recentScans = [];

                if (historySnapshot.hasData) {
                  final docs = historySnapshot.data!.docs;
                  totalScanned = docs.length;
                  recentScans = docs.take(3).toList();

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
                      /// Dashboard Title
                      const Text(
                        "Dashboard",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 20),

                      /// Greeting
                      Text(
                        "Hei, $displayName! 👋",
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),

                      Text(
                        dateStr,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 20),

                      /// TIP CARD (BISA DIKLIK)
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(18),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const EduBitPage(),
                              ),
                            );
                          },
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(18),
                            decoration: BoxDecoration(
                              color: primaryGreen,
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white24,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: const Text(
                                    "🏆 Tip Hari Ini",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 14),
                                const Text(
                                  "Kurangi Plastik Sekali Pakai",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  "Dengan membawa botol minum sendiri, Anda bisa mengurangi hingga 156 botol plastik per tahun!",
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 13,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                const Align(
                                  alignment: Alignment.centerRight,
                                  child: Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      /// IMPACT CARD
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Dampak Minggu Ini",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(height: 24),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: lightGreen,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: const Icon(
                                        Icons.eco,
                                        color: primaryGreen,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      "${totalCo2.toStringAsFixed(1)} kg",
                                      style: const TextStyle(
                                        fontSize: 24,
                                        color: primaryGreen,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Text(
                                      "CO₂ Tersimpan",
                                      style: TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: lightGreen,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: const Icon(
                                        Icons.qr_code_scanner,
                                        color: primaryGreen,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      "$totalScanned",
                                      style: const TextStyle(
                                        fontSize: 24,
                                        color: primaryGreen,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Text(
                                      "Produk Di-scan",
                                      style: TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      /// PRODUK TERAKHIR
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Produk Terakhir Di-scan",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => const RiwayatPage(),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    "Lihat Semua",
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),
                            if (recentScans.isEmpty)
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 16.0),
                                child: Center(
                                  child: Text(
                                    "Belum ada produk yang di-scan.",
                                    style: TextStyle(color: Colors.grey, fontSize: 13),
                                  ),
                                ),
                              )
                            else
                              ...recentScans.map((doc) {
                                final data = doc.data();
                                return _productTile(
                                  data['productName'] ?? 'Produk Tanpa Nama',
                                  data['productBrand'] ?? 'Brand',
                                  data['ecoScore'] ?? 'C',
                                );
                              }),
                          ],
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
        currentIndex: 0,
        selectedItemColor: primaryGreen,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          switch (index) {
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
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => const ProfilePage(),
                ),
              );
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
            icon: Icon(Icons.person_outline),
            label: "Profil",
          ),
        ],
      ),
    );
  }

  static Widget _productTile(
    String title,
    String subtitle,
    String grade,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: lightGreen,
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(
            Icons.eco,
            color: primaryGreen,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
        subtitle: Text(subtitle),
        trailing: Container(
          width: 34,
          height: 34,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: grade.toUpperCase() == 'A' || grade.toUpperCase() == 'B' ? primaryGreen : Colors.amber,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            grade,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}