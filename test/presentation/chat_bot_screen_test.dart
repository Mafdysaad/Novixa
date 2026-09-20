import 'package:ai_chat_bot/core/service/service_locator.dart';
import 'package:ai_chat_bot/models/chat_message_model/chat_message_model.dart';
import 'package:ai_chat_bot/models/chat_message_model/content.dart';
import 'package:ai_chat_bot/models/chat_message_model/step.dart';
import 'package:ai_chat_bot/models/chat_message_model/usage.dart';
import 'package:ai_chat_bot/presentation/chat_bot_screen.dart';
import 'package:ai_chat_bot/presentation/manger/cubit/send_message_cubit.dart';
import 'package:ai_chat_bot/presentation/widgets/chat_message_input_bar.dart';
import 'package:ai_chat_bot/presentation/widgets/dotIndicator.dart';

import 'package:ai_chat_bot/repositories/gemini_chat_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class fackGeminiChatRepository extends Mock implements GeminiChatRepository {}

ChatMessageModel _getchateMessageModel() {
  return ChatMessageModel(
    id: '1',
    status: 'shht',
    usage: Usage(totalTokens: 293),
    steps: [
      stepp(
        content: [Content(text: 'hi am your ai assastant', type: 'text')],
      ),
    ],
    object: 'gmin',
    model: 'dsns',
  );
}

void main() {
  late fackGeminiChatRepository fackgeminchatrepository;
  setUp(() async {
    fackgeminchatrepository = fackGeminiChatRepository();
    await getIt.reset();
    getIt.registerSingleton<GeminiChatRepository>(fackgeminchatrepository);
    getIt.registerFactory<SendMessageCubit>(
      () => SendMessageCubit(repository: getIt.get<GeminiChatRepository>()),
    );
  });
  group('send message flow', () {
    testWidgets('Loading Indicator on send', (tester) async {
      when(() => fackgeminchatrepository.sendMessage(any())).thenAnswer((
        _,
      ) async {
        return Future.delayed(Duration(seconds: 2), () {
          return left(_getchateMessageModel());
        });
      });
      await tester.pumpWidget(MaterialApp(home: ChatBotScreen()));
      await tester.pumpAndSettle();
      var textfaild = find.byType(ChatMessageInputBar);
      await tester.enterText(textfaild, 'Hi Mafdy');
      await tester.pumpAndSettle();
      var send_icon = find.byKey(const Key('Send_Icon'));
      await tester.tap(send_icon);
      await tester.pump();
      expect(find.byType(DotIndicator), findsOneWidget);
      await tester.pumpAndSettle();
    });
  });
}
