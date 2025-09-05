import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

/// Gère l'état du thème de l'application (mode et couleur).
/// Il étend ChangeNotifier pour notifier ses auditeurs des changements.
class ThemeNotifier with ChangeNotifier {
  static const String _themeModeKey = 'themeMode';
  static const String _primaryColorValueKey = 'primaryColorValue';

  ThemeMode _currentThemeMode = ThemeMode.dark;
  MaterialColor _primarySwatch = Colors.blue;

  ThemeMode get themeMode => _currentThemeMode;
  MaterialColor get primarySwatch => _primarySwatch;

  ThemeNotifier() {
    _loadThemeSettings();
  }

  Future<void> _loadThemeSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final colorValue = prefs.getInt(_primaryColorValueKey);
    if (colorValue != null) {
      _primarySwatch = AppThemes.createMaterialColor(Color(colorValue));
    }
    final themeModeIndex = prefs.getInt(_themeModeKey);
    if (themeModeIndex != null) {
      _currentThemeMode = ThemeMode.values[themeModeIndex];
    }
    notifyListeners();
  }

  void toggleThemeMode() async {
    _currentThemeMode = _currentThemeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_themeModeKey, _currentThemeMode.index);
    notifyListeners();
  }

  void changeThemeColor(Color newColor) async {
    _primarySwatch = AppThemes.createMaterialColor(newColor);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_primaryColorValueKey, newColor.value);
    notifyListeners();
  }
}

/// Contient les définitions complètes des thèmes (clair et sombre).
class AppThemes {
  static MaterialColor createMaterialColor(Color color) {
    List strengths = <double>[.05, .1, .2, .3, .4, .5, .6, .7, .8, .9];
    Map<int, Color> swatch = {};
    final int r = color.red, g = color.green, b = color.blue;
    for (int i = 0; i < 10; i++) {
      swatch[(strengths[i] * 1000).round()] = Color.fromRGBO(r, g, b, strengths[i]);
    }
    return MaterialColor(color.value, swatch);
  }

  static ThemeData lightTheme(MaterialColor primarySwatch) {
    return ThemeData(
      brightness: Brightness.light,
      primarySwatch: primarySwatch,
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: primarySwatch,
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: AppBarTheme(
        backgroundColor: primarySwatch,
        foregroundColor: Colors.white,
        elevation: 4.0,
        titleTextStyle: GoogleFonts.poppins(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      textTheme: GoogleFonts.poppinsTextTheme(
        ThemeData.light().textTheme.apply(
          bodyColor: Colors.black87,
          displayColor: Colors.black,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primarySwatch,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          textStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: primarySwatch[200]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: primarySwatch, width: 2.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: primarySwatch[300]!),
        ),
        hintStyle: GoogleFonts.poppins(color: Colors.grey[500]),
        labelStyle: GoogleFonts.poppins(color: Colors.black87),
      ),
    );
  }

  static ThemeData darkTheme(MaterialColor primarySwatch) {
    return ThemeData(
      brightness: Brightness.dark,
      primarySwatch: primarySwatch,
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: primarySwatch,
        brightness: Brightness.dark,
      ),
      scaffoldBackgroundColor: Colors.grey[900],
      appBarTheme: AppBarTheme(
        backgroundColor: primarySwatch[700],
        foregroundColor: Colors.white,
        elevation: 4.0,
        titleTextStyle: GoogleFonts.poppins(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      textTheme: GoogleFonts.poppinsTextTheme(
        ThemeData.dark().textTheme.apply(
          bodyColor: Colors.white70,
          displayColor: Colors.white,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primarySwatch,
          foregroundColor: Colors.white,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: primarySwatch[700]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: primarySwatch[300]!, width: 2.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: primarySwatch[600]!),
        ),
        hintStyle: GoogleFonts.poppins(color: Colors.grey[500]),
        labelStyle: GoogleFonts.poppins(color: Colors.white70),
      ),
    );
  }
}