import 'package:flutter/material.dart';

/// Autify brand colors extracted from logo.
/// Premium Light palette: navy, blue, teal, green, orange on white.
class AppColors {
  AppColors._();

  // ─── Primary ───────────────────────────────────
  static const Color primaryNavy = Color(0xFF1A2B50);
  static const Color primaryBlue = Color(0xFF2B6CB0);
  static const Color primaryLight = Color(0xFF4A90D9);

  // ─── Accents ───────────────────────────────────
  static const Color accentTeal = Color(0xFF38A89D);
  static const Color accentGreen = Color(0xFF48BB78);
  static const Color accentOrange = Color(0xFFED8936);
  static const Color accentCoral = Color(0xFFE8705A);

  // ─── Neutrals ──────────────────────────────────
  static const Color background = Color(0xFFF7FAFC);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceAlt = Color(0xFFF0F4F8);
  static const Color border = Color(0xFFE2E8F0);
  static const Color subtleGray = Color(0xFFEDF2F7);

  // ─── Text ──────────────────────────────────────
  static const Color textPrimary = Color(0xFF1A2B50);
  static const Color textSecondary = Color(0xFF4A5568);
  static const Color textMuted = Color(0xFF718096);
  static const Color textOnDark = Color(0xFFFFFFFF);
  static const Color textOnDarkMuted = Color(0xFFCBD5E0);

  // ─── Gradients ─────────────────────────────────
  static const LinearGradient heroGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFFFFFFFF), Color(0xFFEBF4FF), Color(0xFFF7FAFC)],
  );

  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryBlue, accentTeal],
  );

  static const LinearGradient ctaGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF2B6CB0), Color(0xFF38A89D)],
  );

  static const LinearGradient darkGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF1A2B50), Color(0xFF2D3748)],
  );

  // ─── Shadows ───────────────────────────────────
  static List<BoxShadow> get softShadow => [
    BoxShadow(
      color: primaryNavy.withValues(alpha: 0.06),
      blurRadius: 24,
      offset: const Offset(0, 8),
      spreadRadius: 0,
    ),
  ];

  static List<BoxShadow> get mediumShadow => [
    BoxShadow(
      color: primaryNavy.withValues(alpha: 0.08),
      blurRadius: 32,
      offset: const Offset(0, 12),
      spreadRadius: -4,
    ),
  ];

  static List<BoxShadow> get hoverShadow => [
    BoxShadow(
      color: primaryBlue.withValues(alpha: 0.15),
      blurRadius: 40,
      offset: const Offset(0, 16),
      spreadRadius: -4,
    ),
  ];
}
