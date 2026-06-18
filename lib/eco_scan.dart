import 'package:flutter/material.dart';

class EcoScanLandingPage extends StatelessWidget {
  const EcoScanLandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8F5E9),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              // Header
              Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Masuk",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Judul
              const Text(
                "Scan Smarter.\nLive Greener.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),

              const SizedBox(height: 16),

              const Text(
                "Pindai produk dan temukan informasi keberlanjutannya. Buat keputusan belanja yang lebih bijak.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),

              const SizedBox(height: 30),

              // Logo
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Center(
                  child: Icon(
                    Icons.eco,
                    size: 80,
                    color: Colors.green,
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // Tombol Mulai Gratis
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF436946),
                  ),
                  onPressed: () {},
                  child: const Text(
                    "Mulai Gratis",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Tombol Masuk
              SizedBox(
                width: double.infinity,
                height: 50,
                child: OutlinedButton(
                  onPressed: () {},
                  child: const Text(
                    "Masuk",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // Fitur
              _buildFeatureCard(
                Icons.qr_code_scanner,
                "Scan Produk",
                "Pindai barcode atau foto kemasan untuk mendapatkan info keberlanjutan",
              ),

              _buildFeatureCard(
                Icons.bar_chart,
                "Eco Score",
                "Skor A hingga E berdasarkan bahan, produksi, dan jejak karbon",
              ),

              _buildFeatureCard(
                Icons.trending_up,
                "Rekomendasi Hijau",
                "Alternatif produk lebih ramah lingkungan dengan harga terjangkau",
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureCard(
    IconData icon,
    String title,
    String subtitle,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: Colors.green,
          size: 30,
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(subtitle),
      ),
    );
  }
}