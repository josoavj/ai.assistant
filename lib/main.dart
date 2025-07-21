import 'package:ai_test/screens/intro.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ai_test/screens/chatscreen.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  MaterialColor _primarySwatch = Colors.blue;
  int _primaryColorValue = Colors.blue.value;
  ThemeMode _currentThemeMode = ThemeMode.light; // État pour le mode de thème

  // Clé pour SharedPreferences
  static const String _themeModeKey = 'themeMode';
  static const String _primaryColorValueKey = 'primaryColorValue';


  @override
  void initState() {
    super.initState();
    _loadThemeSettings(); // Charger la couleur ET le mode de thème
  }

  // Charger la couleur du thème ET le mode depuis SharedPreferences
  void _loadThemeSettings() async {
    final prefs = await SharedPreferences.getInstance();

    // Charger la couleur principale
    final colorValue = prefs.getInt(_primaryColorValueKey);
    if (colorValue != null) {
      _primaryColorValue = colorValue;
      _primarySwatch = _createMaterialColor(Color(colorValue));
    }

    // Charger le mode de thème
    final themeModeIndex = prefs.getInt(_themeModeKey);
    if (themeModeIndex != null) {
      _currentThemeMode = ThemeMode.values[themeModeIndex];
    }

    setState(() {}); // Mettre à jour l'interface utilisateur
  }

  // Helper pour créer MaterialColor (pour éviter la duplication)
  MaterialColor _createMaterialColor(Color color) {
    return MaterialColor(
      color.value,
      <int, Color>{
        50: color.withAlpha((255 * 0.1).round()),
        100: color.withAlpha((255 * 0.2).round()),
        200: color.withAlpha((255 * 0.3).round()),
        300: color.withAlpha((255 * 0.4).round()),
        400: color.withAlpha((255 * 0.5).round()),
        500: color.withAlpha((255 * 0.6).round()),
        600: color.withAlpha((255 * 0.7).round()),
        700: color.withAlpha((255 * 0.8).round()),
        800: color.withAlpha((255 * 0.9).round()),
        900: color.withAlpha((255 * 1.0).round()),
      },
    );
  }


  void _changeThemeColor(Color newColor) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_primaryColorValueKey, newColor.value);
    setState(() {
      _primaryColorValue = newColor.value;
      _primarySwatch = _createMaterialColor(newColor);
    });
  }

  void _toggleThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _currentThemeMode = _currentThemeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
    await prefs.setInt(_themeModeKey, _currentThemeMode.index);
  }
