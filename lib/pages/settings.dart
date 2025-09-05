import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';
import 'package:ai_test/main.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeNotifier>(context);
    final ThemeData currentTheme = Theme.of(context);

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
        ],
      ),
    );
  }
}