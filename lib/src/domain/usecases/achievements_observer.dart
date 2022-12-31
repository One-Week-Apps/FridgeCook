import 'package:fridge_cook/src/domain/entities/achievement_types.dart';

abstract class AchievementsObserver {
  void update(AchievementTypes type);
}
