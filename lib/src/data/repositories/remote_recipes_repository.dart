import 'package:fridge_cook/src/domain/entities/product.dart';
import 'package:fridge_cook/src/domain/entities/recipe.dart';
import 'package:fridge_cook/src/domain/repositories/openai/completions_api.dart';
import 'package:fridge_cook/src/domain/repositories/openai/create_image_api.dart';
import 'package:fridge_cook/src/domain/repositories/recipes_repository.dart';
import 'package:fridge_cook/src/domain/usecases/completions_response_formatter.dart';

class RemoteRecipesRepository extends RecipesRepository {
  RemoteRecipesRepository();
  
  @override
  Future<List<Recipe>> getAllRecipes(List<Product> products) async {
    List<String> forecastArray = await CompletionsApi.getForecast(products);
    var formatter = CompletionsResponseFormatter();

    List<Recipe> recipes = [];
    for(var forecast in forecastArray) {
      String recipeName = formatter.getRecipeName(forecast);
      if (recipes.map((e) => e.name).contains(recipeName)) {
        continue;
      }

      String imageUrl = await GenerationsApi.getForecast(recipeName);
      var recipe = formatter.format(forecast, imageUrl, products);
      
      recipes.add(recipe);
    }

    return recipes;
  }
}
