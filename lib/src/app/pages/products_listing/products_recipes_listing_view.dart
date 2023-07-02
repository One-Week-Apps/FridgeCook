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

class DialogUtils {
  static DialogUtils _instance = new DialogUtils.internal();

  DialogUtils.internal();

  factory DialogUtils() => _instance;

  static final _productController = TextEditingController();
  static List<String> _tags = [];

  static Widget _makeTag(name) {
    return Container(decoration: BoxDecoration(
                    color: PrimaryColor.withAlpha(18),
                    border: Border.all(color: Color.fromARGB(18, 223, 0, 26),),
                    borderRadius: BorderRadius.all(Radius.circular(10))
                  ), width: 125, height: 40, padding: EdgeInsets.all(8),
        child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(name, style: GoogleFonts.dmSans(fontWeight: FontWeight.bold, fontSize: 13, color: PrimaryColor,),),
                                    IconButton(
                                      icon: Icon(Icons.close, color: PrimaryColor),
                                      onPressed: () {
                                        print("DEBUG_SESSION remove tag: " + name);
                                      },
                                    ),
                                  ],
                                ),
      );//Text(name);
  }

  //typedef WidgetBuilder = Widget Function(BuildContext context);

  static void showCustomDialog(BuildContext context,
      {@required String title, 
      String okBtnText = "Ok",
      String cancelBtnText = "Cancel",
      @required Function addTagFunction,
      @required Function removeTagFunction,
      @required ListStringVoidFunc okBtnFunction}) {

        var textField = TextFormField(
      maxLength: 100,
      controller: _productController,
      onFieldSubmitted: (value) {
        print("Field submitted ! " + value);
        _tags.add(value);
        _productController.text = "";
        addTagFunction();
        //controller.addProduct(value);
      }, decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Enter ingredients...',
    ));

    var tagView = Wrap(spacing: 8, children: [for (var tag in _tags) _makeTag(tag),],);

