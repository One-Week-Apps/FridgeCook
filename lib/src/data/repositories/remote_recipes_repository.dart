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
    String forecast = await CompletionsApi.getForecast(products);
    var formatter = CompletionsResponseFormatter();
    String recipeName = formatter.getRecipeName(forecast);
    String imageUrl = await GenerationsApi.getForecast(recipeName);
    var recipe = formatter.format(forecast, imageUrl, products);
    return [recipe];
  }
}
