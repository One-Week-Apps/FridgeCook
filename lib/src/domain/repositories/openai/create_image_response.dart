import 'dart:convert';

import 'package:http/http.dart';

/// Represents a response received from the OpenAI generations endpoint.
///
/// The OpenAI generations endpoint, including its response format, is
/// defined on the OpenAI developer site: (https://beta.openai.com/docs/api-reference/images/create)[https://beta.openai.com/docs/api-reference/images/create?lang=curl].
/// This class is used to serialize the response from the generations
/// endpoint. The response has the format,
///
///   {
///     "created": 1589478378,
///     "data": [
///       {
///         "url": "https://..."
///       },
///       {
///         "url": "https://..."
///       }
///     ]
///   }

class GenerationsResponse {
  final int? created;
  final Map<String, dynamic>? data;
  final String? imageUrl;

  const GenerationsResponse({
    this.created,
    this.data,
    this.imageUrl,
  });

  factory GenerationsResponse.fromResponse(Response response) {
    Map<String, dynamic> responseBody = json.decode(response.body);

    Map<String, dynamic> data = responseBody['data'];

    String imageUrl = data[0]['url'];

    return GenerationsResponse(
      created: responseBody['created'],
      imageUrl: imageUrl,
    );
  }
}