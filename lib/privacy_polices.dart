import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8F5E9),
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0, leading: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.black), onPressed: () => Navigator.pop(context)), title: const Text("Kebijakan Privasi", style: TextStyle(color: Colors.black))),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Data yang Kami Kumpulkan", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                Text("Kami mengumpulkan data berupa:\n- Nama dan Email saat pendaftaran.\n- Riwayat produk yang dipindai (Scan).\n- Preferensi filter yang Anda atur."),
                SizedBox(height: 20),
                Text("Penggunaan Data", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                Text("Data digunakan untuk meningkatkan akurasi rekomendasi ramah lingkungan dan statistik jejak karbon pribadi Anda. Kami tidak akan membagikan data pribadi Anda ke pihak ketiga tanpa persetujuan."),
              ],
            ),
          ),
        ),
      ),
    );
  }
}