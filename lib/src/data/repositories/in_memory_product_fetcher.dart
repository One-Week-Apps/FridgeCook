import 'package:fridge_cook/src/domain/entities/product.dart';
import 'package:fridge_cook/src/domain/repositories/product_fetcher.dart';

class InMemoryProductFetcher extends ProductFetcher {
  Product product;
  InMemoryProductFetcher(this.product);

  @override
  Future<Product> fetchProduct(String id) async {
    return product;
  }
}
