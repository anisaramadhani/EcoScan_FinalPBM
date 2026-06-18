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

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Produk yang di-scan:",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 8),

            _buildScannedProductCard(),

            const SizedBox(height: 20),

            const Text(
              "Alternatif yang Direkomendasikan:",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 8),

            ...List.generate(
              3,
              (index) => _buildAlternativeProductCard(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScannedProductCard() {
    return Card(
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
              width: 50,
              height: 50,

              decoration: BoxDecoration(
                color: Colors.green.shade100,
                borderRadius: BorderRadius.circular(10),
              ),

              child: const Icon(
                Icons.qr_code_scanner,
                color: Color(0xFF436946),
              ),
            ),

            const SizedBox(width: 12),

            const Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    "Sabun Cuci Piring Ekologis",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),

                  SizedBox(height: 4),

                  Text("EcoClean"),

                  SizedBox(height: 4),

                  Text(
                    "Rp 25.000",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 10,
              ),

              decoration: BoxDecoration(
                color: Colors.green.shade600,
                borderRadius: BorderRadius.circular(8),
              ),

              child: const Text(
                "A",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAlternativeProductCard() {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),

      child: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Sabun Cuci Piring Organik Premium",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: 4),

                      Text("Nature's Clean"),

                      SizedBox(height: 4),

                      Text(
                        "Rp 28.000",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  padding: const EdgeInsets.all(12),

                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius:
                        BorderRadius.circular(8),
                  ),

                  child: const Text(
                    "A",
                    style: TextStyle(
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
                  backgroundColor:
                      Colors.green.shade100,
                  label: const Text(
                    "Lebih Hijau",
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ),

                Chip(
                  backgroundColor:
                      Colors.green.shade100,
                  label: const Text(
                    "Merek Lokal",
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            const Row(
              children: [
                Icon(
                  Icons.location_on,
                  size: 16,
                  color: Colors.grey,
                ),

                SizedBox(width: 4),

                Expanded(
                  child: Text(
                    "Tersedia di: Alfamart, Indomaret",
                    style: TextStyle(
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