// Dans la méthode build de _MyAppState

  @override
  Widget build(BuildContext context) {
    // Définition du thème clair (Light)
    final lightTheme = ThemeData(
      brightness: Brightness.light, // Important pour le thème clair
      primarySwatch: _primarySwatch,
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: _primarySwatch,
        brightness: Brightness.light, // Assurez-vous que cela correspond
        // secondary: Colors.amber, // Définissez si nécessaire
      ),
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: AppBarTheme(
        backgroundColor: _primarySwatch,
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
      drawerTheme: const DrawerThemeData(
        backgroundColor: Colors.white,
      ),
      listTileTheme: ListTileThemeData(
        iconColor: _primarySwatch[700],
        textColor: Colors.blueGrey[800],
        selectedTileColor: _primarySwatch.withAlpha((255 * 0.1).round()),
      ),
      textTheme: GoogleFonts.poppinsTextTheme(
        ThemeData.light().textTheme.apply( // Utiliser ThemeData.light() comme base
          bodyColor: Colors.black87,
          displayColor: Colors.black,
        ),
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: _primarySwatch,
        textTheme: ButtonTextTheme.primary,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: _primarySwatch,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          textStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: _primarySwatch,
          textStyle: GoogleFonts.poppins(fontWeight: FontWeight.w500),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: _primarySwatch[200]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: _primarySwatch, width: 2.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: _primarySwatch[300]!),
        ),
        hintStyle: GoogleFonts.poppins(color: Colors.grey[500]),
        labelStyle: GoogleFonts.poppins(color: Colors.black87),
      ),
      dialogTheme: DialogThemeData(
        titleTextStyle: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
        contentTextStyle: GoogleFonts.poppins(fontSize: 14, color: Colors.black54),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );

    // Définition du thème sombre (Dark)
    final darkTheme = ThemeData(
      brightness: Brightness.dark, // Important pour le thème sombre
      primarySwatch: _primarySwatch, // Vous pouvez garder la même couleur primaire ou la changer
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: _primarySwatch,
        brightness: Brightness.dark, // Assurez-vous que cela correspond
        // secondary: Colors.tealAccent, // Exemple de couleur secondaire pour le thème sombre
      ),
      scaffoldBackgroundColor: Colors.grey[900], // Couleur de fond sombre typique
      appBarTheme: AppBarTheme(
        backgroundColor: _primarySwatch[700], // Un peu plus sombre ou différent pour le thème sombre
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
      drawerTheme: DrawerThemeData(
        backgroundColor: Colors.grey[850],
      ),
      listTileTheme: ListTileThemeData(
        iconColor: _primarySwatch[300], // Couleurs plus claires sur fond sombre
        textColor: Colors.white70,
        selectedTileColor: _primarySwatch.withAlpha((255 * 0.2).round()), // Opacité ajustée pour le sombre
      ),
      textTheme: GoogleFonts.poppinsTextTheme(
        ThemeData.dark().textTheme.apply( // Utiliser ThemeData.dark() comme base
          bodyColor: Colors.white70,
          displayColor: Colors.white,
        ),
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: _primarySwatch,
        textTheme: ButtonTextTheme.primary,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: _primarySwatch,
          foregroundColor: Colors.white,
          // ... autres styles
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: _primarySwatch[300], // Plus clair
          // ... autres styles
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: _primarySwatch[700]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: _primarySwatch[300]!, width: 2.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: _primarySwatch[600]!),
        ),
        hintStyle: GoogleFonts.poppins(color: Colors.grey[500]),
        labelStyle: GoogleFonts.poppins(color: Colors.white70),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: Colors.grey[800],
        titleTextStyle: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        contentTextStyle: GoogleFonts.poppins(fontSize: 14, color: Colors.white70),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );

    return MaterialApp(
      title: 'MyAI Assistant',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,        // Thème clair
      darkTheme: darkTheme,     // Thème sombre
      themeMode: _currentThemeMode, // Mode de thème actuel (contrôlé par l'état)
      home: const Intro(),
      builder: (context, child) {
        // Modifiez ThemeProvider pour inclure la fonction de basculement du thème
        return ThemeProvider(
          changeThemeColor: _changeThemeColor,
          currentPrimaryColor: Color(_primaryColorValue),
          currentThemeMode: _currentThemeMode, // Passez le mode actuel
          toggleThemeMode: _toggleThemeMode, // Passez la fonction de basculement
          child: child!,
        );
      },
    );
  }
}
class ThemeProvider extends InheritedWidget {
  final ValueChanged<Color> changeThemeColor;
  final Color currentPrimaryColor;
  final ThemeMode currentThemeMode;
  final VoidCallback toggleThemeMode;

  const ThemeProvider({
    Key? key,
    required this.changeThemeColor,
    required this.currentPrimaryColor,
    required this.currentThemeMode,
    required this.toggleThemeMode,
    required Widget child,
  }) : super(key: key, child: child);

  static ThemeProvider of(BuildContext context) {
    final ThemeProvider? result = context.dependOnInheritedWidgetOfExactType<ThemeProvider>();
    assert(result != null, 'No ThemeProvider found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(covariant ThemeProvider oldWidget) {
    return oldWidget.currentPrimaryColor != currentPrimaryColor ||
        oldWidget.currentThemeMode != currentThemeMode; // Vérifier aussi le changement de mode
  }
}
