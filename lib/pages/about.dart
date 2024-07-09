import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/link.dart';

class About extends StatefulWidget {
  const About({super.key});

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //floatingActionButton: ,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back),
          onPressed: () => Navigator.pop(context),),
        title: Text("Informations", 
        style: GoogleFonts.poppins(
          fontSize: 15,
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),),
        centerTitle: true
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "AI ChatBot Application", 
              style: GoogleFonts.poppins(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 20,),
            // About the developer
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
              "Developped by:",
              style: GoogleFonts.poppins(
                fontSize: 15,
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
            Link(
                uri: Uri.https('github.com', '/Josoa886'),
                target: LinkTarget.blank,
                builder: (context, followLink) => TextButton(
                  onPressed: followLink,
                  child:  AbsorbPointer(
                    child: Text('Josoa886', 
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        color: Colors.white,fontWeight: FontWeight.w700
                      ),),
                  ),
                ),
              ),
              ],
            ),
        
            // The repository
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
              "GitHub Repo:",
              style: GoogleFonts.poppins(
                fontSize: 15,
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
            Link(
                uri: Uri.https('github.com', '/Josoa886/ai_test'),
                target: LinkTarget.blank,
                builder: (context, followLink) => TextButton(
                  onPressed: followLink,
                  child:  AbsorbPointer(
                    child: Text('AI Test', 
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        color: Colors.white,fontWeight: FontWeight.w700
                      ),),
                  ),
                ),
              ),
              ],
            ),
            TextButton(
              child: Text(
                  "Adnanced Informations",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
              ),
              onPressed: (){
                showAboutDialog(
                  context: context,
                  applicationLegalese: "© 2024 Josoa Vonjiniaina",
                  applicationName: "AI ChatBot",
                  applicationVersion: "1.0.0",
                  applicationIcon: const FlutterLogo(size: 30),
                  children: [
                    const SizedBox(height: 20,),
                    Text(
                      "This is a simple AI ChatBot application \n developed by Josoa Vonjiniaina.",
                      style:GoogleFonts.poppins(
                        fontSize: 9,
                      )),
                    Text(
                      "This application is open source and \n can be found on GitHub.",
                      style: GoogleFonts.poppins(
                        fontSize: 9),),
                    Text(
                      "This application is developed using Flutter and Dart.",
                      style: GoogleFonts.poppins(
                        fontSize: 8),),
                  ]
                  );
              }, 
              ),
          ],),
      ),
    );
  }
}