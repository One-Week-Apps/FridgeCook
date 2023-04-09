import 'package:fridge_cook/src/domain/entities/product.dart';
import 'package:fridge_cook/src/domain/entities/recipe.dart';
import 'package:fridge_cook/src/domain/repositories/recipes_repository.dart';

class InMemoryRecipesRepository extends RecipesRepository {
  List<Recipe> recipes;
  InMemoryRecipesRepository(this.recipes);
  
  @override
  Future<List<Recipe>> getAllRecipes(List<Product> products) async {
    return recipes;
  }
  
}
