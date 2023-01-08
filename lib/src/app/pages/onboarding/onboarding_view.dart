import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:fridge_cook/src/app/CustomImages.dart';
import 'package:fridge_cook/src/data/repositories/in_memory_performance_repository.dart';
import '../../SharedPreferencesKeys.dart';
import '../products_listing/products_listing_view.dart';

class OnboardingRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var goToNextAnimationView = Lottie.asset(
        'assets/animations/Onboarding_Slide_Left_Arrows_Animation.json');
    var style = GoogleFonts.salsa(fontSize: 20);

    return Scaffold(
      appBar: AppBar(
        title: Text('Fridge Cook', style: GoogleFonts.salsa(fontSize: 30)),
      ),
      body: Center(
        child:
          PageView(
            children: <Widget>[

              Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Spacer(flex: 1),
                Text('Scan all your ingredients\nusing your device\'s camera!', textAlign: TextAlign.center, style: style,),
                Spacer(flex: 1),
                Image.asset(CustomImages.onboardingScan, height: 300,),
                goToNextAnimationView,
                Spacer(flex: 1),
              ]),


              Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Spacer(flex: 1),
                Text('Wrong ingredients or quantities?\nAlready cooked?\nReview and modify your ingredients anytime!', textAlign: TextAlign.center, style: style,),
                Spacer(flex: 1),
                Image.asset(CustomImages.onboardingListing, height: 300,),
                goToNextAnimationView,
                Spacer(flex: 1),
              ]),


              Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Spacer(flex: 1),
                Text('Tadam!\nCustom recipes suggestions are \nautomatically generated based on your ingredients!', textAlign: TextAlign.center, style: style,),
                Spacer(flex: 1),
                Image.asset(CustomImages.onboardingRecipesListing, height: 300,),
                goToNextAnimationView,
                Spacer(flex: 1),
              ]),

              Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Spacer(flex: 1),
                Text('Get more details \nby selecting a particular recipe.', textAlign: TextAlign.center, style: style,),
                Spacer(flex: 1),
                Image.asset(CustomImages.onboardingRecipeDetails, height: 250,),
                goToNextAnimationView,
                Spacer(flex: 1),
              ]),

              Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Spacer(flex: 1),
                Text('Well done, you have \ncompleted this tutorial!', textAlign: TextAlign.center, style: style,),
                Spacer(flex: 1),
                ElevatedButton(
                  child: Text('Lets go!'),
                  onPressed: () async {
                    var _sharedPref = SharedPref();
                    await _sharedPref.save(SharedPreferencesKeys.tutorialCompleted, true);
                    Navigator.pushReplacementNamed(
                      context, 
                      ProductsListingRoute.routeName
                    );
                  },
                ),
                Spacer(flex: 1),
              ]),


            ],
          )
          ),
    );
  }
}