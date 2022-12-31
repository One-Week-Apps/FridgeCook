import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:oktoast/oktoast.dart';
import 'package:fridge_cook/src/app/SharedPreferencesKeys.dart';
import 'package:fridge_cook/src/app/pages/achievements/achievements_controller.dart';
import 'package:fridge_cook/src/app/pages/moves_details/moves_details_view.dart';
import 'package:fridge_cook/src/app/pages/moves_listing/moves_listing_view.dart';
import 'package:fridge_cook/src/app/pages/onboarding/onboarding_view.dart';
import 'package:fridge_cook/src/app/pages/stats/stats_view.dart';
import 'package:fridge_cook/src/data/repositories/in_memory_performance_repository.dart';
import 'package:fridge_cook/src/domain/entities/achievement_types.dart';
import 'package:fridge_cook/src/domain/entities/move.dart';
import 'package:fridge_cook/src/domain/usecases/achievements_observer.dart';

class CommonDeps {
  static final CommonDeps _singleton = CommonDeps._internal();

  AchievementsObserver achievementsObserver;

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

  String lastDateTimeAppOpened;
  try {
    lastDateTimeAppOpened = await _sharedPref.read(SharedPreferencesKeys.lastDateTimeAppOpened);
  } catch (e) {
    lastDateTimeAppOpened = DateTime.utc(1970, 01, 01).toIso8601String();
  }

  final now = DateTime.now();
  final yesterday = DateTime(now.year, now.month, now.day - 1);

  final dateToCheck = DateTime.parse(lastDateTimeAppOpened).toLocal();
  final aDate = DateTime(dateToCheck.year, dateToCheck.month, dateToCheck.day);
  bool isFirstOpeningOfTheDay = aDate == yesterday;

  lastDateTimeAppOpened = now.toUtc().toIso8601String();
  await _sharedPref.save(SharedPreferencesKeys.lastDateTimeAppOpened, lastDateTimeAppOpened);

  runApp(MyApp(tutorialCompleted, isFirstOpeningOfTheDay));
}

const PrimaryColor = const Color(0xFFFFFFFF);

class MyApp extends StatelessWidget {
  MyApp(this.tutorialCompleted, this.isFirstOpeningOfTheDay);
  final bool tutorialCompleted;
  final bool isFirstOpeningOfTheDay;

  @override
  Widget build(BuildContext context) {
    FlutterCleanArchitecture.debugModeOn();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    AchievementsObserver achievementsObserver = AchievementsController();
    CommonDeps().achievementsObserver = achievementsObserver;

    if (isFirstOpeningOfTheDay) {
        achievementsObserver.update(AchievementTypes.consecutiveDaysAppOpening);
    }
    
    var homeRoute = tutorialCompleted ? MovesListingRoute(achievementsObserver) : OnboardingRoute();

    return OKToast(
          child: MaterialApp(
        title: 'Fridge Cook',
        theme: ThemeData(
            primaryColor: PrimaryColor,
            primarySwatch: Colors.red,
            fontFamily: 'Montserrat'),
        home: homeRoute,
        routes: {
          MovesListingRoute.routeName: (context) => MovesListingRoute(achievementsObserver),
          MovesDetailsRoute.routeName: (context) { 
            final Move move = ModalRoute.of(context).settings.arguments; 
            return MovesDetailsRoute(achievementsObserver, move); 
          },
          StatsRoute.routeName: (context) {
            if (isFirstOpeningOfTheDay) {
              achievementsObserver.update(AchievementTypes.analyst);
            }
            return StatsRoute(achievementsObserver);
          },
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
