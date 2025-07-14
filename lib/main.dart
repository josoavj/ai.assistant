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
    // Ensure SharedPreferences is imported and available
    final prefs = await SharedPreferences.getInstance();
    final colorValue = prefs.getInt('primaryColorValue');
    if (colorValue != null) {
      setState(() {
        _primaryColorValue = colorValue;
        _primarySwatch = MaterialColor(
          _primaryColorValue,
          <int, Color>{
            50: Color(_primaryColorValue).withOpacity(0.1),
            100: Color(_primaryColorValue).withOpacity(0.2),
            200: Color(_primaryColorValue).withOpacity(0.3),
            300: Color(_primaryColorValue).withOpacity(0.4),
            400: Color(_primaryColorValue).withOpacity(0.5),
            500: Color(_primaryColorValue).withOpacity(0.6),
            600: Color(_primaryColorValue).withOpacity(0.7),
            700: Color(_primaryColorValue).withOpacity(0.8),
            800: Color(_primaryColorValue).withOpacity(0.9),
            900: Color(_primaryColorValue).withOpacity(1.0),
          },
        );
      });
    }
  }

  // Change la couleur du thème et la sauvegarde
  void _changeThemeColor(Color newColor) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('primaryColorValue', newColor.value);
    setState(() {
      _primaryColorValue = newColor.value;
      _primarySwatch = MaterialColor(
        newColor.value,
        <int, Color>{
          50: newColor.withOpacity(0.1),
          100: newColor.withOpacity(0.2),
          200: newColor.withOpacity(0.3),
          300: newColor.withOpacity(0.4),
          400: newColor.withOpacity(0.5),
          500: newColor.withOpacity(0.6),
          600: newColor.withOpacity(0.7),
          700: newColor.withOpacity(0.8),
          800: newColor.withOpacity(0.9),
          900: newColor.withOpacity(1.0),
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
          // secondary: Colors.amber, // You can define a secondary color if needed
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
          selectedTileColor: _primarySwatch.withOpacity(0.1),
          // hoverColor: _primarySwatch.withOpacity(0.05), // REMOVED: This parameter does not exist in ListTileThemeData
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
        // --- FIX: Use DialogThemeData instead of DialogTheme ---
        dialogTheme: DialogThemeData(
          titleTextStyle: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
          contentTextStyle: GoogleFonts.poppins(fontSize: 14, color: Colors.black54),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
      home: ChatScreen(title: 'MyAI Assistant'),
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
  bool updateShouldNotify(covariant ThemeProvider oldWidget) { // Added covariant keyword
    return oldWidget.currentPrimaryColor != currentPrimaryColor;
  }
}