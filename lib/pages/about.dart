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
            Text(
              "Version 1.0.0",
              style: GoogleFonts.poppins(
                fontSize: 15,
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
        
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
          ],),
      ),
    );
  }
}