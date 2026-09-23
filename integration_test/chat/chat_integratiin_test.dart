import 'dart:async';

import 'package:ai_chat_bot/core/service/service_locator.dart';

import 'package:ai_chat_bot/presentation/chat_bot_screen.dart';
import 'package:ai_chat_bot/presentation/manger/cubit/send_message_cubit.dart';

import 'package:ai_chat_bot/presentation/widgets/ai_bubble.dart';
import 'package:ai_chat_bot/presentation/widgets/chat_message_input_bar.dart';
import 'package:ai_chat_bot/presentation/widgets/dotIndicator.dart';
import 'package:ai_chat_bot/presentation/widgets/fauiler_bubble.dart';
import 'package:ai_chat_bot/presentation/widgets/user_bubble.dart';
import 'package:ai_chat_bot/repositories/chat_repository.dart';
import 'package:ai_chat_bot/repositories/gemini_chat_repository.dart';

import 'package:ai_chat_bot/services/clientserves/api_clinetservice.dart';
import 'package:ai_chat_bot/services/clientserves/gemini_chat_service.dart';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:integration_test/integration_test.dart';
import 'package:mocktail/mocktail.dart';

class ApiClientserviceMock extends Mock implements ApiClientService {}

Map<String, dynamic> _SuccessRespnsBody = {
  "id":
      "v1_ChdORzZxYXN5UkpjR2MyOG9QMnJhWTRRdxIXTkc2cWFzeVJKY0djMjhvUDJyYVk0UXc",
  "status": "completed",
  "usage": {
    "total_tokens": 187,
    "total_input_tokens": 2,
    "input_tokens_by_modality": [
      {"modality": "text", "tokens": 2},
    ],
    "total_cached_tokens": 0,
    "total_output_tokens": 9,
    "total_tool_use_tokens": 0,
    "total_thought_tokens": 176,
    "raw_prompt_token": 33,
    "model_invocation_token_counts": [
      {
        "prompt_tokens_details": [
          {"modality": "text", "tokens": 33},
        ],
        "candidates_tokens_details": [
          {"modality": "text", "tokens": 13},
        ],
        "thoughts_tokens_details": [
          {"modality": "text", "tokens": 176},
        ],
      },
    ],
  },
  "created": "2026-09-16T10:23:48Z",
  "updated": "2026-09-16T10:23:48Z",
  "service_tier": "standard",
  "steps": [
    {
      "signature":
          "EuEFCt4FARFNMg8H2YVm8TlWV1jHfcl+PvDE374ra6o4q5asrTIEDzdEvFoxw5Wv5sQBfq1pGfJ+lx8jdnpLJ7nYNSl0TBjdZf+pUHRd1LFOVppmbFWFpoHazlvpVgI9oFj+jqM/pTH+0Nea0LquDKDd8/ENERAj92/6VsMq1Kt9J7skswTep5IAWSDnT3KOsRYjdFXU37hK97et1i1fB77EjwXW5Bpp3fbM100cou3K7KM6MzGWHsBzmBYMCArKliS5CdReMKbYe5foGAiKHCLZwLTCVRa+3VhF7NaKiU1XvcNlOiyAxR+lthFj+TtTX8X3sZRg96Pc0ODeNrtnLs5jKATZkycMJFkW4bdwNJLID7qUfsCTbxFYaX2mNLqggKHqWwLcB8s06qqFC9vuahgc5lXPibW68sj6LQd9EjxtAjxzt3nYUhnQKyjAvjQmAgyu5y37odvQXVI2kC3AYaNxinkI1+7gzbX+OZNhOS+cl28ly1/c7KYxZu8zmkd7sDvjcSrbuB8SFentYKo6AH5ERHutygcxJwmNp1m4/SuEmNik5p1bgq9r+CMAfg4cnk/BaLM1JtBw5CrnJRA7hJfD978HHMriidzOF/QPgJxTUDbAvuQt9FPcZneO5hSugkWL26lJy8Rs03ZLbDxl73v6Djwlm+jGcKMK64tln2nHxcXrEk5vi63yHDG1SqdizT12+aYpTmrNiBOCV+fHREgG0BaFItn8NQhUJ0U1174kXQ7f9stxF/SXqGb7vx8J7iB98B1N49LVqynbNM7Nc7BEN5nTqdd64L4mDL5KaByHjb2DYMqJi1fRMbbOdhTPNp3y/Aje+7UP1UUBBtr0QVaxvsrhChURLpsFjPDY1qrknHq8JMlYvZ8LOBnmlb3tyEVLyycvryQjyIJPmcYNWq48snjP+6o2QZsWjM8HCUHW42lVRs5WA2BN3lp+0IdjudTy39RxGsG+0OTX3ZA5Qdt3KO0=",
      "type": "thought",
    },
    {
      "content": [
        {"text": "Hello! How can I help you today?", "type": "text"},
      ],
      "type": "model_output",
    },
  ],
  "object": "interaction",
  "model": "gemini-3.6-flash",
};
Future<Response> _getSuccessResponse() async {
  return Response(
    requestOptions: RequestOptions(
      path: 'https://generativelanguage.googleapis.com/v1beta/interactions',
    ),
    statusCode: 200,
    data: _SuccessRespnsBody,
  );
}

DioException _getretryableExaption() {
  final requestoptions = RequestOptions(
    path: 'https://generativelanguage.googleapis.com/v1beta/interactions',
  );
  return DioException(
    response: Response(requestOptions: requestoptions, statusCode: 429),
    requestOptions: requestoptions,
    type: DioExceptionType.badResponse,
  );
}

