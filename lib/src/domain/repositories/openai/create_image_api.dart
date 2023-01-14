import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fridge_cook/src/domain/repositories/openai/openai_headers.dart';
import 'package:fridge_cook/src/domain/repositories/openai/create_image_request.dart';
import 'package:fridge_cook/src/domain/repositories/openai/create_image_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GenerationsApi {
  static final Uri generationsEndpoint =
      Uri.parse('https://api.openai.com/v1/images/generations');

  static Future<String> getForecast(String prompt) async {
    final prefs = await SharedPreferences.getInstance();

    String stored = prefs.getString(prompt);

    if (stored != null) {
      return stored.trim();
    }
    else {
      GenerationsResponse newForecast = await getNewGeneration(prompt);
      return newForecast.imageUrl?.trim();
    }
  }

  static Future<GenerationsResponse> getNewGeneration(String prompt) async {
    GenerationsRequest request = GenerationsRequest(
      prompt: prompt,
      n: 1,
      size: "512x512",
    );

    http.Response response = await http.post(generationsEndpoint,
        headers: openAIHeaders, body: request.toJson());

    debugPrint('Received OpenAI API response: ${response.body}');

    if (response.statusCode != 200) {
      debugPrint(
          'Failed to get a generation with status code, ${response.statusCode}');
    }

    GenerationsResponse generationsResponse =
        GenerationsResponse.fromResponse(response);

    save(request, generationsResponse);

    return generationsResponse;
  }

  static Future<void> save(GenerationsRequest request, GenerationsResponse response) async {
    final prefs = await SharedPreferences.getInstance();

    if (response.imageUrl != null) {
      String key = request.prompt;
      await prefs.setString(key, response.imageUrl);
    }
  }
}
