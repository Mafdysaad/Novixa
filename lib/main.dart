import 'package:ai_chat_bot/core/service/service_locator.dart';
import 'package:ai_chat_bot/presentation/chat_bot_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:google_fonts/google_fonts.dart';

void main() async {
  await setup();
  await dotenv.load(fileName: 'assets/env/.env');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI Chat Bot',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF3369FF),
          primary: const Color(0xFF3369FF),
          onPrimary: Colors.white,
          background: Colors.white,
          surface: Colors.white,
        ),
        textTheme: GoogleFonts.nunitoTextTheme(ThemeData.light().textTheme),
      ),
      home: const ChatBotScreen(),
    );
  }
}
