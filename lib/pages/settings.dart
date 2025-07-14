import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';


class Settings extends StatefulWidget { // Changé en StatefulWidget pour les Switches
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool _darkModeEnabled = false; // État pour le mode sombre
  bool _notificationsEnabled = true; // État pour les notifications

  @override
  Widget build(BuildContext context) {
    // Obtenez le thème courant pour adapter le style
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Paramètres",
          style: GoogleFonts.poppins(
            fontSize: 20, // Taille ajustée pour cohérence
            fontWeight: FontWeight.bold, // Plus audacieux
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        actions: [
          Tooltip( // Ajout d'un Tooltip pour l'icône de sortie
            message: "Quitter l'application",
            child: IconButton(
              onPressed: () => SystemNavigator.pop(),
              icon: const Icon(Icons.exit_to_app_rounded),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView( // Permet de faire défiler si le contenu est long
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Alignement à gauche pour les titres de section
          children: [
            // --- Section Général ---
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                "Général",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: theme.primaryColor, // Couleur du thème principal
                ),
              ),
            ),
            Card(
              margin: const EdgeInsets.only(bottom: 20.0),
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.dark_mode_outlined),
                    title: Text(
                      "Mode Sombre",
                      style: GoogleFonts.poppins(fontSize: 16),
                    ),
                    trailing: CupertinoSwitch( // Un joli switch Cupertino
                      value: _darkModeEnabled,
                      onChanged: (bool value) {
                        setState(() {
                          _darkModeEnabled = value;
                          // Ici, vous implémenteriez la logique pour changer le thème de l'app
                          // ex: Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
                        });
                      },
                      activeColor: theme.primaryColor,
                    ),
                  ),
                  const Divider(height: 1, indent: 15, endIndent: 15), // Séparateur
                  ListTile(
                    leading: const Icon(Icons.language_outlined),
                    title: Text(
                      "Langue",
                      style: GoogleFonts.poppins(fontSize: 16),
                    ),
                    subtitle: Text( // Afficher la langue actuelle
                      "Français (par défaut)",
                      style: GoogleFonts.poppins(fontSize: 14),
                    ),
                    trailing: const Icon(CupertinoIcons.right_chevron),
                    onTap: () {
                      // Logique pour changer la langue
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Changer la langue (non implémenté)")),
                      );
                    },
                  ),
                ],
              ),
            ),

            // --- Section Notifications ---
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                "Notifications",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: theme.primaryColor,
                ),
              ),
            ),
            Card(
              margin: const EdgeInsets.only(bottom: 20.0),
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.notifications_active_outlined),
                    title: Text(
                      "Activer les notifications",
                      style: GoogleFonts.poppins(fontSize: 16),
                    ),
                    trailing: CupertinoSwitch(
                      value: _notificationsEnabled,
                      onChanged: (bool value) {
                        setState(() {
                          _notificationsEnabled = value;
                          // Logique pour activer/désactiver les notifications
                        });
                      },
                      activeColor: theme.primaryColor,
                    ),
                  ),
                ],
              ),
            ),

            // --- Section Données et Stockage ---
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                "Données et Stockage",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: theme.primaryColor,
                ),
              ),
            ),
            Card(
              margin: const EdgeInsets.only(bottom: 20.0),
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.cleaning_services_outlined),
                    title: Text(
                      "Vider le cache",
                      style: GoogleFonts.poppins(fontSize: 16),
                    ),
                    trailing: const Icon(CupertinoIcons.right_chevron),
                    onTap: () {
                      // Logique pour vider le cache
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Cache vidé avec succès ! (Simulé)")),
                      );
                    },
                  ),
                ],
              ),
            ),

            // --- Section Support ---
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                "Support",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: theme.primaryColor,
                ),
              ),
            ),
            Card(
              margin: const EdgeInsets.only(bottom: 20.0),
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.help_outline),
                    title: Text(
                      "Aide et FAQ",
                      style: GoogleFonts.poppins(fontSize: 16),
                    ),
                    trailing: const Icon(CupertinoIcons.right_chevron),
                    onTap: () {
                      // Naviguer vers une page FAQ
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Ouvrir la page FAQ (non implémenté)")),
                      );
                      // Example: Navigator.push(context, MaterialPageRoute(builder: (context) => const FAQPage()));
                    },
                  ),
                  const Divider(height: 1, indent: 15, endIndent: 15),
                  ListTile(
                    leading: const Icon(Icons.contact_support_outlined),
                    title: Text(
                      "Contacter le support",
                      style: GoogleFonts.poppins(fontSize: 16),
                    ),
                    trailing: const Icon(CupertinoIcons.right_chevron),
                    onTap: () {
                      // Ouvrir un formulaire de contact ou un client email
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Ouvrir le contact support (non implémenté)")),
                      );
                      // Example: Navigator.push(context, MaterialPageRoute(builder: (context) => const ContactPage()));
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}