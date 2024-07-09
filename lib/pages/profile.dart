import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context), 
          icon: const Icon(CupertinoIcons.back)),
        title: Text(
          "Mon compte",
          style: GoogleFonts.poppins(
            fontSize: 15,
            fontWeight: FontWeight.w700
          ),),
        centerTitle: true,

      ),
      body: Container(
        
      ),
    );
  }
}