import 'package:ai_test/api/api.dart';
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
        actions: [
          IconButton(
            icon: const Icon(Icons.door_back_door_rounded),
            onPressed: () {
               showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title:  Text(
                      "Déconnecter",
                      style: GoogleFonts.poppins(fontSize: 15),),
                    content:  Text(
                      "Vous êtes sur de déconnecter votre compte?", 
                       style: GoogleFonts.poppins(fontSize: 11),),
                    actions: [
                      TextButton(
                        child: const Text("Non"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: const Text("Oui"),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const MyAI()));
                      },),]);
            });})
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            Text(
              "Nom: ",
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
      ),
    );
  }
}