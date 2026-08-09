import 'package:ai_chat_bot/presentation/chat_bot_screen.dart';
import 'package:ai_chat_bot/presentation/manger/cubit/send_message_cubit.dart';

import 'package:ai_chat_bot/models/chat_message_model/chat_message_model.dart';
import 'package:ai_chat_bot/repositories/gemini_chat_repository.dart';
import 'package:ai_chat_bot/services/clientserves/gemini_chat_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SendMessageCubit(
        repository: GeminiChatRepository(
          geminiChatService: GeminiChatService(),
        ),
      ),
      child: MaterialApp(
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
      ),
    );
  }
}
