import 'package:flutter/widgets.dart';
import 'package:fridge_cook/src/domain/entities/product.dart';

class Recipe {
  final String name;
  final List<String> ingredients;
  final List<String> directions;
  final String image;
  final List<Product> products;

  Recipe(this.name, this.ingredients, this.directions, this.image, this.products);

  @override
  String toString() =>
      '$name, $ingredients, $directions, $image, $products';
}
