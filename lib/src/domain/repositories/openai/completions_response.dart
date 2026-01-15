import 'dart:convert';

import 'package:http/http.dart';

/// Represents a response received from the OpenAI completions endpoint.
///
/// The OpenAI completions endpoint, including its response format, is
/// defined on the OpenAI developer site: (https://beta.openai.com/docs/api-reference/completions/create)[https://beta.openai.com/docs/api-reference/completions/create?lang=curl].
/// This class is used to serialize the response from the completions
/// endpoint. The response has the format,
///
///   {
///     "id": "cmpl-uqkvlQyYK7bGYrRHQ0eXlWi7",
///     "object": "text_completion",
///     "created": 1589478378,
///     "model": "text-curie-001",
///     "choices": [
///       {
///         "text": "\n\nThis is a test",
///         "index": 0,
///         "logprobs": null,
///         "finish_reason": "length"
///       }
///     ],
///     "usage": {
///       "prompt_tokens": 5,
///       "completion_tokens": 6,
///       "total_tokens": 11
///     }
///   }
class CompletionsResponse {
  final String id;
  final String object;
  final int created;
  final String model;
  final List<dynamic> choices; // This list contains the completions
  final Map<String, dynamic> usage;
  final int promptTokens;
  final int completionTokens;
  final int totalTokens;
  final String firstCompletion;
  final List<String> completions;

  const CompletionsResponse({
    required this.id,
    required this.object,
    required this.created,
    required this.model,
    required this.choices,
    required this.usage,
    required this.promptTokens,
    required this.completionTokens,
    required this.totalTokens,
    required this.firstCompletion,
    required this.completions,
  });

  /// Returns a [CompletionResponse] from the JSON obtained from the
  /// completions endpoint.
  factory CompletionsResponse.fromResponse(Response response) {
    // Get the response body in JSON format
    var responseBody = json.decode(response.body);

    // Parse out information from the response
    var usage = responseBody['usage'];

    // Parse out the choices
    var choices = responseBody['choices'];

    // Get the text for the different completions
    print("choices = " + choices.runtimeType.toString());

    List<String> completions = [];
    for (var choice in choices) {
      completions.add(choice['text']);
    }
    String firstCompletion = completions[0];

    return CompletionsResponse(
      id: responseBody['userId'],
      object: responseBody['id'],
      created: responseBody['title'],
      model: responseBody['model'],
      choices: choices,
      usage: usage,
      promptTokens: usage['prompt_tokens'],
      completionTokens: usage['completion_tokens'],
      totalTokens: usage['total_tokens'],
      firstCompletion: firstCompletion,
      completions: completions,
    );
  }
}