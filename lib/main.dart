import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ai_test/screens/chatscreen.dart';

// Class to manage and notify about theme changes
class ThemeProvider with ChangeNotifier {
  static const String _themeModeKey = 'themeMode';

  ThemeMode _themeMode = ThemeMode.dark; // Default to dark theme

  ThemeMode get themeMode => _themeMode;

  ThemeProvider() {
    _loadThemeMode();
  }

  Future<void> _loadThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final isDarkMode = prefs.getBool(_themeModeKey) ?? true;
    _themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  void toggleThemeMode() async {
    _themeMode = _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_themeModeKey, _themeMode == ThemeMode.dark);
    notifyListeners();
  }
}

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyAI(),
    ),
  );
}

class MyAI extends StatelessWidget {
  const MyAI({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'CHAT-AI',
          theme: ThemeHelper.lightTheme(),
          darkTheme: ThemeHelper.darkTheme(),
          themeMode: themeProvider.themeMode,
          home: const ChatScreen(title: 'My Chat-AI'),
        );
      },
    );
  }
}

// Helper class to define your themes
class ThemeHelper {
  static ThemeData lightTheme() {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.light,
        seedColor: const Color.fromARGB(255, 171, 222, 244),
      ),
      useMaterial3: true,
      // You can add other light theme properties here
    );
  }

  static ThemeData darkTheme() {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.dark,
        seedColor: const Color.fromARGB(255, 171, 222, 244),
      ),
      useMaterial3: true,
      // You can add other dark theme properties here
    );
  }
}