
class SharedPreferencesKeys {
  SharedPreferencesKeys._();

  static const _prefix = 'prefs_';
  static const tutorialCompleted = _prefix + 'tutorialCompleted';
  static const lastDateTimeAppOpened = _prefix + 'lastDateTimeAppOpened';
  static const performanceCount = _prefix + 'performanceCount';
  static const performance = _prefix + 'performance_';
  static const likedMove = _prefix + 'likedMove_';

  // storage format: { prefs_achievementCurrentStep_14: 3 }
  static const achievementCurrentStep = _prefix + 'achievementCurrentStep_';

  // storage format: { prefs_achievementClaimed_14: false }
  static const achievementClaimed = _prefix + 'achievementClaimed_';
}
