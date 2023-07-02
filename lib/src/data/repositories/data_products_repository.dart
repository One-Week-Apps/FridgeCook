import 'package:fridge_cook/src/domain/entities/product_category.dart';

import '../../domain/entities/product.dart';
import '../../domain/repositories/products_repository.dart';
import 'package:flutter/cupertino.dart';

class DataProductsRepository extends ProductsRepository {
  List<Product> products;
  static DataProductsRepository _instance = DataProductsRepository._internal();
  DataProductsRepository._internal() {
    products = <Product>[];
    products.addAll([
      Product("Apple", 1, ProductCategory.fruits, "https://media.istockphoto.com/id/184276818/fr/photo/pomme-rouge.jpg?s=612x612&w=0&k=20&c=yk9viCWt8_VHAvSvzPuqZI-A79xkestBMyCf1AEyhrc="),
      Product("Orange", 1, ProductCategory.fruits, "https://st.depositphotos.com/1000141/1941/i/600/depositphotos_19418467-stock-photo-ripe-orange-with-leaf.jpg"),
    ]);
  }
  factory DataProductsRepository() => _instance;

  @override
  Future<List<Product>> getAllProducts() async {
    return products;
  }
  
  @override
  Future<bool> add(Product product) async {
    
    Product existingProduct;

    try {
      existingProduct = products.firstWhere((element) => element.name == product.name);
    } catch (e) {
      existingProduct = null;
    }

    if(existingProduct != null) {
      return false;
    }

    products.add(product);
    return true;
  }

  Future<bool> delete(String id) async {
    
    Product existingProduct;

    try {
      existingProduct = products.firstWhere((element) => element.name == id);
    } catch (e) {
      existingProduct = null;
    }

    if(existingProduct == null) {
      return false;
    }

    products.removeWhere((item) => item.name == id);
    return true;
  }
  
  @override
  Future<Product> getProduct(String id) async {
    Product existingProduct;

    try {
      existingProduct = products.firstWhere((element) => element.name == id);
    } catch (e) {
      existingProduct = null;
    }

    return existingProduct;
  }

  @override
  Future<bool> updateProduct(String id, int newQuantity) async {
    int index = products.indexWhere((element) => element.name == id);
    products[index] = Product(products[index].name, newQuantity, products[index].category, products[index].image);
    return true;
  }
}
