import 'package:fridge_cook/src/domain/entities/product.dart';
import 'package:fridge_cook/src/domain/entities/product_category.dart';

import '../../domain/entities/recipe.dart';
import '../../domain/repositories/recipes_repository.dart';
import 'package:flutter/cupertino.dart';

class DataRecipesRepository extends RecipesRepository {
  List<Recipe> recipes;
  static DataRecipesRepository _instance = DataRecipesRepository._internal();
  DataRecipesRepository._internal() {
    recipes = <Recipe>[];
    recipes.addAll([
      Recipe(
        "Orange Cake",
        ["ingredients"],
        ["directions"],
        "https://st.depositphotos.com/1000141/1941/i/600/depositphotos_19418467-stock-photo-ripe-orange-with-leaf.jpg",
        [
          Product(
            "Orange",
            1,
            ProductCategory.fruits,
            "https://st.depositphotos.com/1000141/1941/i/600/depositphotos_19418467-stock-photo-ripe-orange-with-leaf.jpg",
          ),
        ],
      ),
    ]);
  }
  factory DataRecipesRepository() => _instance;

  @override
  Future<List<Recipe>> getAllRecipes(List<Product> products) async {
    return recipes;
  }
}
