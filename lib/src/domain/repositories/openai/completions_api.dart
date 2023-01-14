import 'package:flutter/material.dart';
import 'package:fridge_cook/src/domain/entities/product.dart';
import 'package:fridge_cook/src/domain/usecases/completions_request_formatter.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:fridge_cook/src/domain/repositories/openai/openai_headers.dart';
import 'package:fridge_cook/src/domain/repositories/openai/completions_request.dart';
import 'package:fridge_cook/src/domain/entities/openai_models.dart';
import 'package:fridge_cook/src/domain/repositories/openai/completions_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CompletionsApi {
  static final Uri completionsEndpoint =
      Uri.parse('https://api.openai.com/v1/completions');

  static final String key = DateFormat.yMMMd().format(DateTime.now());

  static Future<String> getForecast(List<Product> products) async {
    final prefs = await SharedPreferences.getInstance();

    String storedForecast = prefs.getString(key);

    if (storedForecast != null) {
      return storedForecast.trim();
    }
    else {
      CompletionsResponse newForecast = await getNewForecast(products);
      return newForecast.firstCompletion?.trim();
    }
  }

  static Future<CompletionsResponse> getNewForecast(List<Product> products) async {

    final prompt = CompletionsRequestFormatter().format(products);
    CompletionsRequest request = CompletionsRequest(
      model: OpenAIModel.model(OpenAIModels.textDavinci002).identifier,
      prompt: prompt,
      maxTokens: 128,
      temperature: 0.9,
    );

    debugPrint('Sending OpenAI API request: $prompt');

    http.Response response = await http.post(completionsEndpoint,
        headers: openAIHeaders, body: request.toJson());

    debugPrint('Received OpenAI API response: ${response.body}');

    if (response.statusCode != 200) {
      debugPrint(
          'Failed to get a forecast with status code, ${response.statusCode}');
    }

    CompletionsResponse completionsResponse =
        CompletionsResponse.fromResponse(response);

    save(completionsResponse);

    return completionsResponse;
  }

  static Future<void> save(CompletionsResponse response) async {
    final prefs = await SharedPreferences.getInstance();

    if (response.firstCompletion != null) {
      await prefs.setString(key, response.firstCompletion);
    }
  }
}
