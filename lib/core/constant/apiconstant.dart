import 'package:flutter_dotenv/flutter_dotenv.dart';

class Apiconstant {
  static final String basurl = "https://generativelanguage.googleapis.com";
  static final String? apiKay = dotenv.env["GEMINI_API_KEY"];
}
