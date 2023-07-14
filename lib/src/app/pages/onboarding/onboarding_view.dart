import 'package:flutter/material.dart';
import 'package:fridge_cook/main.dart';
import 'package:fridge_cook/src/app/pages/products_listing/products_recipes_listing_view.dart';
import 'package:fridge_cook/src/app/widgets/full_screen_image_viewer.dart';
import 'package:fridge_cook/src/data/repositories/SharedPref.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fridge_cook/src/app/CustomImages.dart';
import '../../SharedPreferencesKeys.dart';

class OnboardingRoute extends StatelessWidget {
  static const routeName = '/onboarding';
  final PageController _pageController = PageController();

  void nextPage() {
    _pageController.animateToPage(
      _pageController.page.toInt() + 1,
      duration: Duration(milliseconds: 400),
      curve: Curves.easeIn
    );
  }

  @override
  Widget build(BuildContext context) {
    var goToNextAnimationView = TextButton(
                  style: TextButton.styleFrom(
                    fixedSize: const Size(300, 50),
                    foregroundColor: Colors.white,
                    backgroundColor: PrimaryColor,
                    padding: const EdgeInsets.all(14.0),
                    textStyle: GoogleFonts.dmSans(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white),
                  ),
                  onPressed: () {
                    nextPage();
                  },
                  child: const Text('Next'),
                );
    var closeView = TextButton(
      style: TextButton.styleFrom(
        foregroundColor: Color.fromARGB(102, 71, 72, 71),
        backgroundColor: Colors.transparent,
        padding: const EdgeInsets.all(14.0),
        textStyle: GoogleFonts.dmSans(fontWeight: FontWeight.w500, fontSize: 14, color: Color.fromARGB(102, 71, 72, 71)),
      ),
      onPressed: () async {
                    var _sharedPref = SharedPref();
                    await _sharedPref.save(SharedPreferencesKeys.tutorialCompleted, true);
                    Navigator.pushReplacementNamed(
                      context, 
                      ProductsListingRoute.routeName
                    );
                  },
      child: const Text('Close'),
    );
    var style = GoogleFonts.dmSans(fontWeight: FontWeight.w500, fontSize: 14, color: Color.fromARGB(192, 71, 72, 71));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('How to use Fridge Cook', style: GoogleFonts.dmSans(fontWeight: FontWeight.bold, fontSize: 22, color: Colors.black),)
      ),
      body: Center(
        child:
          PageView(
            controller: _pageController,
            children: <Widget>[

              Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Spacer(flex: 3),
                makeOnboardingImage(CustomImages.onboardingScan, context),
                Spacer(flex: 2),
                Text('Start by adding\n all the ingredients you have\nfor cooking!', textAlign: TextAlign.center, style: style,),
                Spacer(flex: 2),
                goToNextAnimationView,
                Spacer(flex: 1),
                closeView,
                Spacer(flex: 2),
              ]),


              Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Spacer(flex: 3),
                makeOnboardingImage(CustomImages.onboardingListing, context),
                Spacer(flex: 2),
                Text('Wrong ingredients or quantities?\nAlready cooked?\nReview and modify your ingredients anytime!', textAlign: TextAlign.center, style: style,),
                Spacer(flex: 2),
                goToNextAnimationView,
                Spacer(flex: 1),
                closeView,
                Spacer(flex: 2),
              ]),


              Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Spacer(flex: 3),
                makeOnboardingImage(CustomImages.onboardingRecipesListing, context),
                Spacer(flex: 2),
                Text('Tadam!\nCustom recipes suggestions are \nautomatically generated based on your ingredients!', textAlign: TextAlign.center, style: style,),
                Spacer(flex: 2),
                goToNextAnimationView,
                Spacer(flex: 1),
                closeView,
                Spacer(flex: 2),
              ]),

              Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Spacer(flex: 3),
                makeOnboardingImage(CustomImages.onboardingRecipeDetails, context),
                Spacer(flex: 2),
                Text('Get more details \nby selecting a particular recipe.', textAlign: TextAlign.center, style: style,),
                Spacer(flex: 2),
                goToNextAnimationView,
                Spacer(flex: 1),
                closeView,
                Spacer(flex: 2),
              ]),

              Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Spacer(flex: 1),
                Text('Well done, you have \ncompleted this tutorial!', textAlign: TextAlign.center, style: style,),
                Spacer(flex: 1),
                TextButton(
                  style: TextButton.styleFrom(
                    fixedSize: const Size(300, 50),
                    foregroundColor: Colors.white,
                    backgroundColor: PrimaryColor,
                    padding: const EdgeInsets.all(14.0),
                    textStyle: GoogleFonts.dmSans(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white),
                  ),
                  onPressed: () async {
                    var _sharedPref = SharedPref();
                    await _sharedPref.save(SharedPreferencesKeys.tutorialCompleted, true);
                    Navigator.pushReplacementNamed(
                      context, 
                      ProductsListingRoute.routeName
                    );
                  },
                  child: const Text('Let\'s go!'),
                ),
                Spacer(flex: 1),
              ]),
            ],
          )
          ),
    );
  }

  Widget makeOnboardingImage(String name, BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var imageHeight = screenSize.height * 2 / 3 - 100;

    return InkWell(
      splashColor: Colors.white10,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FullScreenImageViewer(name)),
        );
      },
      child: Ink.image(
        fit: BoxFit.fitHeight,
        height: imageHeight,
        image: AssetImage(
          name
        ),
      )
    );
  }
}