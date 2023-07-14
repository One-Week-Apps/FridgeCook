import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:fridge_cook/main.dart';
import 'package:fridge_cook/src/app/pages/loader/loader_view.dart';
import 'package:fridge_cook/src/app/pages/onboarding/onboarding_view.dart';
import 'package:fridge_cook/src/app/pages/recipes_listing/recipes_listing_controller.dart';
import 'package:fridge_cook/src/app/widgets/full_screen_image_viewer.dart';
import 'package:fridge_cook/src/data/repositories/data_product_categories_repository.dart';
import 'package:fridge_cook/src/data/repositories/remote_product_fetcher.dart';
import 'package:fridge_cook/src/data/repositories/remote_recipes_repository.dart';
import 'package:fridge_cook/src/data/repositories/shared_products_repository.dart';
import 'package:fridge_cook/src/domain/entities/product_category.dart';
import 'package:fridge_cook/src/domain/entities/recipe.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fridge_cook/src/app/CustomImages.dart';
import 'package:fridge_cook/src/app/pages/recipes_details/recipes_details_view.dart';
import 'package:fridge_cook/src/domain/entities/product.dart';
import 'products_listing_controller.dart';

typedef ListStringVoidFunc = void Function(List<String> list);
typedef StringVoidFunc = void Function(String value);

class DialogUtils {
  static DialogUtils _instance = new DialogUtils.internal();

  DialogUtils.internal();

  factory DialogUtils() => _instance;

  static final _productController = TextEditingController();
  static List<String> _tags = [];

  static Widget _makeTag(name, Function removeTagFunction) {
    return Container(decoration: BoxDecoration(
                    color: PrimaryColor.withAlpha(18),
                    border: Border.all(color: Color.fromARGB(18, 223, 0, 26),),
                    borderRadius: BorderRadius.all(Radius.circular(10))
                  ), width: (56 + name.toString().length * 8).toDouble(), height: 50, padding: EdgeInsets.only(left: 8, top: 5, right: 0, bottom: 5),
        child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(name, style: GoogleFonts.dmSans(fontWeight: FontWeight.bold, fontSize: 13, color: PrimaryColor,),),
                                    Spacer(flex: 1,),
                                    IconButton(
                                      color: const Color.fromARGB(255, 223, 0, 27),
                                      icon: ImageIcon(AssetImage(CustomImages.close)),
                                      onPressed: () {
                                        removeTagFunction(name);
                                      },
                                    ),
                                  ],
                                ),
      );
  }

  static void showCustomDialog(BuildContext context,
      {@required String title, 
      String okBtnText = "Ok",
      String cancelBtnText = "Cancel",
      @required ListStringVoidFunc okBtnFunction}) {

var addIngredientsView = TextButton(
                  style: TextButton.styleFrom(
                    fixedSize: const Size(300, 50),
                    foregroundColor: Colors.white,
                    backgroundColor: PrimaryColor,
                    padding: const EdgeInsets.all(14.0),
                    textStyle: GoogleFonts.dmSans(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white),
                  ),
                  onPressed: () {
                    //nextPage();
                    okBtnFunction(_tags);
                    // clear tags once we submit ingredients
                    _tags = [];
                  },
                  child: Text(okBtnText),
                );
                
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            icon: Container(
          alignment: FractionalOffset.topRight, child: InkWell(onTap:() {
            Navigator.pop(context);
          }, child: Icon(Icons.close))),
            title: Text(title),
            content: 
            
            
            StatefulBuilder(builder: ((BuildContext context, StateSetter setState) {
              return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextFormField(
      maxLength: 100,
      controller: _productController,
      onFieldSubmitted: (value) {
        _tags.add(value);
        _productController.text = "";
        setState((){});
      }, decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Enter ingredients...',
    )),
                Wrap(spacing: 8, runSpacing: 8, children: [for (var tag in _tags) _makeTag(tag, (String value) {
            _tags.remove(value);
             setState((){});
            }),],),
              ]);
            })
            
             
              
              
          )
              
              ,
              actionsAlignment: MainAxisAlignment.center,
            actions: <Widget>[
              addIngredientsView,
            ],
          );
        });
  }
 }

