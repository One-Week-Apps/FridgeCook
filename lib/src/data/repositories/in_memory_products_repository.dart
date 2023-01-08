import 'package:fridge_cook/src/domain/entities/product.dart';
import 'package:fridge_cook/src/domain/repositories/products_repository.dart';

class InMemoryProductsRepository extends ProductsRepository {
  List<Product> products;
  InMemoryProductsRepository(this.products);
  
  @override
  Future<List<Product>> getAllProducts() async {
    return products;
  }
  
}
