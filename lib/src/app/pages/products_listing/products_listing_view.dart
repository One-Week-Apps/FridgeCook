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

  Widget _productTableViewCell(int index, Product item) {
    var controller = FlutterCleanArchitecture.getController<ProductsListingController>(context);
    var product = controller.products[index];
    print("product[${index.toString()}] = $product");
    var thumbnailWidth = MediaQuery.of(context).size.width - 100;
    var thumbnail = product.image;//Image.network(product.thumbnailUrlString, width: thumbnailWidth, height: thumbnailWidth * 360 / 480);

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
                          Text('\n' + product.name,
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
                    arguments: product
                  );
                },
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
        child: Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[SizedBox(width: 5),]),
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
      body: Center(),
    );
  }

}
