import 'package:ai_test/screens/intro.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AI ChatBot',
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 7, 116, 206),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 7, 116, 206),
          foregroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
        ),
        scaffoldBackgroundColor: Colors.blueGrey[50],
        cardTheme: CardThemeData( // Changed from CardTheme to CardThemeData
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 10,
        ),
      ),
      home: const Intro(),
    );
  }
}