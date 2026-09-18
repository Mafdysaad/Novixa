import 'package:ai_chat_bot/core/service/service_locator.dart';
import 'package:ai_chat_bot/presentation/manger/cubit/send_message_cubit.dart';
import 'package:ai_chat_bot/repositories/gemini_chat_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class fackGeminiChatRepository extends Mock implements GeminiChatRepository {}

void main() {
  late fackGeminiChatRepository fackgeminchatrepository;
  setUp(() {
    fackgeminchatrepository = fackGeminiChatRepository();
    getIt.reset();
    getIt.registerSingleton<GeminiChatRepository>(fackgeminchatrepository);
    getIt.registerFactory<SendMessageCubit>(
      () => SendMessageCubit(repository: getIt.get<GeminiChatRepository>()),
    );
  });
  group('send message flow', () {});
}
