import '../entities/achievement.dart';

abstract class AchievementsRepository {
  Future<List<Achievement>> fetch();

  Future<void> update(String uid, int newValue);

  Future<void> claim(String uid);

  Future<void> reset();
}
