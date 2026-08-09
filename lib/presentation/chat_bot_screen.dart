import 'dart:math';

import 'package:ai_chat_bot/models/chat_message_model/chat_message_model.dart';
import 'package:ai_chat_bot/presentation/manger/cubit/send_message_cubit.dart';
import 'package:ai_chat_bot/presentation/manger/cubit/send_message_state.dart';
import 'package:ai_chat_bot/presentation/widgets/assistant_avatar.dart';
import 'package:ai_chat_bot/presentation/widgets/chat_bot_app_bar.dart';
import 'package:ai_chat_bot/presentation/widgets/chat_message_bubble.dart';
import 'package:ai_chat_bot/presentation/widgets/chat_message_input_bar.dart';
import 'package:ai_chat_bot/presentation/widgets/figma_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChatBotScreen extends StatefulWidget {
  const ChatBotScreen({super.key});

  @override
  State<ChatBotScreen> createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<ChatMessageModel> messages = [];
  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    context.read<SendMessageCubit>().add(ChatMessageSent(text));
    _messageController.clear();
    FocusScope.of(context).unfocus();
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const ChatBotAppBar(),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final contentWidth = min(constraints.maxWidth, 450.0);
            return Center(
              child: SizedBox(
                width: contentWidth,
                child: Column(
                  children: [
                    const SizedBox(height: 12),
                    SvgPicture.network(
                      figmaDividerLineUrl,
                      width: contentWidth,
                      height: 1,
                    ),
                    const SizedBox(height: 18),
                    Expanded(
                      child: BlocBuilder<SendMessageCubit, SendMessageState>(
                        builder: (context, state) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            if (_scrollController.hasClients) {
                              _scrollController.animateTo(
                                _scrollController.position.maxScrollExtent,
                                duration: const Duration(milliseconds: 250),
                                curve: Curves.easeOut,
                              );
                            }
                          });

                          return ListView.separated(
                            controller: _scrollController,
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            itemCount: messages.length,
                            separatorBuilder: (_, __) =>
                                const SizedBox(height: 24),
                            itemBuilder: (context, index) {
                              final message = messages[index];
                              final isUser = index.isEven;

                              return Padding(
                                padding: EdgeInsets.only(
                                  left: isUser ? 40 : 62,
                                  right: isUser ? 29 : 40,
                                ),
                                child: Row(
                                  mainAxisAlignment: isUser
                                      ? MainAxisAlignment.end
                                      : MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    if (!isUser) ...[
                                      const AssistantAvatar(),
                                      const SizedBox(width: 12),
                                    ],
                                    Flexible(
                                      child: ChatMessageBubble(
                                        message: message.text ?? '',
                                        isUser: isUser,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: ChatMessageInputBar(
                        controller: _messageController,
                        onSend: _sendMessage,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
