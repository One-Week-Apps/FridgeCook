import 'package:fridge_cook/src/domain/entities/product.dart';
import 'package:fridge_cook/src/domain/entities/product_category.dart';
import 'package:fridge_cook/src/domain/entities/product_quantity.dart';

import '../../domain/entities/recipe.dart';
import '../../domain/repositories/recipes_repository.dart';

class DataRecipesRepository extends RecipesRepository {
  late List<Recipe> recipes;
  static final DataRecipesRepository _instance = DataRecipesRepository._internal();
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
            ProductQuantity(1),
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
