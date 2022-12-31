import 'package:fridge_cook/src/app/SharedPreferencesKeys.dart';
import 'package:fridge_cook/src/domain/entities/achievement_types.dart';
// import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/achievement.dart';
import '../../domain/repositories/achievements_repository.dart';

class DataAchievementsRepository extends AchievementsRepository {
  DataAchievementsRepository._();

  static DataAchievementsRepository shared = DataAchievementsRepository._();

  List<Achievement> _achievements = [
    Achievement("0", AchievementTypes.consecutiveDaysAppOpening, "App lover!",
        "Open the app for 2 consecutive days", false, 0, 2),
    Achievement("1", AchievementTypes.consecutiveDaysAppOpening, "App lover!",
        "Open the app for 5 consecutive days", false, 0, 5),
    Achievement("2", AchievementTypes.consecutiveDaysAppOpening, "App lover!",
        "Open the app for 10 consecutive days", false, 0, 10),
    Achievement("10", AchievementTypes.consecutiveDaysDancing,
        "Daily performer!", "Dance 2 times", false, 0, 2),
    Achievement("11", AchievementTypes.consecutiveDaysDancing,
        "Daily performer!", "Dance 5 times", false, 0, 5),
    Achievement("12", AchievementTypes.consecutiveDaysDancing,
        "Daily performer!", "Dance 10 times", false, 0, 10),
    Achievement("20", AchievementTypes.numberOfLikes, "Serial liker!",
        "Like a total of 5 dances", false, 0, 5),
    Achievement("21", AchievementTypes.numberOfLikes, "Serial liker!",
        "Like a total of 10 dances", false, 0, 10),
    Achievement("22", AchievementTypes.numberOfLikes, "Serial liker!",
        "Like a total of 15 dances", false, 0, 15),
    Achievement("30", AchievementTypes.difficulty1, "Rookie dancer!",
        "Perform a total of 5 moves with difficulty 1", false, 0, 5),
    Achievement("31", AchievementTypes.difficulty1, "Rookie dancer!",
        "Perform a total of 10 moves with difficulty 1", false, 0, 10),
    Achievement("32", AchievementTypes.difficulty1, "Rookie dancer!",
        "Perform a total of 15 moves with difficulty 1", false, 0, 15),
    Achievement("40", AchievementTypes.difficulty2, "Simple dancer!",
        "Perform a total of 5 moves with difficulty 2", false, 0, 5),
    Achievement("41", AchievementTypes.difficulty2, "Simple dancer!",
        "Perform a total of 10 moves with difficulty 2", false, 0, 10),
    Achievement("42", AchievementTypes.difficulty2, "Simple dancer!",
        "Perform a total of 15 moves with difficulty 2", false, 0, 5),
    Achievement("50", AchievementTypes.difficulty3, "Novice dancer!",
        "Perform a total of 5 moves with difficulty 3", false, 0, 5),
    Achievement("51", AchievementTypes.difficulty3, "Novice dancer!",
        "Perform a total of 10 moves with difficulty 3", false, 0, 10),
    Achievement("52", AchievementTypes.difficulty3, "Novice dancer!",
        "Perform a total of 15 moves with difficulty 3", false, 0, 15),
    Achievement("60", AchievementTypes.difficulty4, "Pro dancer!",
        "Perform a total of 5 moves with difficulty 4", false, 0, 5),
    Achievement("61", AchievementTypes.difficulty4, "Pro dancer!",
        "Perform a total of 10 moves with difficulty 4", false, 0, 10),
    Achievement("62", AchievementTypes.difficulty4, "Pro dancer!",
        "Perform a total of 15 moves with difficulty 4", false, 0, 15),
    Achievement("70", AchievementTypes.difficulty5, "Expert dancer!",
        "Perform a total of 5 moves with difficulty 5", false, 0, 5),
    Achievement("71", AchievementTypes.difficulty5, "Expert dancer!",
        "Perform a total of 10 moves with difficulty 5", false, 0, 10),
    Achievement("72", AchievementTypes.difficulty5, "Expert dancer!",
        "Perform a total of 15 moves with difficulty 5", false, 0, 15),
    Achievement("80", AchievementTypes.videoLearner, "Video learner!",
        "Watch a total of 5 videos", false, 0, 5),
    Achievement("81", AchievementTypes.videoLearner, "Video learner!",
        "Watch a total of 10 videos", false, 0, 10),
    Achievement("82", AchievementTypes.videoLearner, "Video learner!",
        "Watch a total of 15 videos", false, 0, 15),
    Achievement("90", AchievementTypes.refresher, "Dance picker!",
        "Use the dance refresh button 5 times", false, 0, 5),
    Achievement("91", AchievementTypes.refresher, "Dance picker!",
        "Use the dance refresh button 10 times", false, 0, 10),
    Achievement("92", AchievementTypes.refresher, "Dance picker!",
        "Use the dance refresh button 15 times", false, 0, 15),
    Achievement("100", AchievementTypes.analyst, "Dance analyst!",
        "Open the Stats tab 5 different days", false, 0, 5),
    Achievement("101", AchievementTypes.analyst, "Dance analyst!",
        "Open the Stats tab 10 different days", false, 0, 10),
    Achievement("102", AchievementTypes.analyst, "Dance analyst!",
        "Open the Stats tab 15 different days", false, 0, 15),
  ];

  _keyFor(String uid) {
    return SharedPreferencesKeys.achievementCurrentStep + "_" + uid;
  }

  _claimedKeyFor(String uid) {
    return SharedPreferencesKeys.achievementClaimed + "_" + uid;
  }

  Future<List<Achievement>> fetch() async {
    // var sharedPrefs = await SharedPreferences.getInstance();
    // var updatedAchievements = _achievements;

    // for (var i = 0; i < updatedAchievements.length; i++) {
    //   var uid = updatedAchievements[i].uid;
    //   var currentStep = sharedPrefs.getInt(_keyFor(uid));
    //   if (currentStep == null) {
    //     currentStep = 0;
    //   }
    //   var isRewardClaimed = sharedPrefs.getBool(_claimedKeyFor(uid));
    //   if (isRewardClaimed == null) {
    //     isRewardClaimed = false;
    //   }

    //   updatedAchievements[i].currentStep = currentStep;
    //   updatedAchievements[i].isRewardClaimed = isRewardClaimed;
    // }

    // return updatedAchievements;
    return _achievements;
  }

  Future<void> update(String uid, int newValue) async {
    // var sharedPrefs = await SharedPreferences.getInstance();

    // // Perform change locally to improve lookups
    // await sharedPrefs.setInt(_keyFor(uid), newValue);
  }

  Future<void> claim(String uid) async {
    // var sharedPrefs = await SharedPreferences.getInstance();

    // await sharedPrefs.setBool(_claimedKeyFor(uid), true);
  }

  Future<void> reset() async {
    // var sharedPrefs = await SharedPreferences.getInstance();

    // _achievements.forEach((e) {
    //   sharedPrefs.remove(_keyFor(e.uid));
    //   sharedPrefs.remove(_claimedKeyFor(e.uid));
    // });
  }
}
