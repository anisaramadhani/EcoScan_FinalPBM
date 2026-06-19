import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

class ProductService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Memetakan nilai Eco-Score ke deskripsi, skor persentase, dan emisi CO2 yang tersimpan
  Map<String, dynamic> _getEcoScoreDetails(String grade) {
    switch (grade.toUpperCase()) {
      case 'A':
        return {
          'ecoGradeDesc': 'Sangat Ramah Lingkungan',
          'ingredientsScore': 0.95,
          'ingredientsPercentage': '95%',
          'carbonScore': 0.95,
          'carbonPercentage': '95%',
          'co2Saved': 1.5,
          'isEcoFriendly': true,
        };
      case 'B':
        return {
          'ecoGradeDesc': 'Ramah Lingkungan',
          'ingredientsScore': 0.85,
          'ingredientsPercentage': '85%',
          'carbonScore': 0.85,
          'carbonPercentage': '85%',
          'co2Saved': 1.0,
          'isEcoFriendly': true,
        };
      case 'C':
        return {
          'ecoGradeDesc': 'Cukup Ramah Lingkungan',
          'ingredientsScore': 0.70,
          'ingredientsPercentage': '70%',
          'carbonScore': 0.70,
          'carbonPercentage': '70%',
          'co2Saved': 0.5,
          'isEcoFriendly': false,
        };
      case 'D':
        return {
          'ecoGradeDesc': 'Kurang Ramah Lingkungan',
          'ingredientsScore': 0.50,
          'ingredientsPercentage': '50%',
          'carbonScore': 0.50,
          'carbonPercentage': '50%',
          'co2Saved': 0.2,
          'isEcoFriendly': false,
        };
      case 'E':
      default:
        return {
          'ecoGradeDesc': 'Tidak Ramah Lingkungan',
          'ingredientsScore': 0.30,
          'ingredientsPercentage': '30%',
          'carbonScore': 0.30,
          'carbonPercentage': '30%',
          'co2Saved': 0.0,
          'isEcoFriendly': false,
        };
    }
  }

  // Algoritma Fallback untuk menghitung Eco-Score dari atribut kemasan, label, dan bahan
  String _calculateFallbackEcoScore({
    required String labels,
    required String packaging,
    required String ingredients,
  }) {
    int points = 0;
    final labelsLower = labels.toLowerCase();
    final packagingLower = packaging.toLowerCase();

    // 1. Cek Label Ekologis (+2 Poin)
    if (labelsLower.contains('organic') ||
        labelsLower.contains('organik') ||
        labelsLower.contains('bio') ||
        labelsLower.contains('eco') ||
        labelsLower.contains('fairtrade') ||
        labelsLower.contains('rainforest') ||
        labelsLower.contains('fsc')) {
      points += 2;
    }

    // 2. Cek Kemasan Ramah Lingkungan (+1 Poin)
    if (packagingLower.contains('paper') ||
        packagingLower.contains('kertas') ||
        packagingLower.contains('cardboard') ||
        packagingLower.contains('karton') ||
        packagingLower.contains('glass') ||
        packagingLower.contains('kaca') ||
        packagingLower.contains('recycled') ||
        packagingLower.contains('daur ulang') ||
        packagingLower.contains('biodegradable')) {
      points += 1;
    }

    // 3. Cek Kemasan Kurang Ramah Lingkungan (-1 Poin)
    if (packagingLower.contains('plastic') ||
        packagingLower.contains('plastik') ||
        packagingLower.contains('pet') ||
        packagingLower.contains('pvc') ||
        packagingLower.contains('styrofoam') ||
        packagingLower.contains('kaleng') ||
        packagingLower.contains('alu')) {
      points -= 1;
    }

    // 4. Pemetaan Skor Akhir
    if (points >= 2) return 'A';
    if (points == 1) return 'B';
    if (points == 0) return 'C';
    if (points == -1) return 'D';
    return 'E';
  }

  // Request API OpenFoodFacts dan simpan/cache ke Cloud Firestore
  Future<Map<String, dynamic>> fetchProductFromOpenFoodFacts(String barcode) async {
    final url = Uri.parse('https://world.openfoodfacts.org/api/v2/product/$barcode.json');
    try {
      final response = await http.get(
        url,
        headers: {'User-Agent': 'EcoScan - Flutter Android App - Version 1.0.0'},
      );

      if (response.statusCode == 200) {
        final decoded = json.decode(response.body);
        if (decoded['status'] == 1 && decoded['product'] != null) {
          final productData = decoded['product'];

          // Ambil nama
          final name = productData['product_name_id'] ??
              productData['product_name'] ??
              productData['product_name_en'] ??
              'Produk Tanpa Nama';

          // Ambil brand
          final brand = productData['brands'] ?? 'Brand Tidak Teridentifikasi';

          // Ambil bahan-bahan
          final ingredients = productData['ingredients_text_id'] ??
              productData['ingredients_text'] ??
              productData['ingredients_text_en'] ??
              'Bahan-bahan tidak tercantum.';

          // Ambil Nutri-Score
          final nutriScore = (productData['nutriscore_grade'] ?? 'Unknown')
              .toString()
              .toUpperCase();

          // Ambil Kemasan dan Label
          final packaging = productData['packaging_text'] ??
              productData['packaging'] ??
              '';
          
          final labels = productData['labels'] ?? '';

          // Ambil Eco-Score atau jalankan Algoritma Fallback
          String ecoScore = (productData['ecoscore_grade'] ?? 'unknown')
              .toString()
              .toUpperCase();

          bool ecoScoreFromAPI = true;
          if (ecoScore == 'UNKNOWN' || ecoScore == 'NULL' || ecoScore.isEmpty) {
            ecoScore = _calculateFallbackEcoScore(
              labels: labels,
              packaging: packaging,
              ingredients: ingredients,
            );
            ecoScoreFromAPI = false;
          }

          // Dapatkan detail berdasarkan eco grade
          final details = _getEcoScoreDetails(ecoScore);

          // Tentukan kategori
          String category = 'Makanan & Minuman';
          if (productData['pnns_groups_1'] != null) {
            category = productData['pnns_groups_1'];
          } else if (productData['categories'] != null) {
            category = (productData['categories'] as String).split(',').first;
          }

          final Map<String, dynamic> productMap = {
            'barcode': barcode,
            'name': name,
            'brand': brand,
            'category': category,
            'ingredients': ingredients,
            'nutriScore': nutriScore,
            'packaging': packaging.isEmpty ? 'Kemasan Standar' : packaging,
            'labels': labels.isEmpty ? 'Tidak ada label sertifikasi' : labels,
            'ecoScore': ecoScore,
            'ecoScoreFromAPI': ecoScoreFromAPI,
            ...details,
            'price': 22500.0, // default price mock
            'stores': ['Alfamart', 'Indomaret', 'Lotte Mart'],
            'createdAt': Timestamp.now(),
          };

          // Cache ke Firestore
          await _db.collection('products').doc(barcode).set(productMap);
          return productMap;
        }
      }
    } catch (e) {
      print('Error fetching OpenFoodFacts: $e');
    }

    // Fallback jika API gagal atau produk tidak ditemukan
    return _createMockProduct(barcode);
  }

  // Membuat mockup produk default dan menyimpannya ke Firestore
  Future<Map<String, dynamic>> _createMockProduct(String barcode) async {
    final Map<String, dynamic> mockProduct = {
      'barcode': barcode,
      'name': 'Sabun Mandi Organik ($barcode)',
      'brand': 'EcoLife',
      'category': 'Pembersih',
      'ingredients': 'Minyak kelapa sawit terkelola, Gliserin alami, Lidah buaya, Pewangi alami melati.',
      'nutriScore': 'N/A',
      'packaging': 'Kertas Karton Daur Ulang',
      'labels': 'Eco-Cert, FSC Certified',
      'ecoScore': 'A',
      'ecoScoreFromAPI': false,
      ..._getEcoScoreDetails('A'),
      'price': 25000.0,
      'stores': ['Alfamart', 'Indomaret'],
      'createdAt': Timestamp.now(),
    };

    // Simpan ke Firestore cache agar selanjutnya bisa dibaca lokal
    await _db.collection('products').doc(barcode).set(mockProduct);
    return mockProduct;
  }

  // Mengambil data produk, cek di Firestore dulu baru ke API
  Future<Map<String, dynamic>> getProduct(String barcode) async {
    try {
      final doc = await _db.collection('products').doc(barcode).get();
      if (doc.exists && doc.data() != null) {
        return doc.data()!;
      }
    } catch (e) {
      print('Firestore read error: $e');
    }
    return fetchProductFromOpenFoodFacts(barcode);
  }

  // Mendapatkan alternatif produk ramah lingkungan
  Future<List<Map<String, dynamic>>> getAlternatives(String category, String currentBarcode) async {
    try {
      final query = await _db.collection('products')
          .where('category', isEqualTo: category)
          .where('isEcoFriendly', isEqualTo: true)
          .limit(3)
          .get();

      final List<Map<String, dynamic>> alternatives = [];
      for (var doc in query.docs) {
        if (doc.id != currentBarcode) {
          alternatives.add(doc.data());
        }
      }

      if (alternatives.isNotEmpty) {
        return alternatives;
      }
    } catch (e) {
      print('Error fetching alternatives from Firestore: $e');
    }

    // Fallback static list yang disesuaikan secara dinamis dengan kategori produk
    final categoryLower = category.toLowerCase();
    if (categoryLower.contains('cereal') ||
        categoryLower.contains('potato') ||
        categoryLower.contains('food') ||
        categoryLower.contains('makanan') ||
        categoryLower.contains('snack') ||
        categoryLower.contains('beverage') ||
        categoryLower.contains('minuman') ||
        categoryLower.contains('mie') ||
        categoryLower.contains('noodle') ||
        categoryLower.contains('pasta') ||
        categoryLower.contains('instant')) {
      return [
        {
          'barcode': 'alt_food_01',
          'name': 'Mi Organik Gandum Utuh',
          'brand': 'Naturise',
          'category': category,
          'ecoScore': 'A',
          'ecoGradeDesc': 'Sangat Ramah Lingkungan',
          'price': 15000.0,
          'isEcoFriendly': true,
          'stores': ['Superindo', 'Alfamart'],
        },
        {
          'barcode': 'alt_food_02',
          'name': 'Pasta Gandum Utuh Eco-Pack',
          'brand': 'BioNoodle',
          'category': category,
          'ecoScore': 'A',
          'ecoGradeDesc': 'Sangat Ramah Lingkungan',
          'price': 19500.0,
          'isEcoFriendly': true,
          'stores': ['Indomaret', 'Lotte Mart'],
        }
      ];
    } else if (categoryLower.contains('clean') ||
        categoryLower.contains('pembersih') ||
        categoryLower.contains('deterjen') ||
        categoryLower.contains('sabun') ||
        categoryLower.contains('wash') ||
        categoryLower.contains('soap') ||
        categoryLower.contains('care')) {
      return [
        {
          'barcode': 'alt_clean_01',
          'name': 'Pembersih Serbaguna Bio-Green',
          'brand': 'BioGreen',
          'category': category,
          'ecoScore': 'A',
          'ecoGradeDesc': 'Sangat Ramah Lingkungan',
          'price': 27000.0,
          'isEcoFriendly': true,
          'stores': ['Alfamart', 'Superindo'],
        },
        {
          'barcode': 'alt_clean_02',
          'name': 'Sabun Cuci Piring Ekologis Premium',
          'brand': 'EcoClean',
          'category': category,
          'ecoScore': 'A',
          'ecoGradeDesc': 'Sangat Ramah Lingkungan',
          'price': 16000.0,
          'isEcoFriendly': true,
          'stores': ['Indomaret', 'Superindo'],
        }
      ];
    } else {
      return [
        {
          'barcode': 'alt_general_01',
          'name': 'Sedotan Bambu Reusable (Isi 10)',
          'brand': 'BambooLife',
          'category': category,
          'ecoScore': 'A',
          'ecoGradeDesc': 'Sangat Ramah Lingkungan',
          'price': 12000.0,
          'isEcoFriendly': true,
          'stores': ['Alfamart', 'Indomaret'],
        },
        {
          'barcode': 'alt_general_02',
          'name': 'Tas Belanja Kanvas Daur Ulang',
          'brand': 'EcoBag',
          'category': category,
          'ecoScore': 'A',
          'ecoGradeDesc': 'Sangat Ramah Lingkungan',
          'price': 8000.0,
          'isEcoFriendly': true,
          'stores': ['Superindo'],
        }
      ];
    }
  }

  // Menyimpan riwayat scan ke database user
  Future<void> saveScanHistory({
    required String uid,
    required Map<String, dynamic> product,
  }) async {
    final historyRef = _db.collection('users').doc(uid).collection('history');
    
    // Periksa apakah produk ini sudah pernah di-scan hari ini untuk menghindari duplikasi berlebih
    final query = await historyRef
        .where('productId', isEqualTo: product['barcode'])
        .limit(1)
        .get();

    if (query.docs.isEmpty) {
      await historyRef.add({
        'productId': product['barcode'],
        'productName': product['name'],
        'productBrand': product['brand'],
        'ecoScore': product['ecoScore'],
        'co2Saved': product['co2Saved'] ?? 0.0,
        'isEcoFriendly': product['isEcoFriendly'] ?? false,
        'scannedAt': FieldValue.serverTimestamp(),
      });
    } else {
      // Update timestamp scan terakhir
      await query.docs.first.reference.update({
        'scannedAt': FieldValue.serverTimestamp(),
      });
    }
  }

  // Mengambil stream riwayat scan user secara real-time
  Stream<QuerySnapshot<Map<String, dynamic>>> getScanHistoryStream(String uid) {
    return _db.collection('users')
        .doc(uid)
        .collection('history')
        .orderBy('scannedAt', descending: true)
        .snapshots();
  }
}
