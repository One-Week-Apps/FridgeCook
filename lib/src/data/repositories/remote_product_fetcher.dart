import 'package:fridge_cook/src/domain/entities/product.dart';
import 'package:fridge_cook/src/domain/entities/product_category.dart';
import 'package:fridge_cook/src/domain/repositories/openai/completions_api.dart';
import 'package:fridge_cook/src/domain/repositories/openai/create_image_api.dart';
import 'package:fridge_cook/src/domain/repositories/product_fetcher.dart';

class RemoteProductFetcher extends ProductFetcher {
  RemoteProductFetcher();

  @override
  Future<Product?> fetchProduct(String id) async {
    bool isIngredient = await CompletionsApi.isIngredient(id);

    if (isIngredient == false) {
      return null;
    }

    String categoryString = await CompletionsApi.getCategory(id, ProductCategory.getValues());
    ProductCategory category = ProductCategory.fromName(categoryString);

    var imageUrl = await GenerationsApi.getForecast(id);
    return Product(id, 1, category, imageUrl);
  }
}
