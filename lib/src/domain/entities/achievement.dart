import 'package:fridge_cook/src/domain/entities/achievement_types.dart';

class Achievement {
  final String uid;
  final AchievementTypes type;
  final String name;
  final String description;

  bool isRewardClaimed;
  int currentStep;
  int numberOfStep;

  Achievement(this.uid, this.type, this.name, this.description,
      this.isRewardClaimed, this.currentStep, this.numberOfStep);

  @override
  String toString() =>
      '$uid, $name, $currentStep, $numberOfStep';
}
