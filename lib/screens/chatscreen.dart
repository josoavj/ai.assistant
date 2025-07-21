// Chat Screen
import 'package:ai_test/api/api_call.dart';
import 'package:ai_test/pages/about.dart';
import 'package:ai_test/pages/profile.dart';
import 'package:ai_test/pages/settings.dart';
import 'package:ai_test/screens/chatwidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; 
import 'package:google_fonts/google_fonts.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.title});

  final String title;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String? apiKey;

  // Fonction pour afficher la boîte de dialogue de confirmation de sortie
  void _showExitConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Quitter l'application",
            style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          content: Text(
            "Vous êtes sur le point de quitter l'application. Voulez-vous continuer ?",
            style: GoogleFonts.poppins(fontSize: 14),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Ferme la boîte de dialogue
              },
              child: Text(
                "Annuler",
                style: GoogleFonts.poppins(color: Theme.of(context).primaryColor),
              ),
            ),
            TextButton(
              onPressed: () {
                SystemNavigator.pop(); // Quitte l'application
              },
              child: Text(
                "Quitter",
                style: GoogleFonts.poppins(color: Colors.red), // Couleur pour l'action de sortie
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Accès au thème de l'application
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 20, // Taille ajustée pour cohérence
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          Tooltip( // Ajout d'un Tooltip pour l'icône de profil
            message: "Mon Profil",
            child: IconButton(
              iconSize: 24, // Taille d'icône légèrement plus grande
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const Profile()));
              },
              icon: const Icon(CupertinoIcons.profile_circled),
            ),
          ),
          const SizedBox(width: 8), // Espacement après l'icône
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero, // Important pour supprimer le padding par défaut
          children: [
            // DrawerHeader amélioré
            DrawerHeader(
              decoration: BoxDecoration(
                color: theme.primaryColor,
                // image: DecorationImage(
                //   image: AssetImage("assets/images/drawer_background.png"),
                //   fit: BoxFit.cover,
                // ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end, // Alignez le contenu en bas
                children: [
                  // Logo ou avatar de l'application
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white.withOpacity(0.2), // Effet de transparence
                    child: Icon(
                      Icons.bubble_chart, 
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'MyAI ChatBot', // Titre plus descriptif
                    style: GoogleFonts.poppins(
                      fontSize: 22, // Taille ajustée
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    'Votre assistant intelligent', // Sous-titre
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
            ),
            // Éléments du Drawer
            ListTile(
              leading: Icon(CupertinoIcons.info, color: theme.primaryColor), // Couleur de l'icône
              title: Text(
                'À propos',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.blueGrey[800], // Couleur du texte
                  fontWeight: FontWeight.w500,
                ),
              ),
              onTap: () {
                Navigator.pop(context); // Ferme le drawer avant la navigation
                Navigator.push(context, MaterialPageRoute(builder: (context) => const About()));
              },
              selectedTileColor: theme.primaryColor.withOpacity(0.1), // Couleur au survol/sélection
              hoverColor: theme.primaryColor.withOpacity(0.05),
            ),
            ListTile(
              leading: Icon(CupertinoIcons.settings_solid, color: theme.primaryColor),
              title: Text(
                'Paramètres',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.blueGrey[800],
                  fontWeight: FontWeight.w500,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => const Settings()));
              },
              selectedTileColor: theme.primaryColor.withAlpha((255 * 0.1).round()),
              hoverColor: theme.primaryColor.withAlpha((255 * 0.05).round()),
            ),
            const Divider(indent: 15, endIndent: 15), // Séparateur visuel
            ListTile(
              leading: Icon(Icons.exit_to_app, color: Colors.redAccent), // Une couleur distinctive pour quitter
              title: Text(
                'Quitter',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.redAccent,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onTap: () {
                Navigator.pop(context); // Ferme le drawer
                _showExitConfirmationDialog(); // Affiche la boîte de dialogue
              },
              selectedTileColor: Colors.redAccent.withOpacity(0.1),
              hoverColor: Colors.redAccent.withOpacity(0.05),
            ),
          ],
        ),
      ),
      body: switch (apiKey) {
        final providedKey? => ChatWidget(apiKey: providedKey),
      // Make sure ApiKeyWidget is available, e.g., defined in screenswidget.dart
        _ => ApiKeyWidget(onSubmitted: (key) {
          setState(() => apiKey = key);
        }),
      },
    );
  }
}