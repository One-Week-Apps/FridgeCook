import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:fridge_cook/src/app/SharedPreferencesKeys.dart';
import 'package:fridge_cook/src/app/pages/loader/loader_view.dart';
import 'package:fridge_cook/src/data/repositories/SharedPref.dart';
import 'package:fridge_cook/src/domain/entities/recipe.dart';
import 'package:oktoast/oktoast.dart';
import 'package:fridge_cook/src/app/pages/recipes_details/recipes_details_view.dart';
import 'package:fridge_cook/src/app/pages/products_listing/products_recipes_listing_view.dart';
import 'package:fridge_cook/src/app/pages/onboarding/onboarding_view.dart';

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

const PrimaryColor = const Color.fromARGB(255, 223, 0, 26);

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
            fontFamily: 'DM Sans'),
        home: homeRoute,
        routes: {
          OnboardingRoute.routeName: (context) => OnboardingRoute(),
          ProductsListingRoute.routeName: (context) => ProductsListingRoute(),
          LoaderRoute.routeName: (context) {
            final List<String> args = ModalRoute.of(context).settings.arguments;
            final String title = args.first;
            final String description = args.last;
            return LoaderRoute(title, description);
          },
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
