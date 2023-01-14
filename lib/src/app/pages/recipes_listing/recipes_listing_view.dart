import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:math';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:fridge_cook/src/data/repositories/data_recipes_repository.dart';
import 'package:fridge_cook/src/domain/entities/recipe.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fridge_cook/src/app/CustomImages.dart';
import 'package:fridge_cook/src/app/pages/recipes_details/recipes_details_view.dart';
import 'package:fridge_cook/src/data/repositories/data_products_repository.dart';
import 'package:fridge_cook/src/domain/entities/product.dart';
import 'recipes_listing_controller.dart';

class RecipesListingRoute extends View {
  static const routeName = '/recipesListing';
  RecipesListingRoute({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _RecipesListingRouteState createState() => _RecipesListingRouteState();
}

class _RecipesListingRouteState extends ViewState<RecipesListingRoute, RecipesListingController>
    with SingleTickerProviderStateMixin {
    _RecipesListingRouteState()
      : super(RecipesListingController(DataRecipesRepository()));

  Widget _refreshRecipesButton() {
    var controller = FlutterCleanArchitecture.getController<RecipesListingController>(context);
    return FloatingActionButton(
      heroTag: "refreshRecipesButton",
      backgroundColor: Colors.black,
      onPressed: () {
        
      },
      tooltip: 'Flush Salsa Recipes',
      child: Icon(Icons.refresh),
    );
  }

  Widget _productTableViewCell(int index, Recipe item) {
    var controller = FlutterCleanArchitecture.getController<RecipesListingController>(context);
    var recipe = controller.recipes[index];
    print("recipe[${index.toString()}] = $recipe");
    var thumbnailWidth = MediaQuery.of(context).size.width - 100;
    var thumbnail = recipe.image;//Image.network(, width: thumbnailWidth, height: thumbnailWidth * 360 / 480);

    return InkWell(
                child: Container(
                  width: 356,
                  height: 500,
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      thumbnail,
                      Row(
                        children: <Widget>[
                          Text('\n' + recipe.name,
                              style: GoogleFonts.montserrat(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900)),
                          Spacer(
                            flex: 1,
                          ),
                          Image.asset(
                  CustomImages.like,
                  width: 20,
                  height: 20,
                )
              ],
                      ),
                      Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Difficulty: ${1} over 5",
                            textAlign: TextAlign.left,
                          )),
                      Text(" "),
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

  var _doOnce = true;
  @override
  Widget get view => buildPage();

  Widget buildPage() {
    var controller = FlutterCleanArchitecture.getController<RecipesListingController>(context);

    if (_doOnce) {
      _doOnce = false;
      controller.getAllRecipes();
    }

    var children = <Widget>[
      for (var i = 0 ; i < controller.recipes.length ; i++) _productTableViewCell(i, controller.recipes[i])
    ];

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: Container(width: 200, padding: EdgeInsets.only(top: 100),
        child: Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[_refreshRecipesButton(), SizedBox(width: 5),]),
      ),
      appBar: AppBar(
        title: Text(
          'What\'s in your fridge? 🧑‍🍳',
          style: GoogleFonts.salsa(fontSize: 30),
        ),
        actions: <Widget>[
        ],
        bottom: TabBar(
          tabs: [
            Tab(child: Text('My ingredients')),
            Tab(child: Text('My recipes')),
          ],
        ),
      ),
      body: Center(
        child:
            GridView.count(
          crossAxisCount: 3,
          children: [Center(
              child: Text(""),
            )],/*List.generate(100, (index) {
            return Center(
              child: Text(
                'Item $index',
                style: Theme.of(context).textTheme.headline5,
              ),
            );
          })*/
        ),/*ListView(
                padding: const EdgeInsets.all(8)
                    .add(EdgeInsets.only(top: 100))
                    .add(EdgeInsets.only(bottom: 50)),
                children: children,
      )*/),
    );
  }

}
