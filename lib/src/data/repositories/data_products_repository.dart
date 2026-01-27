import 'package:fridge_cook/src/domain/entities/product_category.dart';
import 'package:fridge_cook/src/domain/entities/product_quantity.dart';

import '../../domain/entities/product.dart';
import '../../domain/repositories/products_repository.dart';

class DataProductsRepository extends ProductsRepository {
  late List<Product> products;
  static final DataProductsRepository _instance = DataProductsRepository._internal();
  DataProductsRepository._internal() {
    products = <Product>[];
    products.addAll([
      Product("Apple", ProductQuantity(1), ProductCategory.fruits, "https://media.istockphoto.com/id/184276818/fr/photo/pomme-rouge.jpg?s=612x612&w=0&k=20&c=yk9viCWt8_VHAvSvzPuqZI-A79xkestBMyCf1AEyhrc="),
      Product("Orange", ProductQuantity(1), ProductCategory.fruits, "https://st.depositphotos.com/1000141/1941/i/600/depositphotos_19418467-stock-photo-ripe-orange-with-leaf.jpg"),
    ]);
  }
  factory DataProductsRepository() => _instance;

  @override
  Future<List<Product>> getAllProducts() async {
    return products;
  }

  @override
  Future<bool> add(Product product) async {
    try {
      products.firstWhere((element) => element.name == product.name);
      return false; // Product already exists
    } catch (e) {
      products.add(product);
      return true;
    }
  }

  @override
  Future<bool> delete(String id) async {
    try {
      products.firstWhere((element) => element.name == id);
      products.removeWhere((item) => item.name == id);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<Product?> getProduct(String id) async {
    try {
      return products.firstWhere((element) => element.name == id);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<bool> updateProduct(String id, ProductQuantity newQuantity) async {
    int index = products.indexWhere((element) => element.name == id);
    if (index == -1) {
      return false;
    }
    products[index] = Product(
      products[index].name,
      newQuantity,
      products[index].category,
      products[index].image,
    );
    return true;
  }
}
