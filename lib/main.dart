import 'package:ai_test/pages/settings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ai_test/screens/chatscreen.dart';
import 'package:ai_test/pages/about.dart';
import 'package:ai_test/pages/profile.dart';
import 'others/app_theme.dart';

void main() {
  runApp(
    // On enveloppe l'application avec le ChangeNotifierProvider
    // pour rendre le ThemeNotifier disponible à tous les widgets en dessous.
    ChangeNotifierProvider(
      create: (context) => ThemeNotifier(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Le Consumer écoute les changements dans ThemeNotifier
    // et reconstruit l'application si le thème change.
    return Consumer<ThemeNotifier>(
      builder: (context, themeNotifier, child) {
        return MaterialApp(
          title: 'MyAI Assistant',
          debugShowCheckedModeBanner: false,
          // Utilisation des thèmes définis dans la classe AppThemes
          theme: AppThemes.lightTheme(themeNotifier.primarySwatch),
          darkTheme: AppThemes.darkTheme(themeNotifier.primarySwatch),
          // Le mode de thème est contrôlé par le ThemeNotifier
          themeMode: themeNotifier.themeMode,
          routes: {
            '/': (context) => const ChatScreen(),
            '/settings': (context) => const Settings(),
            '/about': (context) => const About(),
            '/profile': (context) => const Profile(),
          },
          initialRoute: '/',
        );
      },
    );
  }
}