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
  // Couleur principale par défaut
  MaterialColor _primarySwatch = Colors.blue; // Utilisation d'un MaterialColor par défaut
  int _primaryColorValue = Colors.blue.value; // Valeur entière de la couleur par défaut

  @override
  void initState() {
    super.initState();
    _loadThemeColor(); // Charger la couleur du thème sauvegardée
  }

  // Charge la couleur du thème depuis SharedPreferences
  void _loadThemeColor() async {
    final prefs = await SharedPreferences.getInstance();
    final colorValue = prefs.getInt('primaryColorValue');
    if (colorValue != null) {
      setState(() {
        _primaryColorValue = colorValue;
        _primarySwatch = MaterialColor(
          _primaryColorValue,
          <int, Color>{
            50: Color(_primaryColorValue).withAlpha((255 * 0.1).round()),
            100: Color(_primaryColorValue).withAlpha((255 * 0.2).round()),
            200: Color(_primaryColorValue).withAlpha((255 * 0.3).round()),
            300: Color(_primaryColorValue).withAlpha((255 * 0.4).round()),
            400: Color(_primaryColorValue).withAlpha((255 * 0.5).round()),
            500: Color(_primaryColorValue).withAlpha((255 * 0.6).round()),
            600: Color(_primaryColorValue).withAlpha((255 * 0.7).round()),
            700: Color(_primaryColorValue).withAlpha((255 * 0.8).round()),
            800: Color(_primaryColorValue).withAlpha((255 * 0.9).round()),
            900: Color(_primaryColorValue).withAlpha((255 * 1.0).round()),
          },
        );
      });
    }
  }

  void _changeThemeColor(Color newColor) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('primaryColorValue', newColor.value);
    setState(() {
      _primaryColorValue = newColor.value;
      _primarySwatch = MaterialColor(
        newColor.value,
        <int, Color>{
          50: newColor.withAlpha((255 * 0.1).round()), // Corrigé avec withAlpha
          100: newColor.withAlpha((255 * 0.2).round()),
          200: newColor.withAlpha((255 * 0.3).round()),
          300: newColor.withAlpha((255 * 0.4).round()),
          400: newColor.withAlpha((255 * 0.5).round()),
          500: newColor.withAlpha((255 * 0.6).round()),
          600: newColor.withAlpha((255 * 0.7).round()),
          700: newColor.withAlpha((255 * 0.8).round()),
          800: newColor.withAlpha((255 * 0.9).round()),
          900: newColor.withAlpha((255 * 1.0).round()),
        },
      );
    });
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyAI Assistant',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: _primarySwatch,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: _primarySwatch,
          // secondary: Colors.amber,
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
          // Correction pour withOpacity
          selectedTileColor: _primarySwatch.withAlpha((255 * 0.1).round()),
          // hoverColor: _primarySwatch.withAlpha((255 * 0.05).round()), // hoverColor n'existe pas dans ListTileThemeData
        ),
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme.apply(
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
      ),
      home: const Intro(),
      builder: (context, child) {
        return ThemeProvider(
          changeTheme: _changeThemeColor,
          currentPrimaryColor: Color(_primaryColorValue),
          child: child!,
        );
      },
    );
  }
}

class ThemeProvider extends InheritedWidget {
  final ValueChanged<Color> changeTheme;
  final Color currentPrimaryColor;

  const ThemeProvider({
    Key? key,
    required this.changeTheme,
    required this.currentPrimaryColor,
    required Widget child,
  }) : super(key: key, child: child);

  static ThemeProvider of(BuildContext context) {
    final ThemeProvider? result = context.dependOnInheritedWidgetOfExactType<ThemeProvider>();
    assert(result != null, 'No ThemeProvider found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(covariant ThemeProvider oldWidget) {
    return oldWidget.currentPrimaryColor != currentPrimaryColor;
  }
}