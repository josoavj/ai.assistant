import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:ai_test/main.dart'; // Assurez-vous que le nom de la classe ThemeProvider est correct

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  late Color pickerColor;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    pickerColor = ThemeProvider.of(context).currentPrimaryColor;
  }

  void _showColorPickerDialog() {
    // Récupérer la couleur actuelle avant d'ouvrir le dialogue
    // pour que le picker démarre avec cette couleur
    Color currentColorForPicker = ThemeProvider.of(context).currentPrimaryColor;

    showDialog(
      context: context,
      builder: (context) {
        // Utiliser un StatefulWidget pour le contenu du dialogue si le picker a besoin de gérer son propre état interne
        // de manière plus complexe, mais ici un simple setState sur _SettingsState suffit.
        return AlertDialog(
          title: Text('Choisir une couleur', style: GoogleFonts.poppins()),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: currentColorForPicker, // Utiliser la couleur récupérée
              onColorChanged: (color) {
                // Mettre à jour la couleur temporaire dans le picker
                // N'applique pas encore le thème globalement
                setState(() {
                  pickerColor = color; // Met à jour la variable de l'état _SettingsState
                  // qui sera utilisée si l'utilisateur appuie sur "Appliquer"
                });
              },
              pickerAreaHeightPercent: 0.8,
              enableAlpha: false,
              displayThumbColor: true,
              paletteType: PaletteType.hsvWithHue,
              labelTypes: const [],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Annuler'),
            ),
            ElevatedButton(
              onPressed: () {
                // Appliquer la nouvelle couleur via ThemeProvider
                ThemeProvider.of(context).changeThemeColor(pickerColor); // Utilisation de la variable d'état mise à jour
                Navigator.of(context).pop();
              },
              child: const Text('Appliquer'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Accéder à ThemeProvider pour obtenir les informations et fonctions du thème
    final themeProvider = ThemeProvider.of(context);
    final ThemeData currentTheme = Theme.of(context); // Pour les styles généraux du thème actuel (clair ou sombre)

    return Scaffold(
      appBar: AppBar(
        title: const Text('Paramètres'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          ListTile(
            leading: Icon(Icons.color_lens, color: currentTheme.primaryColor),
            title: Text('Couleur du Thème', style: GoogleFonts.poppins()),
            subtitle: Text(
              'Modifier la couleur principale de l\'application',
              style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[600]),
            ),
            trailing: CircleAvatar(
              backgroundColor: themeProvider.currentPrimaryColor, // Couleur du ThemeProvider
              radius: 12,
            ),
            onTap: _showColorPickerDialog,
          ),
          const Divider(),
          // Option pour basculer entre le thème Sombre et Normal
          SwitchListTile(
            title: Text(
              'Mode Sombre',
              style: GoogleFonts.poppins(),
            ),
            value: themeProvider.currentThemeMode == ThemeMode.dark,
            onChanged: (bool value) {
              themeProvider.toggleThemeMode(); // Appelle la fonction de ThemeProvider
            },
            secondary: Icon(
              themeProvider.currentThemeMode == ThemeMode.dark
                  ? Icons.dark_mode
                  : Icons.light_mode,
              color: currentTheme.colorScheme.secondary, // Utiliser une couleur du thème actuel
            ),
            activeColor: currentTheme.primaryColor, // Couleur du switch quand actif
          ),
          const Divider(),
          ListTile(
            leading: Icon(Icons.notifications, color: currentTheme.colorScheme.secondary),
            title: Text('Notifications', style: GoogleFonts.poppins()),
            subtitle: Text(
              'Activer/désactiver les notifications',
              style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[600]),
            ),
            trailing: Switch(
              value: true, // Remplacez par une vraie variable d'état si nécessaire
              onChanged: (bool value) {
                // Gérer le changement d'état des notifications
              },
              activeColor: currentTheme.primaryColor,
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }
}
