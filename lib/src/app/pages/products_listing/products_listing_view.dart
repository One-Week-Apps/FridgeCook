import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:math';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
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
  _ProductsListingRouteState createState() => _ProductsListingRouteState();
}

class _ProductsListingRouteState extends ViewState<ProductsListingRoute, ProductsListingController>
    with SingleTickerProviderStateMixin {
    _ProductsListingRouteState()
      : super(ProductsListingController(DataProductsRepository()));

  Widget _refreshProductsButton() {
    var controller = FlutterCleanArchitecture.getController<ProductsListingController>(context);
    return FloatingActionButton(
      heroTag: "refreshProductsButton",
      backgroundColor: Colors.black,
      onPressed: () {
        controller.flushProductsButtonPressed();
      },
      tooltip: 'Flush Salsa Products',
      child: Icon(Icons.refresh),
    );
  }

  Widget _productTableViewCell(int index, Product item) {
    var controller = FlutterCleanArchitecture.getController<ProductsListingController>(context);
    var move = controller.products[index];
    print("move[${index.toString()}] = $move");
    var thumbnailWidth = MediaQuery.of(context).size.width - 100;
    var thumbnail = Image.network(move.thumbnailUrlString, width: thumbnailWidth, height: thumbnailWidth * 360 / 480);

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
                          Text('\n' + move.name,
                              style: GoogleFonts.montserrat(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900)),
                          Spacer(
                            flex: 1,
                          ),
                          Image.asset(
                  move.isLiked ? CustomImages.like : CustomImages.dislike,
                  width: 20,
                  height: 20,
                )
              ],
                      ),
                      Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Difficulty: ${move.difficulty} over 5",
                            textAlign: TextAlign.left,
                          )),
                      Text(" "),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          move.description.substring(0, min(200, move.description.length - 1)) + "...\n"))
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.pushNamed(
                    context, 
                    RecipesDetailsRoute.routeName,
                    arguments: move
                  );
                },
              );
  }

  Widget _ratePerformanceButton() {
    var controller = FlutterCleanArchitecture.getController<ProductsListingController>(context);
    return FloatingActionButton(
      heroTag: "ratePerformanceButton",
      backgroundColor: Colors.black,
      onPressed: () {
        controller.ratePerformanceButtonPressed(context);
      },
      tooltip: 'Flush Salsa Products',
      child: Icon(Icons.done),
    );
  }

  var _doOnce = true;
  @override
  Widget get view => buildPage();

  Widget buildPage() {
    var controller = FlutterCleanArchitecture.getController<ProductsListingController>(context);

    if (_doOnce) {
      _doOnce = false;
      controller.getAllProducts();
    }

    var children = <Widget>[
      for (var i = 0 ; i < controller.products.length ; i++) _productTableViewCell(i, controller.products[i])
    ];

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: Container(width: 200, padding: EdgeInsets.only(top: 100),
        child: Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[_refreshProductsButton(), SizedBox(width: 5), _ratePerformanceButton()]),
      ),
      appBar: AppBar(
        title: Text(
          'What\'s in your fridge? 🧑‍🍳',
          style: GoogleFonts.salsa(fontSize: 30),
        ),
        actions: <Widget>[
          IconButton(
            icon: Image.asset(CustomImages.trophy),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AchievementsRoute()),
              );
            },
          )
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
      )*/,),
    );
  }

}
