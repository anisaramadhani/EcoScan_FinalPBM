import 'package:flutter/material.dart';

class NotificationSettingsPage extends StatefulWidget {
  const NotificationSettingsPage({super.key});

  @override
  State<NotificationSettingsPage> createState() => _NotificationSettingsPageState();
}

class _NotificationSettingsPageState extends State<NotificationSettingsPage> {
  bool tipsHarian = true;
  bool pencapaian = true;
  bool laporanMingguan = false;
  bool alertProduk = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8F5E9),
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0, leading: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.black), onPressed: () => Navigator.pop(context)), title: const Text("Notifikasi", style: TextStyle(color: Colors.black))),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SwitchListTile(title: const Text("Tips Harian"), subtitle: const Text("Terima tip lingkungan setiap hari"), value: tipsHarian, onChanged: (v) => setState(() => tipsHarian = v)),
                SwitchListTile(title: const Text("Pencapaian"), subtitle: const Text("Notifikasi saat mendapat badge baru"), value: pencapaian, onChanged: (v) => setState(() => pencapaian = v)),
                SwitchListTile(title: const Text("Laporan Mingguan"), subtitle: const Text("Ringkasan dampak mingguan Anda"), value: laporanMingguan, onChanged: (v) => setState(() => laporanMingguan = v)),
                SwitchListTile(title: const Text("Alert Produk"), subtitle: const Text("Peringatan produk tidak ramah lingkungan"), value: alertProduk, onChanged: (v) => setState(() => alertProduk = v)),
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