import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'pages/landing_page.dart';

void main() {
  runApp(const AutifyWebApp());
}

/// Root application widget.
class AutifyWebApp extends StatelessWidget {
  const AutifyWebApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Autify — Analisi Dati per Autismo',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const LandingPage(),
    );
  }
}
