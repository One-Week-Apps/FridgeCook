import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:fridge_cook/src/app/SharedPreferencesKeys.dart';
import 'package:fridge_cook/src/app/pages/recipes_listing/recipes_listing_view.dart';
import 'package:fridge_cook/src/data/repositories/SharedPref.dart';
import 'package:fridge_cook/src/domain/entities/recipe.dart';
import 'package:oktoast/oktoast.dart';
import 'package:fridge_cook/src/app/pages/recipes_details/recipes_details_view.dart';
import 'package:fridge_cook/src/app/pages/products_listing/products_listing_view.dart';
import 'package:fridge_cook/src/app/pages/onboarding/onboarding_view.dart';

class CommonDeps {
  static final CommonDeps _singleton = CommonDeps._internal();

  factory CommonDeps() {
    return _singleton;
  }

  CommonDeps._internal();
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var _sharedPref = SharedPref();
  bool tutorialCompleted;
  try {
    tutorialCompleted = await _sharedPref.read(SharedPreferencesKeys.tutorialCompleted);
  } catch (e) {
    tutorialCompleted = false;
  }

  runApp(MyApp(tutorialCompleted));
}

const PrimaryColor = const Color(0xFFFFFFFF);

class ColorModel with ChangeNotifier {
  void updateDisplay() {
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  MyApp(this.tutorialCompleted);
  final bool tutorialCompleted;

  @override
  Widget build(BuildContext context) {
    FlutterCleanArchitecture.debugModeOn();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    
    var homeRoute = tutorialCompleted ? ProductsListingRoute() : OnboardingRoute();

    return OKToast(
          child: MaterialApp(
        title: 'Fridge Cook',
        theme: ThemeData(
            primaryColor: PrimaryColor,
            primarySwatch: Colors.red,
            fontFamily: 'Montserrat'),
        home: homeRoute,
        routes: {
          ProductsListingRoute.routeName: (context) => ProductsListingRoute(),
          RecipesListingRoute.routeName:(context) => RecipesListingRoute(),
          RecipesDetailsRoute.routeName: (context) {
            final Recipe recipe = ModalRoute.of(context).settings.arguments;
            return RecipesDetailsRoute(recipe); 
          },
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
