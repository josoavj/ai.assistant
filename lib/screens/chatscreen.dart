
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

// Chat Screen state management
class _ChatScreenState extends State<ChatScreen> {
  String? apiKey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 7, 116, 206),
              ),
              child: Text('MyAI Menu', 
                style: GoogleFonts.poppins(
                  fontSize: 25,
                  color: Colors.white,fontWeight: FontWeight.w700
                ),),
            ),
            ListTile(
              leading: const Icon(CupertinoIcons.info),
              iconColor: Colors.white,
              title: const Text('A propos'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const About()));
              },
            ),
            ListTile(
              leading: const Icon(CupertinoIcons.settings_solid),
              iconColor: Colors.white,
              title: const Text('Paramètres'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const Settings()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              iconColor: Colors.white,
              title: const Text('Quitter'),
              onTap: () {
                 showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title:  Text(
                      "Quitter l'application",
                      style: GoogleFonts.poppins(fontSize: 15),),
                    content:  Text(
                      "Vous êtes sur le point de quitter l'application. \n voulez vous continuer ?", 
                       style: GoogleFonts.poppins(fontSize: 11),),
                    actions: [
                      TextButton(
                        child: const Text("Annuler"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: const Text("Quitter"),
                        onPressed: () {
                          SystemNavigator.pop();
                        },
                      ),
                    ],
                  );
                  }
                  );
              },
            ),
          ],
        ),
      
      ),
      appBar: AppBar(
        title: Text(widget.title, 
        style: GoogleFonts.poppins(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),),
      centerTitle: true,
      actions: [
        IconButton(
          iconSize: 20,
          onPressed: () {
             Navigator.push(context, MaterialPageRoute(builder: (context) => const Profile()));
          },
          icon: const Icon(CupertinoIcons.profile_circled),
        ),],
      ),
      body: switch (apiKey) {
        final providedKey? => ChatWidget(apiKey: providedKey),
        _ => ApiKeyWidget(onSubmitted: (key) {
            setState(() => apiKey = key);
          }),
      },
    );
  }
}
