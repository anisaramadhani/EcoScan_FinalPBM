import 'package:flutter/material.dart';

class EduBitPage extends StatefulWidget {
  const EduBitPage({super.key});

  @override
  State<EduBitPage> createState() => _EduBitPageState();
}

class _EduBitPageState extends State<EduBitPage> {
  final PageController _pageController = PageController();

  int _currentPage = 0;

  final List<Map<String, String>> eduData = [
    {
      "tag": "Konsumsi Berkelanjutan",
      "title": "Kurangi Plastik Sekali Pakai",
      "desc":
          "Dengan membawa botol minum sendiri, Anda bisa mengurangi hingga 156 botol plastik per tahun! Plastik membutuhkan ratusan tahun untuk terurai dan mencemari lautan kita."
    },
    {
      "tag": "Pertanian Berkelanjutan",
      "title": "Pilih Produk Organik Lokal",
      "desc":
          "Produk lokal mengurangi emisi transportasi hingga 70%. Selain itu, produk organik tidak menggunakan pestisida kimia yang merusak tanah dan air."
    },
    {
      "tag": "Pengelolaan Limbah",
      "title": "Kompos dari Sisa Makanan",
      "desc":
          "Sisa makanan di TPA menghasilkan gas metana yang 25x lebih berbahaya dari CO₂. Dengan mengkompos, Anda mengubah sampah menjadi pupuk alami."
    },
    {
      "tag": "Konservasi Air",
      "title": "Hemat Air Saat Mencuci",
      "desc":
          "Menggunakan sabun konsentrat dapat mengurangi penggunaan air hingga 50%. Tutup keran saat menyabuni untuk menghemat 6 liter air per menit."
    },
    {
      "tag": "Perubahan Iklim",
      "title": "Dampak Perubahan Iklim",
      "desc":
          "Suhu bumi telah meningkat 1.1°C sejak era pra-industri. Setiap 0.5°C kenaikan berarti lebih banyak bencana alam. Pilihan harian kita sangat penting!"
    },
    {
      "tag": "Bahan Kimia Ramah Tangga",
      "title": "Surfaktan Ramah Lingkungan",
      "desc":
          "Deterjen konvensional mengandung surfaktan kimia yang mencemari sungai. Pilih produk dengan surfaktan nabati yang mudah terurai secara alami."
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < eduData.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8F5E9),

      appBar: AppBar(
        backgroundColor: const Color(0xFFE8F5E9),
        elevation: 0,
        title: const Text(
          "EduBit",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: eduData.length,
                onPageChanged: (page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: [
                          const Align(
                            alignment: Alignment.topRight,
                            child: Text(
                              "SDG 13.3",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ),

                          const SizedBox(height: 40),

                          const Icon(
                            Icons.eco,
                            size: 80,
                            color: Color(0xFF436946),
                          ),

                          const SizedBox(height: 20),

                          Chip(
                            label: Text(
                              eduData[index]["tag"]!,
                              style: const TextStyle(fontSize: 12),
                            ),
                          ),

                          const SizedBox(height: 20),

                          Text(
                            eduData[index]["title"]!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 12),

                          Text(
                            eduData[index]["desc"]!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 14,
                              height: 1.5,
                            ),
                          ),

                          const Spacer(),

                          const Divider(),

                          Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: List.generate(
                                  eduData.length,
                                  (i) => Padding(
                                    padding:
                                        const EdgeInsets.symmetric(
                                      horizontal: 2,
                                    ),
                                    child: Icon(
                                      Icons.circle,
                                      size: 8,
                                      color: i == index
                                          ? const Color(0xFF436946)
                                          : Colors.grey.shade400,
                                    ),
                                  ),
                                ),
                              ),

                              TextButton.icon(
                                onPressed: () {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        "Fitur Bagikan akan segera hadir",
                                      ),
                                    ),
                                  );
                                },
                                icon: const Icon(
                                  Icons.share,
                                  size: 18,
                                ),
                                label: const Text("Bagikan"),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 20),

            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
              children: [
                FloatingActionButton(
                  heroTag: "prev",
                  backgroundColor: _currentPage > 0
                      ? const Color(0xFF436946)
                      : Colors.grey.shade300,
                  onPressed:
                      _currentPage > 0 ? _previousPage : null,
                  child: const Icon(
                    Icons.chevron_left,
                    color: Colors.white,
                  ),
                ),

                Text(
                  "${_currentPage + 1} dari ${eduData.length}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),

                FloatingActionButton(
                  heroTag: "next",
                  backgroundColor:
                      _currentPage < eduData.length - 1
                          ? const Color(0xFF436946)
                          : Colors.grey.shade300,
                  onPressed:
                      _currentPage < eduData.length - 1
                          ? _nextPage
                          : null,
                  child: const Icon(
                    Icons.chevron_right,
                    color: Colors.white,
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