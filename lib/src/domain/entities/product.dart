import 'package:flutter/widgets.dart';

class Product {
  final String name;
  final int quantity;
  final Image image;

  Product(this.name, this.quantity, this.image);

  @override
  String toString() =>
      '$name, $quantity, $image';

  Product.fromJson(Map<String, dynamic> json)
    : name = json['id'],
      quantity = json['quantity'],
      image = Image.network(json['image']);

  Map<String, dynamic> toJson() => {
        'id': 0,
        'dateTime': 0,
        'score': [
        ]
      };
}
