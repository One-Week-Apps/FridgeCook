import 'package:flutter/material.dart';
import 'package:fridge_cook/src/app/widgets/full_screen_image_viewer.dart';
import 'package:fridge_cook/src/data/repositories/SharedPref.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:fridge_cook/src/app/CustomImages.dart';
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
                Spacer(flex: 2),
                Text('Scan all your ingredients\nusing your device\'s camera!', textAlign: TextAlign.center, style: style,),
                Spacer(flex: 1),
                makeOnboardingImage(CustomImages.onboardingScan, context),
                goToNextAnimationView,
                Spacer(flex: 1),
              ]),


              Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Spacer(flex: 2),
                Text('Wrong ingredients or quantities?\nAlready cooked?\nReview and modify your ingredients anytime!', textAlign: TextAlign.center, style: style,),
                Spacer(flex: 1),
                makeOnboardingImage(CustomImages.onboardingListing, context),
                goToNextAnimationView,
                Spacer(flex: 1),
              ]),


              Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Spacer(flex: 2),
                Text('Tadam!\nCustom recipes suggestions are \nautomatically generated based on your ingredients!', textAlign: TextAlign.center, style: style,),
                Spacer(flex: 1),
                makeOnboardingImage(CustomImages.onboardingRecipesListing, context),
                goToNextAnimationView,
                Spacer(flex: 1),
              ]),

              Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Spacer(flex: 2),
                Text('Get more details \nby selecting a particular recipe.', textAlign: TextAlign.center, style: style,),
                Spacer(flex: 1),
                makeOnboardingImage(CustomImages.onboardingRecipeDetails, context),
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