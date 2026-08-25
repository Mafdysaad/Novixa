import 'dart:math';

import 'package:ai_chat_bot/core/service/service_locator.dart';

import 'package:ai_chat_bot/models/chat_message_model/content.dart';
import 'package:ai_chat_bot/presentation/manger/cubit/send_message_cubit.dart';
import 'package:ai_chat_bot/presentation/manger/cubit/send_message_state.dart';

import 'package:ai_chat_bot/presentation/widgets/chat_bot_app_bar.dart';
import 'package:ai_chat_bot/presentation/widgets/chat_message_input_bar.dart';
import 'package:ai_chat_bot/presentation/widgets/fauiler_message_list.dart';
import 'package:ai_chat_bot/presentation/widgets/figma_assets.dart';
import 'package:ai_chat_bot/presentation/widgets/loding_message_list.dart';
import 'package:ai_chat_bot/presentation/widgets/messages_list.dart';
import 'package:ai_chat_bot/repositories/chat_repository.dart';
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
  final List<Content> messages = [];

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _handleSend() {
    String text = _messageController.text.trim();
    if (text.isEmpty) return;
    messages.add(Content(text: text));
    _messageController.clear();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
        );
      }
    });
    // TODO: implement initState
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const ChatBotAppBar(),
      body: BlocProvider(
        create: (_) => SendMessageCubit(repository: getIt<ChatRepository>()),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final contentWidth = min(constraints.maxWidth, 450.0);
              return Center(
                child: SizedBox(
                  width: contentWidth,
                  child: Column(
                    children: [
                      const SizedBox(height: 12),
                      SvgPicture.asset(
                        figmaDividerLineUrl,
                        width: contentWidth,
                        height: 1,
                      ),
                      const SizedBox(height: 18),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child:
                              BlocConsumer<SendMessageCubit, SendMessageState>(
                                listener: (context, state) {
                                  if (state is SendMessageSuccess) {
                                    messages.addAll(
                                      state.chatMessageModel.steps![1].content!,
                                    );
                                  }
                                },
                                builder: (context, state) {
                                  if (state is SendMessageLoading) {
                                    return LodingMessageList(
                                      scrollController: _scrollController,
                                      messages: messages,
                                    );
                                  }
                                  if (state is SendMessageFailure) {
                                    return FauilerMessageList(
                                      scrollController: _scrollController,
                                      messages: messages,
                                      text: state.message,
                                    );
                                  }
                                  return MessagesList(
                                    scrollController: _scrollController,
                                    messages: messages,
                                  );
                                },
                              ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: 20,
                          right: 25,
                          left: 25,
                        ),
                        child: ChatMessageInputBar(
                          controller: _messageController,
                          onSend: () {
                            _handleSend();
                            context.read<SendMessageCubit>().sendMessage(
                              messages,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
