import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart'; // Import pour TapGestureRecognizer
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart'; // Utilisation directe de url_launcher

class About extends StatefulWidget {
  const About({super.key});

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  // Fonction pour lancer les URLs
  Future<void> _launchUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea( // Ajout de SafeArea
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(CupertinoIcons.back),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            "Informations",
            style: GoogleFonts.poppins(
              fontSize: 20, // Taille un peu plus grande
              fontWeight: FontWeight.bold, // Plus audacieux
            ),
          ),
          centerTitle: true,
          elevation: 0, // Pas d'ombre sous l'AppBar si vous voulez un look plus plat
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0), // Padding général autour du contenu
          child: Center(
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0), // Bords arrondis
              ),
              // Utilisation d'un dégradé pour la couleur de la carte
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  gradient: const LinearGradient(
                    colors: [
                      Color.fromARGB(255, 12, 100, 175), // Bleu un peu plus clair
                      Color.fromARGB(255, 7, 60, 100), // Bleu plus foncé
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                padding: const EdgeInsets.all(30),
                width: 300, // Largeur fixe un peu plus grande
                constraints: const BoxConstraints(minHeight: 250), // Hauteur minimale
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "AI ChatBot Application",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 24, // Taille plus grande pour le titre
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 25), // Espacement ajusté
                    // About the developer
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: [
                            WidgetSpan(
                              child: Icon(Icons.person, color: Colors.white.withOpacity(0.8), size: 18),
                              alignment: PlaceholderAlignment.middle,
                            ),
                            const TextSpan(text: ' '), // Pour l'espace entre l'icône et le texte
                            TextSpan(
                              text: "Développé par: ",
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                color: Colors.white.withOpacity(0.9),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            TextSpan(
                              text: "josoavj",
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                color: Colors.blueAccent[100], // Couleur pour le lien
                                fontWeight: FontWeight.w700,
                                decoration: TextDecoration.underline, // Souligner le lien
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => _launchUrl('https://github.com/josoavj'),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // The repository
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: [
                            WidgetSpan(
                              child: Icon(Icons.code, color: Colors.white.withOpacity(0.8), size: 18),
                              alignment: PlaceholderAlignment.middle,
                            ),
                            const TextSpan(text: ' '),
                            TextSpan(
                              text: "Dépôt GitHub: ",
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                color: Colors.white.withOpacity(0.9),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            TextSpan(
                              text: "AI Test",
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                color: Colors.blueAccent[100],
                                fontWeight: FontWeight.w700,
                                decoration: TextDecoration.underline,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => _launchUrl('https://github.com/josoavj/ai.assistant'),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 30), // Espacement avant le bouton d'infos
                    ListTile(
                      leading: const Icon(Icons.info_outline, color: Colors.white),
                      title: Text(
                        "Informations Avancées",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      trailing: const Icon(CupertinoIcons.right_chevron, color: Colors.white),
                      onTap: () {
                        showAboutDialog(
                          context: context,
                          applicationLegalese: "© 2024 Josoa Vonjiniaina",
                          applicationName: "AI ChatBot",
                          applicationVersion: "1.0.0",
                          applicationIcon: const FlutterLogo(size: 30),
                          children: [
                            const SizedBox(height: 15),
                            Text(
                              "Ceci est une application de ChatBot IA simple développée par Josoa Vonjiniaina.",
                              style: GoogleFonts.poppins(fontSize: 12),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "Cette application est open source et peut être trouvée sur GitHub.",
                              style: GoogleFonts.poppins(fontSize: 12),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "Elle est développée avec Flutter et Dart.",
                              style: GoogleFonts.poppins(fontSize: 12),
                            ),
                          ],
                        );
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(color: Colors.white.withOpacity(0.3), width: 1), // Bordure légère
                      ),
                      tileColor: Colors.white.withOpacity(0.1), // Couleur de fond du ListTile
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}