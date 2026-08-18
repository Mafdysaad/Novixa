import 'package:ai_chat_bot/repositories/chat_repository.dart';
import 'package:ai_chat_bot/repositories/gemini_chat_repository.dart';
import 'package:ai_chat_bot/services/clientserves/api_clinetservice.dart';
import 'package:ai_chat_bot/services/clientserves/gemini_chat_service.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;
Future<void> setup() async {
  //core
  getIt.registerLazySingleton<Dio>(
    () =>
        Dio(BaseOptions(baseUrl: 'https://generativelanguage.googleapis.com')),
  );
  getIt.registerLazySingleton<ApiClientService>(
    () => ApiClientService(dio: getIt<Dio>()),
  );

  //Gemini service
  getIt.registerLazySingleton<GeminiChatService>(
    () => GeminiChatService(client: getIt<ApiClientService>()),
  );
  getIt.registerLazySingleton<ChatRepository>(
    () => GeminiChatRepository(geminiChatService: getIt<GeminiChatService>()),
  );
}
