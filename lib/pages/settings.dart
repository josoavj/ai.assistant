import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../others/app_theme.dart';
import 'login.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeNotifier>(context);
    final ThemeData currentTheme = Theme.of(context);

    // Fonction pour afficher le dialogue de sélection de couleur
    void showColorPickerDialog() {
      Color pickerColor = themeProvider.primarySwatch;
      showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                title: Text('Choisir une couleur', style: GoogleFonts.poppins()),
                content: SingleChildScrollView(
                  child: ColorPicker(
                    pickerColor: pickerColor,
                    onColorChanged: (color) {
                      setState(() => pickerColor = color);
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
                      Provider.of<ThemeNotifier>(context, listen: false)
                          .changeThemeColor(pickerColor);
                      Navigator.of(context).pop();
                    },
                    child: const Text('Appliquer'),
                  ),
                ],
              );
            },
          );
        },
      );
    }

    // Fonction pour afficher le dialogue de changement de clé API
    void showApiKeyDialog() async {
      final prefs = await SharedPreferences.getInstance();
      final currentKey = prefs.getString('gemini_api_key') ?? '';
      final TextEditingController keyController = TextEditingController(text: currentKey);

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Changer de clé API', style: GoogleFonts.poppins()),
            content: TextField(
              controller: keyController,
              decoration: InputDecoration(
                hintText: 'Entrez votre nouvelle clé API',
                hintStyle: GoogleFonts.poppins(),
                border: const OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Annuler'),
              ),
              ElevatedButton(
                onPressed: () async {
                  if (keyController.text.isNotEmpty) {
                    await prefs.setString('gemini_api_key', keyController.text);
                    if (context.mounted) {
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Clé API mise à jour.', style: GoogleFonts.poppins())),
                      );
                    }
                  }
                },
                child: const Text('Enregistrer'),
              ),
            ],
          );
        },
      );
    }

    // Fonction de déconnexion
    void _handleLogout() {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    }


    return Scaffold(
      appBar: AppBar(
        title: const Text('Paramètres'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Option pour changer la couleur
          ListTile(
            leading: Icon(Icons.color_lens, color: currentTheme.primaryColor),
            title: Text('Couleur du Thème', style: GoogleFonts.poppins()),
            subtitle: Text(
              'Modifier la couleur principale de l\'application',
              style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[600]),
            ),
            trailing: CircleAvatar(
              backgroundColor: themeProvider.primarySwatch,
              radius: 12,
            ),
            onTap: showColorPickerDialog,
          ),
          const Divider(),
          // Option pour basculer entre le thème Sombre et Normal
          SwitchListTile(
            title: Text(
              'Mode Sombre',
              style: GoogleFonts.poppins(),
            ),
            value: themeProvider.themeMode == ThemeMode.dark,
            onChanged: (bool value) {
              themeProvider.toggleThemeMode();
            },
            secondary: Icon(
              themeProvider.themeMode == ThemeMode.dark
                  ? Icons.dark_mode
                  : Icons.light_mode,
              color: currentTheme.primaryColor,
            ),
            activeColor: currentTheme.primaryColor,
          ),
          const Divider(),
          // Nouvelle option pour changer la clé API
          ListTile(
            leading: Icon(Icons.vpn_key, color: currentTheme.primaryColor),
            title: Text(
              'Clé API',
              style: GoogleFonts.poppins(),
            ),
            subtitle: Text(
              'Mettre à jour la clé API pour le chat',
              style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[600]),
            ),
            onTap: showApiKeyDialog,
          ),
          const Divider(),
          // Option de deconnexion
          ListTile(
            leading: Icon(Icons.logout, color: currentTheme.colorScheme.error),
            title: Text('Déconnexion', style: GoogleFonts.poppins()),
            subtitle: Text(
              'Se déconnecter de votre compte',
              style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[600]),
            ),
            onTap: _handleLogout,
          ),
        ],
      ),
    );
  }
}
