import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../entities/recipe.dart';
import '../repositories/recipes_repository.dart';

class GetAllRecipesUseCase
    extends UseCase<GetAllRecipesUseCaseResponse, GetAllRecipesUseCaseParams> {
  final RecipesRepository recipesRepository;

  GetAllRecipesUseCase(this.recipesRepository);

  @override
  Future<Stream<GetAllRecipesUseCaseResponse>> buildUseCaseStream(
      GetAllRecipesUseCaseParams params) async {
    final StreamController<GetAllRecipesUseCaseResponse> controller =
        StreamController();
    try {
      // get products
      List<Recipe> recipes = await recipesRepository.getAllRecipes();
      controller.add(GetAllRecipesUseCaseResponse(recipes));
      logger.finest('GetRecipesUseCase successful.');
      controller.close();
    } catch (e) {
      logger.severe('GetRecipesUseCase unsuccessful.');
      controller.addError(e);
    }
    return controller.stream;
  }
}

class GetAllRecipesUseCaseParams {
  int count;
  GetAllRecipesUseCaseParams(this.count);
}

class GetAllRecipesUseCaseResponse {
  List<Recipe> recipes;
  GetAllRecipesUseCaseResponse(this.recipes);
}
