import 'package:flutter/widgets.dart';

class Product {
  final String name;
  final int quantity;
  final Image image;

  Product(this.name, this.quantity, this.image);

  @override
  String toString() =>
      '$name, $quantity, $image';
}
