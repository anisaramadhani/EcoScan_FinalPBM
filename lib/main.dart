import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:provider/provider.dart';

import 'eco_scan.dart';
import 'theme_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: DevicePreview(
        enabled: true,
        builder: (context) => const EcoScanApp(),
      ),
    ),
  );
}

class EcoScanApp extends StatelessWidget {
  const EcoScanApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,

      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,

      title: 'EcoScan',

      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.green,
      ),

      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.green,
      ),

      themeMode: themeProvider.themeMode,

      home: const EcoScanLandingPage(),
    );
  }
}