DioException _getnonretryableExaption() {
  final requestoptions = RequestOptions(
    path: 'https://generativelanguage.googleapis.com/v1beta/interactions',
  );

  return DioException(
    response: Response(requestOptions: requestoptions, statusCode: 400),
    requestOptions: requestoptions,
    type: DioExceptionType.badResponse,
  );
}

void main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  late ApiClientserviceMock apiClientserviceMock;
  await dotenv.load(fileName: 'assets/env/.env');
  setUp(() async {
    await getIt.reset();
    apiClientserviceMock = ApiClientserviceMock();
    getIt.registerSingleton<ApiClientService>(apiClientserviceMock);

    getIt.registerSingleton<GeminiChatService>(
      GeminiChatService(client: getIt<ApiClientService>()),
    );

    getIt.registerSingleton<ChatRepository>(
      GeminiChatRepository(geminiChatService: getIt<GeminiChatService>()),
    );

    getIt.registerFactory<SendMessageCubit>(
      () => SendMessageCubit(repository: getIt<ChatRepository>()),
    );
  });
  group('send message flow', () {
    testWidgets('Loading Indicator on send', (tester) async {
      when(
        () => apiClientserviceMock.post(
          any(),
          data: any(named: 'data'),
          options: any(named: 'options'),
        ),
      ).thenAnswer((_) async {
        return Future.delayed(Duration(seconds: 2), () {
          return _getSuccessResponse();
        });
      });
      await tester.pumpWidget(MaterialApp(home: ChatBotScreen()));
      await tester.pumpAndSettle();
      var textfaild = find.byType(ChatMessageInputBar);
      await tester.enterText(textfaild, 'Hi Mafdy');
      await tester.pumpAndSettle();
      var send_icon = find.byKey(const Key('Send_Icon'));
      await tester.tap(send_icon);
      await tester.pump(const Duration(milliseconds: 500));
      expect(find.byType(DotIndicator), findsOneWidget);
      await tester.pumpAndSettle();
    });

    testWidgets('Successful AI Response', (tester) async {
      when(
        () => apiClientserviceMock.post(
          any(),
          data: any(named: 'data'),
          options: any(named: 'options'),
        ),
      ).thenAnswer((_) async {
        return Future.delayed(Duration(seconds: 2), () {
          return _getSuccessResponse();
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
        when(
          () => apiClientserviceMock.post(
            any(),
            data: any(named: 'data'),
            options: any(named: 'options'),
          ),
        ).thenAnswer((_) async {
          return Future.delayed(Duration(seconds: 2), () {
            throw _getnonretryableExaption();
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
        when(
          () => apiClientserviceMock.post(
            any(),
            data: any(named: 'data'),
            options: any(named: 'options'),
          ),
        ).thenAnswer((_) async {
          return Future.delayed(Duration(seconds: 2), () {
            if (count == 1) {
              return _getSuccessResponse();
            }
            count++;
            throw Exception('some thing is wrong');
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
      testWidgets('failed at all retry attempts', (tester) async {
        when(
          () => apiClientserviceMock.post(
            any(),
            data: any(named: 'data'),
            options: any(named: 'options'),
          ),
        ).thenAnswer((_) async {
          return Future.delayed(Duration(seconds: 2), () {
            throw _getnonretryableExaption();
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
      testWidgets('sending a new message', (tester) async {
        when(
          () => apiClientserviceMock.post(
            any(),
            data: any(named: 'data'),
            options: any(named: 'options'),
          ),
        ).thenAnswer((_) async {
          return Future.delayed(Duration(seconds: 2), () {
            throw _getretryableExaption();
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
        await tester.enterText(textfaild, 'New message');
        await tester.pumpAndSettle();
        await tester.tap(send_icon);
        await tester.pumpAndSettle();
        expect(
          find.descendant(
            of: find.byType(FauilerBubble),
            matching: find.text('New message'),
          ),
          findsOneWidget,
        );
      });
      testWidgets('freeze the ui when user sends message', (tester) async {
        final completer = Completer<Response<dynamic>>();
        when(
          () => apiClientserviceMock.post(
            any(),
            data: any(named: 'data'),
            options: any(named: 'options'),
          ),
        ).thenAnswer((_) {
          return completer.future;
        });
        await tester.pumpWidget(MaterialApp(home: ChatBotScreen()));
        await tester.pumpAndSettle();
        var textfaild = find.byType(ChatMessageInputBar);
        await tester.enterText(textfaild, 'Hi Mafdy');
        await tester.pumpAndSettle();
        var send_icon = find.byKey(const Key('Send_Icon'));
        await tester.tap(send_icon);
        await tester.pump(const Duration(milliseconds: 500));
        expect(find.byType(DotIndicator), findsOneWidget);
        await tester.enterText(textfaild, 'New message');
        await tester.tap(send_icon, warnIfMissed: false);
        await tester.pump();
        verify(
          () => apiClientserviceMock.post(
            any(),
            data: any(named: 'data'),
            options: any(named: 'options'),
          ),
        ).called(1);
        expect(
          find.descendant(
            of: find.byType(FauilerBubble),
            matching: find.text('New message'),
          ),
          findsNothing,
        );
        completer.complete(_getSuccessResponse());
        await tester.pumpAndSettle();
      });
    });
  });
}
