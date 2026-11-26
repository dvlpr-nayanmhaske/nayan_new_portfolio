import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Primary Backgrounds
  static const Color primaryBackground = Color(0xFF0B0F19);
  static const Color secondaryBackground = Color(0xFF111827);
  static const Color cardBackground = Color(0xFF161F30);
  static const Color cardBackgroundHover = Color(0xFF1A2540);

  // Accent Colors
  static const Color primaryAccent = Color(0xFF8B5CF6);
  static const Color secondaryAccent = Color(0xFF38BDF8);
  static const Color accentGreen = Color(0xFF34D399);
  static const Color accentPink = Color(0xFFEC4899);

  // Text Colors
  static const Color primaryText = Color(0xFFF8FAFC);
  static const Color secondaryText = Color(0xFF94A3B8);
  static const Color tertiaryText = Color(0xFF64748B);
  static const Color hintText = Color(0xFF475569);

  // Border & Divider
  static const Color borderColor = Color(0xFF263247);
  static const Color borderColorLight = Color(0xFF1E3A5F);

  // Gradient Colors
  static const Color gradientStart = Color(0xFF8B5CF6);
  static const Color gradientEnd = Color(0xFF38BDF8);

  // Status Colors
  static const Color success = Color(0xFF34D399);
  static const Color error = Color(0xFFEF4444);
  static const Color warning = Color(0xFFF59E0B);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryAccent, secondaryAccent],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient heroGradient = LinearGradient(
    colors: [Color(0xFF8B5CF6), Color(0xFF38BDF8)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cardGradient = LinearGradient(
    colors: [Color(0xFF1A2540), Color(0xFF161F30)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static LinearGradient glowGradient(Color color) => LinearGradient(
        colors: [color.withValues(alpha: 0.2), color.withValues(alpha: 0.0)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      );
}
