import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:fridge_cook/src/app/pages/products_listing/products_listing_controller.dart';
import 'package:fridge_cook/src/app/pages/recipes_listing/recipes_listing_presenter.dart';
import 'package:fridge_cook/src/domain/entities/product.dart';
import 'package:fridge_cook/src/domain/entities/recipe.dart';

class RecipesListingController extends Controller {
  List<Recipe> _recipes = [];
  
  // data used by the View
  List<Recipe> get recipes => _recipes;
  
  final RecipesListingPresenter presenter;
  final ProductsListingController productsListingController;
  // Presenter should always be initialized this way
  RecipesListingController(productsRepo, productsListingController)
      : presenter = RecipesListingPresenter(productsRepo),
        productsListingController = productsListingController,
        super();

  @override
  // this is called automatically by the parent class
  void initListeners() {

    presenter.getAllRecipesOnNext = (List<Recipe> recipes) {
      print('UI refreshed with recipes: ' + recipes.toString());
      _recipes = recipes;
      
      // As the same view is used for both products and recipes screen,
      // we call refresh UI on the products controller which is binded to the view
      print("DEBUG_SESSION Waiting");
      asyncFunction().then((val) {
        print("DEBUG_SESSION Waiting End");
        productsListingController.refreshUI();
      });
    };
  }

  Future<int> asyncFunction() async {
     await new Future.delayed(const Duration(seconds: 3));
     return 0;
  }

  void getAllRecipes(List<Product> products) => presenter.getAllRecipes(products);

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
