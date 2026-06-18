import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({super.key});

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  final MobileScannerController controller = MobileScannerController();

  bool scanned = false;
  bool torchEnabled = false;

  String barcodeValue = '';

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _showBarcodeResult(String barcode) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Barcode Terdeteksi"),
        content: Text(barcode),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);

              setState(() {
                scanned = false;
              });
            },
            child: const Text("Scan Lagi"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAF1E3),

      appBar: AppBar(
        title: const Text("Scan"),
        centerTitle: true,
        backgroundColor: const Color(0xFFEAF1E3),
        elevation: 0,
      ),

      body: Stack(
        children: [
          /// Kamera
          MobileScanner(
            controller: controller,
            onDetect: (capture) {
              if (scanned) return;

              final barcode = capture.barcodes.first;

              setState(() {
                scanned = true;
                barcodeValue = barcode.rawValue ?? '';
              });

              _showBarcodeResult(barcodeValue);
            },
          ),

          /// Tombol Flash
          Positioned(
            top: 20,
            left: 20,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black45,
                borderRadius: BorderRadius.circular(30),
              ),
              child: IconButton(
                onPressed: () async {
                  await controller.toggleTorch();

                  setState(() {
                    torchEnabled = !torchEnabled;
                  });
                },
                icon: Icon(
                  torchEnabled
                      ? Icons.flash_on
                      : Icons.flash_off,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          /// Tombol Ganti Kamera
          Positioned(
            top: 20,
            right: 20,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black45,
                borderRadius: BorderRadius.circular(30),
              ),
              child: IconButton(
                onPressed: () {
                  controller.switchCamera();
                },
                icon: const Icon(
                  Icons.cameraswitch,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          /// Area Scan
          Center(
            child: Container(
              width: 260,
              height: 260,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.blue,
                  width: 3,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),

          /// Petunjuk
          Positioned(
            bottom: 100,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: const Text(
                  "Arahkan kamera ke barcode produk",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}