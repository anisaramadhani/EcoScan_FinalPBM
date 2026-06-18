import 'package:flutter/material.dart';
import 'dashboard.dart';

class RiwayatPage extends StatefulWidget {
  const RiwayatPage({super.key});

  @override
  State<RiwayatPage> createState() => _RiwayatPageState();
}

class _RiwayatPageState extends State<RiwayatPage> {
  bool showHistory = true;

  final Color primaryGreen = const Color(0xFF769173);

  @override
  Widget build(BuildContext context) {
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
              child: showHistory
                  ? _historyView()
                  : _impactView(),
            ),
          ],
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        selectedItemColor: primaryGreen,
        type: BottomNavigationBarType.fixed,

        onTap: (index) {
        if (index == 0) {
            Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => DashboardPage(),
            ),
            );
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

  Widget _historyView() {
    return ListView(
      children: [

        _historyCard(
          "Sabun Cuci Piring Ekologis",
          "EcoClean",
          "A",
        ),

        _historyCard(
          "Deterjen Ramah Lingkungan",
          "GreenWash",
          "B",
        ),

        _historyCard(
          "Shampoo Organik",
          "Nature's Best",
          "A",
        ),

        _historyCard(
          "Pasta Gigi Alami",
          "BioCare",
          "B",
        ),

        _historyCard(
          "Sabun Mandi Herbal",
          "EcoLife",
          "A",
        ),
      ],
    );
  }

  Widget _impactView() {
    return SingleChildScrollView(
      child: Column(
        children: [

          Row(
            children: [

              Expanded(
                child: _impactBox(
                  "5/6",
                  "Produk Hijau Dipilih",
                  Icons.trending_up,
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: _impactBox(
                  "8.7 Kg",
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
                    mainAxisAlignment:
                        MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment:
                        CrossAxisAlignment.end,
                    children: [

                      _bar(120),
                      _bar(150),
                      _bar(100),
                      _bar(160),
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
                backgroundColor:
                    const Color(0xFFEAF1E3),
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
              subtitle: const Text(
                "Hemat 5kg CO₂ dalam sebulan",
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
      String grade) {
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
          child: const Icon(Icons.eco_outlined),
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
            color: primaryGreen,
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
      IconData icon) {
    return Container(
      height: 140,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
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
          Text(title),
        ],
      ),
    );
  }

  Widget _bar(double height) {
    return Container(
      width: 35,
      height: height,
      decoration: BoxDecoration(
        color: primaryGreen,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}