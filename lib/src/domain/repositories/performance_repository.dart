import 'package:fridge_cook/src/domain/entities/performance.dart';

abstract class PerformanceRepository {
  Future<bool> add(Performance performance);
  Future<List<Performance>> all();
}
