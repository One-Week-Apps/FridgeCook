import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:fridge_cook/src/app/CustomImages.dart';
import 'package:fridge_cook/src/domain/entities/product.dart';
import 'package:fridge_cook/src/domain/entities/product_category.dart';
import 'package:oktoast/oktoast.dart';

import 'products_listing_presenter.dart';

import 'package:fridge_cook/main.dart';

class ProductsListingController extends Controller {
  int _counter = 0;
  List<ProductCategory> _categories = [];
  List<Product> _products = [];
  List<Product> _filteredProducts = [];
  
  // data used by the View
  int get counter => _counter;
  List<ProductCategory> get productCategories => _categories;
  List<Product> get products => _filteredProducts;
  
  final ProductsListingPresenter presenter;
  // Presenter should always be initialized this way
  ProductsListingController(categoriesRepo, productsRepo, productFetcher)
      : _counter = 0,
        presenter = ProductsListingPresenter(categoriesRepo, productsRepo, productFetcher),
        super();

  void refreshUI() {
    super.refreshUI();
  }

  @override
  // this is called automatically by the parent class
  void initListeners() {

    presenter.getAllCategoriesOnNext = (List<ProductCategory> categories) {
      print(categories.toString());
      _categories = categories;
      // do not refresh UI yet as it will be refreshed once products have been fetched
    };

    presenter.getAllProductsOnNext = (List<Product> products) {
      print(products.toString());
      _products = products;
      refreshUI();
    };

    presenter.addProductOnNext = (bool isAdded) {
      if (isAdded) {
        // as a mutation occured products list must be updated
        this.getAllProducts();
      } else {
        showToast("Sorry, we cannot add this ingredient...");
      }
    };

    presenter.deleteProductOnNext = (bool isDeleted) {
      if (isDeleted) {
        // as a mutation occured products list must be updated
        this.getAllProducts();
      } else {
        showToast("Sorry, we cannot delete this ingredient...");
      }
    };
  }

  void getAllCategories() => presenter.getAllCategories();
  void getAllProducts() => presenter.getAllProducts();
  String productCategoryName(int index) {
    if (index < 0 || index >= _categories.length) {
      return "All items";
    }

    return _categories[index].name;
  }
  void filter(ProductCategory category) {
    _filteredProducts = _products.where((product) => product.category.name == category.name).toList();
    refreshUI();
  }
  void disableFilters() {
    _filteredProducts = _products;
    refreshUI();
  }
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
