import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';

import 'eco_scan.dart';
import 'login_page.dart';


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


      // Device Preview
      useInheritedMediaQuery: true,

      locale: DevicePreview.locale(context),

      builder: DevicePreview.appBuilder,


      title: 'EcoScan',


      // Halaman pertama tetap Landing Page
      home: const EcoScanLandingPage(),

    );

  }
}