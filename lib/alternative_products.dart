import 'package:flutter/material.dart';
import 'services/product_service.dart';

class AlternativeProductsPage extends StatefulWidget {
  final String category;
  final String barcode;

  const AlternativeProductsPage({
    super.key,
    required this.category,
    required this.barcode,
  });

  @override
  State<AlternativeProductsPage> createState() => _AlternativeProductsPageState();
}

class _AlternativeProductsPageState extends State<AlternativeProductsPage> {
  final ProductService _productService = ProductService();
  late Future<List<Map<String, dynamic>>> _alternativesFuture;

  @override
  void initState() {
    super.initState();
    _alternativesFuture = _productService.getAlternatives(widget.category, widget.barcode);
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
    return Scaffold(
      backgroundColor: const Color(0xFFE8F5E9),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Alternatif Lebih Hijau",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _alternativesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: Color(0xFF436946)));
          }

          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          final alternatives = snapshot.data ?? [];

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Kategori Produk yang di-scan:",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                
                // Card kategori
                Card(
                  color: const Color(0xFF9FBC9C),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Container(
                          width: 45,
                          height: 45,
                          decoration: BoxDecoration(
                            color: Colors.green.shade100,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.category_outlined,
                            color: Color(0xFF436946),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Kategori Terdeteksi",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black54,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                widget.category,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  "Alternatif yang Direkomendasikan:",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),

                if (alternatives.isEmpty)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 24.0),
                    child: Center(
                      child: Text("Tidak ada rekomendasi alternatif untuk saat ini."),
                    ),
                  )
                else
                  ...alternatives.map((prod) => _buildAlternativeProductCard(prod)),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildAlternativeProductCard(Map<String, dynamic> product) {
    final ecoScore = product['ecoScore'] ?? 'B';
    final gradeColor = _getGradeColor(ecoScore);
    final String storeList = (product['stores'] as List<dynamic>?)?.join(', ') ?? 'Supermarket Lokal';

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product['name'] ?? 'Produk Organik',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        product['brand'] ?? 'Brand Eco',
                        style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Rp ${(product['price'] ?? 20000.0).toStringAsFixed(0)}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: gradeColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    ecoScore,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                Chip(
                  backgroundColor: Colors.green.shade100,
                  label: const Text(
                    "Lebih Hijau",
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF436946),
                    ),
                  ),
                ),
                Chip(
                  backgroundColor: Colors.green.shade100,
                  label: const Text(
                    "Ramah Lingkungan",
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF436946),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(
                  Icons.location_on,
                  size: 16,
                  color: Colors.grey,
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    "Tersedia di: $storeList",
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}