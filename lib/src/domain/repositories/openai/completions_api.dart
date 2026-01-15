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
  static const String FORECASTS_SEPARATOR_KEY = "#";

  static Future<String> getCategory(String prompt, List<String> categories) async {

    CompletionsRequest request = CompletionsRequest(
      model: OpenAIModel.model(OpenAIModels.textDavinci002).identifier,
      prompt: "Given the following categories: ${categories.join(", ")}. Which category is $prompt ? Answer in one lowercased word.",
      maxTokens: 10,
      temperature: 0,
      topP: 1,
      n: 1,
      stream: false,
      longprobs: 0,
      stop: '',
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

    final completion = completionsResponse.firstCompletion?.trim()?.toLowerCase() ?? '';

    return completion;
  }

  static Future<bool> isIngredient(String prompt) async {

    CompletionsRequest request = CompletionsRequest(
      model: OpenAIModel.model(OpenAIModels.textDavinci002).identifier,
      prompt: "Q: Is banana an ingredient?\ntrue\n\nQ: Is apple an ingredient?\ntrue\n\nQ: Is chair an ingredient?\nfalse\n\nQ: Is eggs an ingredient?\ntrue\n\nQ: Is Marylin Monroe and ingredient?\nfalse\n\nQ: Is fridge an ingredient?\nfalse\n\nQ: Is people an ingredient?\nfalse\n\nQ: Is atom an ingredient?\nfalse\n\nQ: Is bear an ingredient?\nfalse\n\nQ: Is tv an ingredient?\nfalse\n\nQ: Is berry an ingredient?\ntrue\n\nQ: Is $prompt an ingredient?\nA:",
      maxTokens: 10,
      temperature: 0,
      topP: 1,
      n: 1,
      stream: false,
      longprobs: 0,
      stop: '',
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

    final completion = completionsResponse.firstCompletion?.trim()?.toLowerCase() ?? '';

    return completion.contains('true') || completion.contains('yes');
  }

  static Future<List<String>> getForecast(List<Product> products) async {
    final prefs = await SharedPreferences.getInstance();

    String? storedForecast = prefs.getString(key);

    if (storedForecast != null) {
      return storedForecast.split(FORECASTS_SEPARATOR_KEY).map((e) => e.trim()).toList();
    }
    else {
      CompletionsResponse newForecast = await getNewForecast(products);
      if (newForecast.completions != null) {
        return newForecast.completions.map((e) => e.trim()).toList();
      } else {
        return [];
      }
    }
  }

  static Future<CompletionsResponse> getNewForecast(List<Product> products) async {

    final prompt = CompletionsRequestFormatter().format(products);
    CompletionsRequest request = CompletionsRequest(
      model: OpenAIModel.model(OpenAIModels.textDavinci002).identifier,
      prompt: prompt,
      maxTokens: 3400,
      temperature: 0.4,
      topP: 1,
      n: 10,
      stream: false,
      longprobs: 0,
      stop: '',
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

    if (response.completions != null) {
      await prefs.setString(key, response.completions.join(FORECASTS_SEPARATOR_KEY));
    }
  }
}
