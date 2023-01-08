import 'package:fridge_cook/src/domain/entities/recipe.dart';

abstract class RecipesRepository {
  Future<List<Recipe>> getAllRecipes();
}
