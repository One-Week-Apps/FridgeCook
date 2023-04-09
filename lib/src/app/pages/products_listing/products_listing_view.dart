import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:math';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:fridge_cook/src/app/pages/recipes_listing/recipes_listing_controller.dart';
import 'package:fridge_cook/src/data/repositories/data_recipes_repository.dart';
import 'package:fridge_cook/src/data/repositories/in_memory_product_fetcher.dart';
import 'package:fridge_cook/src/data/repositories/in_memory_products_repository.dart';
import 'package:fridge_cook/src/data/repositories/remote_product_fetcher.dart';
import 'package:fridge_cook/src/data/repositories/remote_recipes_repository.dart';
import 'package:fridge_cook/src/data/repositories/shared_products_repository.dart';
import 'package:fridge_cook/src/domain/entities/recipe.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fridge_cook/src/app/CustomImages.dart';
import 'package:fridge_cook/src/app/pages/recipes_details/recipes_details_view.dart';
import 'package:fridge_cook/src/data/repositories/data_products_repository.dart';
import 'package:fridge_cook/src/domain/entities/product.dart';
import 'products_listing_controller.dart';

class ProductsListingRoute extends View {
  static const routeName = '/productsListing';
  ProductsListingRoute({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ProductsListingRouteState createState() => _ProductsListingRouteState(
    ProductsListingController(SharedPreferencesProductRepository(), RemoteProductFetcher()),
    RecipesListingController(RemoteRecipesRepository())
    );
}

class _ProductsListingRouteState extends ViewState<ProductsListingRoute, ProductsListingController>
    with SingleTickerProviderStateMixin {

      ProductsListingController controller;
      RecipesListingController recipesController;

    _ProductsListingRouteState(ProductsListingController controller, RecipesListingController recipesController)
      : this.controller = controller, this.recipesController = recipesController, super(controller);

  Widget _recipeTableViewCell(int index, Recipe item) {
    var recipe = item;
    print("recipe[${index.toString()}] = $recipe");
    var thumbnail = Image.network(recipe.image, width: 100, height: 100,);

    return InkWell(
                child: Container(
                  width: 356,
                  height: thumbnail.height,
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      // thumbnail,
                      Row(
                        children: <Widget>[
                          Text('\n' + recipe.name,
                              style: GoogleFonts.montserrat(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900)),
                          Spacer(
                            flex: 1,
                          ),
                          thumbnail,
                          // Spacer(flex: 1,),
                          // IconButton(
                          //   icon: Image.asset(CustomImages.trash),
                          //   onPressed: () {
                          //     print("deleting product $index");
                          //   },
                          // ),
                //           Image.asset(
                //   CustomImages.like,
                //   width: 20,
                //   height: 20,
                // )
              ],
                      ),
                      // Container(
                      //     alignment: Alignment.centerLeft,
                      //     child: Text(
                      //       "Difficulty: ${1} over 5",
                      //       textAlign: TextAlign.left,
                      //     )),
                      // Text(" "),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.pushNamed(
                    context, 
                    RecipesDetailsRoute.routeName,
                    arguments: recipe
                  );
                },
              );
  }

  String presentProductTitle(Product product) {
    String message = '\n' + product.name;
    if (product.quantity > 1) {
      message += ' (x${product.quantity})';
    }
    return message;  
  }

  Widget _productTableViewCell(int index, Product item) {
    //var controller = FlutterCleanArchitecture.getController<ProductsListingController>(context);
    var product = item;//Product("", 1, Image.network(""));// controller.products[index];
    print("product[${index.toString()}] = $product");
    var thumbnailWidth = MediaQuery.of(context).size.width / 2;
    var thumbnail = Image.network(product.image, width: thumbnailWidth, height: thumbnailWidth * 360 / 480);

    return InkWell(
                child: Container(
                  width: 356,
                  height: thumbnail.height,
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      // thumbnail,
                      Row(
                        children: <Widget>[
                          Text(presentProductTitle(product),
                              style: GoogleFonts.montserrat(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900)),
                          Spacer(
                            flex: 1,
                          ),
                          thumbnail,
                          // Spacer(flex: 1,),
                          IconButton(
                            icon: Image.asset(CustomImages.trash),
                            onPressed: () {
                              print("deleting product $index");
                              controller.deleteProduct(product.name);
                            },
                          ),
                //           Image.asset(
                //   CustomImages.like,
                //   width: 20,
                //   height: 20,
                // )
              ],
                      ),
                      // Container(
                      //     alignment: Alignment.centerLeft,
                      //     child: Text(
                      //       "Difficulty: ${1} over 5",
                      //       textAlign: TextAlign.left,
                      //     )),
                      // Text(" "),
                    ],
                  ),
                ),
                onTap: () {
                  // Navigator.pushNamed(
                  //   context, 
                  //   RecipesDetailsRoute.routeName,
                  //   arguments: product
                  // );
                },
              );
  }

  var _doOnce = true;
  int _selectedIndex = 0;
  @override
  Widget get view => buildPage();

  Widget productsListingView(ProductsListingController controller) {
    Widget bottomOverlayView = Align(
      alignment: Alignment.bottomCenter,
      child: Container(color: Colors.white, child: Padding(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16), child: TextFormField(onFieldSubmitted: (value) {
        print("Field submitted ! " + value);
        controller.addProduct(value);
      }, decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Add a product:',
            )),)),
    );

    var productsChildren = <Widget>[
      for (var i = 0 ; i < controller.products.length ; i++) _productTableViewCell(i, controller.products[i])
    ];
    Widget productsListingView = ListView(padding: const EdgeInsets.all(8), children: productsChildren);

    return Center(child: Stack(children: [productsListingView, bottomOverlayView]));
  }

  Widget recipesListingView() {
    var recipesChildren = <Widget>[
      for (var i = 0 ; i < recipesController.recipes.length ; i++) _recipeTableViewCell(i, recipesController.recipes[i])
    ];
    Widget recipesListingView = ListView(padding: const EdgeInsets.all(8), children: recipesChildren);
    return recipesListingView;
  }

  Widget buildPage() {
    if (_doOnce) {
      _doOnce = false;
      controller.getAllProducts();
    }

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: Container(width: 200, padding: EdgeInsets.only(top: 100),
        child: Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[SizedBox(width: 5),]),
      ),
      appBar: AppBar(
        title: Text(
          _selectedIndex == 0 ? 'What\'s in your fridge? 🧑‍🍳' : 'Recipes suggestions 🧑‍🍳',
          style: GoogleFonts.salsa(fontSize: 30),
        ),
      ),
      body: ControlledWidgetBuilder<ProductsListingController>(builder: (context, controller) {
        return _selectedIndex == 0 ? productsListingView(controller) : recipesListingView();
      }),
      bottomNavigationBar: BottomNavigationBar(
      currentIndex: _selectedIndex,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart),
          label: 'My Products',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.dinner_dining),
          label: 'My Recipes',
        ),
      ],
      onTap: (index) {
        print("selected index: $index");
        if (index == _selectedIndex) {
          return;
        }
        setState(() {
          _selectedIndex = index;
          if (index == 1) {
            recipesController.getAllRecipes(this.controller.products);
          }
        });
      },
  ),
    );
  }

}
