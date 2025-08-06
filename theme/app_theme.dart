import 'package:flutter/material.dart';

class AppTheme {
  // Colors
  static const Color primaryColor = Color(0xFF16590E);
  static const Color primaryLightColor = Color(0xFF4AF823);
  static const Color accentColor = Color(0xFFC0FFB1);
  static const Color backgroundColor = Colors.white;
  static const Color textColor = Color(0xFF000000);
  static const Color textLightColor = Color(0xFF999999);
  static const Color textDarkColor = Color(0xFF444444);
  static const Color progressColor = Color(0xFF61EF41);
  static const Color completedColor = Color(0xFF16590E);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryLightColor, primaryColor],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  // Text Styles
  static const TextStyle headingStyle = TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w600,
    fontSize: 24,
    color: textColor,
  );

  static const TextStyle titleStyle = TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w600,
    fontSize: 30,
    color: textColor,
  );

  static const TextStyle subtitleStyle = TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w500,
    fontSize: 18,
    color: textLightColor,
  );

  static const TextStyle buttonTextStyle = TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w500,
    fontSize: 14,
    color: Colors.white,
  );

  static const TextStyle inputLabelStyle = TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w500,
    fontSize: 13,
    color: textDarkColor,
  );

  // Theme Data
  static final ThemeData lightTheme = ThemeData(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: backgroundColor,
    fontFamily: 'Poppins',
    textTheme: const TextTheme(
      displayLarge: headingStyle,
      displayMedium: titleStyle,
      bodyLarge: subtitleStyle,
      bodyMedium: inputLabelStyle,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: accentColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
    ),
  );
}
