import 'package:flutter/material.dart';

class TermsConditionsPage extends StatelessWidget {
  const TermsConditionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8F5E9),
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0, leading: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.black), onPressed: () => Navigator.pop(context)), title: const Text("Syarat & Ketentuan", style: TextStyle(color: Colors.black))),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Ketentuan Penggunaan", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                Text("Dengan menggunakan aplikasi EcoScan, Anda menyetujui ketentuan berikut:\n\n1. Pengguna bertanggung jawab atas informasi yang diunggah.\n2. EcoScan berhak memperbarui data jejak karbon secara berkala.\n3. Dilarang menyalahgunakan data untuk kepentingan komersial tanpa izin."),
                SizedBox(height: 20),
                Text("Kebijakan Layanan", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                Text("Layanan kami diberikan 'apa adanya'. Kami berupaya memberikan informasi yang akurat namun tidak menjamin 100% akurasi data bahan baku produk."),
              ],
            ),
          ),
        ),
      ),
    );
  }
}