var goToNextAnimationView = TextButton(
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
                  },
                  child: Text(okBtnText),
                );
                
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            icon: Container(
          alignment: FractionalOffset.topRight, child: InkWell(onTap:() {
            Navigator.pop(context);
          }, child: Icon(Icons.close))),//_getCloseButton(context),
            title: Text(title),
            //title: Row(
            //  mainAxisAlignment: MainAxisAlignment.center, children: [Text(title)/*, _getCloseButton(context),*/]),
            content: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                //_getCloseButton(context),
                textField,
                tagView,
              ]),
              actionsAlignment: MainAxisAlignment.end,
            actions: <Widget>[
              /*ElevatedButton(
                child: Text(okBtnText, style: GoogleFonts.dmSans(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.white,),),
                onPressed: okBtnFunction,
              )*/goToNextAnimationView,
              /*ElevatedButton(
                  child: Text(cancelBtnText),
                  onPressed: () => Navigator.pop(context))*/
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
    print("recipe[${index.toString()}] = $recipe");
    var thumbnail = CachedNetworkImage(
      imageUrl: recipe.image,
      placeholder: (context, url) => CircularProgressIndicator(),
      errorWidget: (context, url, error) => Icon(null),
      width: 100,
      height: 100,
    );

    return InkWell(
      child: Container(
        width: 356,
        height: thumbnail.height,
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text('\n' + recipe.name,
                    style: GoogleFonts.dmSans(
                        fontSize: 20,
                        fontWeight: FontWeight.w900)),
                Spacer(
                  flex: 1,
                ),
                thumbnail,
              ],
            ),
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

  Widget _categoryTableViewCell(int index, ProductCategory category) {
    var thumbnailHeight = 56.0;
    var isSelected = _selectedProductCategoryIndex != index;
    
    var view = Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Spacer(flex: 2),
                InkWell(
                  onTap:() {
                    print("selected category index: $index");
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
                  color: Color(0xDF001B),
                  height: thumbnailHeight,
                  decoration: BoxDecoration(
                    border: Border.all(color: isSelected ? Color(0x12DF001B) : Color.fromARGB(255, 223, 0, 26),),
                    borderRadius: BorderRadius.all(Radius.circular(14))
                  ),
                  child: _makeCategoryImage(category.image),
                )
                ),
                Spacer(flex: 1),
                Text(category.name, textAlign: TextAlign.center,),
                Spacer(flex: 1),
              ]);

    return view;
  }

  Widget _makeCategoryImage(String name) {
    return InkWell(
      splashColor: Colors.white10,
      child: Ink.image(
        fit: BoxFit.fitHeight,
        height: 19.0,
        image: AssetImage(
          name
        ),
      )
    );
  }

  Widget _productTableViewCell(int index, Product product) {
    var thumbnailHeight = 100.0;
    var thumbnail = makeZoomableImage(product.image, thumbnailHeight, context);

    return InkWell(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: thumbnailHeight + 10,
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[

                      // thumbnail,
                      Row(
                        children: <Widget>[
                          Text(product.name,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.dmSans(
                              fontSize: 20,
                              fontWeight: FontWeight.w900)),
                          Spacer(),
                          Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.remove),
                                      onPressed: () {
                                        controller.deleteOne(product.name);
                                      },
                                    ),
                                    Text(product.quantity.toString()),
                                    IconButton(
                                      icon: Icon(Icons.add),
                                      onPressed: () {
                                        controller.addProduct(product.name);
                                      },
                                    ),
                                  ],
                                ),
                          SizedBox(width: 50),
                          thumbnail,
                          SizedBox(width: 50),
                          IconButton(
                            icon: Image.asset(CustomImages.trash),
                            onPressed: () {
                              print("deleting product $index");
                              controller.deleteProduct(product.name);
                            },
                          ),
              ],
                      ),
                      SizedBox(height: 5),
                      const Divider(
            height: 1,
            thickness: 0.5,
            indent: 0,
            endIndent: 0,
            color: Colors.grey,
          ),
                    ],
                  ),
                ),
                onTap: () {
                  print("image tapped");
                },
              );
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
        )//Image.network(name, width: width, height: height),
    );
  }

  var _doOnce = true;
  var _isLoaderDisplayed = false;
  int _refreshSinceLoadCounter = 0;
  int _selectedIndex = 0;
  int _selectedProductCategoryIndex = -1;
  @override
  Widget get view => buildPage();
  
  //final _productController = TextEditingController();

  Widget productsListingView(ProductsListingController controller) {

    /*var textField = TextFormField(
      maxLength: 10,
      controller: _productController,
      onFieldSubmitted: (value) {
        print("Field submitted ! " + value);
        _productController.text = "";
        controller.addProduct(value);
      }, decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'New ingredient',
    ));

    Widget bottomOverlayView = Align(
      alignment: Alignment.bottomCenter,
      child: Container(color: Colors.white, child: Padding(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16), child: textField,)),
    );*/

    var listingHeight = MediaQuery.of(context).size.height - AppBar().preferredSize.height - 60 - 105;

    if (controller.products.isEmpty) {
      Widget emptyProductsView = Container(padding: EdgeInsets.all(15), height: listingHeight, child: Text("Hum... 🤔\n\nIt looks like your fridge is empty for now... 👨‍🍳\n\nStart by adding some ingredients below!", style: TextStyle(fontSize: 17,)));
      return Center(child: Stack(children: [emptyProductsView/*, bottomOverlayView*/]));
    }

    var categoriesChildren = <Widget>[
      for (var i = 0 ; i < controller.productCategories.length ; i++) _categoryTableViewCell(i, controller.productCategories[i])
    ];
    Widget categoriesListingView = Container(height: listingHeight, child: ListView(padding: const EdgeInsets.all(8), children: categoriesChildren));

    var productsChildren = <Widget>[
      for (var i = 0 ; i < controller.products.length ; i++) _productTableViewCell(i, controller.products[i])
    ];
    Widget productsListingView = Container(height: listingHeight, child: ListView(padding: const EdgeInsets.all(8), children: productsChildren));

    return Center(child: Stack(children: [categoriesListingView, Text(controller.productCategoryName(_selectedProductCategoryIndex)), productsListingView/*, bottomOverlayView*/]));
  }

  Widget recipesListingView() {
    var recipesChildren = <Widget>[
      for (var i = 0 ; i < recipesController.recipes.length ; i++) _recipeTableViewCell(i, recipesController.recipes[i])
    ];
    Widget recipesListingView = ListView(padding: const EdgeInsets.all(8), children: recipesChildren);
    return recipesListingView;
  }

  void addProducts(List<String> productNames){
    setState(() {});
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

    var fab = _selectedIndex != 0 ? null : ControlledWidgetBuilder<ProductsListingController>(builder: (context, controller) { return InkWell(onTap: () {

                                        print("DEBUG_SESSION show dialog");
                                        //controller.deleteOne(product.name);
                                        DialogUtils.showCustomDialog(context,
          title: "New ingredients",
          okBtnText: "Add ingredients",
          addTagFunction: () {
            print("DEBUG_SESSION addTagFunction");
            setState((){});
          },
          removeTagFunction: () => setState((){}),
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
                                      //onPressed: () {},
                                    ),
                                    Text("New ingredient", style: GoogleFonts.dmSans(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.white,),),
                                  ],
                                ),
        ]
          
          
          ),
      )); })  ;

    return Scaffold(
      //floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: fab,
      appBar: AppBar(
        //centerTitle: false,
        title: Text(
          _selectedIndex == 0 ? 'What\'s in my fridge?' : 'Recipes suggestions 👨‍🍳',
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
        // since a refresh occured we dismiss loader modals
        //Navigator.maybePop(context, _doOnce == false);
        print("DEBUG_SESSION UI REFRESH");
        if (_isLoaderDisplayed) {
          _refreshSinceLoadCounter += 1;
          if (_refreshSinceLoadCounter == 2) {
            _isLoaderDisplayed = false;
            //_selectedIndex = 1;
            Navigator.pop(context);
          }
        }
        //Navigator.of(context).popUntil((route) { print("DEBUG_SESSION " + route.settings.name); return route.settings.name == "/productsListing"; });
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
        print("selected index: $index");
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
        //});
      },
  ),
    );
  }

}
