import 'package:ai_chat_bot/core/error/errors.dart';
import 'package:ai_chat_bot/core/service/service_locator.dart';
import 'package:ai_chat_bot/models/chat_message_model/chat_message_model.dart';
import 'package:ai_chat_bot/models/chat_message_model/content.dart';
import 'package:ai_chat_bot/models/chat_message_model/step.dart';
import 'package:ai_chat_bot/models/chat_message_model/usage.dart';
import 'package:ai_chat_bot/presentation/chat_bot_screen.dart';
import 'package:ai_chat_bot/presentation/manger/cubit/send_message_cubit.dart';
import 'package:ai_chat_bot/presentation/widgets/ai_bubble.dart';
import 'package:ai_chat_bot/presentation/widgets/chat_message_input_bar.dart';
import 'package:ai_chat_bot/presentation/widgets/dotIndicator.dart';
import 'package:ai_chat_bot/presentation/widgets/fauiler_bubble.dart';
import 'package:ai_chat_bot/presentation/widgets/user_bubble.dart';

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

ServerFailure _getServerFailurMessage() {
  return ServerFailure('some thing is wrong');
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

    testWidgets('Successful AI Response', (tester) async {
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
      await tester.pumpAndSettle();
      expect(find.byType(AiBubble), findsOneWidget);
    });
    group('Failuer Ai Response', () {
      testWidgets('Failuer AI Response', (tester) async {
        when(() => fackgeminchatrepository.sendMessage(any())).thenAnswer((
          _,
        ) async {
          return Future.delayed(Duration(seconds: 2), () {
            return right(_getServerFailurMessage());
          });
        });
        await tester.pumpWidget(MaterialApp(home: ChatBotScreen()));
        await tester.pumpAndSettle();
        var textfaild = find.byType(ChatMessageInputBar);
        await tester.enterText(textfaild, 'Hi Mafdy');
        await tester.pumpAndSettle();
        var send_icon = find.byKey(const Key('Send_Icon'));
        await tester.tap(send_icon);
        await tester.pumpAndSettle();
        expect(
          find.descendant(
            of: find.byType(FauilerBubble),
            matching: find.text('Hi Mafdy'),
          ),
          findsOne,
        );
      });

      testWidgets('Successful Retry on firs attempt', (tester) async {
        int count = 0;
        when(() => fackgeminchatrepository.sendMessage(any())).thenAnswer((
          _,
        ) async {
          return Future.delayed(Duration(seconds: 2), () {
            if (count == 1) {
              return left(_getchateMessageModel());
            }
            count++;
            return right(_getServerFailurMessage());
          });
        });
        await tester.pumpWidget(MaterialApp(home: ChatBotScreen()));
        await tester.pumpAndSettle();
        var textfaild = find.byType(ChatMessageInputBar);
        await tester.enterText(textfaild, 'Hi Mafdy');
        await tester.pumpAndSettle();
        var send_icon = find.byKey(const Key('Send_Icon'));
        await tester.tap(send_icon);
        await tester.pumpAndSettle();
        var icon = find.descendant(
          of: find.byType(FauilerBubble),
          matching: find.byIcon(Icons.rotate_right_sharp),
        );
        await tester.tap(icon);
        await tester.pumpAndSettle();
        expect(find.byType(AiBubble), findsOneWidget);
        expect(find.byType(UserBubble), findsOneWidget);
        expect(find.byType(FauilerBubble), findsNothing);
      });
      testWidgets('failed at all retry attempt', (tester) async {
        when(() => fackgeminchatrepository.sendMessage(any())).thenAnswer((
          _,
        ) async {
          return Future.delayed(Duration(seconds: 2), () {
            return right(_getServerFailurMessage());
          });
        });
        await tester.pumpWidget(MaterialApp(home: ChatBotScreen()));
        await tester.pumpAndSettle();
        var textfaild = find.byType(ChatMessageInputBar);
        await tester.enterText(textfaild, 'Hi Mafdy');
        await tester.pumpAndSettle();
        var send_icon = find.byKey(const Key('Send_Icon'));
        await tester.tap(send_icon);
        await tester.pumpAndSettle();
        var icon = find.descendant(
          of: find.byType(FauilerBubble),
          matching: find.byIcon(Icons.rotate_right_sharp),
        );
        await tester.tap(icon);
        await tester.pumpAndSettle();
        expect(find.byType(AiBubble), findsNothing);
        expect(find.byType(UserBubble), findsNothing);
        expect(find.byType(FauilerBubble), findsOneWidget);
      });
    });
  });
}
