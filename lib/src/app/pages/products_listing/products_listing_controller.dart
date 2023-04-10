import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:fridge_cook/src/app/CustomImages.dart';
import 'package:fridge_cook/src/domain/entities/product.dart';

import 'products_listing_presenter.dart';

import 'package:fridge_cook/main.dart';

class ProductsListingController extends Controller {
  int _counter = 0;
  List<Product> _products = [];
  
  // data used by the View
  int get counter => _counter;
  List<Product> get products => _products;
  
  final ProductsListingPresenter presenter;
  // Presenter should always be initialized this way
  ProductsListingController(productsRepo, productFetcher)
      : _counter = 0,
        presenter = ProductsListingPresenter(productsRepo, productFetcher),
        super();

  @override
  // this is called automatically by the parent class
  void initListeners() {

    presenter.getAllProductsOnNext = (List<Product> products) {
      print(products.toString());
      _products = products;
      refreshUI();
    };

    presenter.addProductOnNext = (bool isAdded) {
      // as a mutation occured products list must be updated
      this.getAllProducts();
    };

    presenter.deleteProductOnNext = (bool isDeleted) {
      // as a mutation occured products list must be updated
      this.getAllProducts();
    };
  }

  void getAllProducts() => presenter.getAllProducts();
  void addProduct(String value) => presenter.addProduct(value);
  void deleteProduct(String value) => presenter.deleteProduct(value);
  void deleteOne(String value) => presenter.deleteOne(value);

  @override
  void onResumed() {
    print("On resumed");
    super.onResumed();
  }

  @override
  void onDisposed() {
    presenter.dispose();
    super.onDisposed();
  }
}
