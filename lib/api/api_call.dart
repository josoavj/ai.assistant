// API Key Injection & Usage
import 'package:ai_test/others/screenswidget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/link.dart';


class ApiKeyWidget extends StatelessWidget {
  ApiKeyWidget({required this.onSubmitted, super.key});

  final ValueChanged<String> onSubmitted;
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
               Text(
                "Pour utiliser votre IA,"
                "vous devez obtenir une clé API",
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  color: Colors.white,fontWeight: FontWeight.w700
                )
              ),
              const SizedBox(height: 8),
              Link(
                uri: Uri.https('makersuite.google.com', '/app/apikey'),
                target: LinkTarget.blank,
                builder: (context, followLink) => TextButton(
                  onPressed: followLink,
                  child:  AbsorbPointer(
                    child: Text('Obtenir un clé API', 
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        color: Colors.white,fontWeight: FontWeight.w700
                      ),),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                    style: GoogleFonts.poppins(
                           fontSize: 12,
                           color: Colors.white, 
                           fontWeight: FontWeight.w400),
                    decoration:
                      textFieldDecoration(context, 'Entrer votre clé d''API'),
                      controller: _textController,
                      // Condition : Feature
                      /**
                       * Condition pour vérifier si le champ est vide
                       * Si le champ est vide alors un alerte est envoyé 
                       * à l'utilisateur pour lui demander de remplir le champ
                       */
                      onSubmitted: (value) {
                        onSubmitted(value);
                      },
                    ),
                  ),
                  const SizedBox(height: 5),
                  TextButton(
                    onPressed: () {
                      onSubmitted(_textController.value.text);
                    },
                    child: AbsorbPointer(
                      child: Text('Connecter', 
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          color: Colors.white,fontWeight: FontWeight.w800
                        ),),
                    )
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

