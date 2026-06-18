import 'package:flutter/material.dart';

class AlternativeProductsPage extends StatelessWidget {
  const AlternativeProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8F5E9),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const Icon(Icons.arrow_back, color: Colors.black),
        title: const Text("Alternatif Lebih Hijau", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Produk yang di-scan:", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            _buildScannedProductCard(),
            const SizedBox(height: 16),
            ...List.generate(3, (index) => _buildAlternativeProductCard()),
          ],
        ),
      ),
    );
  }

  Widget _buildScannedProductCard() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        title: const Text("Sabun Cuci Piring Ekologis", style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: const Text("EcoClean\nRp 25.000"),
        trailing: Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.green.shade400, borderRadius: BorderRadius.circular(8)), child: const Text("A", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
      ),
    );
  }

  Widget _buildAlternativeProductCard() {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    const Text("Sabun Cuci Piring Organik Premium", style: TextStyle(fontWeight: FontWeight.bold)),
                    const Text("Nature's Clean"),
                    const Text("Rp 28.000", style: TextStyle(fontWeight: FontWeight.bold)),
                  ]),
                ),
                Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.green.shade600, borderRadius: BorderRadius.circular(8)), child: const Text("A", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold))),
              ],
            ),
            const SizedBox(height: 8),
            Wrap(spacing: 8, children: [
              Chip(label: const Text("Lebih Hijau", style: TextStyle(fontSize: 12)), backgroundColor: Colors.green.shade100),
              Chip(label: const Text("Merek Lokal", style: TextStyle(fontSize: 12)), backgroundColor: Colors.green.shade100),
            ]),
            const Row(children: [Icon(Icons.location_on, size: 16, color: Colors.grey), SizedBox(width: 4), Text("Tersedia di: Alfamart, Indomaret", style: TextStyle(fontSize: 12, color: Colors.grey))]),
            const SizedBox(height: 12),
            Row(children: [
              Expanded(child: OutlinedButton(onPressed: () {}, child: const Text("Bandingkan Detail"))),
              const SizedBox(width: 10),
              Expanded(child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF436946)), onPressed: () {}, child: const Text("Pilih Produk Ini", style: TextStyle(color: Colors.white)))),
            ]),
          ],
        ),
      ),
    );
  }
}