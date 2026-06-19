import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'services/product_service.dart';
import 'dashboard.dart';
import 'scan.dart';
import 'profile_page.dart';

class RiwayatPage extends StatefulWidget {
  const RiwayatPage({super.key});

  @override
  State<RiwayatPage> createState() => _RiwayatPageState();
}

class _RiwayatPageState extends State<RiwayatPage> {
  bool showHistory = true;
  final Color primaryGreen = const Color(0xFF769173);
  final ProductService _productService = ProductService();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final user = _auth.currentUser;
    final uid = user?.uid ?? '';

    return Scaffold(
      backgroundColor: const Color(0xFFEAF1E3),
      appBar: AppBar(
        title: const Text("Riwayat"),
        backgroundColor: const Color(0xFFEAF1E3),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// TAB SWITCHER
            Container(
              height: 42,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          showHistory = true;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: showHistory
                              ? Colors.grey.shade200
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Center(
                          child: Text("Riwayat Scan"),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          showHistory = false;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: !showHistory
                              ? Colors.grey.shade200
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Center(
                          child: Text("Dampak Saya"),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            Expanded(
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: uid.isNotEmpty
                    ? _productService.getScanHistoryStream(uid)
                    : const Stream.empty(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator(color: Color(0xFF769173)));
                  }

                  final docs = snapshot.data?.docs ?? [];

                  if (showHistory) {
                    return _historyView(docs);
                  } else {
                    return _impactView(docs);
                  }
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        selectedItemColor: primaryGreen,
        type: BottomNavigationBarType.fixed,
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

  Widget _historyView(List<QueryDocumentSnapshot<Map<String, dynamic>>> docs) {
    if (docs.isEmpty) {
      return const Center(
        child: Text("Belum ada riwayat scan produk."),
      );
    }

    return ListView.builder(
      itemCount: docs.length,
      itemBuilder: (context, index) {
        final data = docs[index].data();
        return _historyCard(
          data['productName'] ?? 'Produk Tanpa Nama',
          data['productBrand'] ?? 'Brand',
          data['ecoScore'] ?? 'C',
        );
      },
    );
  }

  Widget _impactView(List<QueryDocumentSnapshot<Map<String, dynamic>>> docs) {
    int greenCount = 0;
    double totalCo2 = 0.0;

    for (var doc in docs) {
      final data = doc.data();
      final isEco = data['isEcoFriendly'] ?? false;
      final ecoScore = data['ecoScore'] ?? 'C';
      
      if (isEco || ecoScore == 'A' || ecoScore == 'B') {
        greenCount++;
      }

      final co2 = data['co2Saved'];
      if (co2 != null) {
        totalCo2 += (co2 as num).toDouble();
      }
    }

    // Dynamic bar heights based on co2 saved
    double barHeight = (totalCo2 * 12).clamp(10, 180).toDouble();

    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _impactBox(
                  "$greenCount/${docs.length}",
                  "Produk Hijau Dipilih",
                  Icons.trending_up,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _impactBox(
                  "${totalCo2.toStringAsFixed(1)} Kg",
                  "Total Karbon Tersimpan",
                  Icons.eco,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Karbon Hemat Per Minggu",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 180,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      _bar(30), // Minggu 1
                      _bar(45), // Minggu 2
                      _bar(20), // Minggu 3
                      _bar(barHeight), // Minggu 4 (Dynamic berdasarkan real data)
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
            ),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: const Color(0xFFEAF1E3),
                child: Icon(
                  Icons.eco,
                  color: primaryGreen,
                ),
              ),
              title: const Text(
                "Carbon Saver",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                "Anda telah menghemat ${totalCo2.toStringAsFixed(1)} kg CO₂ sejak menggunakan EcoScan.",
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _historyCard(
    String title,
    String brand,
    String grade,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(Icons.eco_outlined, color: Colors.green),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(brand),
        trailing: Container(
          width: 42,
          height: 42,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: grade.toUpperCase() == 'A' || grade.toUpperCase() == 'B' ? primaryGreen : Colors.amber,
            borderRadius: BorderRadius.circular(10),
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

  Widget _impactBox(
    String value,
    String title,
    IconData icon,
  ) {
    return Container(
      height: 140,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: primaryGreen,
          ),
          const Spacer(),
          Text(
            value,
            style: TextStyle(
              color: primaryGreen,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(title, style: const TextStyle(fontSize: 12, color: Colors.black54)),
        ],
      ),
    );
  }

  Widget _bar(double height) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 35,
          height: height.clamp(5, 180),
          decoration: BoxDecoration(
            color: primaryGreen,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        const SizedBox(height: 4),
        Text("W${height == 30 ? 1 : height == 45 ? 2 : height == 20 ? 3 : 4}", style: const TextStyle(fontSize: 10, color: Colors.grey)),
      ],
    );
  }
}