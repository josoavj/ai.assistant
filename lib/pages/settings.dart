import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart'; // Ajoutez cette dépendance
import 'package:ai_test/main.dart'; // Importez votre fichier main.dart pour ThemeProvider

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  // Couleur actuellement sélectionnée dans le picker
  late Color pickerColor;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Initialiser pickerColor avec la couleur principale actuelle du thème
    pickerColor = ThemeProvider.of(context).currentPrimaryColor;
  }

  void _showColorPickerDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Choisir une couleur', style: GoogleFonts.poppins()),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: pickerColor,
              onColorChanged: (color) {
                setState(() {
                  pickerColor = color;
                });
              },
              pickerAreaHeightPercent: 0.8,
              enableAlpha: false, // Pas besoin d'alpha pour la couleur principale
              displayThumbColor: true,
              paletteType: PaletteType.hsvWithHue, // Ou un autre type de palette
              labelTypes: const [], // Supprimer les étiquettes de valeur (HEX, RGB) pour la simplicité
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
                ThemeProvider.of(context).changeTheme(pickerColor);
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
    final ThemeData theme = Theme.of(context); // Accès au thème

    return Scaffold(
      appBar: AppBar(
        title: const Text('Paramètres'), // Style de l'AppBar via main.dart
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          ListTile(
            leading: Icon(Icons.color_lens, color: theme.primaryColor), // Icône avec couleur du thème
            title: Text('Couleur du Thème', style: GoogleFonts.poppins()),
            subtitle: Text(
              'Modifier la couleur principale de l\'application',
              style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[600]),
            ),
            trailing: CircleAvatar(
              backgroundColor: ThemeProvider.of(context).currentPrimaryColor, // Affiche la couleur actuelle
              radius: 12,
            ),
            onTap: _showColorPickerDialog,
          ),
          const Divider(),
          // Vous pouvez ajouter d'autres options de paramètres ici
          ListTile(
            leading: Icon(Icons.notifications, color: theme.colorScheme.secondary),
            title: Text('Notifications', style: GoogleFonts.poppins()),
            subtitle: Text(
              'Activer/désactiver les notifications',
              style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[600]),
            ),
            trailing: Switch(
              value: true, // Exemple de valeur
              onChanged: (bool value) {
                // Gérer le changement d'état
              },
              activeColor: theme.primaryColor,
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }
}