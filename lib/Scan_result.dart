import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'services/product_service.dart';
import 'alternative_products.dart';
import 'dashboard.dart';

class ScanResultPage extends StatefulWidget {
  final String barcode;
  const ScanResultPage({super.key, required this.barcode});

  @override
  State<ScanResultPage> createState() => _ScanResultPageState();
}

class _ScanResultPageState extends State<ScanResultPage> {
  final ProductService _productService = ProductService();
  bool _isLoading = true;
  bool _isSaving = false;
  bool _isSaved = false;
  Map<String, dynamic>? _product;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadProduct();
  }

  Future<void> _loadProduct() async {
    try {
      final p = await _productService.getProduct(widget.barcode);
      if (mounted) {
        setState(() {
          _product = p;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _saveToHistory() async {
    if (_product == null) return;
    setState(() {
      _isSaving = true;
    });
    try {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid != null) {
        await _productService.saveScanHistory(uid: uid, product: _product!);
        if (mounted) {
          setState(() {
            _isSaved = true;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Berhasil disimpan ke riwayat")),
          );
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Silakan login terlebih dahulu untuk menyimpan")),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Gagal menyimpan: $e")),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
      }
    }
  }

  Color _getGradeColor(String grade) {
    switch (grade.toUpperCase()) {
      case 'A':
        return const Color(0xFF436946);
      case 'B':
        return Colors.green.shade400;
      case 'C':
        return Colors.amber;
      case 'D':
        return Colors.orange;
      case 'E':
      default:
        return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        backgroundColor: Color(0xFFE8F5E9),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(color: Color(0xFF436946)),
              SizedBox(height: 16),
              Text("Mengambil data produk...", style: TextStyle(fontWeight: FontWeight.w500)),
            ],
          ),
        ),
      );
    }

    if (_error != null || _product == null) {
      return Scaffold(
        backgroundColor: const Color(0xFFE8F5E9),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => DashboardPage(),
                ),
                (route) => false,
              );
            },
          ),
          title: const Text("Hasil Scan", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 64, color: Colors.red),
                const SizedBox(height: 16),
                Text("Terjadi kesalahan: ${_error ?? 'Produk tidak ditemukan'}", textAlign: TextAlign.center),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _isLoading = true;
                      _error = null;
                    });
                    _loadProduct();
                  },
                  child: const Text("Coba Lagi"),
                )
              ],
            ),
          ),
        ),
      );
    }

    final p = _product!;
    final String ecoScore = p['ecoScore'] ?? 'C';
    final Color gradeColor = _getGradeColor(ecoScore);
    final String labelStr = p['labels'] ?? 'Tidak ada label sertifikasi';
    final String packagingStr = p['packaging'] ?? 'Kemasan Standar';
    final String ingredientsStr = p['ingredients'] ?? 'Bahan tidak tercantum';
    final String nutriScore = p['nutriScore'] ?? 'N/A';

    return Scaffold(
      backgroundColor: const Color(0xFFE8F5E9),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => DashboardPage(),
              ),
              (route) => false,
            );
          },
        ),
        title: const Text(
          "Hasil Scan",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.share,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Produk Card
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.shopping_bag_outlined, color: Color(0xFF436946)),
                ),
                title: Text(
                  p['name'] ?? 'Sabun Cuci Piring',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  "${p['brand'] ?? 'EcoClean'}\n${p['category'] ?? 'Pembersih'}",
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Eco Score Container
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: gradeColor,
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Text(
                    "Eco-Score",
                    style: TextStyle(
                      color: gradeColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    ecoScore,
                    style: TextStyle(
                      fontSize: 64,
                      fontWeight: FontWeight.bold,
                      color: gradeColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    p['ecoGradeDesc'] ?? 'Cukup Ramah Lingkungan',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  if (p['ecoScoreFromAPI'] == false)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        "*Dihitung otomatis oleh EcoScan (Fallback API)",
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 11,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Nutri Score (Tambahan dari request user)
            if (nutriScore != 'N/A' && nutriScore != 'UNKNOWN')
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Nutri-Score Grade:",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade800,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            nutriScore,
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

            // Detail Penilaian
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Detail Penilaian",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                _buildProgressItem(
                  "Bahan Baku (Ingredients)",
                  ingredientsStr,
                  p['ingredientsScore'] ?? 0.70,
                  p['ingredientsPercentage'] ?? '70%',
                ),
                _buildProgressItem(
                  "Jejak Lingkungan (Kemasan & Label)",
                  "Kemasan: $packagingStr\n\nLabel: $labelStr",
                  p['carbonScore'] ?? 0.70,
                  p['carbonPercentage'] ?? '70%',
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Fakta Menarik
            Container(
              margin: const EdgeInsets.symmetric(vertical: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      Text(
                        " Fakta Menarik",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    p['interestingFact'] ??
                        "Produk ini mengandung bahan-bahan pilihan yang ditargetkan untuk mengurangi dampak buruk pada ekosistem lokal.",
                  ),
                ],
              ),
            ),

            // Tombol Alternatif
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF436946),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AlternativeProductsPage(
                        category: p['category'] ?? 'Makanan & Minuman',
                        barcode: widget.barcode,
                      ),
                    ),
                  );
                },
                child: const Text(
                  "Lihat Alternatif Lebih Hijau",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Simpan Riwayat Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: _isSaved
                  ? OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.green),
                      ),
                      onPressed: null,
                      icon: const Icon(Icons.check, color: Colors.green),
                      label: const Text(
                        "Tersimpan di Riwayat",
                        style: TextStyle(color: Colors.green),
                      ),
                    )
                  : OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFF436946)),
                      ),
                      onPressed: _isSaving ? null : _saveToHistory,
                      icon: _isSaving
                          ? const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(strokeWidth: 2, color: Color(0xFF436946)),
                            )
                          : const Icon(Icons.bookmark_border, color: Color(0xFF436946)),
                      label: const Text(
                        "Simpan ke Riwayat",
                        style: TextStyle(color: Color(0xFF436946)),
                      ),
                    ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressItem(
    String title,
    String detailText,
    double value,
    String percentage,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ExpansionTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Eco-Efficiency Score:"),
                    Text(percentage, style: const TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: value,
                  color: const Color(0xFF436946),
                  backgroundColor: Colors.grey[200],
                ),
                const SizedBox(height: 16),
                Text(
                  detailText,
                  style: TextStyle(color: Colors.grey.shade800, fontSize: 13, height: 1.4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}