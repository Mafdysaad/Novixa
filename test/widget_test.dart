// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:ai_chat_bot/models/chat_message_model/chat_message_model.dart';
import 'package:ai_chat_bot/models/chat_message_model/content.dart';
import 'package:ai_chat_bot/models/chat_message_model/step.dart';
import 'package:ai_chat_bot/models/chat_message_model/usage.dart';
import 'package:ai_chat_bot/repositories/gemini_chat_repository.dart';
import 'package:ai_chat_bot/services/clientserves/gemini_chat_service.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:mocktail/mocktail.dart';

class geminichatservsesmock extends Mock implements GeminiChatService {}

ChatMessageModel _getChatMessageModel() => ChatMessageModel(
  id: '1',
  status: 'good',
  usage: Usage(totalTokens: 10),
  steps: [
    Step(
      type: 'dsd',
      content: [Content(type: 'text', text: 'hellow')],
    ),
  ],
  object: 'ehds',
  model: 'dsjds',
);

void main() {
  late GeminiChatRepository geminiChatRepository;
  late geminichatservsesmock geminichatservesmock;
  setUp(() {
    geminichatservesmock = geminichatservsesmock();
    geminiChatRepository = GeminiChatRepository(
      geminiChatService: geminichatservesmock,
    );
  });
  group('vildation logic in send message', () {
    test('messge length doesn\'t change if length is less than 20', () async {
      // moking the request
      when(
        () => geminichatservesmock.sendMessage(input: any(named: 'input')),
      ).thenAnswer(
        (_) async => _getChatMessageModel(),
      ); // return chatmessageModel
      // generate List of Content to mocking the param of the function
      var messages = List.generate(
        19,
        (index) => Content(text: 'h1', type: 'text'),
      );
      //calling the rual request to trigger the request and test the code
      var result = await geminiChatRepository.sendMessage(messages);
      // catch inter param of the inner function inside the request
      var Captured =
          verify(
                () => geminichatservesmock.sendMessage(
                  input: captureAny(named: 'input'),
                ),
              ).captured.first
              as List<Content>;
      // comparing between the actual value and expected value
      expect(Captured.length, equals(messages.length));
    });
    test('messge length change if length is greater than 20', () async {
      // moking the request
      when(
        () => geminichatservesmock.sendMessage(input: any(named: 'input')),
      ).thenAnswer(
        (_) async => _getChatMessageModel(),
      ); // return chatmessageModel
      // generate List of Content to mocking the param of the function
      var messages = List.generate(
        30,
        (index) => Content(text: 'h1', type: 'text'),
      );
      //calling the rual request to trigger the request and test the code
      var result = await geminiChatRepository.sendMessage(messages);
      // catch inter param of the inner function inside the request
      var Captured =
          verify(
                () => geminichatservesmock.sendMessage(
                  input: captureAny(named: 'input'),
                ),
              ).captured.first
              as List<Content>;
      // comparing between the actual value and expected value
      expect(Captured.length, equals(5));
    });
  });
}
