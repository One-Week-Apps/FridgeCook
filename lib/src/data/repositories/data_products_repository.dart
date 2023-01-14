import '../../domain/entities/product.dart';
import '../../domain/repositories/products_repository.dart';
import 'package:flutter/cupertino.dart';

class DataProductsRepository extends ProductsRepository {
  List<Product> products;
  static DataProductsRepository _instance = DataProductsRepository._internal();
  DataProductsRepository._internal() {
    products = <Product>[];
    products.addAll([
      Product("Apple", 1, Image.network("https://media.istockphoto.com/id/184276818/fr/photo/pomme-rouge.jpg?s=612x612&w=0&k=20&c=yk9viCWt8_VHAvSvzPuqZI-A79xkestBMyCf1AEyhrc=")),
      Product("Orange", 1, Image.network("https://st.depositphotos.com/1000141/1941/i/600/depositphotos_19418467-stock-photo-ripe-orange-with-leaf.jpg")),
    ]);
  }
  factory DataProductsRepository() => _instance;

  @override
  Future<List<Product>> getAllProducts() async {
    return products;
  }
  
  @override
  Future<bool> add(Product product) {
    products.add(product);
  }
}
