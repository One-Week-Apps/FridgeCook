import 'package:flutter/widgets.dart';

class Product {
  final String name;
  final int quantity;
  final String image;

  Product(this.name, this.quantity, this.image);

  @override
  String toString() =>
      '$name, $quantity, $image';

  Product.fromJson(Map<String, dynamic> json)
    : name = json['name'],
      quantity = json['quantity'],
      image = json['image'];

  Map<String, dynamic> toJson() => {
        'name': this.name,
        'quantity': this.quantity,
        'image': this.image
      };
}
