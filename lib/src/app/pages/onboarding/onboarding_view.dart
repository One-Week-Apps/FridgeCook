import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'package:lottie/lottie.dart';
import 'package:fridge_cook/src/app/CustomImages.dart';
import 'package:fridge_cook/src/data/repositories/in_memory_performance_repository.dart';
import '../../SharedPreferencesKeys.dart';
import '../moves_listing/moves_listing_view.dart';

class OnboardingRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // var goToNextAnimationView = Lottie.asset(
    //     'assets/animations/Onboarding_Slide_Left_Arrows_Animation.json');
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
                Text('Try to perform these moves \nin one dance !', textAlign: TextAlign.center, style: style,),
                Spacer(flex: 1),
                Image.asset(CustomImages.onboardingMoves, height: 300,),
                //goToNextAnimationView,
                Spacer(flex: 1),
              ]),


              Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Spacer(flex: 1),
                Text('Then self-rate your dance style \nusing the validation button below.', textAlign: TextAlign.center, style: style,),
                Spacer(flex: 1),
                Image.asset(CustomImages.onboardingDone, height: 50,),
                Image.asset(CustomImages.onboardingRating, height: 250,),
                //goToNextAnimationView,
                Spacer(flex: 1),
              ]),


              Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Spacer(flex: 1),
                Text('Followers can still rate their dancing \neven if not performing these moves.', textAlign: TextAlign.center, style: style,),
                Spacer(flex: 1),
                Image.asset(CustomImages.logo, height: 250,),
                //goToNextAnimationView,
                Spacer(flex: 1),
              ]),

              Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Spacer(flex: 1),
                Text('Access more details \nby selecting a particular move.', textAlign: TextAlign.center, style: style,),
                Spacer(flex: 1),
                Image.asset(CustomImages.onboardingMoveDetails, height: 250,),
                //goToNextAnimationView,
                Spacer(flex: 1),
              ]),

              Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Spacer(flex: 1),
                Text('Track your progress by \nearning various achievements.', textAlign: TextAlign.center, style: style,),
                Spacer(flex: 1),
                Image.asset(CustomImages.onboardingAchievements, height: 250,),
                //goToNextAnimationView,
                Spacer(flex: 1),
              ]),

              Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Spacer(flex: 1),
                Text('Access to your stats to see \nyour progress for the current week.', textAlign: TextAlign.center, style: style,),
                Image.asset(CustomImages.stats, height: 50,),
                Spacer(flex: 1),
                //goToNextAnimationView,
                Spacer(flex: 1),
              ]),

              Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Spacer(flex: 1),
                Text('If you have a WearOS compatible smartwatch, you can download our companion app: Fridge Cook.\n This will allow you to get inspiration for your dance moves using smartwatch vibrations !', textAlign: TextAlign.center, style: style,),
                Spacer(flex: 1),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[Image.asset(CustomImages.watch1, height: 150,), Image.asset(CustomImages.watch2, height: 150,)]),
                Spacer(flex: 1),
                //goToNextAnimationView,
                Spacer(flex: 1),
              ]),

              Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Spacer(flex: 1),
                Text('Well done, you have \ncompleted this tutorial!', textAlign: TextAlign.center, style: style,),
                Spacer(flex: 1),
                // RaisedButton(
                //   child: Text('Lets go!'),
                //   onPressed: () async {
                //     var _sharedPref = SharedPref();
                //     await _sharedPref.save(SharedPreferencesKeys.tutorialCompleted, true);
                //     Navigator.pushReplacementNamed(
                //       context, 
                //       MovesListingRoute.routeName
                //     );
                //   },
                // ),
                Spacer(flex: 1),
              ]),


            ],
          )
          ),
    );
  }
}