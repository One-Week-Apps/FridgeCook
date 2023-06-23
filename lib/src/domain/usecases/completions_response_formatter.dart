import 'package:fridge_cook/src/domain/entities/product.dart';
import 'package:fridge_cook/src/domain/entities/recipe.dart';

class CompletionsResponseFormatter {
  static const NAME_TAG = "Name:";
  static const INGREDIENTS_TAG = "Ingredients:";
  static const INGREDIENTS_SEPARATOR_TAG = ", ";
  static const DIRECTIONS_TAG = "Recipe:";
  static final orderedListRegex = new RegExp(r"\n\d+. ");
  static const SEPARATOR_TAG = "\n\n";

  String getRecipeName(String response) {
    return response.trim().split(SEPARATOR_TAG)[0].split(NAME_TAG)[1].trim();
  }

  Recipe format(String response, String imageUrl, List<Product> products) {
    final trimmedResponse = response.trim();

    final recipeName = getRecipeName(response);

    final responseAfterIngredients = trimmedResponse.split(INGREDIENTS_TAG)[1].trim();
    final directionsResponseSplit = responseAfterIngredients.split(SEPARATOR_TAG + DIRECTIONS_TAG);
    final ingredients = directionsResponseSplit[0].split(INGREDIENTS_SEPARATOR_TAG);
    ingredients.removeWhere((e) => e.isEmpty || e.contains("\n"));

    final responseAfterDirections = directionsResponseSplit[1];
    final directions = responseAfterDirections.split(orderedListRegex);
    directions.removeWhere((e) => e.isEmpty || e.contains('\n'));

    return Recipe(recipeName, ingredients, directions, imageUrl, products);
  }
}