class ProductsListingRoute extends View {
  static const routeName = '/productsListing';
  ProductsListingRoute({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ProductsListingRouteState createState() {
    final productsListingController = ProductsListingController(DataProductCategoriesRepository(), SharedPreferencesProductRepository(), RemoteProductFetcher());
    return _ProductsListingRouteState(
    productsListingController,
    RecipesListingController(RemoteRecipesRepository(), productsListingController)
    );
  } 
}

class _ProductsListingRouteState extends ViewState<ProductsListingRoute, ProductsListingController>
    with SingleTickerProviderStateMixin {

      ProductsListingController controller;
      RecipesListingController recipesController;

    _ProductsListingRouteState(ProductsListingController controller, RecipesListingController recipesController)
      : this.controller = controller, this.recipesController = recipesController, super(controller);

  Widget _recipeTableViewCell(int index, Recipe item) {
    var recipe = item;
    var thumbnail = CachedNetworkImage(
      imageUrl: recipe.image,
      placeholder: (context, url) => CircularProgressIndicator(),
      errorWidget: (context, url, error) => Icon(null),
      width: 100,
      height: 100,
    );

    return InkWell(
      child: Card(child: Container(
        padding: EdgeInsets.only(left: 24),
        width: 356,
        height: thumbnail.height,
        color: Colors.white,
        child: Row(
              children: <Widget>[

                Column(crossAxisAlignment: CrossAxisAlignment.start , children: [
                  Text('\n' + recipe.name,
                  textAlign: TextAlign.left,
                    style: GoogleFonts.dmSans(
                        color: Color.fromRGBO(17, 58, 17, 1),
                        fontSize: 14,
                        fontWeight: FontWeight.bold)),
                        SizedBox(height: 10,),
                        ProductsDetailsState.makeRecipeSpecifications(),
                ],),

                



                Spacer(
                  flex: 1,
                ),
                thumbnail,
              ],
            ),
      )),
    onTap: () {
      Navigator.pushNamed(
        context, 
        RecipesDetailsRoute.routeName,
        arguments: recipe
      );
    },
    );
  }

  Widget _categoryTableViewCell(int index, ProductCategory category) {
    var thumbnailWidth = 56.0;
    var isSelected = _selectedProductCategoryIndex != index;
    var productCountInCategory = controller.allProducts.where((e) => e.category == category).length;
    
    var view = Row(children: [SizedBox(width: 20,), Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Spacer(flex: 2),
                InkWell(
                  onTap:() {
                    setState(() {
                      if (index == _selectedProductCategoryIndex) {
                        _selectedProductCategoryIndex = -1;
                        controller.disableFilters();
                        return;
                      } else {
                        _selectedProductCategoryIndex = index;
                        controller.filter(category);
                      }
                    });
                  },
                  child: Container(
                  width: thumbnailWidth,
                  height: thumbnailWidth,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(223, 0, 27, 0.07),
                    border: Border.all(color: isSelected ? Color(0x12DF001B) : Color.fromARGB(255, 223, 0, 26),),
                    borderRadius: BorderRadius.all(Radius.circular(14))
                  ),
                  child: Image.network(category.image, width: 19, height: 19,),
                )
                ),
                Spacer(flex: 1),
                Text("${category.name}${productCountInCategory > 0 ?  " ($productCountInCategory)" : ""}", textAlign: TextAlign.center, style: GoogleFonts.dmSans(
                              fontSize: 11,
                              fontWeight: FontWeight.w100, color: Color.fromARGB(255, 128, 128, 128))),
                Spacer(flex: 1),
              ])]);

