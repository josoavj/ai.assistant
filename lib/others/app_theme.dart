import 'package:ai_test/screens/chatscreen.dart';
import 'package:flutter/material.dart';

class MyAI extends StatelessWidget {
  const MyAI({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CHAT-AI',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.dark,
          seedColor: const Color.fromARGB(255, 171, 222, 244),
        ),
        useMaterial3: true,
      ),
      home: const ChatScreen(title: 'My Chat-AI',),
    );
  }
}



