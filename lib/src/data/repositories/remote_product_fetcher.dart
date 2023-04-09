import 'package:fridge_cook/src/domain/entities/product.dart';
import 'package:fridge_cook/src/domain/repositories/openai/create_image_api.dart';
import 'package:fridge_cook/src/domain/repositories/product_fetcher.dart';

class RemoteProductFetcher extends ProductFetcher {
  RemoteProductFetcher();

  @override
  Future<Product> fetchProduct(String id) async {
    var imageUrl = await GenerationsApi.getForecast(id);
    return Product(id, 1, imageUrl);
  }
}
