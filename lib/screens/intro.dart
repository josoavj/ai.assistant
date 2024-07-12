import 'package:ai_test/others/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Intro extends StatefulWidget {
  const Intro({super.key});

  @override
  State<Intro> createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  @override
  void initState(){
    goto();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 7, 116, 206),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              width: 150,
              child: CircleAvatar(
                radius: 80,
                foregroundImage: AssetImage(
                  "assets/images/todoroki.png",
                ),
                ),
            ),
            const SizedBox(height: 50,),
            Text('Welcome to',
            style: GoogleFonts.poppins(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold
            ),
            ),

            Text('MyAI',
            style: GoogleFonts.poppins(
              fontSize: 25,
              color: Colors.white,
              fontWeight: FontWeight.bold
            ),
            ),
          ],
        ),
      )
    );
  }
  Future<void> goto() async{
    await Future.delayed( const Duration(seconds: 5));
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MyAI()));
}
}

