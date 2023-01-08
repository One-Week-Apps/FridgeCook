import 'dart:convert';

/// Represents the parameters used in the body of a request to the OpenAI
/// generations endpoint.
///
/// The OpenAI completions endpoint is defined on the OpenAI developer site:
/// (https://beta.openai.com/docs/api-reference/generations/create)[https://beta.openai.com/docs/api-reference/generations/create?lang=curl].
/// This class is used to represent the parameters passed to the endpoint
/// in the body of the REST API request. The body has the format,
///
///   {
///     "prompt": "A cute baby sea otter",
///     "n": 2,
///     "size": "1024x1024"
///   }
class GenerationsRequest {
  final String prompt;
  final int? n;
  final String? size;

  GenerationsRequest({
    this.prompt,
    this.n,
    this.size,
  });

  String toJson() {
    Map<String, dynamic> jsonBody = {
      'prompt': prompt,
      'n': n,
      'size': size,
    };

    if (n != null) {
      jsonBody.addAll({'n': n});
    }

    if (size != null) {
      jsonBody.addAll({'size': size});
    }

    return json.encode(jsonBody);
  }
}