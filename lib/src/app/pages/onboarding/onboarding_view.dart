import 'package:flutter/material.dart';
import 'package:fridge_cook/main.dart';
import 'package:fridge_cook/src/app/pages/products_listing/products_recipes_listing_view.dart';
import 'package:fridge_cook/src/app/widgets/full_screen_image_viewer.dart';
import 'package:fridge_cook/src/data/repositories/SharedPref.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../SharedPreferencesKeys.dart';

class OnboardingStep {
  String description;
  String image;

  OnboardingStep(this.description, this.image);
}

class OnboardingRoute extends StatelessWidget {
  static const routeName = '/onboarding';
  final PageController _pageController = PageController();
  final String title;
  final List<OnboardingStep> steps;

  OnboardingRoute(this.title, this.steps);

  @override
  Widget build(BuildContext context) {

    var pages = <Widget>[for (var step in steps) _makeStepView(step, context)];
    pages.add(Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Spacer(flex: 1),
        Text('Well done, you have \ncompleted this tutorial!', textAlign: TextAlign.center, style: GoogleFonts.dmSans(fontWeight: FontWeight.w500, fontSize: 14, color: Color.fromARGB(192, 71, 72, 71)),),
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
      ]));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(title, style: GoogleFonts.dmSans(fontWeight: FontWeight.bold, fontSize: 22, color: Colors.black),)
      ),
      body: Center(
        child:
          PageView(
            controller: _pageController,
            children: pages,
          )
          ),
    );
  }

  Widget _makeStepView(OnboardingStep step, BuildContext context) {
    var goToNextAnimationView = TextButton(
                  style: TextButton.styleFrom(
                    fixedSize: const Size(300, 50),
                    foregroundColor: Colors.white,
                    backgroundColor: PrimaryColor,
                    padding: const EdgeInsets.all(14.0),
                    textStyle: GoogleFonts.dmSans(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white),
                  ),
                  onPressed: () {
                    _nextPage();
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

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Spacer(flex: 3),
        _makeOnboardingImage(step.image, context),
        Spacer(flex: 2),
        Text(step.description, textAlign: TextAlign.center, style: style,),
        Spacer(flex: 2),
        goToNextAnimationView,
        Spacer(flex: 1),
        closeView,
        Spacer(flex: 2),
    ]);
  }

  Widget _makeOnboardingImage(String name, BuildContext context) {
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

  void _nextPage() {
    _pageController.animateToPage(
      _pageController.page.toInt() + 1,
      duration: Duration(milliseconds: 400),
      curve: Curves.easeIn
    );
  }
}