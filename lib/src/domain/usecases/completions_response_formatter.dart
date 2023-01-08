import 'package:flutter/widgets.dart';
import 'package:fridge_cook/src/domain/entities/product.dart';
import 'package:fridge_cook/src/domain/entities/recipe.dart';

class CompletionsResponseFormatter {
  static const INGREDIENTS_TAG = "Ingredients:";
  static const DIRECTIONS_TAG = "Directions:";
  static final orderedListRegex = new RegExp(r"\n\n\d+. ");
  static const SEPARATOR_TAG = "\n\n";

  Recipe format(String response, String imageUrl, List<Product> products) {
    final trimmedResponse = response.trim();
    final splittedResponse = trimmedResponse.split(SEPARATOR_TAG);
    
    final recipeName = splittedResponse[0];

    final responseAfterIngredients = trimmedResponse.split(INGREDIENTS_TAG)[1].trim();
    final directionsResponseSplit = responseAfterIngredients.split(DIRECTIONS_TAG);
    final ingredients = directionsResponseSplit[0].split(SEPARATOR_TAG);
    ingredients.removeWhere((e) => e.isEmpty);

    final responseAfterDirections = directionsResponseSplit[1];
    final directions = responseAfterDirections.split(orderedListRegex);
    directions.removeWhere((e) => e.isEmpty);

    return Recipe(recipeName, ingredients, directions, Image.network(imageUrl), products);
  }
}