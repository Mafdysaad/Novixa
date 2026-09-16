import 'package:ai_chat_bot/models/chat_message_model/chat_message_model.dart';
import 'package:ai_chat_bot/models/chat_message_model/content.dart';
import 'package:ai_chat_bot/services/clientserves/api_clinetservice.dart';
import 'package:ai_chat_bot/services/clientserves/gemini_chat_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class ApiclientMoking extends Mock implements ApiClientService {}

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
  WidgetsFlutterBinding.ensureInitialized();
  late ApiclientMoking apickintMoking;
  late GeminiChatService geminiChatService;
  await dotenv.load(fileName: 'assets/env/.env');
  setUp(() {
    apickintMoking = ApiclientMoking();
    geminiChatService = GeminiChatService(client: apickintMoking);
  });
  group('Retry  logic ', () {
    test('success on first ateempt', () async {
      when(
        () => apickintMoking.post(
          any(),
          data: any(named: 'data'),
          options: any(named: 'options'),
        ),
      ).thenAnswer((_) => _getSuccessResponse());
      var result = await geminiChatService.sendMessage(input: []);
      int callcount = verify(
        () => apickintMoking.post(
          any(),
          data: any(named: 'data'),
          options: any(named: 'options'),
        ),
      ).callCount;
      expect(callcount, 1);
      expect(result, isA<ChatMessageModel>());
    });

    test(
      'failed on first attempt but successed on second attempt => retryable exception',
      () async {
        int count = 0;
        when(
          () => apickintMoking.post(
            any(),
            data: any(named: 'data'),
            options: any(named: 'options'),
          ),
        ).thenAnswer((_) {
          count++;
          if (count == 1) {
            throw _getretryableExaption();
          }
          return _getSuccessResponse();
        });
        var result = await geminiChatService.sendMessage(input: []);
        int callcount = verify(
          () => apickintMoking.post(
            any(),
            data: any(named: 'data'),
            options: any(named: 'options'),
          ),
        ).callCount;
        expect(callcount, 2);
        expect(result, isA<ChatMessageModel>());
      },
    );

    test(
      'failed on first attempt and cannot be retried => non-retryable exception ',
      () async {
        when(
          () => apickintMoking.post(
            any(),
            data: any(named: 'data'),
            options: any(named: 'options'),
          ),
        ).thenAnswer((_) {
          throw _getnonretryableExaption();
        });
        await expectLater(
          () => geminiChatService.sendMessage(input: []),
          throwsA(isA<DioException>()),
        );
        int callcount = verify(
          () => apickintMoking.post(
            any(),
            data: any(named: 'data'),
            options: any(named: 'options'),
          ),
        ).callCount;
        expect(callcount, 1);
      },
    );
  });
}
