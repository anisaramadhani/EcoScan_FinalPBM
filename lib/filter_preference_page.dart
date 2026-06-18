import 'package:flutter/material.dart';

class FilterSettingsPage extends StatefulWidget {
  const FilterSettingsPage({super.key});

  @override
  State<FilterSettingsPage> createState() => _FilterSettingsPageState();
}

class _FilterSettingsPageState extends State<FilterSettingsPage> {
  bool prioritasLokal = true;
  bool hanyaTersedia = false;
  String rentangHarga = 'Semua Harga';
  String skorEco = 'B atau lebih baik';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8F5E9),
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0, leading: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.black), onPressed: () => Navigator.pop(context)), title: const Text("Preferensi Filter", style: TextStyle(color: Colors.black))),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CheckboxListTile(title: const Text("Prioritas Produk Lokal"), value: prioritasLokal, onChanged: (v) => setState(() => prioritasLokal = v!)),
                CheckboxListTile(title: const Text("Hanya Produk Tersedia"), value: hanyaTersedia, onChanged: (v) => setState(() => hanyaTersedia = v!)),
                const Divider(),
                const Text("Rentang Harga", style: TextStyle(fontWeight: FontWeight.bold)),
                ...['Semua Harga', 'Ekonomis (< Rp 25.000)', 'Menengah (Rp 25.000 - Rp 50.000)', 'Premium (> Rp 50.000)'].map((e) => RadioListTile(title: Text(e), value: e, groupValue: rentangHarga, onChanged: (v) => setState(() => rentangHarga = v!))),
                const Divider(),
                const Text("Skor Eco Minimum", style: TextStyle(fontWeight: FontWeight.bold)),
                ...['A (Sangat Ramah Lingkungan)', 'B atau lebih baik', 'C atau lebih baik', 'Semua Skor'].map((e) => RadioListTile(title: Text(e), value: e, groupValue: skorEco, onChanged: (v) => setState(() => skorEco = v!))),
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