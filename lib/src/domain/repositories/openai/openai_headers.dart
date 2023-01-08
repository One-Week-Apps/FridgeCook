import 'package:fridge_cook/src/domain/repositories/openai/api_key.dart';

final Map<String, String> openAIHeaders = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $openAIApiKey',
  };