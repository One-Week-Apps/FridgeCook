import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:fridge_cook/src/app/CustomImages.dart';
import 'package:fridge_cook/src/app/pages/recipes_listing/recipes_listing_presenter.dart';
import 'package:fridge_cook/src/domain/entities/product.dart';
import 'package:fridge_cook/src/domain/entities/recipe.dart';

import 'package:fridge_cook/main.dart';

class RecipesListingController extends Controller {
  int _counter;
  List<Recipe> _recipes;
  
  // data used by the View
  int get counter => _counter;
  List<Recipe> get recipes => _recipes;
  
  final RecipesListingPresenter presenter;
  // Presenter should always be initialized this way
  RecipesListingController(productsRepo)
      : _counter = 0,
        presenter = RecipesListingPresenter(productsRepo),
        super();

  @override
  // this is called automatically by the parent class
  void initListeners() {

    presenter.getAllRecipesOnNext = (List<Recipe> recipes) {
      print(recipes.toString());
      _recipes = recipes;
      refreshUI();
    };
  }

  void getAllRecipes() => presenter.getAllRecipes();

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
