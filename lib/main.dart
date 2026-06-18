import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'eco_scan.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => const EcoScanApp(),
    ),
  );
}

class EcoScanApp extends StatelessWidget {
  const EcoScanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      home: const EcoScanLandingPage(),
    );
  }
}