    return view;
  }

  Widget _productTableViewCell(int index, Product product) {
    var width = 158.0;
    var thumbnailHeight = 44.0;
    var thumbnail = makeZoomableImage(product.image, thumbnailHeight, context);

    var canRemoveMore = controller.canRemoveMore(product);
    var canAddMore = controller.canAddMore(product);
    var lessQuantityUpdaterBackgroundColor = canRemoveMore ? Color.fromRGBO(223, 0, 27, 1) : Color.fromRGBO(223, 0, 27, 0.07);
    var lessQuantityUpdaterForegroundColor = canRemoveMore ? Colors.white : Color.fromRGBO(223, 0, 27, 1);
    var quantityUpdaterBackgroundColor = canAddMore ? Color.fromRGBO(223, 0, 27, 1) : Color.fromRGBO(223, 0, 27, 0.07);
    var quantityUpdaterForegroundColor = canAddMore ? Colors.white : Color.fromRGBO(223, 0, 27, 1);

    return Card(child: Container(
                  width: width,
                  height: 173,
                  color: Colors.white,
                  child: Stack(children: [Positioned(left: width / 2, child: Column(
                        children: <Widget>[
                          SizedBox(height: 40),
                          thumbnail,
                          SizedBox(height: 18),
                          Text(product.name,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.dmSans(
                              fontSize: 14,
                              fontWeight: FontWeight.w500, color: Color.fromRGBO(71, 72, 71, 0.96))),
                          SizedBox(height: 13),
                          Row(
                                  children: [
                                    InkWell(onTap: () {
                                      if (canRemoveMore) {
                                        controller.deleteOne(product.name);
                                      }
                                    }, child:
                                    Container(decoration: BoxDecoration(
                                      color: lessQuantityUpdaterBackgroundColor,
                    borderRadius: BorderRadius.all(Radius.circular(11.5))
                  ), width: 23, height: 23, child:
                                    Text("-", textAlign: TextAlign.center, style: TextStyle(color: lessQuantityUpdaterForegroundColor)),)),
                                    SizedBox(width: 8,),
                                    Text(product.quantity.toString(), style: GoogleFonts.dmSans(fontWeight: FontWeight.w500, fontSize: 14)),
                                    SizedBox(width: 8,),
                                    InkWell(onTap: () {
                                      if (canAddMore) {
                                        controller.addProduct(product.name);
                                      }
                                    }, child:
                                    Container(decoration: BoxDecoration(
                                      color: quantityUpdaterBackgroundColor,
                    borderRadius: BorderRadius.all(Radius.circular(11.5))
                  ), width: 23, height: 23, child:
                                    Text("+", textAlign: TextAlign.center, style: TextStyle(color: quantityUpdaterForegroundColor)),
                                    )),
                                  ],
                                ),
                          SizedBox(height: 50),
              ],
                      )), Positioned(top: 14, right: 0.105 * width, child: Container(decoration: BoxDecoration(
                    border: Border.all(color: Color.fromRGBO(223, 223, 223, 1),),
                    borderRadius: BorderRadius.all(Radius.circular(6))
                  ), width: 28, height: 28, child: 
                          IconButton(
                            icon: Image.asset(CustomImages.trash),
                            onPressed: () {
                              controller.deleteProduct(product.name);
                            },
                          ))),]),
                ));
  }

  Widget makeZoomableImage(String name, double width, BuildContext context) {
    return InkWell(
      splashColor: Colors.white10,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FullScreenRemoteImageViewer(name)),
        );
      },
      child: CachedNetworkImage(
          imageUrl: name,
          placeholder: (context, url) => CircularProgressIndicator(),
          errorWidget: (context, url, error) => Icon(null),
          width: width,
          height: width,
        )
    );
  }

  var _doOnce = true;
  var _isLoaderDisplayed = false;
  int _refreshSinceLoadCounter = 0;
  int _selectedIndex = 0;
  int _selectedProductCategoryIndex = -1;
  @override
  Widget get view => buildPage();

  Widget productsListingView(ProductsListingController controller) {

    var listingHeight = MediaQuery.of(context).size.height - AppBar().preferredSize.height - 60 - 135;

    if (controller.products.isEmpty && _selectedProductCategoryIndex == -1) {
      Widget emptyProductsView = Container(padding: EdgeInsets.all(15), height: listingHeight, child: Text("Hum... 🤔\n\nIt looks like your fridge is empty for now... 👨‍🍳\n\nStart by adding some ingredients below!", style: TextStyle(fontSize: 17,)));
      return Center(child: Stack(children: [emptyProductsView]));
    }

    var categoriesChildren = <Widget>[
      for (var i = 0 ; i < controller.productCategories.length ; i++) _categoryTableViewCell(i, controller.productCategories[i])
    ];
    Widget categoriesListingView = Container(width: MediaQuery.of(context).size.width, height: 100, child: ListView(physics: const AlwaysScrollableScrollPhysics(), scrollDirection: Axis.horizontal, padding: const EdgeInsets.all(8), children: categoriesChildren));

    var productsChildren = <Widget>[
      for (var i = 0 ; i < controller.products.length ; i++) _productTableViewCell(i, controller.products[i])
    ];
    Widget productsListingView = Container(height: listingHeight, child: GridView.count(crossAxisCount: 2, padding: const EdgeInsets.all(8), children: productsChildren));

    return Padding(padding: EdgeInsets.only(left: 24), child: Column(children: [categoriesListingView, Align(alignment: Alignment.centerLeft, child: Text(controller.productCategoryName(_selectedProductCategoryIndex), style: GoogleFonts.dmSans(fontWeight: FontWeight.bold, fontSize: 16, color: Color.fromARGB(255, 4, 4, 21),),)), productsListingView]));
  }

  Widget recipesListingView() {
    var recipesChildren = <Widget>[
      for (var i = 0 ; i < recipesController.recipes.length ; i++) _recipeTableViewCell(i, recipesController.recipes[i])
    ];
    Widget recipesListingView = ListView(padding: const EdgeInsets.all(8), children: recipesChildren);
    return recipesListingView;
  }

  void addProducts(List<String> productNames){

    // first we dismiss the 'New ingredients' modal window
    Navigator.pop(context);
    setState(() {});

    List<String> args = [
      'Adding your ingredients...',
      'Your ingredients will be added soon. We\'re cooking for you!',
    ];
    Navigator.pushNamed(
      context,
      LoaderRoute.routeName,
      arguments: args,
    );

    _refreshSinceLoadCounter = 0;
    _isLoaderDisplayed = true;

    for (var productName in productNames) {
      controller.addProduct(productName);
    }
  }

  Widget buildPage() {
    if (_doOnce) {
      _doOnce = false;
      controller.getAllCategories();
      controller.getAllProducts();
    }

    var newIngredientsButton = _selectedIndex != 0 ? null : ControlledWidgetBuilder<ProductsListingController>(builder: (context, controller) { return InkWell(onTap: () {
    DialogUtils.showCustomDialog(context,
          title: "New ingredients",
          okBtnText: "Add ingredients",
          okBtnFunction: addProducts,
        );
                                          
    }, child: Container(decoration: BoxDecoration(
                    color: PrimaryColor,
                    border: Border.all(color: Color.fromARGB(255, 223, 0, 26),),
                    borderRadius: BorderRadius.all(Radius.circular(10))
                  ), width: 200, height: 65, padding: EdgeInsets.all(18),
        child: Row(children: <Widget>[
          
          Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    IconButton(
                                      icon: ImageIcon(AssetImage(CustomImages.plus), color: Colors.white),
                                      onPressed: () {},
                                    ),
                                    Text("New ingredient", style: GoogleFonts.dmSans(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.white,),),
                                  ],
                                ),
        ]
          
          
          ),
      )); })  ;

    return Scaffold(
      floatingActionButton: newIngredientsButton,
      appBar: AppBar(
        title: Text(
          _selectedIndex == 0 ? 'What\'s in my fridge?' : 'Recipes suggestions',
          style: GoogleFonts.dmSans(fontWeight: FontWeight.bold, fontSize: 22, color: Colors.black),
        ),
        actions: [
          InkWell(onTap:() {
            Navigator.pushReplacementNamed(
              context, 
              OnboardingRoute.routeName
            );
          }, child: Container(padding: EdgeInsets.only(right: 22), child: ImageIcon(AssetImage(CustomImages.info), color: Colors.black),)),
        ],

        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ControlledWidgetBuilder<ProductsListingController>(builder: (context, controller) {
        if (_isLoaderDisplayed) {
          // when a loader is being displayed
          // the first refresh is trigered when we display a loader screen, so we wait for the second refresh to actually dismiss the loader screen
          _refreshSinceLoadCounter += 1;
          if (_refreshSinceLoadCounter == 2) {
            _isLoaderDisplayed = false;
            Navigator.pop(context);
          }
        }
        return _selectedIndex == 0 ? productsListingView(controller) : recipesListingView();
      }),
      bottomNavigationBar: BottomNavigationBar(
      currentIndex: _selectedIndex,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: ImageIcon(AssetImage(CustomImages.myProducts)),
          label: 'My products',
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(AssetImage(CustomImages.myRecipes)),
          label: 'My recipes',
        ),
      ],
      onTap: (index) {
        if (index == _selectedIndex) {
          return;
        }

        if (index == 0) {
        setState(() {
          _selectedIndex = index;
        });
        } else
        
          if (index == 1) {
            setState(() {
            _selectedIndex = index;
            });
            List<String> args = [
              'Generating your recipes...',
              'Your custom recipe suggestions will be ready soon. We\'re excited to show you!',
            ];
            Navigator.pushNamed(
              context,
              LoaderRoute.routeName,
              arguments: args,
            );

            _refreshSinceLoadCounter = 0;
            _isLoaderDisplayed = true;

            recipesController.getAllRecipes(this.controller.products);
          }
      },
  ),
    );
  }
}
