import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ryde_app/src/core/theme/customs/app_text_theme.dart';
import 'package:ryde_app/src/core/theme/customs/app_textfield.dart';
import 'package:ryde_app/src/core/theme/customs/elevated_button_theme.dart';
import 'package:ryde_app/src/core/theme/customs/outlined_button_theme.dart';

class AppTheme {
  static final light = ThemeData(
    brightness: Brightness.light,
    textTheme: AppTextTheme.light,
    fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
    elevatedButtonTheme: AppElevatedButtonTheme.light,
    outlinedButtonTheme: AppOutlinedButtonTheme.light,
    useMaterial3: true,
    colorScheme: const ColorScheme.light(
      primary: Color(0xFF1E88E5),
      onPrimary: Colors.white,
      secondary: Color(0xFF42A5F5),
      onSecondary: Colors.white,
      surface: Colors.white,
      onSurface: Colors.black87,
    ),
    scaffoldBackgroundColor: Colors.white,
    inputDecorationTheme: AppTextFieldTheme.light,
  );
}
